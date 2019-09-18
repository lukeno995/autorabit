trigger PO_InsertAttachments on ContentDocument (after update) {
    if (!QuoteDoucmentAttachmentsUtility.hasAlreadyRun) {
        QuoteDoucmentAttachmentsUtility.hasAlreadyRun = true;
        QuoteDoucmentAttachmentsUtility.AttachmentInsertion(trigger.new);
    }
}