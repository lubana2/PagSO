@isTest
public class InsertedLeadTriggerHelperTest {
	@isTest static void TestInsertLead() {
        Lead L = new Lead(LastName = 'Bandy',Company = 'Forte', Bussines_Line__c = 'Sport');       
        Test.startTest();
    	Database.SaveResult  result = Database.insert(L, false);
    	Test.stopTest();
        System.assert(result.isSuccess());
     	System.assertEquals(0,result.getErrors().size());
        System.assertEquals(1, [select count() from Task where Subject = 'Please follow the bussines Sport']);   
    }
    @isTest static void TestInsertLeadbulk() { 
        List<Lead> Leads = TestDataFactory.createLeads(50, false);
        Test.startTest();
        insert Leads;
    	Test.stopTest();
        System.assertEquals(50, [select count() from Task where Subject = 'Please follow the bussines Work']);   
    }
}