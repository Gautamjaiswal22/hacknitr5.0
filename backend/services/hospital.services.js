const UserModel = require('../model/user.model');
const HospitalModel = require('../model/hospital.model');
const AppointmentModel = require('../model/hospital.model');
const otpGenerator = require('otp-generator');
const crypto = require('crypto');
const key = 'otp-secret-key';
const twilio = require('twilio');
const request = require('request');
const http = require('https');

const { type } = require('os');


function genotp(otpTo) {
    const otp = otpGenerator.generate(4, {
        digits: true,
        // alphabets: false,    
        // upperCase: false,
        upperCaseAlphabets: false,
        lowerCaseAlphabets: false,
        specialChars: false
    });
    const ttl = 1000 * 60 * 1000; //min sec
    const expires = Date.now() + ttl;
    const data = `${otpTo}.${otp}.${expires}`;
    const hash = crypto.createHmac("sha256", key).update(data).digest("hex");
    const fullHash = `${hash}.${expires}`;
    console.log(`your otp is ${otp}`);
    const otpmap = {
        "otp": otp,
        "hash": fullHash
    };
    return otpmap;
}

async function registerHospital(params, callback) {
    const { mail, mobile, telephone } = params;

    mobileOtpMap = genotp(mobile);
    mobileOtp = mobileOtpMap['otp'];
    mobileFullHash = mobileOtpMap['hash'];
    console.log(`your Mobile otp is ${mobileOtp}`);

    mailOtpMap = genotp(mail);
    mailOtp = mailOtpMap['otp'];
    mailFullHash = mailOtpMap['hash'];
    console.log(`your mail otp is ${mailOtp}`);

    gendata = {
        "mobileHash": mobileFullHash,
        "mailhash": mailFullHash
    }
    try {
        let IdExist;
        let hospital_Id;
        //------------genrate hospital ID-----
        do {
            const min = 1000000; // 7-digit minimum value
            const max = 9999999; // 7-digit maximum value
            const randomDigits = Math.floor(Math.random() * (max - min + 1)) + min;
            hospital_Id = `HID${randomDigits}`;
            // const randompwd = Math.floor(Math.random() * (max - min + 1)) + min;
            // const pwdhash = crypto.createHmac("sha256", key).update(randompwd).digest("hex");
            IdExist = await HospitalModel.find({
                'hospital_login_cred.hid'
                    : hospital_Id
            });
            console.log(IdExist);
            if (IdExist.length == 0) {
                const createHospital = new HospitalModel({
                    'hospital_login_cred.hid': hospital_Id
                });
                const ret = await createHospital.save();
                console.log(ret);

                // const updatedUser = await HospitalModel.findOneAndUpdate(
                //     { 'contact_data.mail': mail },
                //     {
                //         $set: {
                //             'hospital_login_cred.hid': hospital_Id,
                //         }
                //     },
                //     { new: true }
                // );
            }
        } while (IdExist.length > 0);

        console.log
            (mail);
        console.log
            (gendata);
        const contact_data = {
            'mail': mail,
            'mobile': mobile,
            'mailHash': mailFullHash,
            'mobileHash': mobileFullHash,
            'telephone': telephone
        }

        const updatedUser = await HospitalModel.findOneAndUpdate(
            { 'hospital_login_cred.hid': hospital_Id },
            {
                $set: {
                    contact_data
                }
            },
            { new: true }
        );

        // Find the user document by phone number and update the specified key-value pair
        // const createHospital = new HospitalModel({
        //     // mail, mobile, ['mailHash']: mailfullHash, ['mobileHash']: fullHash, telephone
        //     contact_data
        // });
        console.log("create user HospitalModel ----");
        // console.log(createHospital);
        // const ret = await createHospital.save();
        console.log("before" + updatedUser);
        updatedUser['mobileotp'] = mobileOtp;
        updatedUser['mailotp'] = mailOtp;
        console.log("after" + updatedUser);
        result = updatedUser;
        result['mobileotp'] = mobileOtp;
        result['mailotp'] = mailOtp;
        return result;
    } catch (error) {
        console.error("Error:", error);
        return false;
    }
}

async function findHospital(params, callback) {
    try {
        const { mail, phone } = params;
        if (!mail) {
            throw new Error("MAIL NUMBER REQUIRED");
        }
        const existuser = await HospitalModel.findOne(
            { mail },
        );
        console.log(existuser);
        if (existuser) {
            return "HospitalExist";
        }
        else {
            return "HospitalDoesNotExist";
        }
    } catch (err) {
        throw err;
    }
}



async function verifyMobile(params, callback) {
    const { mobile, otp } = params;
    const existuser = await HospitalModel.findOne(
        { "contact_data.mobile": mobile },
    );
    console.log(existuser);
    if (existuser) {
        const hash = existuser["contact_data"]["mobileHash"];
        let [hashValue, expires] = hash.split('.');
        let now = Date.now();
        if (now > parseInt(expires)) return "OTP Expired";
        let data = `${mobile}.${otp}.${expires}`;
        let newCalculatedHash = crypto.createHmac("sha256", key).update(data).digest("hex");
        if (newCalculatedHash === hashValue) {
            // if (true) {
            return "Success";
        }
        else {
            return "Invalid OTP";
        }
    }
    else {
        return "notfound"
    }
}

async function verifyMail(params, callback) {
    const { mail, otp } = params;
    const existuser = await HospitalModel.findOne(
        { 'contact_data.mail': mail },
    );
    console.log(existuser);
    if (existuser) {
        const hash = existuser["contact_data"]["mailHash"];
        let [hashValue, expires] = hash.split('.');
        let now = Date.now();
        if (now > parseInt(expires)) return "OTP Expired";
        let data = `${mail}.${otp}.${expires}`;
        let newCalculatedHash = crypto.createHmac("sha256", key).update(data).digest("hex");
        if (newCalculatedHash === hashValue) {
            // if (true) {
            return "Success";
        }
        else {
            return "Invalid OTP";
        }
    }
    else {
        return "notfound"
    }
}

async function hospitalBasicDetail(params, callback) {
    const { hospital_login_cred, general_data, address_data } = params;
    const hid = hospital_login_cred["hid"];

    try {
        console.log("PARAMS");
        console.log(params);

        // Find the user document by phone number and update the specified key-value pair
        // const createHospital = new HospitalModel({
        //     params
        // });

        const updatedUser = await HospitalModel.findOneAndUpdate(
            { "hospital_login_cred.hid": hid },
            { $set: { general_data, address_data } },
            { new: true }
        );
        console.log("Updated User:", updatedUser);
        if (!updatedUser) {
            console.log("User not found");
            return "User not found";
        }
        console.log("Key-value pair updated successfully");
        return "updated";
    } catch (error) {
        console.error("Error:", error);
        return false;
    }
}

async function hospitalGovernmenttDetails(params, callback) {
    // const { mail } = params;
    const { hospital_login_cred, govt_data } = params;
    const hid = hospital_login_cred['hid'];

    try {
        console.log
            (params);
        // Find the user document by phone number and update the specified key-value pair
        // const createHospital = new HospitalModel({
        //     params
        // });

        const updatedUser = await HospitalModel.findOneAndUpdate(
            { "hospital_login_cred.hid": hid },
            { $set: { govt_data } },
            { new: true }
        );
        console.log(
            updatedUser
        );

        if (!updatedUser) {
            console.log("User not found");
            return "User not found";
        }
        console.log("Updated User:", updatedUser);
        return "updated";
    } catch (error) {
        console.error("Error:", error);
        return false;
    }
}


async function generateHospitalIdPwd(params, callback) {
    const { hid } = params;

    try {
        console.log
            (params);
        // Find the user document by phone number and update the specified key-value pair
        // const createHospital = new HospitalModel({
        //     params
        // });

        const min = 1000000; // 7-digit minimum value
        const max = 9999999; // 7-digit maximum value
        const randomDigits = Math.floor(Math.random() * (max - min + 1)) + min;
        // const hospital_Id = `HID${randomDigits}`;
        const randompwd = Math.floor(Math.random() * (max - min + 1)) + min;
        // const pwdhash = crypto.createHmac("sha256", key).update(randompwd).digest("hex");
        // const IdExist = await HospitalModel.find({
        //     'hospital_login_cred.hid'
        //         : hospital_Id
        // });


        const updatedUser = await HospitalModel.findOneAndUpdate(
            { 'hospital_login_cred.hid': hid },
            {
                $set: {
                    'hospital_login_cred.pwd': randompwd
                }
            },
            { new: true }
        );
        console.log(
            updatedUser
        );
        if (!updatedUser) {
            console.log("User not found");
            return { data: false }
        }
        console.log("Updated User:", updatedUser);

        idpwd = {
            "Hospital_ID": hid,
            "Password": randompwd
        };
        return idpwd;
    } catch (error) {
        console.error("Error:", error);
        return { error: true }
    }
}


async function hospitalLogin(params, callback) {
    const { hid, pwd } = params;
    // const existuser = await HospitalModel.findOne(
    //     { hospital_login_cred, hid },

    // );
    // const existuser = await HospitalModel.findOne({ 'hospital_login_cred.hid': hid });
    console.log("-----");
    const existuser = await HospitalModel.findOne({ 'hospital_login_cred.hid': String(hid) });
    console.log("-----");

    console.log(existuser);
    if (existuser) {
        const hash = existuser["hospital_login_cred"]["pwd"];
        console.log(hash);
        // let [hashValue, expires] = hash.split('.');
        // let now = Date.now();
        // if (now > parseInt(expires)) return "OTP Expired";
        // let data = `${mail}.${otp}.${expires}`;
        // let newCalculatedHash = crypto.createHmac("sha256", key).update(data).digest("hex");
        if (pwd === hash) {
            // if (true) {
            return existuser;
        }
        else {
            return "Invalid ID or PWD";
        }
    }
    else {
        return "notfound"
    }
}

async function allhospitals(params, callback) {
    try {
        // const hospitals = await HospitalModel.find();
        const hospitals = await HospitalModel.find({
            'general_dataa': { $exists: true }
        });
        console.log("After filtering:", hospitals);
        // filter end
        console.log(hospitals);
        return hospitals;
    } catch (err) {
        console.error(err);
        return 'An error occurred while fetching hospitals.'
        // res.status(500).json({ error: 'An error occurred while fetching hospitals.' });
    }
}


async function allhospitals(params, callback) {
    try {
        const hospitals = await HospitalModel.find();
        console.log(hospitals);
        return hospitals;
    } catch (err) {
        console.error(err);
        return 'An error occurred while fetching hospitals.'
        // res.status(500).json({ error: 'An error occurred while fetching hospitals.' });
    }
}

module.exports = { registerHospital, findHospital, verifyMobile, verifyMail, hospitalBasicDetail, hospitalGovernmenttDetails, generateHospitalIdPwd, hospitalLogin, allhospitals };



