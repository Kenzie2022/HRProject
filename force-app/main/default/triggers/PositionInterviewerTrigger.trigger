trigger PositionInterviewerTrigger on Position_Interviewer__c (before insert, before update) {
    if (trigger.isBefore) {
        if (trigger.isInsert || trigger.isUpdate) {
            PositionInterviewerHandler.validatePositionInterviewer(trigger.new);
            
        }
    

}
}