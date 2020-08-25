/**
* The  program implements an Test Class for WorkForceRequesterBatch class
* @author  Manish Jha
* @version 1.0
* @since   2020-08-23
*/
@isTest
private class WorkForceRequesterBatchTest {
 /* Method to setup data */
    @testSetup static void setup() {
        /* Create common test Accounts */
        List<Case> testCases = new List<Case>();
        for(Integer i=0;i<2;i++) {
            testCases.add(new Case(Status = 'New'));
        }
        insert testCases;     
    }
    /*Test Batch class for Successful Scenario*/
    @isTest static void testMethodSuccess() {
        Test.setMock(HttpCalloutMock.class, new WorkforceHTTPMock(200));  
        List<Case> caseList =new List<Case>();
        for(Case cs: [Select Id, Status from case]){
                cs.Status = 'Closure Initiated';
                caseList.add(cs);
        }
        if(!caseList.isEmpty())
            update caseList;
        Test.StartTest();
        Id batchJobId = Database.executeBatch(new WorkForceRequesterBatch('WorkForce_Handler'), 200);
        Test.StopTest();
        for(Case cs: [Select Id, Status from case]){
            System.assertEquals(cs.Status,'Closed');
        }
        

    }
    /*Test Batch class for Failureful Scenario*/
    @isTest static void testMethodFailure() {
        Test.setMock(HttpCalloutMock.class, new WorkforceHTTPMock(500));  
        List<Case> caseList =new List<Case>();
        for(Case cs: [Select Id, Status from case]){
                cs.Status = 'Closure Initiated';
                caseList.add(cs);
        }
        if(!caseList.isEmpty())
            update caseList;
        Test.StartTest();
        Id batchJobId = Database.executeBatch(new WorkForceRequesterBatch('WorkForce_Handler'), 200);
        Test.StopTest();
        for(Case cs: [Select Id, Status from case]){
            System.assertEquals(cs.Status,'Closure Initiated');
        }

    }
}
