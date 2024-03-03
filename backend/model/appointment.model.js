const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const appointmentSchema = new Schema({

    appointmentId: {
        type: String,
        lowercase: true,
        require: true,
        unique: true,
    },

    patient_data: {
        UHID: String,
        patient_name: String,
    },

    appointment_data: {
        date: Date,
        hospital_id: String,
        doctor_id: String,
        health_issue: String,
    },
    

    transaction_data: {
        booked_on: Date,
        transaction_id: String,
        amount: Number
    },

    diagnosis_data: {
        status: String,
        prescription_id: String
    },

});

const AppointmentModel = db.model('appointment', appointmentSchema);
module.exports = AppointmentModel;

