trigger PO_OpportunityLineItemTrigger on OpportunityLineItem ( after insert ) 
{
    OpportunityLineItem oli = trigger.new[0];
     //   OpportunityLineItemHandler.UpdateOppwithProductPrice( trigger.new );
}