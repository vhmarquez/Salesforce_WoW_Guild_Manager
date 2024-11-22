public with sharing class WoWProfileAPI {
    
    public static void fetchRealmIndex(){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_WOW_Profile_API/data/wow/realm/index?locale=en_US&namespace=dynamic-us');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if(res.getStatusCode() == 200){
            RealmIndexObject realmIndex = new RealmIndexObject();
            realmIndex = (RealmIndexObject) JSON.deserialize(res.getBody().replaceAll('_links', 'links'), RealmIndexObject.class);
            
            List<Realm__c> realms = new List<Realm__c>();
            for(RealmIndexObject.realms realm : realmIndex.realms){
                realms.add(new Realm__c(Realm_ID__c=realm.id, Name=realm.name, Realm_Slug__c=realm.slug));
            }

            try{
                // if(!Schema.SObjectType.Realm__c.isCreateable() || !Schema.SObjectType.Realm__c.isUpdateable()){
                //     return null;
                // }
                upsert realms;
            } catch(DmlException e){
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
        } else {
            System.debug('Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
        }
        
        
    }

    public static void fetchCharacterProfileSummary(String realmSlug, String characterName){

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Profile_API/profile/wow/character/'+realmSlug+'/'+characterName+'?namespace=profile-us');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if(res.getStatusCode() == 200){
            CharacterProfileSummaryObject characterProfile = new CharacterProfileSummaryObject();
            characterProfile = (CharacterProfileSummaryObject) JSON.deserialize(res.getBody().replaceAll('_links', 'links'), CharacterProfileSummaryObject.class);

            //Lead character = new Lead(LastName=characterProfile.name, Realm__r=characterProfile.realm.name.en_US, Company='WoW API');
            System.debug(characterProfile);
        } else {
            System.debug('Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
        }
    }

    public static void fetchCharacterMediaSummary(String realmSlug, String characterName){

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Profile_API/profile/wow/character/'+realmSlug+'/'+characterName+'/character-media?namespace=profile-us&locale=en_US');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if(res.getStatusCode() == 200){
            CharacterMediaSummaryObject characterMedia = new CharacterMediaSummaryObject();
            characterMedia = (CharacterMediaSummaryObject) JSON.deserialize(res.getBody().replaceAll('_links', 'links'), CharacterMediaSummaryObject.class);
            System.debug(characterMedia);
        } else {
            System.debug('Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
        }
    }

    public static void fetchCharacterEquipmentSummary(String realmSlug, String characterName){

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_Profile_API/profile/wow/character/'+realmSlug+'/'+characterName+'/equipment?namespace=profile-us&locale=en_US');
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);
        if(res.getStatusCode() == 200){
            CharacterEquipmentSummaryObject characterEquipment = new CharacterEquipmentSummaryObject();
            characterEquipment = (CharacterEquipmentSummaryObject) JSON.deserialize(res.getBody().replaceAll('set', 'set_bonus').replaceAll('_links', 'links').replaceAll('links', 'links_extra'), CharacterEquipmentSummaryObject.class);
            System.debug(characterEquipment);
        } else {
            System.debug('Http request failed: ' + res.getStatusCode() + ' ' + res.getStatus());
        }

    }

}