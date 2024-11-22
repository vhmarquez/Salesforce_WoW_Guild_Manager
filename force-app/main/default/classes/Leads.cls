public with sharing class Leads {

    private String realmSlug;
    private String characterName;
    private String locale;
    private String namespaceProfile;
    
    public Leads() { }

    public Leads(String realmSlug, String characterName, String locale, String namespaceProfile) {

        this.realmSlug = realmSlug;
        this.characterName = characterName;
        this.locale = locale;
        this.namespaceProfile = namespaceProfile;

        String characterProfile = WoWProfileAPI.fetchCharacterProfileSummary(realmSlug, characterName, namespaceProfile);
        String characterEquipment = WoWProfileAPI.fetchCharacterEquipmentSummary(realmSlug, characterName, namespaceProfile, locale);
        String characterMedia = WoWProfileAPI.fetchCharacterMediaSummary(realmSlug, characterName, namespaceProfile, locale);

        CharacterProfileSummaryObject characterProfileObject = (CharacterProfileSummaryObject) JSON.deserialize(characterProfile.replaceAll('_links', 'links'), CharacterProfileSummaryObject.class);
        CharacterEquipmentSummaryObject characterEquipmentObject = (CharacterEquipmentSummaryObject) JSON.deserialize(characterEquipment.replaceAll('set', 'set_bonus').replaceAll('_links', 'links').replaceAll('links', 'links_extra'), CharacterEquipmentSummaryObject.class);
        CharacterMediaSummaryObject characterMediaObject = (CharacterMediaSummaryObject) JSON.deserialize(characterMedia.replaceAll('_links', 'links'), CharacterMediaSummaryObject.class);

        List<Class__c> classId = [SELECT Id FROM Class__c WHERE Name =: characterProfileObject.character_class.name.en_US];
        List<Specialization__c> classSpecId = [SELECT Id FROM Specialization__c WHERE Class__c =: classId AND Name =: characterProfileObject.active_spec.name.en_US];

        Lead lead = new Lead(
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
            upsert lead;
        } catch (DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }

    }

}