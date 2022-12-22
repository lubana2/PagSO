trigger OpportunityTrigger on opportunity (after insert) {
    if (trigger.isAfter) {
        if (trigger.isInsert) {
            TriggerHelper.createOpportunityContactRoleFromOpp(Trigger.New);
        } 
    }
    
}