/**
* The  program implements an Mock for Test Class for Integeration
* @author  Manish Jha
* @version 1.0
* @since   2020-08-23
*/
@isTest
public with sharing class WorkforceHTTPMock implements HttpCalloutMock{
    private Integer statusCode;
    public workforceHTTPMock(Integer statusCode){
            this.statusCode = statusCode;
    }
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        if(statusCode == 200){
            response.setBody('{"success": true,"secretKey":"DADAD"}');
            response.setStatusCode(200);
        }else{
            response.setBody('{"success": false,"error":"Id doesnt exist"}');
            response.setStatusCode(500);
        }
        return response; 
    }
}
