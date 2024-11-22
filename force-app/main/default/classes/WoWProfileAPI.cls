public with sharing class WoWProfileAPI {
    
    public static String fetchRealmIndex(){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Profile_API/data/wow/realm/index?locale=en_US&namespace=dynamic-us');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if(res.getStatusCode() == 200){
            // RealmIndexObject realmIndex = new RealmIndexObject();
            // realmIndex = (RealmIndexObject) JSON.deserialize(res.getBody().replaceAll('_links', 'links'), RealmIndexObject.class);
            
            // List<Realm__c> realms = new List<Realm__c>();
            // for(RealmIndexObject.realms realm : realmIndex.realms){
            //     realms.add(new Realm__c(Realm_ID__c=realm.id, Name=realm.name, Realm_Slug__c=realm.slug));
            // }

            // try{
            //     // if(!Schema.SObjectType.Realm__c.isCreateable() || !Schema.SObjectType.Realm__c.isUpdateable()){
            //     //     return null;
            //     // }
            //     upsert realms;
            // } catch(DmlException e){
            //     System.debug('The following exception has occurred: ' + e.getMessage());
            // }
            return res.getBody();
        } else {
            System.debug('Realm Index Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
        }

        return null;
    }

    public static String fetchCharacterProfileSummary(String realmSlug, String characterName, String namespaceProfile){

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Profile_API/profile/wow/character/'+realmSlug+'/'+characterName+'?namespace='+namespaceProfile);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if(res.getStatusCode() != 200){
            System.debug('Character Profile Summary Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
        }

        return res.getBody();
    }

    public static String fetchCharacterMediaSummary(String realmSlug, String characterName, String namespaceProfile, String locale){

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Profile_API/profile/wow/character/'+realmSlug+'/'+characterName+'/character-media?namespace='+namespaceProfile+'&locale='+locale);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if(res.getStatusCode() != 200){
            System.debug('Character Media Summary Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
        }

        return res.getBody();
    }

    public static String fetchCharacterEquipmentSummary(String realmSlug, String characterName, String namespaceProfile, String locale){

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Profile_API/profile/wow/character/'+realmSlug+'/'+characterName+'/equipment?namespace='+namespaceProfile+'&locale='+locale);
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);

        if(res.getStatusCode() == 200){
            System.debug('Character Equipment Summary Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
        }

        return res.getBody();
    }

}