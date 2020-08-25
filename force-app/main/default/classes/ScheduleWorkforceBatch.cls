/**
* The  program Schedules WorkForceRequesterBatch batch class
* @author  Manish Jha
* @version 1.0
* @since   2020-08-23
*/
global class ScheduleWorkforceBatch implements Schedulable { 
    global void execute(SchedulableContext SC) { 
        Id batchJobId = Database.executeBatch(new WorkForceRequesterBatch('WorkForce_Handler'), Integer.valueOf(Label.WorkforceBatchSize));

  }
 
}