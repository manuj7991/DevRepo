public class AccountConsumeService {

    @AuraEnabled(cacheable=true)
    public static List<Object> getAccountsCvent(){
        
        List<Object> resMap = new List<Account>();
        Map<String,Account> mapRes = new Map<String,Account>(); 
        String url = 'https://cvent4-dev-ed.my.salesforce.com/services/oauth2/token?';
        url+='grant_type=password&client_id=3MVG9fe4g9fhX0E4X8P7GF02_G62UYFOU2Bo9NZum1NGiLBfIxb3glPwm8xCfvwcQE44OGGhFTcgv0WB.GgDq'; 
        url+='&client_secret=4299437CC28C40590E369450BEC02C152F393B7DFDB0968307D4DC32BAC3CCEA';
        url+='&username=manujp101@gmail.com';
        url+='&password=manuj791'+'jmHUJSydzhfpeuqaZU5R6G2xI';
                
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setHeader('Accept','application/json');
        
        HttpResponse res = h.send(req);
        //System.debug('res :'+res.getBody());
        
        String accsToken = '';
        JSONParser parser1 = JSON.createParser(res.getBody());
        while(parser1.nextToken() != null){
            
            if((parser1.getCurrentToken() == JSONToken.FIELD_NAME) && (parser1.getText() == 'access_token' ) ){
                parser1.nextToken();
                accsToken = parser1.getText();
            }
        }
        
        req = new HttpRequest();
        req.setEndpoint('https://cvent4-dev-ed.my.salesforce.com/services/apexrest/AccountRecord?accountid=0015g000006xd1vAAA');
        req.setMethod('GET');
        req.setHeader('Authorization','Bearer '+accsToken);
        req.setHeader('Content-Type','application/json');
        req.setHeader('Accept','application/json');
            
        res = h.send(req);
        try{
         
            if(res.getstatusCode() == 200 && res.getbody() != null){
          
                //system.debug(json.deserializeUntyped(res.getBody()));
                resMap = (List<Object>) JSON.deserializeUntyped(res.getBody());
                //system.debug('MAP COLLECTION: '+ mapRes);
                /*for(String itr:mapRes.keySet()){

                    resMap.add(mapRes.get(itr));
                }*/
                
             }
        }
        catch(Exception ex){

            system.debug('Exception :'+ex.getMessage());
            //throw new AuraHandledException('Error: '
            //+ ex.getMessage());  
        }
        system.debug('Result :'+resMap);
        return resMap;
    }
    
    
    public class OAuth2{
       public String id{get;set;}
       public String issued_at{get;set;}
       public String instance_url{get;set;}
       public String signature{get;set;}
       public String access_token{get;set;}    
    }
  
}