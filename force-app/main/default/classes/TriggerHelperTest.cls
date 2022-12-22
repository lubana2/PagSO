@isTest
public with sharing class TriggerHelperTest {
    @isTest static void TestcreateOpportunityContactRoleFromOpp() { 
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts;
        List<Contact> testConts = new List<Contact>();
        for(Integer i=0;i<3;i++) {
            testConts.add(new Contact(FirstName = testAccts[0].Name+'Cont'+i, LastName='Test', AccountId=testAccts[0].Id));
            testConts.add(new Contact(FirstName = testAccts[1].Name+'Cont'+i, LastName='Test', AccountId=testAccts[1].Id));
        }
        insert testConts;

        List<Opportunity> testOpps = new List<Opportunity>();
        for(Integer i=0;i<2;i++) {
            testOpps.add(new Opportunity(Name = 'ForteOpp'+i, AccountId=testAccts[0].Id, CloseDate=System.today().addMonths(1), StageName = 'Prospecting'));    
            testOpps.add(new Opportunity(Name = 'ForteOpp'+i, AccountId=testAccts[1].Id, CloseDate=System.today().addMonths(1), StageName = 'Prospecting'));
        }
        Test.startTest();
        insert testOpps;
    	Test.stopTest();
        System.assertEquals(3, [select count() from OpportunityContactRole where OpportunityId = :testOpps[0].Id]);   
        System.assertEquals(3, [select count() from OpportunityContactRole where OpportunityId = :testOpps[1].Id]); 
    }
    @isTest static void TestcreateOpportunityContactRoleFromCont() { 
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts;
        List<Opportunity> testOpps = new List<Opportunity>();
        for(Integer i=0;i<3;i++) {
            testOpps.add(new Opportunity(Name = testAccts[0].Name+'Opp'+i, AccountId=testAccts[0].Id, StageName = 'Prospecting', CloseDate=System.today().addMonths(1)));
            testOpps.add(new Opportunity(Name = testAccts[1].Name+'Opp'+i, AccountId=testAccts[1].Id, StageName = 'Prospecting', CloseDate=System.today().addMonths(1)));    
        }
        testOpps.add(new Opportunity(Name = testAccts[0].Name+'Opp3', AccountId=testAccts[0].Id, StageName = 'Closed Won', CloseDate=System.today().addMonths(1)));
        testOpps.add(new Opportunity(Name = testAccts[1].Name+'Opp3', AccountId=testAccts[1].Id, StageName = 'Closed Lost', CloseDate=System.today().addMonths(1)));  
        insert testOpps; 

        List<Contact> testConts = new List<Contact>();
        for(Integer i=0;i<2;i++) {
            testConts.add(new Contact(FirstName = testAccts[0].Name+'Cont'+i, LastName='Test', AccountId=testAccts[0].Id));
            testConts.add(new Contact(FirstName = testAccts[1].Name+'Cont'+i, LastName='Test', AccountId=testAccts[1].Id));
        }
        Test.startTest();
        insert testConts;
    	Test.stopTest();
        System.assertEquals(3, [select count() from OpportunityContactRole where ContactId = :testConts[0].Id]);   
        System.assertEquals(3, [select count() from OpportunityContactRole where ContactId = :testConts[1].Id]); 
    }
}