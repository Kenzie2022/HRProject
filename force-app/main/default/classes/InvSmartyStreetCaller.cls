public with sharing class InvSmartyStreetCaller {
    @InvocableMethod(label='Call SmartyStreet' description='Makes Callouts to SmartyStreet API.')
    public static void makeCallout(List<id> locationIds){
        Id locIs = locationIds[0];

        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://kenziecompany-dev-ed.lightning.force.com/lightning/r/Locations__c/a014x00000bUcKdAAK/view');
            request.setMethod('GET');
            HttpResponse response = http.send(request);

        
            system.debug('resp:' +response.getbody());
            Boolean isSuccess = response.getStatusCode() ==200;
            update new Locations__c(id=locIs, Verified__c= isSuccess);
            
        } catch (Exception exc) {
            ErrorLogHelper.createErrorLog('Call SmartyStreet', exc.getMessage());
  
        }
    }
}