import { useEffect, useState } from "react";
import "./A_signup.css";
import axios from "axios";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faCircleCheck } from "@fortawesome/free-solid-svg-icons";
library.add(faCircleCheck);
import { useLocation } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import { connect } from "react-redux";
import { updateFormField } from "../../redux-stuff/form_action.js";
function Admin_signup({ hid, email, mob_no, updateFormField }) {
  const navigate = useNavigate();

  const [em_ok, setem_ok] = useState(false);
  const [ph_ok, setph_ok] = useState(false);

  const [mobile_otp, setMobile_otp] = useState("");
  const [email_otp, setemail_otp] = useState("");

  const [color1, setcolor1] = useState("#9E9FA6");
  const [color2, setcolor2] = useState("#9E9FA6");

  const { state } = useLocation();

  const Eotp = state.data.DATA.mailOTP;
  const Motp = state.data.DATA.mobileOTP;

  console.log("FRESH DATA  : ", state.data.DATA);
  console.log(hid);

  const submitThis = () => {
    navigate("/basic_detail");
  };

  const verifyPhone = async () => {
    const info = { mobile: mob_no, otp: mobile_otp };
    try {
      const response = await axios.post(
        "https://ehs-q3hx.onrender.com/api/verifyMobile",
        info
      );
      console.log(response);
      setph_ok(true);
      setcolor1("#33d17a");
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const verifyEmail = async () => {
    const info = { mail: email, otp: email_otp };
    try {
      const response = await axios.post(
        "https://ehs-q3hx.onrender.com/api/verifyMail",
        info
      );
      console.log(response);
      setem_ok(true);
      setcolor2("#33d17a");
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const verifyOK = () => {
    if (em_ok && ph_ok) {
      submitThis();
    }
  };

  return (
    <>
      <div>
        <div className="title">Sehat Admin SignUp</div>

        <div className="inp-fields">
          <div>
            <span>test otp : {Motp}</span>
            <div className="inp-child">
              <i>
                {" "}
                <FontAwesomeIcon
                  icon={["fa", "circle-check"]}
                  style={{ color: color1 }}
                />{" "}
              </i>
              <input
                type="text"
                name="mobile_otp"
                value={mobile_otp}
                onChange={(e) => setMobile_otp(e.target.value)}
                id="mobile_otp"
                placeholder="OTP"
                required
              />
            </div>
            <div className="inp-child">
              <button type="" onClick={verifyPhone}>
                Verify Mobile
              </button>
            </div>
          </div>

          <div>
            <span>test otp : {Eotp}</span>
            <div className="inp-child">
              <i>
                {" "}
                <FontAwesomeIcon
                  icon={["fa", "circle-check"]}
                  style={{ color: color2 }}
                />{" "}
              </i>
              <input
                type="text"
                name="email_otp"
                value={email_otp}
                onChange={(e) => setemail_otp(e.target.value)}
                id="email_otp"
                placeholder="OTP"
                required
              />
            </div>
            <div className="inp-child">
              <button type="" onClick={verifyEmail}>
                Verify Email
              </button>
            </div>
          </div>
        </div>

        <div className="login-button">
          <button type="submit" onClick={verifyOK}>
            Login
          </button>
        </div>
      </div>
    </>
  );
}

const mapStateToProps = (state) => {
  return {
    hid: state.form.hid,
    email: state.form.email,
    mob_no: state.form.mob_no,
  };
};

export default connect(mapStateToProps, { updateFormField })(Admin_signup);
