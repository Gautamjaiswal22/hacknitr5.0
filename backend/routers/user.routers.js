const router = require("express").Router();
const { UserContextImpl } = require("twilio/lib/rest/conversations/v1/user");
const UserController = require("../controller/user.controller");

router.post("/registration", UserController.register);
// router.post('/otpLogin', UserController.otpLogin);
router.post("/verifyOTP", UserController.verifyOTP);
router.put("/addname", UserController.addName);
router.post("/findUser", UserController.FindUser);
router.get("/getUserDetails/:phone", UserController.GetUserDetails);
router.post("/hospitalRegister", UserController.registreHospital);
router.post("/findHospital", UserController.FindHospital);
router.post("/verifyMobile", UserController.VerifyMobile);
router.post("/verifyMail", UserController.VerifyMail);
router.put("/addHospitalBasicDetails", UserController.addBasicDetails);
router.put("/addHospitalGovtDetails", UserController.addGovtDetails);
router.put("/gendata/:id", UserController.genData);
router.post(
  "/addReport/:id",
  UserController.upload.single("pdf"),
  UserController.addReport
);
router.get("/fetchUser/:id", UserController.fetchUser);
router.put("/genIdPwd", UserController.genIdPwd);
router.put("/hospitalLogin", UserController.hospitalLogin);
router.get("/fetchhospitals", UserController.allHospital);
router.get("/showAllHospital", UserController.showAllHospital);
router.post("/bookAppointment", UserController.bookAppointment);
router.get("/fetchappointment/:id", UserController.getAppointment);
router.get("/userfetchappointment/:id", UserController.getUserAppointment);
router.post("/postAppointment/:id", UserController.postAppointment);

router.get("/fetchUser/:id", UserController.fetchUser);
router.post("/loginDoc", UserController.loginDoc);
router.post("/addDoc/:id", UserController.addDoc);
router.get("/fetchUHID/:id", UserController.getUHID);
router.get("/fetchDR/:hospitalId?", UserController.fetchAvailDrs);
router.put("/assignDoctor", UserController.assignDoctor);
router.get(
  "/fetchDoctorsAppointment/:DrId",
  UserController.fetchDrsAppointment
); //fetch appointment of a Doctor
router.post("/addDiagnosis", UserController.AddDiagnosis); //fetch appointment of a Doctor
router.get(
  "/fetchPatientPrescription/:UHID",
  UserController.fetchPatientPrescription
); //fetch appointment of a Doctor
router.post("/addHealthHistory", UserController.AddHealthHistory); //fetch appointment of a Doctor
router.post("/addblood/:userid", UserController.addBlood);
router.get("/fetchBlood/:id", UserController.fetchBlood);
module.exports = router;
