
const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const healthdocSchema = new mongoose.Schema({
    name: String,
    date: Date,
    path: String,
});

const healthHistorySchema = new Schema({
    patient_data: {
        createdAt: {
            type: Date,
            default: Date.now,
        },
        UHID: String,
    },

    health_History: {
        cause: String,
        history: [healthdocSchema]
    },
});


const HealthHistoryModel = db.model('HealthHistory', healthHistorySchema);
module.exports = HealthHistoryModel;

