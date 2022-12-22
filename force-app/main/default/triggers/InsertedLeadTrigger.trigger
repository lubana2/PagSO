trigger InsertedLeadTrigger on Lead (after insert) {
	InsertedLeadTriggerHelper.createTasks(Trigger.New);
}