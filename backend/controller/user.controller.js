const UserService = require("../services/user.services");
const HospitalService = require("../services/hospital.services");
const AppointmentService = require("../services/appointment.services");
const AppointmentModel = require("../model/appointment.model");
const CampModel = require("../model/camps.model");
const UserModel = require("../model/user.model");
const multer = require("multer");
const imagekit = require("imagekit");
const DocModel = require("../model/doctor.model");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");

const HospitalModel = require("../model/hospital.model");
const DoctorModel = require("../model/doctor.model");
const {
  NewFactorListInstance,
} = require("twilio/lib/rest/verify/v2/service/entity/newFactor");
const CampsModel = require("../model/camps.model");
const { Parameter } = require("twilio/lib/twiml/VoiceResponse");
const DiagnosisModel = require("../model/diagnosis.model");
const HealthHistoryModel = require("../model/healthHistory.model");
exports.register = async (req, res, next) => {
  try {
    const { phone } = req.body;
    const successRes = await UserService.registerUser(phone);
    // console.log(successRes);
    // res.json({ status: true, success: `user Registered succesfully ${phone}`, otp: `${successRes}` });
    return res.status(200).send({
      status: true,
      success: `user Registered succesfully ${phone}`,
      otp: `${successRes["otp"]}`,
      hashk: `${successRes["hash"]}`,
    });
  } catch (error) {
    throw error;
  }
};

// exports.otpLogin = (req, res, next) => {
//     UserService.createOtp(req.body, (error, results) => {
//         if (error) {
//             return next(error);
//         }
//         return res.status(200).send({
//             status: true,
//             message: results,
//         });
//     });
// };

exports.verifyOTP = (req, res, next) => {
  UserService.verifyOTP(req.body, (error, results) => {
    if (error) {
      return next(error);
    }
    return res.status(200).send({
      status: true,
      message: results,
    });
  });
};

exports.addName = async (req, res, next) => {
  // UserService.addname(req.body, (error, results) => {
  //   if (error) {
  //     return next(error);
  //   }
  //   return res.status(200).send({
  //     message: "Success",
  //     data: results,
  //   });
  // });
  try {
    const { phone, name, city, mail, profilePic } = req.body;
    console.log("inside2");
    // Find the user document by phone number and update the specified key-value pair
    // const updatedUser = await UserModel.findOneAndUpdate(
    //     { phone },
    //     { $set: { name,city}},
    //     { new: true }
    // );

    const updatedUsr = await UserModel.findOneAndUpdate(
      { phone },
      { $set: { city: city, name: name, mail: mail, profilePic: profilePic } }
    );

    if (!updatedUsr) {
      console.log("User not found");
      res.send({ already: false });
    }
    // Log the updated user document
    console.log("Updated User:", updatedUsr);
    console.log("Key-value pair updated successfully");
    res.send({ success: true, already: true });
  } catch (error) {
    console.error("Error:", error);
    res.send({ success: false });
  }
};

exports.FindUser = async (req, res, next) => {
  try {
    console.log("in controller finduser try block");
    // const successRes = await UserService.registerUser(phone);
    const successRes = await UserService.FindUser(req.body);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.GetUserDetails = async (req, res, next) => {
  try {
    console.log("in controller finduser try block");
    const phone = req.params.phone;
    console.log(phone);
    // const successRes = await UserService.registerUser(phone);
    const successRes = await UserService.GetUserDetails(phone);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.registreHospital = async (req, res, next) => {
  try {
    res.set("Access-Control-Allow-Origin", "*");
    const successRes = await HospitalService.registerHospital(req.body);
    console.log("hospital registration query executed");
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
      hid: successRes.hospital_login_cred.hid,
      mobileOTP: successRes.mobileotp,
      mailOTP: successRes.mailotp,
    });
  } catch (error) {
    throw error;
  }
};

exports.FindHospital = async (req, res, next) => {
  try {
    const successRes = await HospitalService.findHospital(req.body);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.VerifyMobile = async (req, res, next) => {
  try {
    res.set("Access-Control-Allow-Origin", "*");
    const successRes = await HospitalService.verifyMobile(req.body);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.VerifyMobile = async (req, res, next) => {
  try {
    res.set("Access-Control-Allow-Origin", "*");
    const successRes = await HospitalService.verifyMobile(req.body);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.VerifyMail = async (req, res, next) => {
  try {
    res.set("Access-Control-Allow-Origin", "*");
    const successRes = await HospitalService.verifyMail(req.body);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.addBasicDetails = async (req, res, next) => {
  try {
    res.set("Access-Control-Allow-Origin", "*");
    const successRes = await HospitalService.hospitalBasicDetail(req.body);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.addGovtDetails = async (req, res, next) => {
  try {
    res.set("Access-Control-Allow-Origin", "*");
    const successRes = await HospitalService.hospitalGovernmenttDetails(
      req.body
    );
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.genData = async (req, res) => {
  const _id = req.params.id;
  console.log("Inside");
  const { age, height, weight, bp, sugar } = req.body;
  console.log(age, height, weight, bp, sugar, _id);
  try {
    res.set("Access-Control-Allow-Origin", "*");
    if (_id) {
      await UserModel.updateOne(
        { _id },
        {
          $set: {
            "gen_data.age": age,
            "gen_data.height": height,
            "gen_data.weight": weight,
            "gen_data.bp": bp,
            "gen_data.sugar": sugar,
          },
        }
      );
      res.json({ success: true });
    } else {
      return res.status(404).json({ message: "User not found" });
    }
  } catch (error) {
    throw error;
  }
};
const storageEngine = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./uploads"); // Set the destination path
  }, // path
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}_${file.originalname}`);
  },
});
const imagekitClient = new imagekit({
  publicKey: "public_1v21XIs7OCce6guYOGwwdBVcOEs=",
  privateKey: "private_5fAx7bo8su30PKwo+V9Wwf8IMbE=",

  urlEndpoint: "https://ik.imagekit.io/blacksp/",
});

exports.upload = multer({
  storage: storageEngine,
});

exports.addReport = async (req, res) => {
  const id = req.params.id;
  const { title, date, symptoms } = req.body;
  console.log("upload route hit");

  try {
    if (!req.file) {
      return res.status(400).send("No file uploaded");
    }
    console.log("entered in upload structure");
    // Retrieve file path of the uploaded PDF
    const pdfPath = req.file.path;
    const tm = Date.now();
    // Read the uploaded PDF file as binary data
    const pdfBuffer = require("fs").readFileSync(pdfPath);

    // Upload PDF to ImageKit
    const imageUploadResult = await imagekitClient.upload({
      file: pdfBuffer,
      fileName: req.file.originalname,
      folder: "/reports", // Optional: Specify a folder in ImageKit
      tags: ["pdf"], // Replace with your preferred file name
      // Optional: Add tags
    });

    // Get the URL of the uploaded PDF from ImageKit
    const pdfURL = imageUploadResult.url;

    //      const file1 = fs.readFileSync(reportpdf[0].path);
    //
    //      const base1 = file1.toString("base64");
    //
    //      const FileUplaodResult = await imagekitClient.upload({
    //        file: base1,
    //        fileName: reportpdf[0].originalname,
    //      });

    // Upload Image 2 to ImageKit

    const report = {
      title,
      date,
      fileURL: pdfURL,
      symptoms,
    };

    const kk = await UserModel.findOneAndUpdate(
      { _id: id },
      { $push: { reports: report } },
      { new: true }
    );

    res.status(200).send({ success: true });
  } catch (error) {
    res.status(500).send({ success: false });
    console.log(error);
  }
};

exports.fetchUser = async (req, res) => {
  const id = req.params.id;
  try {
    if (id) {
      const user = await UserModel.find({ _id: id });
      res.status(200).send(user);
    } else {
      res.status(400).json({ success: false });
    }
  } catch (err) {
    console.log(error);
  }
};

exports.postCamp = async (req, res) => {
  const id = req.params.id;
  console.log(id);
  try {
    const { age, title, start_date, end_date, boost } = req.body;

    const camp = await CampModel.create({
      title,
      age,
      start_date,
      end_date,
      boost,
      HospitalID: id,
    });
    res.status(201).send({ success: true });
  } catch (error) {
    console.log(error);
    res.send({ success: false });
  }
};

exports.genIdPwd = async (req, res, next) => {
  try {
    const successRes = await HospitalService.generateHospitalIdPwd(req.body);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.hospitalLogin = async (req, res, next) => {
  try {
    const successRes = await HospitalService.hospitalLogin(req.body);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.allHospital = async (req, res, next) => {
  try {
    const successRes = await HospitalService.allhospitals(req.body);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.ShowaAllHospital = async (req, res, next) => {
  try {
    const successRes = await HospitalService.showAllHospitals(req.body);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.bookAppointment = async (req, res, next) => {
  try {
    const successRes = await AppointmentService.bookAppointment(req.body);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.getAppointment = async (req, res, next) => {
  try {
    const hopid = req.params.id;

    const appointments = await AppointmentModel.find({
      "appointment_data.hospital_id": hopid,
    });
    console.log(appointments, hopid);
    if (appointments) {
      return res.status(200).send({
        status: true,
        message: "Success",
        data: appointments,
      });
    } else {
      console.log(error);
      return "Appointments not found";
    }
  } catch (error) {
    throw error;
  }
};

exports.getUserAppointment = async (req, res, next) => {
  try {
    const uhid = req.params.id;

    const appointments = await AppointmentModel.find({
      "patient_data.UHID": uhid,
    });
    console.log(appointments, uhid);
    if (appointments) {
      return res.status(200).send({
        status: true,
        message: "Success",
        data: appointments,
      });
    } else {
      console.log(error);
      return "Appointments not found";
    }
  } catch (error) {
    throw error;
  }
};

exports.getUHID = async (req, res, next) => {
  try {
    const successRes = await UserService.fetchUHID(req.params);
    return res.status(200).send({
      status: true,
      message: "Success",
      data: successRes,
    });
  } catch (error) {
    throw error;
  }
};

exports.addDoc = async (req, res) => {
  const id = req.params.id;
  const { name, spec, email, phone } = req.body;
  function generateUniqueID() {
    const timestamp = new Date().getTime().toString().slice(-4);

    const randomPart = Math.floor(10000 + Math.random() * 90000).toString();

    const uniqueID = "DC" + timestamp + randomPart;

    if (uniqueID.length < 8) {
      return uniqueID.padStart(8, "0");
    } else if (uniqueID.length > 8) {
      return uniqueID.slice(0, 8);
    }

    return uniqueID;
  }
  try {
    const hosp = await HospitalModel.find({ _id: id });
    const hopname = hosp[0].general_data.hospitalName;

    const uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const lowercaseLetters = "abcdefghijklmnopqrstuvwxyz";
    const numbers = "0123456789";
    const specialCharacters = "!@#$&_";
    const docID = generateUniqueID();
    // Create a string that contains all the allowed characters
    const allCharacters = uppercaseLetters + lowercaseLetters + numbers;

    let password = "";

    // Add one random special character

    // Add 7 more characters from the combined set of uppercase, lowercase, and numbers
    for (let i = 0; i < 7; i++) {
      password +=
        allCharacters[Math.floor(Math.random() * allCharacters.length)];
    }

    // Shuffle the password characters to make it random

    const array = password.split("");
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
    password = array.join("");
    password +=
      specialCharacters[Math.floor(Math.random() * specialCharacters.length)];

    const transporter = nodemailer.createTransport({
      host: "smtp.zoho.in",
      port: 465,
      secure: true, // Use SSL/TLS
      auth: {
        user: "blacksparrowdevs@zohomail.in", // Replace with your Zoho Mail email address
        pass: "Sparrow@Tech", // Replace with your Zoho Mail password
      },
    });

    const mailOptions1 = {
      from: "blacksparrowdevs@zohomail.in",
      to: `${email},tanayrajeshshroff21@gmail.com,gautamjaiswal252@gmail.com,saranshplay@gmail.com`,
      subject: `Congrates! You are registered.`,
      html: `<p>Dear User</p>
        <p>We are delighted to inform you that you are regsitered with EHS under ${hopname}.</p>
        <p>Below is your credentials given for login.</p>
        <ul>
        <li>Email: <strong>${email}</strong></li>
        <li>Password: <strong>${password}</strong></li>
        <li>ID: <strong>${docID}</strong></li>
        </ul>`,
    };

    transporter.sendMail(mailOptions1, (error, info) => {
      if (error) {
        console.error(error);
        res.send("An error occurred while sending the email.");
      } else {
        console.log("Email sent successfully to recipient 1:", info.response);
      }
    });
    const encPass = await bcrypt.hash(password, 10);

    const doc = await DoctorModel.create({
      email,
      speciality: spec,
      pass: encPass,
      fullname: name,
      phone,
      hospitalID: id,
      docID: docID,
    });

    res.status(201).send({ success: true, data: doc });
  } catch (error) {
    console.log(error);
  }
};

exports.fetchAvailDrs = async (req, res) => {
  let query = {}; // Initialize an empty query object

  // Check if hospitalId is present in the request params
  if (req.params.hospitalId) {
    query.hospitalID = req.params.hospitalId;
  }
  // const hospitalId = req.params.hospitalId;
  // console.log(hospitalId);
  try {
    const Drs = await DoctorModel.find(query);
    const hname = await DoctorModel.find(query);

    console.log(Drs);
    res.status(200).send(Drs);
  } catch (error) {
    res.send({ message: false });
  }
};

exports.assignDoctor = async (req, res) => {
  const appointmentId = req.body.appointmentId;
  const doctorId = req.body.doctorId;
  console.log(appointmentId);
  console.log(doctorId);

  try {
    const Drs = await AppointmentModel.findOneAndUpdate(
      { appointmentId: appointmentId },
      { $set: { "appointment_data.doctor_id": doctorId } },
      { new: true }
    );
    console.log(Drs);
    res.status(200).send(Drs);
  } catch (error) {
    res.send({ message: false });
  }
};

exports.getCamps = async (req, res) => {
  const currentDate = new Date();

  try {
    const camps = await CampsModel.find();
    res.status(200).send(camps);
  } catch (error) {
    res.send({ message: false });
  }
};

exports.fetchDrsAppointment = async (req, res) => {
  const DrId = req.params.DrId;
  console.log(DrId);
  try {
    const DrsAppointment = await AppointmentModel.find({
      "appointment_data.doctor_id": DrId,
    });
    console.log(DrsAppointment);
    res.status(200).send(DrsAppointment);
  } catch (error) {
    res.send({ message: false });
  }
};

exports.AddDiagnosis = async (req, res) => {
  const data = req.body;
  const appointId = req.body.appointment_data.appointmentId;
  try {
    const createDiagnosis = new DiagnosisModel(data);
    const ret = await createDiagnosis.save();
    console.log(ret);
    const diagid = ret["_id"];
    console.log("Diagnosis ID :");
    console.log(diagid);
    const updateAppointmentWithDiagnosis =
      await AppointmentModel.findOneAndUpdate(
        { appointmentId: appointId },
        { $set: { "diagnosis_data.prescription_id": diagid } },
        { new: true }
      );

    res.status(200).send(updateAppointmentWithDiagnosis);
  } catch (error) {
    res.send({ message: false });
  }
};

exports.AddHealthHistory = async (req, res) => {
  const data = req.body;
  try {
    const createHealthHistory = new HealthHistoryModel(data);
    const ret = await createHealthHistory.save();
    console.log(ret);
    res.status(200).send(ret);
  } catch (error) {
    res.send({ message: false });
  }
};

exports.fetchPatientPrescription = async (req, res) => {
  const uhid = req.params.UHID;
  console.log(uhid);
  try {
    const prescription = await DiagnosisModel.find({
      "appointment_data.UHID": uhid,
    });
    console.log(prescription);
    res.status(200).send(prescription);
  } catch (error) {
    res.send({ message: false });
  }
};

exports.showAllHospital = async (req, res) => {
  try {
    const hospitals = await HospitalModel.find(
      {},
      { hospital_login_cred: 0, mailHash: 0, mobileHash: 0 }
    );
    console.log("her");

    res.send(hospitals);
  } catch (error) {
    res.send(error);
  }
};

exports.postAppointment = async (req, res) => {
  const id = req.params.id;
  const { date, health_issue, time } = req.body;

  try {
    const app = await AppointmentModel.create({
      appointment_data: {
        hospital_id: id,
        date: date,
        health_issue: health_issue,
      },
    });
    res.status(201).send({ success: true });
  } catch (error) {
    res.send({ success: false });
  }
};

exports.loginDoc = async (req, res) => {
  const { docID, pass } = req.body;

  try {
    const user = await DocModel.findOne({ docID });
    if (user && (await bcrypt.compare(pass, user.pass))) {
      res.status(200).json({ success: true, docData: user });
    } else {
      res.status(404).json({ success: false });
    }
  } catch (err) {
    console.log(err);
  }
};

exports.addBlood = async (req, res) => {
  const { bloodGroup, isdonatedin6months, iswillingBlood } = req.body;
  const { userid } = req.params;
  try {
    const user = await UserModel.findOne({ _id: userid });

    user.blood = {
      filled: true,
      bloodGroup: bloodGroup,
      willing: iswillingBlood,
      donatedLastSixMonths: isdonatedin6months,
    };

    await user.save();
    res
      .status(200)
      .json({ message: "Blood details updated successfully", status: true });
  } catch (err) {
    console.log(err);
  }
};

exports.fetchBlood = async (req, res) => {
  const { id } = req.params;
  try {
    const users = await UserModel.find({
      _id: { $ne: id },
      "blood.willing": true,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal Server Error" });
  }
};
