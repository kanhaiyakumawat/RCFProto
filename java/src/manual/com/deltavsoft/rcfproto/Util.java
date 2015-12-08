
//******************************************************************************
// RCF - Remote Call Framework
//
// Copyright (c) 2005 - 2013, Delta V Software. All rights reserved.
// http://www.deltavsoft.com
//
// RCF is distributed under dual licenses - closed source or GPL.
// Consult your particular license for conditions of use.
//
// If you have not purchased a commercial license, you are using RCF 
// under GPL terms.
//
// Version: 2.0
// Contact: support <at> deltavsoft.com 
//
//******************************************************************************

package com.deltavsoft.rcfproto;

class Util
{
    public static boolean g_nativeDllLoaded = false;
    public static void LoadRCFProtoNativeDll()
    {
        if (!g_nativeDllLoaded)
        {
            String runningOnOs = System.getProperty("os.name");
            String javaLibPath = System.getProperty("java.library.path");

            String dllName;
            String dllFullName = "";

            if (runningOnOs.startsWith("Windows"))
            {
                dllName = "RCFProto_Java_impl";
                dllFullName = "RCFProto_Java_impl.dll";
            }
            else
            {
                dllName = "RCFProto_Java_impl";
                dllFullName = "libRCFProto_Java_impl.so";
            }

            String loadError = "";
            try
            {
                System.loadLibrary(dllName);
                g_nativeDllLoaded = true;
            }
            catch(Exception e)
            {
                loadError = e.getClass().getName() + ": " + e.getMessage();
            }
            catch(Error e)
            {
                loadError = e.getClass().getName() + ": " + e.getMessage();
            }

            if (loadError != "")
            {
                String errMsg = "Unable to load RCFProto native bindings for Java. Make sure " + dllFullName + " can be loaded from java.library.path.\n";
                errMsg += "System.loadLibrary() error: " + loadError + "\n";
                errMsg += "java.library.path: " + javaLibPath;
                throw new RuntimeException(errMsg);
            }

        }
    }
}