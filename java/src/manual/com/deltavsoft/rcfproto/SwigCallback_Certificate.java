
package com.deltavsoft.rcfproto;

class SwigCallback_Certificate extends _SwigCallback
{
    SwigCallback_Certificate(RcfProtoChannel channel)
    {
        //mCertValidator = certValidator;
        mChannel = channel;
    }

    public boolean ValidateCertificate(_SwigCallbackArgs args)
    {
    
        try
        {
            
            // Downcast the certificate.
            Certificate cert = args.getMCertificatePtr();
            long handle = Certificate.getCPtr(cert);

            switch (cert._getType())
            {
                case Win32:
                    cert = new Win32Certificate(handle, false);
                    break;
                case X509:
                    cert = new X509Certificate(handle, false);
                    break;
                default:
                    cert = new Certificate(handle, false);
                    break;
            }
            
            return RcfProtoChannelImpl.OnValidateCertificate(mChannel, cert);
        }
        catch (Exception e)
        {
            args.setMErrorString(e.getMessage());
        }

        return false;
    }

    //internal CertificateValidationCallback mCertValidator;
    
    private RcfProtoChannel mChannel;
}
