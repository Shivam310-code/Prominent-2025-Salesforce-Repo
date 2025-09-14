public class AccountAnnualRevenueMultiplier {
    
    public static void multiplyAnnualRevenue(Id accId){
        
        Account accValue = [SELECT Id, Name, AnnualRevenue FROM Account where Id =: accId];
        if(accValue.AnnualRevenue != Null){
            accValue.AnnualRevenue = accValue.AnnualRevenue * 1.5;
            update accValue;
        }
    }

}