import s from './reg-hos.module.css'

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCircle } from '@fortawesome/free-solid-svg-icons'
import {connect, useDispatch} from "react-redux";
import {updateFormField} from "../../../redux-stuff/form_action.js";
import CircularProgress from '@mui/material/CircularProgress';
import Box from '@mui/material/Box';
import {Link} from "react-router-dom";
import {useNavigate} from "react-router-dom";
import axios from "axios";
import {useState} from "react";
import {Backdrop} from "@mui/material";
library.add(faCircle)


function Hospital_reg({hid,email, tel_no, mob_no, updateFormField}) {

    const [loading, setloading] = useState(false)
    const [resp, setresp] = useState([])
    const navigate = useNavigate()
    const dispatch = useDispatch()
    const submitThis = async (e) => {
        e.preventDefault();
        setloading(true)
        const info = {mail:email, telephone:tel_no, mobile: mob_no}
        
        try {
            const response = await axios.post('https://ehs-q3hx.onrender.com/api/hospitalRegister',info);
            console.log(response.data)
            setresp(response.data)
            setloading(false)
            dispatch(updateFormField('hid', response.data.hid))
            console.log(hid)
            next_page(response.data)
        } catch (error) {
            console.error(error)
            setloading(false)
        }
    }
    
    const next_page = (DATA) => {
        navigate('/verify_otp', {state:{ data:{DATA}}})
    }
    
    return <>

    <div>
        <div className={s.title}>Register as Hospital</div>
    </div>
    
    <div className={s.linee}>
        <i> <FontAwesomeIcon icon={['fa', 'circle']} style={{color:"#E55771",}} /></i>
        <hr width="10%" color="#939497"/>
        <i> <FontAwesomeIcon icon={['fa', 'circle']} style={{color:"#939497",}} /></i>
        <hr width="10%" color="#939497"/>
        <i> <FontAwesomeIcon icon={['fa', 'circle']} style={{color:"#939497",}} /></i>
    </div>
    <div className={s.hehe}>
        <span>Contact Details</span>
        <span>Basic Details</span>
        <span>Verification</span>
    </div>    
    
    <div>
        <div className={s.sub_title}>Contact Details</div>
    </div>

    <div>

        <div className={s.inp_fields}>
            <div className={s.semi_input}>
                <label htmlFor="">Email Address</label>
                <input type="email" name="email"
                    value={email} onChange={(e)=> updateFormField('email', e.target.value)}
                    id="email" placeholder='Required for us to communicate with you' required/>
            </div>
            <div className={s.semi_input}>
                <label htmlFor="">Telephone Number</label>
                <input type="tel_no" name="telephone"
                    value={tel_no} onChange={(e)=> updateFormField('tel_no', e.target.value)}
                    id="telephone" placeholder='For patients to contact' required/>
            </div>
            <div className={s.semi_input}>
            <label htmlFor="">Mobile Number</label>
                <input type="tel" name="mob_no"
                    value={mob_no} onChange={(e)=> updateFormField('mob_no', e.target.value)}
                    id="mob-num" placeholder='For solving queries' required/>
            </div>
        </div>

        <div className={s.button_saveCont}>
            <Link to={"/reg_basic_detail"}>
                <button onClick={submitThis} >Save and Continue</button>
            </Link>
        </div>
        {
        loading && (<Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', marginTop: '20px'}}>
            <Backdrop open={loading}>
                <CircularProgress />
            </Backdrop>
        </Box>)
        }
    </div>

    </>
}

const mapStateToProps = (state) => {
    return {
        hid:state.form.hid,
        email: state.form.email,
        tel_no: state.form.tel_no,
        mob_no: state.form.mob_no,
    };
};

export default connect(mapStateToProps, {updateFormField})(Hospital_reg)