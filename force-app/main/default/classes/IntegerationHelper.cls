/**
* The  program implements an application that
* helps creating request og the given handler name
* @author  Manish Jha
* @version 1.0
* @since   2020-08-23
*/
public with sharing class IntegerationHelper {
    public static HTTPRequest createRequest(Integration_Handler__mdt handler, String body){
        HttpRequest request = new HttpRequest();
        request.setHeader('Content-Type', handler.Request_Content_Type__c);
        request.setEndpoint(handler.Named_Credential_Name__c);
        request.setMethod(handler.HTTP_Method__c);
        request.setBody(body);
        return request;
}
}
