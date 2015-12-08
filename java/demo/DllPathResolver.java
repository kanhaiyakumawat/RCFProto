
import java.io.File;
import java.io.IOException;

import java.lang.reflect.*;

public class DllPathResolver
{
    public static void resolve(String[] args) throws Exception
    {
        String rootDir = findDistributionRootDir();
        
        String javaLibPath = System.getProperty( "java.library.path" );
        String runningOnOs = System.getProperty("os.name");

        // Class separator symbol differs between Windows and Unix.
        String cpSeparator = ":";
        if (runningOnOs.startsWith("Windows"))
        {
            cpSeparator = ";";
        }
        
        String arch = System.getProperty("sun.arch.data.model");
        String binRelativePath = "";
        if (arch.equals("32"))
        {
            binRelativePath = "java/bin/x86";
        }
        else
        {
            binRelativePath = "java/bin/x64";
        }
        
        // Add default bin location in the distribution, to javaLibPath.
        File binPath = new File(rootDir, binRelativePath);
        javaLibPath = javaLibPath + cpSeparator + binPath;      

        // Add any --dllpath command line entries, to javaLibPath.
        for (int i=0; i<args.length; i++)
        {
            if (    (args[i].equals("--dllpath") || args[i].equals("-d"))
                &&  i+1<args.length)
            {
                File dllDir = new File(args[i+1]);
                String extraPath = dllDir.getCanonicalPath();
                javaLibPath = javaLibPath + cpSeparator + extraPath;
            }
        }

        // This hack enables us to modify java.lib.path at runtime.
        // http://blog.cedarsoft.com/2010/11/setting-java-library-path-programmatically/
        // java.lib.path is used by the JVM when loading the JNI dll.
        System.setProperty( "java.library.path", javaLibPath );
        Field fieldSysPath = ClassLoader.class.getDeclaredField( "sys_paths" );
        fieldSysPath.setAccessible( true );
        fieldSysPath.set( null, null );

    }
    
    public static String findDistributionRootDir() throws IOException
    {
        String runningOnOs = System.getProperty("os.name");
        String javaLibPath = System.getProperty("java.library.path");

        String dllFullName = "";

        if (runningOnOs.startsWith("Windows"))
        {
            dllFullName = "RCFProto_Java_impl.dll";
        }
        else
        {
            dllFullName = "libRCFProto_Java_impl.so";
        }
        
        String arch = System.getProperty("sun.arch.data.model");
        String binRelativePath = "";
        if (arch.equals("32"))
        {
            binRelativePath = "java/bin/x86/" + dllFullName;
        }
        else
        {
            binRelativePath = "java/bin/x64/" + dllFullName;
        }
        
        // Search upwards until we find the native DLL. 
        String initPath = new File(".").getCanonicalPath();
        File testDir = new File(initPath);
        File prevTestDir = new File(initPath);
        while (testDir != null && testDir.exists())
        {
            File testDllPath = new File(testDir, binRelativePath);
            if (testDllPath.exists())
            {
                break;
            }

            // Go up one level.
            testDir = new File(testDir, "..");
            testDir = new File(testDir.getCanonicalPath());
            if (testDir.equals(prevTestDir))
            {
                testDir = null;
            }

            prevTestDir = testDir;
        }
        
        return testDir.getCanonicalPath();

    }
    
}
