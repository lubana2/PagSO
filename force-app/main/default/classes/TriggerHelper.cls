public with sharing class TriggerHelper {
    public static void createOpportunityContactRoleFromOpp(List<Opportunity> insertedOpportunities) {
		List <OpportunityContactRole> oppContRoles = new List<OpportunityContactRole>();
        Set<String> accountIds = new Set<String>(); //usar Set en lugar de List para que no se repitan
        for (Opportunity createdOpportunity : insertedOpportunities) {
            accountIds.Add(createdOpportunity.AccountId);
        }
        Map<Id,List<Id>> accountContactsMap = new Map<Id,List<Id>>();
        for (Contact cont : [SELECT Id,AccountId FROM Contact WHERE AccountId IN :accountIds]) {
            if (accountContactsMap.containsKey(cont.AccountId)) {
                accountContactsMap.get(cont.AccountId).add(cont.Id);
            }else {
                accountContactsMap.put(cont.AccountId, new List<Id>{cont.Id});
            }
        }
        for (Opportunity createdOpportunity : insertedOpportunities){
            if (accountContactsMap.containsKey(createdOpportunity.AccountId)) {
                for (Id  contactFoundId : accountContactsMap.get(createdOpportunity.AccountId)) {
                    OpportunityContactRole newOppContRole = new OpportunityContactRole();
                    newOppContRole.ContactId = contactFoundId; 
                    newOppContRole.OpportunityId = createdOpportunity.Id;
                    newOppContRole.Role = 'Business User';
                    oppContRoles.Add(newOppContRole); 
                }
            }
               			
		}
    	if(!oppContRoles.isempty()){
    		insert oppContRoles;
    	}
	}
    public static void createOpportunityContactRoleFromCont(List<Contact> insertedContacts) {
		List <OpportunityContactRole> oppContRoles = new List<OpportunityContactRole>();
        Set<String> opportunitiesIds = new Set<String>();
        for (Contact createdContact : insertedContacts) {
            opportunitiesIds.Add(createdContact.AccountId);
        }
        Map<Id,List<Id>> accountOpportunitiesMap = new Map<Id,List<Id>>();
        for (Opportunity opp : [SELECT Id,AccountId FROM Opportunity WHERE AccountId IN :opportunitiesIds and StageName != 'Closed Won' and StageName != 'Closed Lost']) {
            if (accountOpportunitiesMap.containsKey(opp.AccountId)) {
                accountOpportunitiesMap.get(opp.AccountId).add(opp.Id);
            }else {
                accountOpportunitiesMap.put(opp.AccountId, new List<Id>{opp.Id});
            }
        }
        for (Contact createdContact : insertedContacts){
            if (accountOpportunitiesMap.containsKey(createdContact.AccountId)) {
                for (Id  opportunityFoundId : accountOpportunitiesMap.get(createdContact.AccountId)) {
                    OpportunityContactRole newOppContRole = new OpportunityContactRole();
                    newOppContRole.ContactId = createdContact.Id;
                    newOppContRole.OpportunityId = OpportunityFoundId; 
                    newOppContRole.Role = 'Business User';
                    oppContRoles.Add(newOppContRole);                
                }
            }   			
		}
    	if(!oppContRoles.isempty()){
    		insert oppContRoles;
    	}
	}    
}

@isTest static void TestUpdateAccountAddress() {
        
    List<ContactPointAddress> ContactPointAddresses = TestDataFactory.createContactPointAddresses(2,2,False);
    
    Test.StartTest();  
    insert ContactPointAddresses; 
    List<Account> modifiedAccounts = [select Id, ShippingCity from Account where ShippingCity = 'TestCity'];
    Test.stopTest();
    System.assertEquals(2, modifiedAccounts.size());
    
}	

@isTest static void TestDeleteAccountAddress() {
        
    List<ContactPointAddress> ContactPointAddresses = TestDataFactory.createContactPointAddresses(2,1,True);
    List<ContactPointAddress> ContactPointAddressesToDelete = new List<ContactPointAddress>();
    
    for (ContactPointAddress aContactPointAddress : ContactPointAddresses) {
        if (aContactPointAddress.IsDefault) ContactPointAddressesToDelete.add(aContactPointAddress);   
    }
    
    Test.StartTest();  
    delete ContactPointAddressesToDelete;
    List<ContactPointAddress> ContactPointAddresses1 = [select Id, Name from ContactPointAddress where Name = 'ContactPointAddressTest'];
    List<Account> modifiedAccounts = [select Id, Name, ShippingCity from Account where Name = 'AccountTest 0'];
    Test.stopTest();
    System.assertEquals(null, modifiedAccounts[0].ShippingCity);
    System.assertEquals(1, ContactPointAddresses.size());
}

: Address Name, Address, City, State/Province, Zip/Postal Code, Country.: