public class EmailServiceVerificationCodeHandler {
    public virtual void log(Messaging.inboundEmail email,Messaging.InboundEnvelope env) {
 
    System.debug(LoggingLevel.INFO,'\n INboundEmail Envelope:\n' + 'from:' + env.fromAddress + ' to: ' + env.toAddress + '\n' +
        '\n  subject    :' + email.subject +
        '\n  ccAddresses:' + email.ccAddresses +
        '\n  toAddresses:' + email.toAddresses +
        '\n  fromAddress:' + email.fromAddress +
        '\n  fromName   :' + email.fromName +
        //'\n  headers    :' + '\n' + headersToString(email.headers) +
         
        '\n  #binAtch:' + (email.binaryAttachments != null ? email.binaryAttachments.size() : 0) +
        '\n  #textAtch:' + (email.textAttachments != null ? email.textAttachments.size() : 0) +
         
        '\n  plaintextBody:' + email.plainTextBody +
        '\n  htmlBody:' + email.htmlBody
    );
    }

}