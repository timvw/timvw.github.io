---
date: "2006-04-22T00:00:00Z"
tags:
- C++
title: Using .Net assemblies in your WIN32 application
aliases:
 - /2006/04/22/using-net-assemblies-in-your-win32-application/
 - /2006/04/22/using-net-assemblies-in-your-win32-application.html
---
Imagine that you've got an extensive codebase using WIN32/MFC and don't want to give that up but on the other hand you'd like to take advantage of DOTNET classes then here's a simple solution: First we write an Interface and an Implementation with C# as following

```csharp
public interface IQuoteClient {
	String getQuote();
	Boolean setQuote(String quote);
}

public class QuoteClient : IQuoteClient {
	// COM requires a parameterless constructor
	public QuoteClient() { ; }
	public string getQuote() { return String.Format"quote";}
	public bool setQuote(string quote) { return true; }
}
```

Go the project Properties and check the "Make assembly COM-Visible" box which you find in the Application tab, Assembly Information. Then you go to the Build tab and check "Register for COM interop" box and at the Signing tab you check the "Sign the assembly" box and assign a key. Build the project.

Now we have to extract a typelibrary, register the typelibrary and install it in the global assembly cache. Open a Visual Studio 2005 Command Prompt and go to your project\bin\Debug directory. Type the following commands

```bash
tlbexp QuoteClient.dll
regasm QuoteClient.dll /tlb:QuoteClient.tlb
gacutil /i QuoteClient.dll
```

Now you can import the classes in this assembly from your WIN32 application as following

```cpp
#import "C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\mscorlib.tlb"
#import "D:\projects\Test\QuoteClient\bin\Debug\ClientLibrary.tlb" no_namespace named_guids
```

And you can use them just like any other COM component

```cpp
CoInitialize(NULL);

IQuoteClient *qc = NULL;
HRESULT hr = CoCreateInstance(
	CLSID_QuoteClient,
	NULL,
	CLSCTX_INPROC_SERVER,
	IID_IQuoteClient,
	reinterpret_cast<void**>(&qc)
);

if (SUCCEEDED(hr)) {
	cout << "Quote: " << qc->getQuote() << endl; qc->Release();
	qc = NULL;
}

CoUninitialize();
```
