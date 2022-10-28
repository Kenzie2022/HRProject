@isTest
private class TestSchPurgePositions {
   
    @IsTest
    static void tester(){
        HR_Manager__c manager = new HR_Manager__c(Name = 'Test Organizer',  
                                          Email__c = 'testemail@gmail.com', 
                                          Phone__c = '63543435677');
        insert manager;

        List<Position__c> positions = new List<Position__c>();
        for (integer i =0; i<200; i++) {
            positions.add (new Position__c(HR_Manager__c = Manager.Id,
                                           Name__c = 'Test Position' + string.valueof(i), 
                                           Start_Date_Time__c = Datetime.now().addMonths(-3),
                                           End_Date_Time__c = Datetime.now().addMonths(-3).addDays(1),
                                           Live__c = true));

        insert positions; 

        test.startTest();                     
        SchPurgePositions obj = new SchPurgePositions();
        obj.execute(null);

        test.stopTest();

        Integer positionCount = [select COUNT() FROM Position__c];
        system.assertEquals(0, positionCount);




      }
       
        
    }
   
}
