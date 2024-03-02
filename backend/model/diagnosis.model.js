// hospital id
// user id
// doc id
// cause
// diseases
// Prescribtion array



const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const prescriptionSchema = new mongoose.Schema({
    drugName: String,
    morning: Boolean,
    evening: Boolean,
    night: Boolean,
    days: String
});

const diagnosisSchema = new Schema({
    appointment_data: {
        date: {
            type: Date,
            default: Date.now,
        },
        appointmentId: String,
        hospital_id: String,
        doctor_id: String,
        UHID: String,
    },
    diagnosis_data: {
        cause: String,
        priscription: [prescriptionSchema]
    },
});


const DiagnosisModel = db.model('diagnosis', diagnosisSchema);
module.exports = DiagnosisModel;

