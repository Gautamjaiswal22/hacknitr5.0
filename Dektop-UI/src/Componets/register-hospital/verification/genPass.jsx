import s from './verify.module.css'
import {useState} from "react";
import {useNavigate} from "react-router-dom";
import axios from "axios";
import {updateFormField} from "../../../redux-stuff/form_action.js";
import {connect} from "react-redux";


const GenPass = ({hid, updateFormField}) =>{
    
    const navigate = useNavigate()
    const [pas, setpass] = useState([])
    const [Hid, setHid] = useState('')
    
    const genPass = async ()=>{

        const info = {hid:hid}

        try {
            const response = await axios.put('https://ehs-q3hx.onrender.com/api/genIdPwd',info)
            console.log(response.data)
            const dtx = response.data
            setpass(dtx.data.Password)
        } catch (e) {
            console.log(e)
        }
    }
    const home = ()=>{
        navigate('/')
    }
    
    return(
        <div>
            <div className={s.button_saveCont}>
                <span>HID =  {hid}</span>
                <span>Password = {pas}</span>
            </div>
            <div className={s.button_saveCont} >
                <button onClick={genPass} >Generate Password</button>
            </div>
            <div className={s.button_saveCont}>
                <span className={s.idpass} >Makesure to copy ID and Password!!!</span>
            </div>
            <div className={s.button_saveCont} >
                <button onClick={home} >Goto Login</button>
            </div>
        </div>
    )
}

const mapStateToProps = (state) => {
    return {
        hid: state.form.hid
    };
};

export default connect(mapStateToProps,{updateFormField})(GenPass)