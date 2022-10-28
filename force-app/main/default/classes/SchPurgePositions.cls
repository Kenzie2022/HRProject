public with sharing class SchPurgePositions implements Database.Batchable<sObject>, Schedulable{
   public  void execute(SchedulableContext sc) {
    Database.executeBatch(new SchPurgePositions());
   
}
   
     public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select id FROM Position__c 
                                         WHERE End_Date_Time__c <=: Datetime.now().addMonths(-2) 
                                          And Live__c = false]);
     }
  
     public void execute(Database.BatchableContext bc, List<Position__c> positions){
        delete positions;
     
      }
  
     public void finish(Database.BatchableContext bc){
        Set<Id> userIds = new Set<Id>();
        for (GroupMember gm: [select UserOrGroupId FROM GroupMember
                               WHERE  Group.Name = 'Daily Job']){

            userIds.add(gm.UserOrGroupId);
        }
        Set<String> emailAddresses = new Set<String>();
        for (User us  : [select Email FROM User 
                         WHERE IsActive = true AND Id IN: userIds ]) {
            
        }
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('Daily Postion Job Completed');
        mail.setSenderDisplayName(' SI Salesforce Robot');
        mail.setPlainTextBody('Daily purge Postion job is completed. You can check Setup -> Apex jobs.');
        mail.setHtmlBody('<p>Daily purge Postion job is completed. You can check Setup -> Apex jobs.<p>');
        mail.setToAddresses(new list<String>(emailAddresses));

        Messaging.sendEmail(new list<Messaging.SingleEmailMessage>{mail});
   }
}





      