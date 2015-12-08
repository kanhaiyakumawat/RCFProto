
# Currently just a copy of what swig generates.
def LoadRCFProtoNativeDll():
    from os.path import dirname
    import imp
    fp = None
    try:
        fp, pathname, description = imp.find_module('_rcfproto', [dirname(__file__)])
    except ImportError:
        import _rcfproto
        return _rcfproto
    if fp is not None:
        try:
            _mod = imp.load_module('_rcfproto', fp, pathname, description)
        finally:
            fp.close()
        return _mod
