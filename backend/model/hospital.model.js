const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const generalDataSchema = new Schema({
    hospitalName: String,
    ownership: String,
    staffSize: String,
    city: String,
    state: String,
    pinCode: String,
    type: String,
    features: {
        type: [String],
    },
    yearOfEstablishment: String,
    haveLabs: String,
    PathologyLicense: String,
    allowAppointment: String,
});

const addressSchema = new Schema({
    address1: String,
    address2: String,
    address3: String,
});

const govt_dataSchema = new Schema({
    Tan: String,
    Pan: String,
    hospitalLicense: String,
});

const hospitalSchema = new Schema({
    hospital_login_cred: {
        hid: {
            type: String,
            unique: true
        },
        pwd: String
    },
    contact_data: {
        mail: {
            type: String,
            lowercase: true,
            unique: true,
        },
        mobile: {
            type: String,
            unique: true,
        },
        telephone: {
            type: String,
        },
        mailHash: String,
        mobileHash: String,
        mobileotp: String,
        mailotp: String,

    },
    general_data: generalDataSchema,
    address_data: addressSchema,
    govt_data: govt_dataSchema,
});

const HospitalModel = db.model('hospital', hospitalSchema);
module.exports = HospitalModel;