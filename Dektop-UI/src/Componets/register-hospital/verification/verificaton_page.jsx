import s from './verify.module.css'

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCircle } from '@fortawesome/free-solid-svg-icons'
import {connect} from "react-redux";
import {updateFormField} from "../../../redux-stuff/form_action.js";
import axios from 'axios'
library.add(faCircle)
import CircularProgress from '@mui/material/CircularProgress';
import Box from '@mui/material/Box';
import {Backdrop} from "@mui/material";
import {useState} from "react";
import {useNavigate} from "react-router-dom";
const Verificaton_page = ({hid, tan_no, pan, updateFormField}) =>{

    const [loading, setloading] = useState(false)
    const navigate = useNavigate()

    const handleSubmit = async (e) => {
        e.preventDefault();
        setloading(true)
        const info = {
            hospital_login_cred: {
                hid: hid
            },
            govt_data: {
                Tan:tan_no,
                Pan:pan,
                hospitalLicense:''
            }
        }

        console.log(info)
        try {
            const response = await axios.put('https://ehs-q3hx.onrender.com/api/addHospitalGovtDetails',info);
            console.log(response.data)
            setloading(false)
            navigate('/gen_pass')
        } catch (error) {
            console.error(error)
            setloading(false)
        }
    };


    
    return <>

    <div>
        <div className={s.title}>Register as Hospital</div>
    </div>

    <div className={s.linee}>
        <i> <FontAwesomeIcon icon={['fa', 'circle']} style={{color:"#E55771",}} /></i>
        <hr width="10%" color="#939497"/>
        <i> <FontAwesomeIcon icon={['fa', 'circle']} style={{color:"#E55771",}} /></i>
        <hr width="10%" color="#939497"/>
        <i> <FontAwesomeIcon icon={['fa', 'circle']} style={{color:"#E55771",}} /></i>
    </div>
    <div className={s.hehe}>
        <span>Contact Details</span>
        <span>Basic Details</span>
        <span>Verification</span>
    </div>    

    <div>
        <div className={s.subs_title}>Contact Details</div>
    </div>

    <div>

        <div className={s.inp_fields}>
            <div className={s.semi_input}>
                <label htmlFor="">TAN Number</label>
                <input type="text" name="tan-num"
                    value={tan_no} onChange={(e)=> updateFormField('tan_no', e.target.value)}
                    id="tan-num" placeholder='' />
            </div>
            <div className={s.semi_input}>
                <label htmlFor="">PAN Number (If no TAN)</label>
                <input type="text" name="pan"
                    value={pan} onChange={(e)=> updateFormField('pan', e.target.value)}
                    id="pan-num" placeholder='' />
            </div>
            <div className={s.semi_input}>
                <label htmlFor="">Govt issued License</label>
                <input type="file" name="gov-lic" 
                    id="gov-lic" placeholder='' required/>
            </div>
        </div>

        <div className={s.button_saveCont} >
            <button onClick={handleSubmit} >Submit</button>
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
        hid: state.form.hid,
        tan_no: state.form.tan_no,
        pan:state.form.pan
    };
};

export default connect(mapStateToProps,{updateFormField})(Verificaton_page)