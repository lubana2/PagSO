trigger ContactTrigger on contact (after insert) {
    if (trigger.isAfter) {
        if (trigger.isInsert) {
            TriggerHelper.createOpportunityContactRoleFromCont(Trigger.New);
        } 
    }
}