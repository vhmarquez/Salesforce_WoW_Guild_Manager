public with sharing class WoWCharacter {

    public static void createCharacterLead(String realmSlug, String characterName) {

        String characterProfile = WoWProfileAPI.fetchCharacterProfileSummary(realmSlug, characterName);
        CharacterProfileSummaryObject characterProfileObject = (CharacterProfileSummaryObject) JSON.deserialize(characterProfile.replaceAll('_links', 'links'), CharacterProfileSummaryObject.class);
        
        Id classId = [SELECT Id FROM Class__c WHERE Name =: characterProfileObject.character_class.name.en_US LIMIT 1].Id;
        Id specId = [SELECT Id FROM Specialization__c WHERE Class__c =: classId AND Name =: characterProfileObject.active_spec.name.en_US LIMIT 1].Id;
        Id realmId = [SELECT Id FROM Realm__c WHERE Name =: characterProfileObject.realm.name.en_US LIMIT 1].Id;

        Lead characterLead = new Lead(
            LastName=characterName,
            Company='WoW API',
            Realm__c=realmId,
            Faction__c=characterProfileObject.faction.name.en_US,
            Class__c=classId,
            Main_Spec__c=SpecId,
            Level__c=characterProfileObject.level,
            Item_Level__c=characterProfileObject.equipped_item_level,
            Race__c=characterProfileObject.race.name.en_US
        );

        try{
            if(Schema.SObjectType.Lead.isCreateable()
            && Schema.SObjectType.Lead.isUpdateable()){
                upsert characterLead;
            }
        } catch (DmlException e) {
            System.debug('The following exception has occurred when trying to upsert a Character Lead: ' + e.getMessage());
        }
    }

    public static void createCharacterModel(String realmSlug, String characterName) {

        String characterMedia = WoWProfileAPI.fetchCharacterMediaSummary(realmSlug, characterName);
        String characterEquipment = WoWProfileAPI.fetchCharacterEquipmentSummary(realmSlug, characterName);
        

        CharacterMediaSummaryObject characterMediaObject = (CharacterMediaSummaryObject) JSON.deserialize(characterMedia.replaceAll('_links', 'links'), CharacterMediaSummaryObject.class);
        CharacterEquipmentSummaryObject characterEquipmentObject = (CharacterEquipmentSummaryObject) JSON.deserialize(characterEquipment.replaceAll('set', 'set_bonus').replaceAll('_links', 'links').replaceAll('links', 'links_extra'), CharacterEquipmentSummaryObject.class);
        // ItemMediaObject media = (ItemMediaObject)JSON.deserialize(res.getBody().replaceAll('_links', 'links'), ItemMediaObject.class);

        // Id leadId = [SELECT Id FROM Lead WHERE LastName =: characterEquipmentObject.character.name AND Realm__c =: characterEquipmentObject.character.realm.name].Id;

    }

}