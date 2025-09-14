public class OpportunityCalloutService {
    
    @future(callout=true)
    public static void processAccountUpdates(set<Id> oppId) {
        
        String accessToken = generateAccessToken();
        system.debug('AccessToken'+accessToken);
        if (accessToken == null) {
            System.debug('Failed to retrieve access token.');
            return;
        }
        
        for (Opportunity opp : [select id, AccountId, Account.Name from Opportunity where Id IN:oppId]) {
            try {
                
                Map<String, String> payload = new Map<String, String>{
                    'AccountId' => opp.AccountId,
                        'AccountName'=>opp.Account.Name
                        };
                            
                system.debug('Payload'+payload);
                String requestBody = JSON.serialize(payload);
                system.debug('RequestBody'+requestBody);
                //string accessToken='00DIU000002NSNg!ARYAQIYCLv6F6jSrt__GrBsrwhHUmpX0MYlBFt33.7AhJQeWgmXd1yxuO_RvviwYrNVcmUQ9XYQAK6gllDO_.ajmtX7_bweJ';
                
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint('https://cloudyweb-dev-ed.develop.my.salesforce.com/services/apexrest/CreateOpportunity');
                request.setMethod('POST');
                request.setHeader('Authorization', 'Bearer '+accessToken);
                request.setHeader('Content-Type', 'application/json');
                request.setBody(requestBody);
                
                HttpResponse response = http.send(request);
                
                if (response.getStatusCode() == 200) {
                    System.debug('Callout successful: ' + response.getBody());
                } else {
                    System.debug('Callout failed: ' + response.getBody());
                }
            } catch (Exception ex) {
                System.debug('Exception occurred during callout: ' + ex.getMessage());
            }
        }
    }
    
    private static String generateAccessToken() {
        try {
            
            String tokenEndpoint = 'https://cloudyweb-dev-ed.develop.my.salesforce.com/services/oauth2/token';
            
            String clientId = '3MVG9uk_cDhyHiA5OznwIxs68q0wqI2lUxoWyKIr.14aEy_XHbiBM8L4VAUp2Syk6NNLL.8Ol4KP88XoZLfW9';
            String clientSecret = '36C1721A2AAA5A50E8723FB70E3993F4288763B95850618CCBBA2E9EF6B549F4'; 
            String username = 'missionprominent@gmail.com'; 
            String password = 'Welcome11@Ntgku2j6Y2qzSNqCKQTwc0Ea';
            
            
            String requestBody = 'grant_type=password'
                + '&client_id=' + EncodingUtil.urlEncode(clientId, 'UTF-8')
                + '&client_secret=' + EncodingUtil.urlEncode(clientSecret, 'UTF-8')
                + '&username=' + EncodingUtil.urlEncode(username, 'UTF-8')
                + '&password=' + EncodingUtil.urlEncode(password, 'UTF-8');
            
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(tokenEndpoint);
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.setBody(requestBody);
            
            HttpResponse response = http.send(request);
         
            if (response.getStatusCode() == 200) {
                Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                return (String) responseBody.get('access_token');
            } else {
                System.debug('Failed to retrieve access token: ' + response.getBody());
                return null;
            }
        } catch (Exception ex) {
            System.debug('Exception occurred while generating access token: ' + ex.getMessage());
            return null;
        }
        
    }
}