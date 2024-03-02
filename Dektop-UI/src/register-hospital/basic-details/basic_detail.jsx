import style from './basic.module.css'

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCircle } from '@fortawesome/free-solid-svg-icons'
import { connect } from 'react-redux';
import {updateFormField} from "../../../redux-stuff/form_action.js";
import {useState} from "react";
import axios from "axios";
import {useNavigate} from "react-router-dom";

import CircularProgress from '@mui/material/CircularProgress';
import Box from '@mui/material/Box';
import {Backdrop} from "@mui/material";

library.add(faCircle)

function Basic_detil({hid,h_name, owner, staff, city, state, pin, type, feature, year_est, pvt_path, path_lic, alw_apnt_bk, addr1, addr2, addr3, updateFormField}) {

    const [loading, setloading] = useState(false)
    const navigate = useNavigate()
    const handleSubmit = async (e) => {
        e.preventDefault();
        setloading(true)
        const info = {
            hospital_login_cred: {
                hid: hid
            },
            general_data: {
                hospitalName: h_name,
                ownership: owner,
                staffSize: staff,
                city: city,
                state: state,
                pinCode: pin,
                type: type,
                features: outputArray,
                yearOfEstablishment: year_est,
                haveLabs: pvt_path,
                PathologyLicense: path_lic,
                allowAppointment: alw_apnt_bk
            },
            address_data:{
                address1:addr1,
                address2:addr2,
                address3:addr3
            }
        }

        console.log(info)
        try {
            const response = await axios.put('https://ehs-q3hx.onrender.com/api/addHospitalBasicDetails',info);
            console.log(response.data)
            setloading(false)
            navigate('/verify')
        } catch (error) {
            console.error(error)
            setloading(false)
        }
    };

    const [outputArray, setOutputArray] = useState([]);
    const [inputValue, setInputValue] = useState('');

    const handleInputChange = (event) => {
        const value = event.target.value;
        setInputValue(value);
        const separatedArray = value.split(',');
        setOutputArray(separatedArray);
        console.log(outputArray)
    };


    return <>

    <div>
        <div className={style.title}>Register as Hospital</div>
    </div>
    
    <div className={style.linee}>
        <i> <FontAwesomeIcon icon={['fa', 'circle']} style={{color:"#E55771",}} /></i>
        <hr width="10%" color="#939497"/>
        <i> <FontAwesomeIcon icon={['fa', 'circle']} style={{color:"#E55771",}} /></i>
        <hr width="10%" color="#939497"/>
        <i> <FontAwesomeIcon icon={['fa', 'circle']} style={{color:"#939497",}} /></i>
    </div>
    <div className={style.hehe}>
        <span>Contact Details</span>
        <span>Basic Details</span>
        <span>Verification</span>
    </div>    
    
    <div>
        <div className={style.sub_title}>Basic Details</div>
    </div>

    <div>
        <div className={style.rows}>
            <div className={style.inp_fields}>
                <div className={style.semi_input}>
                    <label htmlFor="">Hospital Name</label>
                    <input type="text" name="text"
                        value={h_name} onChange={(e)=> updateFormField('h_name', e.target.value)}
                        id="text" placeholder='Enter Full Name  ' required/>
                </div>
                <div className={style.semi_input}>
                    <label htmlFor="">Ownership</label>
                    <select name="ownership" id=""
                        value={owner} onChange={(e)=> updateFormField('owner', e.target.value)}>
                        <option value="Government">Government</option>
                        <option value="Private">Private</option>
                        <option value="Hota hoga aur">Hota hoga aur</option>
                    </select>
                </div>
                <div className={style.semi_input}>
                <label htmlFor="">Staff Size</label>
                    <input type="number" name="staff-number"
                        value={staff} onChange={(e)=> updateFormField('staff', e.target.value)}
                        id="staff-number" placeholder='Management Staff' required/>
                </div>
            </div>
            <div className={style.inp_fields}>
                <div className={style.semi_input}>
                    <label htmlFor="">City</label>
                    <input type="text" name="city-text"
                        value={city} onChange={(e)=> updateFormField('city', e.target.value)}
                        id="city-text" placeholder='Enter City Name' required/>
                </div>
                <div className={style.semi_input}>
                    <label htmlFor="">State</label>
                    <input type="text" name="state"
                        value={state} onChange={(e)=> updateFormField('state', e.target.value)}
                        id="telephone" placeholder='For patients to contact' required/>
                </div>
                <div className={style.semi_input}>
                    <label htmlFor="">PIN code</label>
                    <input type="number" name=""
                        value={pin} onChange={(e)=> updateFormField('pin', e.target.value)}
                        id="mob-num" placeholder='For solving queries' required/>
                </div>
            </div>
            <div className={style.inp_fields}>
                <div className={style.semi_input}>
                    <label htmlFor="">Type</label>
                    <select name="hospital-type" id=""
                        value={type} onChange={(e)=> updateFormField('type', e.target.value)}>
                        <option value="General">General</option>
                        <option value="Rural">Rural</option>
                        <option value="Speciality">Speciality</option>
                        <option value="Teaching">Teaching</option>
                        <option value="Isolation">Isolation</option>
                    </select>
                </div>
                <div className={style.semi_input}>
                    <label htmlFor="">Features</label>
                    <input type="text" name="feature-text"
                        value={inputValue} onChange={handleInputChange}
                        id="feature-text" placeholder='Checklist for features' required/>
                </div>
                <div className={style.semi_input}>
                    <label htmlFor="">Year of Establishment</label>
                    <input type="date" name="year_est"
                        value={year_est} onChange={(e)=> updateFormField('year_est', e.target.value)}
                        id="est-date" placeholder='' required/>
                </div>
            </div>
            <div className={style.inp_fields}>
                <div className={style.semi_input}>
                    <label htmlFor="">Do you have own Path Lab within premises?</label>
                    <select className={style.selection} name="pvt_path" id="pvt_path"
                        value={pvt_path} onChange={(e)=> updateFormField('pvt_path', e.target.value)}>
                        <option >Pick a choice!</option>
                        <option value="yes">Yes</option>
                        <option value="no">No</option>
                    </select>
                </div>
                <div className={style.semi_input}>
                    <label htmlFor="">Path License Number</label>
                    <input type="text" name="path-lic"
                        value={path_lic} onChange={(e)=> updateFormField('path_lic', e.target.value)}
                        id="path-lic" placeholder='In CAPITALS' />
                </div>
                <div className={style.semi_input}>
                    <label htmlFor="">Allow appointment booking?</label>
                    <select name="alw_apnt_bk" id="alw_apnt_bk"
                        value={alw_apnt_bk} onChange={(e)=> updateFormField('alw_apnt_bk', e.target.value)}>
                        <option value="yes">Yes</option>
                        <option value="no">No</option>
                    </select>
                </div>
            </div>
            <div className={style.add}>Address</div>
            <div className={style.inp_fields}>
                <div className={style.semi_input}>
                    <label htmlFor="">Address Line 1</label>
                    <input type="text" name="addr1"
                        value={addr1} onChange={(e)=> updateFormField('addr1', e.target.value)}
                        id="addr1" placeholder='' required/>
                </div>
                <div className={style.semi_input}>
                    <label htmlFor="">Address Line 2</label>
                    <input type="text" name="addr2"
                        value={addr2} onChange={(e)=> updateFormField('addr2', e.target.value)}
                        id="addr2" placeholder='' required/>
                </div>
                <div className={style.semi_input}>
                    <label htmlFor="">Address Line 3</label>
                    <input type="text" name="addr3"
                        value={addr3} onChange={(e)=> updateFormField('addr3', e.target.value)}
                        id="addr3" placeholder='' required/>
                </div>
            </div>
        </div>

        <div className={style.button_saveCont}>
                <button onClick={handleSubmit}>Save and Continue</button>
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
        h_name: state.form.h_name,
        owner:state.form.owner,
        staff:state.form.staff,
        city:state.form.city,
        state:state.form.state,
        pin:state.form.pin,
        type:state.form.type,
        feature:state.form.feature,
        year_est:state.form.year_est,
        pvt_path:state.form.pvt_path,
        path_lic:state.form.path_lic,
        alw_apnt_bk:state.form.alw_apnt_bk,
        addr1:state.form.addr1,
        addr2:state.form.addr2,
        addr3:state.form.addr3,
    };
};

export default connect(mapStateToProps, {updateFormField})(Basic_detil)