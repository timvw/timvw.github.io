---
id: 137
title: Exploring System.CodeDom
date: 2006-12-26T02:52:12+00:00
author: timvw
layout: post
guid: http://www.timvw.be/exploring-systemcodedom/
permalink: /2006/12/26/exploring-systemcodedom/
tags:
  - 'C#'
---
Today i wanted to experiment with [System.CodeDom](http://msdn2.microsoft.com/en-us/library/system.codedom.aspx). This little program requests the user to input names for a namespace, class and method. It also asks the user to input the code that should go into the method body. Then it generates an assembly (test.dll) and creates a new appdomain in which the assembly is loaded... Finally it initializes an instance of the created class and calls the method...

```csharp
static void Main(string[] args)
{
	string loopEnd = "";
	while (loopEnd != "X")
	{
		//string namespaceName = "MySpace";
		//string className = "MyClass";
		//string methodName = "MyMethod";
		//StringBuilder stringBuilder = new StringBuilder("System.Console.WriteLine(\"hihi\");");

		Console.Write("Enter namespace: ");
		string namespaceName = Console.ReadLine();
		Console.Write("Enter class: ");
		string className = Console.ReadLine();
		Console.Write("Enter method: ");
		string methodName = Console.ReadLine();

		StringBuilder stringBuilder = new StringBuilder();
		Console.WriteLine("Enter method body (X to stop)");
		string input = Console.ReadLine();
		while (input != "X")
		{
			stringBuilder.Append(input);
			input = Console.ReadLine();
		}

		CodeCompileUnit codeCompileUnit = new CodeCompileUnit();

		CodeAttributeDeclaration assemblyTitleAttribute = new CodeAttributeDeclaration("System.Reflection.AssemblyTitle");
		assemblyTitleAttribute.Arguments.Add(new CodeAttributeArgument(new CodePrimitiveExpression("A Generated Assembly")));
		codeCompileUnit.AssemblyCustomAttributes.Add(assemblyTitleAttribute);

		CodeTypeDeclaration codeTypeDeclaration = new CodeTypeDeclaration();
		codeTypeDeclaration.Name = className;
		codeTypeDeclaration.IsClass = true;
		codeTypeDeclaration.Attributes = MemberAttributes.Public;

		CodeMemberMethod codeMemberMethod = new CodeMemberMethod();
		codeMemberMethod.Name = methodName;
		codeMemberMethod.Attributes = MemberAttributes.Public;
		codeMemberMethod.ReturnType = new CodeTypeReference(typeof(void));
		codeMemberMethod.Statements.Add(new CodeSnippetStatement(stringBuilder.ToString()));

		codeTypeDeclaration.Members.Add(codeMemberMethod);

		CodeNamespace codeNamespace = new CodeNamespace(namespaceName);
		codeNamespace.Types.Add(codeTypeDeclaration);
		codeCompileUnit.Namespaces.Add(codeNamespace);

		CompilerParameters compilerParameters = new CompilerParameters();
		compilerParameters.OutputAssembly = "test.dll";
		compilerParameters.GenerateExecutable = false;
		compilerParameters.GenerateInMemory = false;

		CSharpCodeProvider cSharpCodeProvider = new CSharpCodeProvider();
		CompilerResults compilerResults = cSharpCodeProvider.CompileAssemblyFromDom(compilerParameters, codeCompileUnit);

		AppDomain appDomain = AppDomain.CreateDomain("new appdomain");
		Assembly assembly = appDomain.Load(compilerResults.CompiledAssembly.FullName);
		object instance = assembly.CreateInstance(namespaceName + "." + className);
		instance.GetType().InvokeMember(methodName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.InvokeMethod, null, instance, null);
		AppDomain.Unload(appDomain);

		Console.WriteLine("Enter X to end (enter something different to continue)");
		loopEnd = Console.ReadLine();
	}
}
```
