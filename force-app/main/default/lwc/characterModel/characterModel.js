import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, getFieldValue, getRecords } from 'lightning/uiRecordApi';
import MISSING_ITEM_URL from '@salesforce/resourceUrl/missing_item';

import APPLICANT_CHARACTER_MODEL_ID_FIELD from '@salesforce/schema/Guild_Applicant__c.Character_Model__r.Id';
import MEMBER_CHARACTER_MODEL_ID_FIELD from '@salesforce/schema/Guild_Member__c.Character_Model__r.Id';

import CHARACTER_MODEL_MAIN_RAW_FIELD from '@salesforce/schema/Character_Model__c.Main_Raw__c';
import CHARACTER_MODEL_HEAD_FIELD from '@salesforce/schema/Character_Model__c.Head__c';
import CHARACTER_MODEL_NECK_FIELD from '@salesforce/schema/Character_Model__c.Neck__c';
import CHARACTER_MODEL_SHOULDER_FIELD from '@salesforce/schema/Character_Model__c.Shoulders__c';
import CHARACTER_MODEL_CHEST_FIELD from '@salesforce/schema/Character_Model__c.Chest__c';
import CHARACTER_MODEL_MAIN_HAND_FIELD from '@salesforce/schema/Character_Model__c.Main_Hand__c';
import CHARACTER_MODEL_OFF_HAND_FIELD from '@salesforce/schema/Character_Model__c.Off_Hand__c';
import CHARACTER_MODEL_WAIST_FIELD from '@salesforce/schema/Character_Model__c.Waist__c';
import CHARACTER_MODEL_LEGS_FIELD from '@salesforce/schema/Character_Model__c.Legs__c';
import CHARACTER_MODEL_FEET_FIELD from '@salesforce/schema/Character_Model__c.Feet__c';
import CHARACTER_MODEL_WRIST_FIELD from '@salesforce/schema/Character_Model__c.Wrist__c';
import CHARACTER_MODEL_HANDS_FIELD from '@salesforce/schema/Character_Model__c.Hands__c';
import CHARACTER_MODEL_FINGER_FIELD from '@salesforce/schema/Character_Model__c.Finger__c';
import CHARACTER_MODEL_FINGER_2_FIELD from '@salesforce/schema/Character_Model__c.Finger_2__c';
import CHARACTER_MODEL_TRINKET_1_FIELD from '@salesforce/schema/Character_Model__c.Trinket_1__c';
import CHARACTER_MODEL_TRINKET_2_FIELD from '@salesforce/schema/Character_Model__c.Trinket_2__c';
import CHARACTER_MODEL_TABARD_FIELD from '@salesforce/schema/Character_Model__c.Tabard__c';
import CHARACTER_MODEL_BACK_FIELD from '@salesforce/schema/Character_Model__c.Back__c';

const GUILD_FIELDS = [
    APPLICANT_CHARACTER_MODEL_ID_FIELD,
    MEMBER_CHARACTER_MODEL_ID_FIELD
];

const CHARACTER_MODEL_FIELDS = [
    CHARACTER_MODEL_MAIN_RAW_FIELD,
    CHARACTER_MODEL_HEAD_FIELD,
    CHARACTER_MODEL_NECK_FIELD,
    CHARACTER_MODEL_SHOULDER_FIELD,
    CHARACTER_MODEL_CHEST_FIELD,
    CHARACTER_MODEL_MAIN_HAND_FIELD,
    CHARACTER_MODEL_OFF_HAND_FIELD,
    CHARACTER_MODEL_WAIST_FIELD,
    CHARACTER_MODEL_LEGS_FIELD,
    CHARACTER_MODEL_FEET_FIELD,
    CHARACTER_MODEL_WRIST_FIELD,
    CHARACTER_MODEL_HANDS_FIELD,
    CHARACTER_MODEL_FINGER_FIELD,
    CHARACTER_MODEL_FINGER_2_FIELD,
    CHARACTER_MODEL_TRINKET_1_FIELD,
    CHARACTER_MODEL_TRINKET_2_FIELD,
    CHARACTER_MODEL_TABARD_FIELD,
    CHARACTER_MODEL_BACK_FIELD
];

export default class CharacterModel extends LightningElement {

    @api recordId;
    @api characterModelId;
    missingItemUrl = MISSING_ITEM_URL;

    @wire(getRecord, { recordId: "$recordId", fields: GUILD_FIELDS})
    guild({ error, data }) {
        if (data) {
            if (APPLICANT_CHARACTER_MODEL_ID_FIELD != null){
                this.characterModelId = getFieldValue(data, APPLICANT_CHARACTER_MODEL_ID_FIELD);
            } else if (MEMBER_CHARACTER_MODEL_ID_FIELD != null){
                this.characterModelId = getFieldValue(data, MEMBER_CHARACTER_MODEL_ID_FIELD);
            }            
        } else if (error) {
            console.log(error);
        }
    };

    @wire(getRecord, { recordId: "$characterModelId", fields: CHARACTER_MODEL_FIELDS})
    characterModel;

    get characterRender() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_MAIN_RAW_FIELD);
    }

    get head() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_HEAD_FIELD);
    }

    get neck() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_NECK_FIELD);
    }

    get shoulders() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_SHOULDER_FIELD);
    }

    get chest() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_CHEST_FIELD);
    }

    get waist() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_WAIST_FIELD);
    }

    get legs() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_LEGS_FIELD);
    }

    get feet() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_FEET_FIELD);
    }

    get wrist() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_WRIST_FIELD);
    }

    get hands() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_HANDS_FIELD);
    }

    get finger() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_FINGER_FIELD);
    }

    get finger_2() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_FINGER_2_FIELD);
    }

    get trinket() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_TRINKET_1_FIELD);
    }

    get trinket_2() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_TRINKET_2_FIELD);
    }

    get back() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_BACK_FIELD);
    }

    get main_hand() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_MAIN_HAND_FIELD);
    }

    get off_hand() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_OFF_HAND_FIELD);
    }

    get tabard() {
        return getFieldValue(this.characterModel.data, CHARACTER_MODEL_TABARD_FIELD);
    }

}