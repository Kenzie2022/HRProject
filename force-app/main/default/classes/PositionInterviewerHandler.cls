public with sharing class PositionInterviewerHandler {
  public static void validatePositionInterviewer(List<Position_Interviewer__c> positionInterviewers){
   Set<Id> positionIds = new Set<Id>();
   Set<Id> InterviewerIds = new Set<Id>();
   Map<String,Position_Interviewer__c> positionInterviewerMap = new Map<String,Position_Interviewer__c>();
   for(Position_Interviewer__c pi : positionInterviewers){
      positionIds.add(pi.Position__c);
      InterviewerIds.add(pi.Interviewer__c);
    
      String myKey = string.valueOf(pi.Position__c) + String.valueOf(pi.Interviewer__c);
      positionInterviewerMap.put(myKey, pi);
    
    }
    system.debug('positionIds :' + positionIds);
    system.debug('interviewerIds :' + InterviewerIds);
    
    for (Position_Interviewer__c pi : [select Id, Position__c, Interviewer__c 
                                       FROM Position_Interviewer__c 
                                       WHERE Position__c IN: positionIds 
                                       And Interviewer__c IN: InterviewerIds]){
        String systemKey = string.valueOf(pi.Position__c) + string.valueOf(pi.Interviewer__c);
        Position_Interviewer__c toBeFailed = positionInterviewerMap.get(systemKey);
        if (toBeFailed != null) {
            toBeFailed.addError('This is a duplicate record of ' + string.valueOf(pi.Id));
            
        }
    }
}

}
