/**
* The BatchClass program implements an application that
* will run with a batch of 50 every 30 minute which will 
* pickup 50 case records on 'Closure Initiated' state
* and will send it to WorkForce System
* @author  Manish Jha
* @version 1.0
* @since   2020-08-23
*/
global with sharing class WorkForceRequesterBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{
    private Integration_Handler__mdt handlerMetadata = new Integration_Handler__mdt	(); 
    private List<Case> caseRecordsToBeUpdated = new List<Case>();
    private static final rflib_Logger LOGGER = rflib_LoggerUtil.getFactory().createBatchedLogger('WorkForceHandler');
    private string filterStatus = 'Closed';
    //private filterStatus = 'Closure Initialised';
	public WorkForceRequesterBatch(String handlerName){
		handlerMetadata = [Select HTTP_Method__c,Named_Credential_Name__c,Request_Content_Type__c from Integration_Handler__mdt	 where DeveloperName= :handlerName LIMIT 1];
	}
	
    global Database.QueryLocator start(Database.BatchableContext bc){
        String soqlQuery = 'Select Id,Status,WF_Secret_Key__c,Case.Owner.Id from Case where status = :filterStatus';
        return Database.getQueryLocator(soqlQuery);
    }
     
    global void execute(Database.BatchableContext bc, List<Case> scope){
         
        for (Case caseIter : scope){
           
                try{
					HttpRequest request = new HttpRequest();
					HttpResponse response = new HttpResponse();
                    Http http = new Http();
                    WorkForceRequestResponseDTO.Request dto = new WorkForceRequestResponseDTO.Request();
					dto.id = caseIter.id;
					dto.agentid = caseIter.Owner.Id;
					request = IntegerationHelper.createRequest(handlerMetadata,dto.toString());
                    response = http.send(request);
                    if (response.getStatusCode() == 200) {
                        WorkForceRequestResponseDTO.Response jsonResponseObject = WorkForceRequestResponseDTO.parseResponse(response.getBody());
                        caseIter.WF_Secret_Key__c = jsonResponseObject.SecretKey;
                        caseIter.status = 'Closed';
                        
                        caseRecordsToBeUpdated.add(caseIter);
                    }else {
                        HandleException manException = new HandleException();
                        manException.setMessage('Status Code '+response.getStatusCode() + ' Message ' + response.getBody());
                        throw manException;
						//throw new ApexException();
					}
					//System.debug('Response-' + jsonResponse);
                }
            Catch(Exception e){
                LOGGER.ERROR('WorkForce Integeration Failed with message '+e.getMessage());  
           }finally {
               LOGGER.publishBatchedLogEvents();
           }
            
        }
        if(!caseRecordsToBeUpdated.isEmpty()){
            update caseRecordsToBeUpdated;
        }
    }
     
    global void finish(Database.BatchableContext bc){
         
    }
}
