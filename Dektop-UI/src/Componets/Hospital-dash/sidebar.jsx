import s from './sidebar.module.css'

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCirclePlus, faPlus, faNotesMedical, faHospital,   faLinesLeaning, faQrcode, faUserDoctor, faTent } from '@fortawesome/free-solid-svg-icons'
import {useNavigate} from "react-router-dom";
library.add(faCirclePlus, faPlus, faNotesMedical, faHospital, faLinesLeaning, faQrcode, faUserDoctor, faTent)

function Sidebar(){

    const navigate = useNavigate()

    function navToScan(){
        navigate('/scan')
    }
    function navToDash(){
        navigate('/ehs_dash')
    }
    function navToDoc() {
        navigate('/doc_prof')
    }
    function home() {
        navigate('/')
    }
    function camp() {
        navigate('/camp')
    }


    return(
        <div>
            <div className={s.sidee}>
                <div className={s.logo_name}>
                    <i onClick={home} > <FontAwesomeIcon icon={["fa", "hospital",]} size={'3x'}  style={{color: "#E55771",}}/></i>
                    <div className={s.titlee}><span onClick={home} >EHS</span> </div>
                </div>
                <div className={s.side_mainn}>
                    <div className={s.chhotu}>
                        <i> <FontAwesomeIcon icon={["fa", "lines-leaning",]} size={'2x'}  style={{color: "#2A2B3F",}}/></i>
                        <span onClick={navToDash} >Appointments</span>
                    </div>
                    <div className={s.chhotu}>
                        <i> <FontAwesomeIcon icon={["fa", "qrcode",]} size={'2x'}  style={{color: "#2A2B3F",}}/></i>
                        <span onClick={navToScan} >Scan</span>
                    </div>
                    <div className={s.chhotu}>
                        <i> <FontAwesomeIcon icon={["fa", "user-doctor",]} size={'2x'}  style={{color: "#2A2B3F",}}/></i>
                        <span onClick={navToDoc}> Doctor Profile</span>
                    </div>
                    <div className={s.chhotu}>
                        <i> <FontAwesomeIcon icon={["fa", "tent",]} size={'2x'}  style={{color: "#2A2B3F",}}/></i>  
                        <span onClick={camp} >Create Camp Event</span>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Sidebar