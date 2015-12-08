
import os
import sys

def Resolve():
    for idx, val in enumerate(sys.argv):
        if val == '--dllpath' and idx+1 < len(sys.argv):
            dllPath = sys.argv[idx+1]
            sys.path.append(dllPath)

def FindDistributionRootDir():
    testDir = os.getcwd()
    prevTestDir = testDir;
    while testDir and os.path.exists(testDir):
        if os.path.exists( os.path.join(testDir, "certs/certA.pem") ):
            break

        testDir = os.path.abspath( os.path.join(testDir, "..") )
        if testDir == prevTestDir:
            testDir = None

        prevTestDir = testDir

    return testDir
