import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import MISSING_ITEM_URL from '@salesforce/resourceUrl/missing_item';

import APPLICANT_CHARACTER_MODEL_ID_FIELD from '@salesforce/schema/Guild_Applicant__c.Character_Model__r.Id';
import MEMBER_CHARACTER_MODEL_ID_FIELD from '@salesforce/schema/Guild_Member__c.Character_Model__r.Id';

import CHARACTER_MODEL_OBJECT from '@salesforce/schema/Character_Model__c';

const GUILD_FIELDS = [
    APPLICANT_CHARACTER_MODEL_ID_FIELD,
    MEMBER_CHARACTER_MODEL_ID_FIELD
];

let CHARACTER_MODEL_FIELDS = [];

export default class CharacterModel extends LightningElement {

    @api recordId;
    @api characterModelId;
    @api objectApiName;

    @track objectInfo;

    missingItemUrl = MISSING_ITEM_URL;

    @wire(getObjectInfo, { objectApiName: CHARACTER_MODEL_OBJECT })
    objectInfo;

    @wire(getRecord, { recordId: "$recordId", fields: GUILD_FIELDS})
    guild({ error, data }) {
        if (data) {
            if (APPLICANT_CHARACTER_MODEL_ID_FIELD != null){
                this.characterModelId = getFieldValue(data, APPLICANT_CHARACTER_MODEL_ID_FIELD);
            } else if (MEMBER_CHARACTER_MODEL_ID_FIELD != null){
                this.characterModelId = getFieldValue(data, MEMBER_CHARACTER_MODEL_ID_FIELD);
            }
            for(const field in this.objectInfo.data.fields){
                CHARACTER_MODEL_FIELDS.push(this.objectInfo.data.apiName + '.' + this.objectInfo.data.fields[field].apiName);
            }
        } else if (error) {
            console.log(error);
        }
    };

    @wire(getRecord, { recordId: "$characterModelId", fields: CHARACTER_MODEL_FIELDS})
    characterModel;

    get characterRender() {
        return this.characterModel.data.fields.Main_Raw__c.value;
    }

    get head() {
        return this.characterModel.data.fields.Head__c.value;
    }

    get neck() {
        return this.characterModel.data.fields.Neck__c.value;
    }

    get shoulders() {
        return this.characterModel.data.fields.Shoulders__c.value;
    }

    get chest() {
        return this.characterModel.data.fields.Chest__c.value;
    }

    get waist() {
        return this.characterModel.data.fields.Waist__c.value;
    }

    get legs() {
        return this.characterModel.data.fields.Legs__c.value;
    }

    get feet() {
        return this.characterModel.data.fields.Feet__c.value;
    }

    get wrist() {
        return this.characterModel.data.fields.Wrist__c.value;
    }

    get hands() {
        return this.characterModel.data.fields.Hands__c.value;
    }

    get finger() {
        return this.characterModel.data.fields.Finger__c.value;
    }

    get finger_2() {
        return this.characterModel.data.fields.Finger_2__c.value;
    }

    get trinket() {
        return this.characterModel.data.fields.Trinket_1__c.value;
    }

    get trinket_2() {
        return this.characterModel.data.fields.Trinket_2__c.value;
    }

    get back() {
        return this.characterModel.data.fields.Back__c.value;
    }

    get main_hand() {
        return this.characterModel.data.fields.Main_Hand__c.value;
    }

    get off_hand() {
        return this.characterModel.data.fields.Off_Hand__c.value;
    }

    get tabard() {
        return this.characterModel.data.fields.Tabard__c.value;
    }

}