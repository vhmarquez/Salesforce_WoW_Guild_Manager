public with sharing class WoWProfileAPI {
    
    public static void fetchRealmIndex(){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:US_WOW_Profile_API/data/wow/realm/index?locale=en_US&namespace=dynamic-us');
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        RealmIndexObject realmIndex = new RealmIndexObject();
        realmIndex = (RealmIndexObject) JSON.deserialize(res.getBody().replaceAll('_links', 'links'), RealmIndexObject.class);
        
        List<Realm__c> realms = new List<Realm__c>();
        for(RealmIndexObject.realms realm : realmIndex.realms){
            realms.add(new Realm__c(Realm_ID__c=realm.id, Name=realm.name, Realm_Slug__c=realm.slug, Region__c=locale));
        }

        try{
            if(!Schema.SObjectType.Realm__c.isCreateable() || !Schema.SObjectType.Realm__c.isUpdateable()){
                return null;
            }
            upsert realms;
        } catch(DmlException e){
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }

}