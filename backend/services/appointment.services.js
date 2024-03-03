const UserModel = require('../model/user.model');
const otpGenerator = require('otp-generator');
const crypto = require('crypto');
const key = 'otp-secret-key';
const HospitalModel = require('../model/hospital.model');
const AppointmentModel = require("../model/appointment.model");
const { type } = require('os');
const { error } = require('console');

// Function to generate a unique appointment ID
function generateUniqueAppointmentId() {
    // Create a unique ID using a timestamp and a random number
    const timestamp = new Date().getTime(); // Current timestamp
    const random = crypto.randomBytes(4).readUInt32LE(0); // Generate a random 32-bit number

    // Combine the timestamp and random number to create the appointment ID
    const appointmentId = `APT${timestamp}${random}`;
    return appointmentId;
}

// Function to book an appointment
async function bookAppointment(params) {
    const { patient_data, appointment_data, transaction_data, diagnosis_data } = params;

    // Generate a unique appointment ID
    const appointmentId = generateUniqueAppointmentId();

    // Create a new appointment record
    const newAppointment = new AppointmentModel({
        appointmentId,
        patient_data,
        appointment_data,
        transaction_data,
        diagnosis_data,
    });
    try {
        // Save the appointment record to the database
        const savedAppointment = await newAppointment.save();
        return savedAppointment;
    } catch (error) {
        console.error('Error:', error);
        throw new Error('Appointment booking failed');
    }
}


async function getAppointment(params) {
    const { hospitalId } = params;
    try {
        console.log(params);
        // Query the database to find all appointments with the specified hospital ID
     const appointments = await AppointmentModel.find({'appointment_data':{hospital_id:hospitalId}});
        if (appointments) {
            return appointments;
        } else {
            console.log(error);
            return 'Appointments not found';
        }
    } catch (error) {
        console.error(error);
        return 'Internal server error';
    }
}

module.exports = { bookAppointment, getAppointment };


