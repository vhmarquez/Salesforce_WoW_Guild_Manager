import { LightningElement, api, wire } from 'lwc';
import { getRecord } from "lightning/uiRecordApi";
// import CHARACTER_MODEL from '@salesforce/schema/Character_Model__c';

const FIELDS = [
    'Character_Model__c.Avatar__c',
    'Character_Model__c.Inset__c',
    'Character_Model__c.Main_Raw__c',
    'Character_Model__c.Head__c',
    'Character_Model__c.Neck__c',
    'Character_Model__c.Shoulders__c',
    'Character_Model__c.Chest__c',
    'Character_Model__c.Waist__c',
    'Character_Model__c.Legs__c',
    'Character_Model__c.Feet__c',
    'Character_Model__c.Wrist__c',
    'Character_Model__c.Hands__c',
    'Character_Model__c.Finger__c',
    'Character_Model__c.Finger_2__c',
    'Character_Model__c.Trinket_1__c',
    'Character_Model__c.Trinket_2__c',
    'Character_Model__c.Back__c',
    'Character_Model__c.Main_Hand__c',
    'Character_Model__c.Off_Hand__c',
    'Character_Model__c.Tabard__c'
];

export default class CharacterModel extends LightningElement {

    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    characterModel;

    get characterRender() {
        return this.characterModel.data.fields.Main_Raw__c.value;
    }

}