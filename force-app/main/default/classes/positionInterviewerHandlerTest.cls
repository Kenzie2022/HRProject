@isTest
public  class positionInterviewerHandlerTest {
   @TestSetup
   static void prepareData(){
    HR_Manager__c manager = new HR_Manager__c(Name = 'Test Organizer',  
                                          Email__c = 'testemail@gmail.com', 
                                          Phone__c = '63543435677');
    insert manager;
    Position__c position = new Position__c(Name__c = 'Test Position', 
                                     HR_Manager__c = Manager.Id,
                                     Start_Date_Time__c = Datetime.now().addDays(1));
    insert position;
    Interviewer__c interviewer = new Interviewer__c(Name = 'test interviewer',
                                                    Email__c = 'testb@gmail.com',
                                                    Phone__c = '98664433');
    insert interviewer;
    Position_Interviewer__c positionInterviewer = new Position_Interviewer__c(position__c = position.Id,
                                                                              Interviewer__c = interviewer.Id);
    insert positionInterviewer;

    
   }
   @istest
    static void testPositive() {
        Position_Interviewer__c systemRecord = [select Position__c, Interviewer__c 
                                                FROM Position_Interviewer__c LIMIT 1];
        test.startTest();
        try {
            insert new Position_Interviewer__c(Position__c = systemRecord.Position__c,
                                               Interviewer__c = systemRecord.Interviewer__c);
        } catch (Exception exc) {
          Test.stopTest();
          Integer systemCount = [select COUNT()FROM Position_Interviewer__c ];           
        }
    }
    @istest
     static void testNegative() {
        delete [select Id FROM Position_Interviewer__c LIMIT 1];
        Position__c position = [select Id FROM Position__c LIMIT 1];
        Interviewer__c interviewer = [select Id FROM Interviewer__c LIMIT 1];
        
         test.startTest();
         insert new Position_Interviewer__c( Position__c = position.Id,
                                            Interviewer__c = interviewer.ID);
         test.stopTest();
         
         Integer systemCount = [select COUNT() FROM Position_Interviewer__c];
         system.assertEquals(1, systemCount);

         
    }
   }
   

