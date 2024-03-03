import "./App.css";

import { Routes, Route } from "react-router-dom";
import Dig_History from "./Componets/Hospital-dash/diagnostic-history/Dig_History.jsx";

import Admin_login from "./Componets/admin-login/admin-login";
import Admin_signup from "./Componets/admin-signup/admin-signup.jsx";
import Hospital_reg from "./Componets/register-hospital/contact/register-hospital.jsx";
import Basic_detail from "./Componets/register-hospital/basic-details/basic_detail.jsx";
import Verificaton_page from "./Componets/register-hospital/verification/verificaton_page.jsx";
import EHS_Dashboard from "./Componets/Hospital-dash/dash_board/dashboard.jsx";
import Scan_page from "./Componets/Hospital-dash/scan/scan.jsx";
import Doc_signin from "./Componets/Hospital-dash/Doctor/Doc_Login/doc_login.jsx";
import Doc_Prof from "./Componets/Hospital-dash/Doctor/doc_profiles/doc_profile.jsx";
import Camp_page from "./Componets/Hospital-dash/camp/camp_page.jsx";
import DOC_Dashboard from "./Componets/Hospital-dash/Doctor/doc_dash/doc_dash.jsx";
import GenPass from "./Componets/register-hospital/verification/genPass.jsx";
import PageNotFound from "./Componets/error.jsx";

function App() {
  return (
    <div>
      <Routes>
        <Route path={"/"} element={<Admin_login />} />

        <Route path={"/contact_det"} element={<Hospital_reg />} />
        <Route path={"/verify_otp"} element={<Admin_signup />} />
        <Route path={"/basic_detail"} element={<Basic_detail />} />
        <Route path={"/verify"} element={<Verificaton_page />} />
        <Route path={"/gen_pass"} element={<GenPass />} />

        <Route path={"/ehs_dash"} element={<EHS_Dashboard />} />
        <Route path={"/scan"} element={<Scan_page />} />
        <Route path={"/scaned_id"} element={<Dig_History />} />

        <Route path={"/doc_signin"} element={<Doc_signin />} />
        <Route path={"/doc_dash"} element={<DOC_Dashboard />} />
        <Route path={"/doc_prof"} element={<Doc_Prof />} />

        <Route path={"/camp"} element={<Camp_page />} />

        <Route path={"*"} element={<PageNotFound />} />
      </Routes>
    </div>
  );
}

export default App;
