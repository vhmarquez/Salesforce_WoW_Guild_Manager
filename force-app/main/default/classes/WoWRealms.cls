public with sharing class WoWRealms {
    
    public static void createAllRealms() {

        String getRealms = WoWProfileAPI.fetchRealmIndex();
        RealmIndexObject realmIndex = (RealmIndexObject) JSON.deserialize(res.getBody().replaceAll('_links', 'links'), RealmIndexObject.class);
        
        List<Realm__c> realms = new List<Realm__c>();
        for(RealmIndexObject.realms realm : realmIndex.realms){
            realms.add(new Realm__c(Realm_ID__c=realm.id, Name=realm.name, Realm_Slug__c=realm.slug));
        }

        try{
            upsert realms;
        } catch(DmlException e){
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }
}