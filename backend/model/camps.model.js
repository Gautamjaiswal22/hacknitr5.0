const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const CampsSchema = new Schema({
    title :String,
    age:Number,
    start_date:Date,
    end_date:Date,
    boost:Boolean,
    HospitalID:String,
    pin:String
});

const CampsModel= db.model('camp', CampsSchema);
module.exports = CampsModel;