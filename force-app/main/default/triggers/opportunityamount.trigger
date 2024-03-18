trigger opportunityamount on Opportunity (after insert, after update) {
    // Once amount on any opportunity linked to account is updated the total amount 
    //of all opportunities linked to the account should be updated on the account field.
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
            oppInsert.opportunityInsert(Trigger.new);
        }
    }
}