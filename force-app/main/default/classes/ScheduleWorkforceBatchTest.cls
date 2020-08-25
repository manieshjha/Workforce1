/**
* The  program implements an Test Class for ScheduleWorkforceBatch class
* @author  Manish Jha
* @version 1.0
* @since   2020-08-23
*/
@isTest
public with sharing class ScheduleWorkforceBatchTest {
    public ScheduleWorkforceBatchTest() {

    }
    public static testMethod void testschedule() {
        ScheduleWorkforceBatch sh1 = new ScheduleWorkforceBatch();
        String sch = '0 0 23 * * ?'; 
        Test.StartTest();
        system.schedule('Test WOrkforce Check', sch, sh1); 
        Test.StopTest(); }
}
