public class InsertedLeadTriggerHelper {
    public static void createTasks(List<Lead> insertedLeads) {
		List <Task> taskList = new List<Task>();
    	for (Lead L : insertedLeads){
    		Task t = new Task();
        	t.Subject = 'Please follow the bussines '+ L.Bussines_Line__c;
            t.OwnerId = L.OwnerId;
            t.WhoId = L.Id;
            t.ActivityDate = System.today() + 1;
        	TaskList.Add(t);
		}
    	if(!taskList.isempty()){
    		insert taskList;
    	}
	}
}