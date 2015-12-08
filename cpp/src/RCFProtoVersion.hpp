
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

#include <winver.h>

#include <RCF/BuildVersion.hpp>

#if defined (_DEBUG)
#define VSN_FILEFLAGS VS_FF_DEBUG
#else
#define VSN_FILEFLAGS 0
#endif

#define RCF_VERSION_NUMERIC     RCF_VERSION_MAJOR, RCF_VERSION_MINOR, RCF_VERSION_MINOR_MINOR, RCF_VERSION_BUILD

#define RCFPROTO_VERSION_INFO(fileName, desc, exeType)                  \
    VS_VERSION_INFO         VERSIONINFO                                 \
    FILEVERSION             RCF_VERSION_NUMERIC                         \
    PRODUCTVERSION          RCF_VERSION_NUMERIC                         \
    FILEFLAGSMASK           VS_FFI_FILEFLAGSMASK                        \
    FILEFLAGS               VSN_FILEFLAGS                               \
    FILEOS                  VOS__WINDOWS32                              \
    FILETYPE                exeType                                     \
{                                                                       \
    BLOCK "StringFileInfo"                                              \
    {                                                                   \
    BLOCK "040904E4"                                                    \
    {                                                                   \
    VALUE "CompanyName",      "Delta V Software\000"                    \
    VALUE "FileDescription",  desc "\000"                               \
    VALUE "FileVersion",      RCF_VERSION_STR "\000"                    \
    VALUE "InternalName",     fileName "\000"                           \
    VALUE "LegalCopyright",   "Copyright © Delta V Software\000"        \
    VALUE "OriginalFilename", fileName "\000"                           \
    VALUE "ProductName",      "RCFProto RPC Framework\000"              \
    VALUE "ProductVersion",   RCF_VERSION_STR "\000"                    \
    }                                                                   \
    }                                                                   \
    BLOCK "VarFileInfo"                                                 \
    {                                                                   \
    VALUE "Translation", 0x0409, 0x04e4                                 \
    }                                                                   \
}

#define RCFPROTO_VERSION_INFO_EXE(fileName, desc)                       \
    RCFPROTO_VERSION_INFO(fileName, desc, VFT_APP)

#define RCFPROTO_VERSION_INFO_DLL(fileName, desc)                       \
    RCFPROTO_VERSION_INFO(fileName, desc, VFT_DLL)
