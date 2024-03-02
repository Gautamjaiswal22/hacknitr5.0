import s from './dash.module.css'
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCirclePlus, faPlus, faNotesMedical, faHospital,   faLinesLeaning, faQrcode, faUserDoctor, faTent } from '@fortawesome/free-solid-svg-icons'
import {useEffect, useState} from "react";
import Popup_box from "./popup.jsx";
import axios from "axios";
import {useLocation, useNavigate} from "react-router-dom";
import {updateData} from "../../../redux-stuff/form_action.js";
library.add(faCirclePlus, faPlus, faNotesMedical, faHospital, faLinesLeaning, faQrcode, faUserDoctor, faTent)
import {connect} from "react-redux";


function EHS_Dashboard({hid, id, Hname, updateData}) {

    const [open, setOpen] = useState(false);
    const [loading, setloading] = useState(false)
    const [Data, setdata] = useState([])

//    console.log(Hname)

    const navigate = useNavigate()
//    const {state} = useLocation()
//    const {hid, id, hName} = state;

//    console.log(id)
    const handleClickToOpen = () => {
        setOpen(true);
    };
    const handleToClose = () => {
        setOpen(false);
    };

    const getBookedAppoint = async () =>{
//        setloading(true)
        try {

            const response = await axios.get('https://ehs-q3hx.onrender.com/api/fetchappointment/'+hid);
//            console.log(response)
            setdata(response.data)
//            console.log("data",Data.data)
//            setloading(false)

        } catch (e) {
            console.log(e)
            setloading(false)
        }
    }

    useEffect(()=>{
        getBookedAppoint()
//        console.log("data",Data.data)
        setTimeout(()=>{
            setloading(true)
        }, 5000 )
    },[])

    function navToScan(){
        navigate('/scan')
    }
    function navToDash(){
        navigate('/ehs_dash')
    }
    function navToDoc() {
        navigate('/doc_prof')
    }
    function camp() {
        navigate('/camp')
    }
    function home() {
        navigate('/ehs_dash')
    }

return(
        <>
        <div className={s.whole_screen}>
            <div className={s.upar}>
                <div className={s.title}>{Hname}</div>
                <i> <FontAwesomeIcon icon={["fa", "circle-plus",]} size={"3x"} style={{color: "#E55771",}}/> </i>
            </div>
            <div className={s.sub_upar}>
                <div className={s.sub_sub_upar}>
                    <div className={s.title}> Appointments </div>
                    <div className={s.new_btn}>
                        <button><i> <FontAwesomeIcon icon={["fa", "plus",]}  style={{color: "#FFFFFF",}}/> </i>NEW</button>
                    </div>
                </div>
                {loading && (
                    <div className={s.two_sub_upar}>
                        {Data.data.map((item, index)=>(
                            <div key={index} className={s.damn}>
                                <span>{item.patient_data.patient_name}</span>
                                <span>{item.diagnosis_data.status}</span>
                                <span>{item.appointment_data.date}</span>
                                {/*<span>{item.appointment_data.}</span>-*/}
                                <span>{item.appointment_data.health_issue}</span>

                                <div className={s.assist_btn}>
                                    <button onClick={handleClickToOpen}><i> <FontAwesomeIcon icon={["fa", "notes-medical",]}  style={{color: "#FFFFFF",}}/> </i>Assist</button>
                                    <Popup_box open={open} onClose={handleToClose} aid={item.appointmentId} id={id} />
                                </div>

                            </div>
                            ))}
                    </div>
                )}

            </div>
            <div className={s.side}>
                <div className={s.logo_name}>
                    <i> <FontAwesomeIcon icon={["fa", "hospital",]} size={'3x'}  style={{color: "#E55771",}}/></i>
                    <div onClick={home} className={s.title}>EHS </div>
                </div>
                <div className={s.side_main}>
                    <div className={s.chhotu}>
                        <i> <FontAwesomeIcon icon={["fa", "lines-leaning",]} size={'2x'}  style={{color: "#2A2B3F",}}/></i>
                        <span onClick={navToDash} >Appointments</span>
                    </div>
                    <div className={s.chhotu}>
                        <i> <FontAwesomeIcon icon={["fa", "qrcode",]} size={'2x'}  style={{color: "#2A2B3F",}}/></i>
                        <span onClick={navToScan}>Scan</span>
                    </div>
                    <div className={s.chhotu}>
                        <i> <FontAwesomeIcon icon={["fa", "user-doctor",]} size={'2x'}  style={{color: "#2A2B3F",}}/></i>
                        <span onClick={navToDoc}> Doctor Profile</span>
                    </div>
                    <div className={s.chhotu}>
                        <i> <FontAwesomeIcon icon={["fa", "tent",]} size={'2x'}  style={{color: "#2A2B3F",}}/></i>  
                        <span onClick={camp}>Create Camp Event</span>
                    </div>
                </div>
            </div>

            </div>
        </>
    )
}

const mapStateToProps = (state) => {
    return {
        hid:state.data.hid,
        id: state.data.id,
        Hname: state.data.Hname,
    };
};

export default connect(mapStateToProps, {updateData})(EHS_Dashboard)