import s from './doc_dash.module.css'
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCirclePlus, faPlus, faNotesMedical, faHospital,   faLinesLeaning, faQrcode, faUserDoctor, faTent } from '@fortawesome/free-solid-svg-icons'
import {useEffect, useState} from "react";
import Sidebar from "../../sidebar.jsx";
import Popup_pres from "./pres_popup.jsx";
import axios from "axios";
import {useLocation} from "react-router-dom";
library.add(faCirclePlus, faPlus, faNotesMedical, faHospital, faLinesLeaning, faQrcode, faUserDoctor, faTent)


function DOC_Dashboard() {

    const [open, setOpen] = useState(false);
    const [dr_name, setdr_name] = useState('')
    const [data, setdata] = useState([])

    const location = useLocation()

    const {docid, name} = location.state
//    console.log(docid)
    const handleClickToOpen = () => {
        setOpen(true);

    };
    const handleToClose = () => {
        setOpen(false);
    };

    const getApt = async () =>{
        //        setloading(true)
        try {
            const response = await axios.get('https://ehs-q3hx.onrender.com/api/fetchDoctorsAppointment/'+docid)
//            console.log(response.data)
            setdata(response.data)
            //            setloading(false)
        }catch (e) {
            console.log(e)
            //            setloading(false)
        }
    }

    setTimeout(()=>{
        getApt()
    }, 2000)


    return(
        <>
        <div className={s.whole_screen}>
            <div className={s.upar}>
                <div className={s.title}> Dr. {name} </div>
                <i> <FontAwesomeIcon icon={["fa", "circle-plus",]} size={"3x"} style={{color: "#E55771",}}/> </i>
            </div>
            <div className={s.sub_upar}>
                <div className={s.sub_sub_upar}>
                    <div className={s.title}> Appointments </div>
                    <div className={s.new_btn}>
                        <button onClick={getApt}><i> <FontAwesomeIcon icon={["fa", "plus",]}  style={{color: "#FFFFFF",}}/> </i>NEW</button>
                    </div>
                </div>
                <div className={s.two_sub_upar}>
                    {data.map((item)=>(
                        <div key={item.id} className={s.appoints}>
                            <span>{item.patient_data.patient_name}</span>
                            <span>{item.diagnosis_data.status}</span>
                            <span>{item.appointment_data.date}</span>
                            {/*<span>{item.appointment_data.}</span>-*/}
                            <span>{item.appointment_data.health_issue}</span>

                            <div className={s.assist_bt}>
                                <button onClick={handleClickToOpen}><i> <FontAwesomeIcon icon={["fa", "notes-medical",]}  style={{color: "#FFFFFF",}}/> </i>Assist</button>
                                <Popup_pres open={open} onClose={handleToClose}
                                    aid={item.appointmentId}
                                    id={item._id}
                                    hid={item.appointment_data.hospital_id}
                                    docid={item.appointment_data.doctor_id}/>
                            </div>

                        </div>
                        ))}
                </div>
            </div>
            <div className={s.side}>
                <Sidebar/>
            </div>
        </div>
        </> 
        )
}

export default DOC_Dashboard