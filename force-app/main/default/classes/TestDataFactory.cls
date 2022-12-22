public class TestDataFactory {
	public static List<Lead> createLeads(Integer numLeads, boolean isinsert) {
        List<Lead> Leads = new List<Lead>();
        for(Integer i=0;i<numLeads;i++) {
            Lead L = new Lead(LastName = 'Name' + i,Company = 'Forte', Bussines_Line__c = 'Work');
            Leads.add(L);
        }
        if (isinsert) {
            insert Leads;
        }
        return Leads;
    }
}