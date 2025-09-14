trigger AccountTrigger on Account (after update) {
    // Create a list to store accounts with changed Rating
   /* List<Account> accountsWithChangedRating = new List<Account>();

    // Iterate through the updated accounts
    for (Account acc : Trigger.new) {
        Account oldAcc = Trigger.oldMap.get(acc.Id);
        // Check if the Rating field has changed
        if (acc.Rating != oldAcc.Rating) {
            accountsWithChangedRating.add(acc);
        }
    }

    // Serialize the list of changed accounts to a JSON string
    if (!accountsWithChangedRating.isEmpty()) {
        String jsonData = JSON.serialize(accountsWithChangedRating);
        SalesforceIntegrationClass.updateRecord(jsonData);
    } */
    
    if(Trigger.isAfter && Trigger.isUpdate){
         accountHandlerClass.updateRating(Trigger.New, Trigger.OldMap);
         accountHandlerClass.updateAccount(Trigger.New, Trigger.OldMap);
    }
}