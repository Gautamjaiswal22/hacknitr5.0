const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const DoctorSchema = new Schema({

    hospitalID: String,
    docID: String,

    email: {
        type: String,
        require: true
    },
    pass: {
        type: String,
        require: true
    },
    fullname: String,
    phone: String,
    speciality: String
});

const DoctorModel = db.model('doctor', DoctorSchema);
module.exports = DoctorModel;