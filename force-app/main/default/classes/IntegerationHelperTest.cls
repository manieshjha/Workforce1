/**
* The  program implements an Test Class for IntegerationHelper
* @author  Manish Jha
* @version 1.0
* @since   2020-08-23
*/
@isTest
public with sharing class IntegerationHelperTest {
    /* It will not need data setup as this only needs custom metadata*/
    @isTest static void testMethodWithMetadata() {
    Test.StartTest();
    for(Integration_Handler__mdt   handlerMetadata : [Select HTTP_Method__c,Named_Credential_Name__c,Request_Content_Type__c from Integration_Handler__mdt]){
        HTTPRequest request =  IntegerationHelper.createRequest(handlerMetadata,'body');
        System.assertEquals(request.getBody(),'body');
    }
    Test.StopTest();

    }
}
