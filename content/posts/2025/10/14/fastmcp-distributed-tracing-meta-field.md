---
title: "FastMCP Distributed Tracing: Transport-Agnostic Context Propagation with _meta"
date: 2025-10-14T10:00:00+01:00
draft: false
tags: ["opentelemetry", "langfuse", "fastmcp", "distributed-tracing", "observability", "llm", "mcp"]
categories: ["observability", "ai"]
---

In my [previous post](/2025/06/27/distributed-tracing-with-fastmcp-combining-opentelemetry-and-langfuse/) about distributed tracing with FastMCP, I demonstrated how to propagate OpenTelemetry context using HTTP headers. While this approach worked well for HTTP-based deployments, it had a significant limitation: it only worked with HTTP transports.

Today, I'm sharing an improved implementation that uses the MCP protocol's `_meta` field convention, making trace context propagation truly transport-agnostic.

## The Problem with HTTP Headers

The original HTTP-header-based approach had several limitations:

1. **Transport-Specific**: Only worked with HTTP/SSE transports, not with stdio
2. **Not Standard**: Required transport-specific implementations
3. **Limited Portability**: Didn't follow MCP protocol conventions

For MCP servers that need to support multiple transports (stdio for local development, HTTP for remote deployments, SSE for streaming), this was a real constraint.

## The Solution: MCP `_meta` Field

The Model Context Protocol now supports a `_meta` field convention ([PR #414](https://github.com/modelcontextprotocol/modelcontextprotocol/pull/414)) specifically designed for metadata propagation, including trace context. This approach:

- **Works everywhere**: stdio, HTTP, and SSE transports
- **Follows standards**: Uses W3C Trace Context format within MCP protocol
- **Compatible**: Works with `openinference-instrumentation-mcp` and other MCP tools
- **Protocol-level**: Integrated at the MCP protocol layer, not transport layer

## How It Works

### Client-Side: Injecting Context

Instead of passing trace context via HTTP headers, we now inject it into the `_meta` field:

```python
from weather_assistant.utils.otel_utils import inject_otel_context_to_meta

# Inject trace context into _meta field
meta = inject_otel_context_to_meta()

# Pass _meta to tool call
await client.call_tool("get_weather", {
    "location": "New York",
    "_meta": meta
})
```

The `inject_otel_context_to_meta()` function creates a dictionary with W3C Trace Context fields:

```python
def inject_otel_context_to_meta() -> dict:
    """
    Inject current OpenTelemetry context into _meta field format.

    Returns:
        Dictionary with trace context fields for _meta field
    """
    carrier = {}
    propagation.inject(carrier, context=context.get_current())
    return carrier
```

### JSON-RPC Structure

The trace context is passed as part of the MCP request:

```json
{
  "jsonrpc": "2.0",
  "method": "tools/call",
  "params": {
    "name": "get_weather",
    "arguments": {
      "location": "New York"
    },
    "_meta": {
      "traceparent": "00-0af7651916cd43dd8448eb211c80319c-00f067aa0ba902b7-01",
      "tracestate": "...",
      "baggage": "..."
    }
  }
}
```

### Server-Side: Extracting Context

On the server side, we use a decorator to extract and activate the trace context:

```python
@mcp.tool()
@otel_utils.with_otel_context_from_meta
@observe
async def get_weather(
    location: str,
    _meta: dict | None = None,
) -> dict:
    """Get current weather with distributed tracing."""
    # Implementation here
```

The decorator stack ensures:

1. `@mcp.tool()` - Registers the function as an MCP tool
2. `@with_otel_context_from_meta` - Extracts trace context from `_meta` field
3. `@observe` - Creates a Langfuse span within the propagated context

The extraction logic is straightforward:

```python
def extract_otel_context_from_meta(meta: dict | None) -> Context:
    """
    Extract OpenTelemetry context from MCP _meta field.

    Args:
        meta: Dictionary containing trace context fields from MCP request

    Returns:
        OpenTelemetry context object with extracted trace context
    """
    if not meta:
        return context.get_current()

    # Create a carrier dict with the trace context fields
    carrier = {}
    if "traceparent" in meta:
        carrier["traceparent"] = meta["traceparent"]
    if "tracestate" in meta:
        carrier["tracestate"] = meta["tracestate"]
    if "baggage" in meta:
        carrier["baggage"] = meta["baggage"]

    # Extract context using OpenTelemetry's propagator
    if carrier:
        return propagation.extract(carrier)
    return context.get_current()
```

## Comparison: Before and After

| Aspect | HTTP Headers | `_meta` Field |
|--------|-------------|---------------|
| Transport Support | HTTP/SSE only | All transports (stdio, HTTP, SSE) |
| Standard | W3C Trace Context | MCP + W3C Trace Context |
| Implementation | Transport-specific | Protocol-level |
| Compatibility | HTTP libraries | Any MCP client/server |
| Use Case | HTTP-only deployments | Universal MCP applications |

## Migration Guide

If you're using the old HTTP-header approach, migration is straightforward:

### 1. Update Utility Functions

Replace `with_otel_context_from_headers` with `with_otel_context_from_meta`:

```python
# Old approach
@mcp.tool()
@with_otel_context_from_headers
@observe
async def get_weather(location: str) -> dict:
    ...

# New approach
@mcp.tool()
@with_otel_context_from_meta
@observe
async def get_weather(location: str, _meta: dict | None = None) -> dict:
    ...
```

### 2. Update Client Code

Replace header injection with `_meta` field:

```python
# Old approach
headers = {}
inject(headers)
transport = StreamableHttpTransport(url="...", extra_headers=headers)

# New approach
meta = inject_otel_context_to_meta()
transport = StreamableHttpTransport(url="...")  # No headers needed
await client.call_tool("tool_name", {"arg": "value", "_meta": meta})
```

### 3. Add `_meta` Parameter

Ensure your tool functions accept the `_meta` parameter:

```python
async def my_tool(arg1: str, _meta: dict | None = None) -> dict:
    # Your implementation
    pass
```

## Benefits

The new approach provides several advantages:

1. **Transport Flexibility**: Switch between stdio, HTTP, and SSE without code changes
2. **Development Experience**: Use stdio during development, HTTP in production
3. **Standards Compliance**: Follows emerging MCP conventions
4. **Tool Compatibility**: Works with the growing MCP ecosystem
5. **Future-Proof**: Aligned with MCP protocol evolution

## Implementation

The complete updated implementation is available in the [fastmcp-otel-langfuse](https://github.com/timvw/fastmcp-otel-langfuse) repository. Key files:

- [`weather_assistant/utils/otel_utils.py`](https://github.com/timvw/fastmcp-otel-langfuse/blob/main/weather_assistant/utils/otel_utils.py) - Context propagation utilities
- [`weather_assistant/server.py`](https://github.com/timvw/fastmcp-otel-langfuse/blob/main/weather_assistant/server.py) - Server with `_meta` extraction
- [`weather_assistant/client.py`](https://github.com/timvw/fastmcp-otel-langfuse/blob/main/weather_assistant/client.py) - Client with `_meta` injection

## Observability Results

The observability experience remains the same - you get complete distributed traces in Langfuse showing the full request flow:

- Client-side spans (e.g., `weather_request`, `handle_weather_request`)
- Server-side tool spans (e.g., `get_weather`, `get_forecast`)
- Proper parent-child relationships across service boundaries
- Token usage, costs, and latency metrics

The only difference is that traces now work regardless of the transport you choose.

## Conclusion

By adopting the MCP `_meta` field convention for trace context propagation, we gain transport-agnostic distributed tracing while maintaining full compatibility with OpenTelemetry and Langfuse. This approach is more flexible, standards-compliant, and future-proof than the HTTP-header-based method.

If you're building MCP servers that need comprehensive observability, I encourage you to adopt this pattern. The migration is straightforward, and the benefits are significant.

For the complete working example, check out the [fastmcp-otel-langfuse repository](https://github.com/timvw/fastmcp-otel-langfuse).

## References

- [MCP Specification - `_meta` field convention (PR #414)](https://github.com/modelcontextprotocol/modelcontextprotocol/pull/414)
- [OpenTelemetry Context Propagation](https://opentelemetry.io/docs/concepts/context-propagation/)
- [W3C Trace Context](https://www.w3.org/TR/trace-context/)
- [OpenInference MCP Instrumentation](https://github.com/Arize-ai/openinference/tree/main/python/instrumentation/openinference-instrumentation-mcp)
- [Previous post: Distributed Tracing with FastMCP](/2025/06/27/distributed-tracing-with-fastmcp-combining-opentelemetry-and-langfuse/)

Happy tracing! 🚀
