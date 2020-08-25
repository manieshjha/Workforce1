/**
* The  program implements an Test Class for WorkForceRequestResponseDTO class
* @author  Manish Jha
* @version 1.0
* @since   2020-08-23
*/
@isTest
public with sharing class WorkForceRequestResponseDTOTest {
    /*This doesn't need Data Setup as it only parses JSON*/
    @isTest static void testMethodForRequest() {
        String json='{"id":"5000K00002AR7FA","agentid":"00528000002V3gB"}';
        WorkForceRequestResponseDTO.Request obj = new WorkForceRequestResponseDTO.Request();
        Test.StartTest();
        obj = WorkForceRequestResponseDTO.parseRequest(json);
        Test.StopTest();
		System.assertEquals(obj.id,'5000K00002AR7FA');
    }
 
    @isTest static void testMethodForResponse() {
        String json='{"success":true,"secretKey":"aagagfgsgdgdgdgs"}';
        WorkForceRequestResponseDTO.Response obj = new WorkForceRequestResponseDTO.Response();
        Test.StartTest();
        obj = WorkForceRequestResponseDTO.parseResponse(json);
        Test.StopTest();
		System.assertEquals(obj.secretKey,'aagagfgsgdgdgdgs');
  
    }
}
