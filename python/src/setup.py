
from setuptools import setup

import os
import sys

extName = '_rcfproto.so'
if os.name == 'nt':
    extName = '_rcfproto.pyd'

if os.path.exists('deltavsoft/' + extName):
    pydPath = os.path.abspath('deltavsoft/' + extName)
else:
    # Locate the relevant .pyd file in the distribution.
    arch64 = sys.maxsize > 2**32
    if arch64:
        print "setup.py: Detected 64 bit Python."
        pydRelativePath = 'python/bin/x64/' + extName
    else:
        print "setup.py: Detected 32 bit Python."
        pydRelativePath = 'python/bin/x86/' + extName
    
    # Seach upwards to the root of the distro.
    testDir = os.getcwd()
    prevTestDir = testDir;
    while testDir and os.path.exists(testDir):
        testPydPath = os.path.abspath( os.path.join(testDir, pydRelativePath) )
        if os.path.exists(testPydPath):
            break

        testDir = os.path.abspath( os.path.join(testDir, "..") )
        if testDir == prevTestDir:
            testDir = None

        prevTestDir = testDir

    pydPath = testPydPath

if os.path.exists(pydPath):
    print "setup.py: Installing rcfproto Python extension from: " + pydPath    
else:
    raise Exception('setup.py: Could not find rcfproto Python extension.')

setup(name='rcfproto',
      version='1.0',
      py_modules = ['deltavsoft.rcfproto', 'deltavsoft.rcfprotoimpl', 'deltavsoft.util'],
      data_files = [ ('deltavsoft', [pydPath]) ],
      install_requires=['protobuf']
      )
