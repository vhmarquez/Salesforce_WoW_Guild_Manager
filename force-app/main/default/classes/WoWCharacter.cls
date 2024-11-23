public with sharing class WoWCharacter {

    public static Lead createCharacterLead(String realmSlug, String characterName, String locale, String namespaceProfile) {

        String characterProfile = WoWProfileAPI.fetchCharacterProfileSummary(realmSlug, characterName, namespaceProfile);
        CharacterProfileSummaryObject characterProfileObject = (CharacterProfileSummaryObject) JSON.deserialize(characterProfile.replaceAll('_links', 'links'), CharacterProfileSummaryObject.class);
        
        Id classId = [SELECT Id FROM Class__c WHERE Name =: characterProfileObject.character_class.name.en_US LIMIT 1].Id;
        Id specId = [SELECT Id FROM Specialization__c WHERE Class__c =: classId AND Name =: characterProfileObject.active_spec.name.en_US LIMIT 1].Id;

        Lead characterLead = new Lead(
            LastName=characterName,
            Company='WoW API',
            Realm__c=characterProfileObject.realm.name.en_US,
            Faction__c=characterProfileObject.faction.name.en_US,
            Class__c=classId.get(0).Id,
            Main_Spec__c=classSpecId.get(0).Id,
            Level__c=characterProfileObject.level,
            Item_Level__c=characterProfileObject.equipped_item_level,
            Race__c=characterProfileObject.race.name.en_US,
            Achievement_Points__c=characterProfileObject.achievement_points,
            Character_Render__c=characterMediaObject.assets[2].value
        );

        try{
            upsert characterLead;
        } catch (DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }

    public static void createCharacterModel(String realmSlug, String characterName, String locale, String namespaceProfile) {

        String characterMedia = WoWProfileAPI.fetchCharacterMediaSummary(realmSlug, characterName, namespaceProfile, locale);
        String characterEquipment = WoWProfileAPI.fetchCharacterEquipmentSummary(realmSlug, characterName, namespaceProfile, locale);

        CharacterMediaSummaryObject characterMediaObject = (CharacterMediaSummaryObject) JSON.deserialize(characterMedia.replaceAll('_links', 'links'), CharacterMediaSummaryObject.class);
        CharacterEquipmentSummaryObject characterEquipmentObject = (CharacterEquipmentSummaryObject) JSON.deserialize(characterEquipment.replaceAll('set', 'set_bonus').replaceAll('_links', 'links').replaceAll('links', 'links_extra'), CharacterEquipmentSummaryObject.class);

        Id leadId = [SELECT Id FROM Lead WHERE LastName =: characterEquipmentObject.character.name AND Realm__c =: characterEquipmentObject.character.realm.name].Id;

    }

}