using System;
using System.Runtime.InteropServices;
using System.Reflection;
using System.Collections.Generic;
using System.IO;

public class DllPathResolver
{
    static List<string> gAssemblyResolvePaths = new List<string>();
    static ResolveEventHandler gResolveHandler;

    static System.Reflection.Assembly OnAssemblyResolveFail(object sender, ResolveEventArgs args)
    {
        string dllName = args.Name.Substring(0, args.Name.IndexOf(",")) + ".dll";

        foreach (string resolvePath in gAssemblyResolvePaths)
        {
            string  assemblyPath = Path.Combine(resolvePath, dllName);
            if (File.Exists(assemblyPath))
            {
                System.Console.WriteLine("DllPathResolver: Loading assembly from path: " + assemblyPath);
                System.Reflection.Assembly tempAssembly = System.Reflection.Assembly.LoadFrom(assemblyPath);
                return tempAssembly;
            }
        }
        return null;
    }

    public static void AddPath(string dllPath)
    {
        dllPath = Path.GetFullPath(dllPath);
        if (!dllPath.EndsWith("\\"))
        {
            dllPath += "\\";
        }
        gAssemblyResolvePaths.Add(dllPath);
    }

    public static void Resolve(string[] args)
    {
        // First, locate the root of the distribution, and use that to construct
        // paths for locating native DLL's.

        string rootDir = FindDistributionRootDir();

        string binRelativePath;
        if (IntPtr.Size == 4)
        {
            binRelativePath = "csharp/bin/x86";
        }
        else
        {
            binRelativePath = "csharp/bin/x64";
        }
        string rcfProtoBinDir = Path.Combine(rootDir, binRelativePath);
        AddPath(rcfProtoBinDir);

        string rcfProtoAssemblyDir = Path.Combine(rootDir, "csharp/bin");
        AddPath(rcfProtoAssemblyDir);

        // Second, parse command line for any further paths.
        for (int i = 0; i < args.Length; i++)
        {
            if ((args[i] == "--dllpath" || args[i] == "-d") && i + 1 < args.Length)
            {
                string dllPath = args[i + 1];
                AddPath(dllPath);
            }
        }

        // Configure the assembly resolve handler (used to find .NET assemblies).
        gResolveHandler = new ResolveEventHandler(OnAssemblyResolveFail);
        AppDomain.CurrentDomain.AssemblyResolve += gResolveHandler;

        // Configure the PATH environment variable (used to find native DLL's).
        string envPath = Environment.GetEnvironmentVariable("PATH");
        foreach (string dllPath in gAssemblyResolvePaths)
        {
            envPath = envPath + ";" + dllPath;
        }
        Environment.SetEnvironmentVariable("PATH", envPath);
    }

    public static string FindDistributionRootDir()
    {
        string codeBase = Assembly.GetExecutingAssembly().CodeBase;
        UriBuilder uri = new UriBuilder(codeBase);
        string path = Uri.UnescapeDataString(uri.Path);
        path = Path.GetDirectoryName(path);

        string testDir = path;
        string prevTestDir = path;
        while (testDir != null && Directory.Exists(testDir))
        {
            string testDllPath = Path.Combine(testDir, "csharp\\bin\\RCFProto_NET.dll");
            if (File.Exists(testDllPath))
            {
                break;
            }

            // Go up one level.
            testDir = Path.GetFullPath(Path.Combine(testDir, ".."));
            if (testDir.Equals(prevTestDir))
            {
                testDir = null;
            }

            prevTestDir = testDir;
        }

        return testDir;
    }
}
