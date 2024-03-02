import { useState } from "react";
import "./A_login.css";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { updateData } from "../../redux-stuff/form_action.js";
import { connect } from "react-redux";
import Box from "@mui/material/Box";
import { Backdrop } from "@mui/material";
import CircularProgress from "@mui/material/CircularProgress";

function Admin_login({ hid, id, Hname, updateData }) {
  const [hospital_id, sethospital_id] = useState("");
  const [password, setpassword] = useState("");
  const [dataIn, setDataIn] = useState("");
  const [resp, setresp] = useState([]);
  const [more, setMore] = useState("");
  const [loading, setLoading] = useState(false);

  const navigate = useNavigate();
  const gotoSignup = () => {
    navigate("/contact_det");
  };
  const gotoDoc = () => {
    navigate("/doc_signin");
  };

  const submitThis = async (e) => {
    e.preventDefault();
    setLoading(true);

    const info = { hid: hospital_id, pwd: password };
    setDataIn([info]);

    try {
      const response = await axios.put(
        "https://ehs-q3hx.onrender.com/api/hospitalLogin",
        info
      );
      //            console.log(response.data)
      setresp(response.data);
      setMore(response.data.data.general_data.hospitalName);
      console.log(response.data.data.general_data);
      setTimeout(() => {
        const id = resp.data._id;
        const name = resp.data.general_data.hospitalName;
        console.log(id, name);
        updateData("id", id);
        updateData("Hname", name);

        gotoHome();
      }, 2000);
      setLoading(false);
    } catch (error) {
      console.error(error);
      setLoading(false);
    }
    ``;
  };

  updateData("hid", hospital_id);

  const gotoHome = () => {
    if (resp.data !== "notfound") {
      navigate("/ehs_dash");
    } else {
      window.alert("INVALID ID or PASS");
    }
  };

  return (
    <>
      <div className="form">
        <form action="" method="POST" onSubmit={submitThis}>
          <div className="title">Sehat Admin Login</div>
          <div className="inp-fields">
            <input
              type="text"
              name="hospital_id"
              value={hospital_id}
              onChange={(e) => sethospital_id(e.target.value)}
              id="hospital_id"
              placeholder="Hospital ID"
              required
            />
            <input
              type="password"
              name="password"
              value={password}
              onChange={(e) => setpassword(e.target.value)}
              id="password"
              placeholder="Password"
              required
            />
          </div>
          <div className="login-button">
            <button type="submit">Login</button>
          </div>
          <div className={"agalbagal"}>
            <div className="login-button">
              <span>New to our platform?</span>
              <button onClick={gotoSignup}>Signup</button>
            </div>
            <div className="login-button">
              <span>Doctor? Pls Login here!!</span>
              <button onClick={gotoDoc}>Doc LogIn</button>
            </div>
          </div>
        </form>
      </div>

      {loading && (
        <Box
          sx={{
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
            marginTop: "20px",
          }}
        >
          <Backdrop open={loading}>
            <CircularProgress />
          </Backdrop>
        </Box>
      )}
    </>
  );
}

const mapStateToProps = (state) => {
  return {
    hid: state.data.hid,
    id: state.data.id,
    Hname: state.data.Hname,
  };
};

export default connect(mapStateToProps, { updateData })(Admin_login);
