public with sharing class oppInsert {
    public static void opportunityInsert(List<Opportunity> oppList){
        Set<Id> accToUpdate = new Set<Id>();
        for(Opportunity opp: oppList){
            accToUpdate.add(opp.AccountId); 
        }

        if (!accToUpdate.isEmpty()) {
            List<Account> accList = new List<Account>();
            DECIMAL mydecval = 0;
            List<AggregateResult> aggRes = [Select AccountId, sum(Amount) totalAmount from Opportunity where AccountId =: accToUpdate 
                                            group by AccountId] ;

            for (Opportunity opp : oppList) {
                for(AggregateResult agr : aggRes){
                    mydecval = (DECIMAL)agr.get('totalAmount');
                    Account accItem = new Account(); 
                    accItem.Id=(Id)agr.get('AccountId'); 
                    accItem.Total_Amount__c = mydecval;  
                    accList.add(accItem);
                }    
            }

            if(!accList.isEmpty()){
                update accList;
            }
        }
    }

}