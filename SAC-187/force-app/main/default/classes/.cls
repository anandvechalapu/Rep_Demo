trigger InstituteStatusTrigger on Institute__c (after update) { 
 
    // Store Ids of Student records to update 
    Set<Id> studentIds = new Set<Id>(); 
 
    // Get the time 30 days ago 
    Date thirtyDaysAgo = Date.today().addDays(-30); 
 
    // Get list of Scholar__c records related to the Institute__c record 
    List<Student__c> students = [SELECT Id, Status__c FROM Student__c WHERE Institute__c IN :Trigger.new]; 
 
    // Iterate over the list of Scholar__c records 
    for (Student__c student : students) { 
        // Check if the Status__c was created more than 30 days ago 
        if (student.Status__c < thirtyDaysAgo) { 
            // Add the Id to the list of records to update 
            studentIds.add(student.Id); 
        } 
    } 
 
    // Update the Status__c to Inactive 
    List<Student__c> studentUpdates = new List<Student__c>(); 
    for (Id studentId : studentIds) { 
        Student__c student = new Student__c(Id = studentId, Status__c = 'Inactive'); 
        studentUpdates.add(student); 
    } 
    update studentUpdates; 
}