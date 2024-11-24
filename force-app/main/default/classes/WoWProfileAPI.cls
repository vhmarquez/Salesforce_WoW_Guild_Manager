public with sharing class WoWProfileAPI {
    
    public static String fetchRealmIndex(){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Profile_API/data/wow/realm/index?locale=en_US&namespace=dynamic-us');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if(res.getStatusCode() != 200){
            System.debug('Realm Index Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
            return null;
        }

        return res.getBody();
    }

    public static String fetchCharacterProfileSummary(String realmSlug, String characterName){

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Profile_API/profile/wow/character/'+realmSlug+'/'+characterName+'?namespace=profile-us');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if(res.getStatusCode() != 200){
            System.debug('Character Profile Summary Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
            return null;
        }

        return res.getBody();
    }

    public static String fetchCharacterMediaSummary(String realmSlug, String characterName){

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Profile_API/profile/wow/character/'+realmSlug+'/'+characterName+'/character-media?namespace=profile-us&locale=en_US');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if(res.getStatusCode() != 200){
            System.debug('Character Media Summary Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
            return null;
        }

        return res.getBody();
    }

    public static String fetchCharacterEquipmentSummary(String realmSlug, String characterName){

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Profile_API/profile/wow/character/'+realmSlug+'/'+characterName+'/equipment?namespace=profile-us&locale=en_US');
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);

        if(res.getStatusCode() != 200){
            System.debug('Character Equipment Summary Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
            return null;
        }

        return res.getBody();
    }

}