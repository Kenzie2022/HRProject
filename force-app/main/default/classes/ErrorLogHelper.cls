public with sharing class ErrorLogHelper {
    public static void createErrorLog(string processName, String logDetails, string ClassName) {
        insert new Error_Log__c(Process_Name__c = processName,
                                Log_Details__c = logDetails,
                                Apex_Class__c = ClassName,
                                Log_Date_Time__c = Datetime.now());
    }
      
}
 