import s from './dig.module.css'
import Sidebar from "../sidebar.jsx";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCirclePlus} from '@fortawesome/free-solid-svg-icons'
import {useEffect, useState} from "react";
import axios from "axios";
import {useLocation} from "react-router-dom";
import {updateData} from "../../../redux-stuff/form_action.js";
import {connect} from "react-redux";
library.add(faCirclePlus)



function Dig_History({Hname}) {
    
    const {state} = useLocation();
    const { id, data } = state;
    
    const ID = id.id
    
    const [prez, setPrez] = useState(false);
    const [hellz, setHell] = useState(false);
    const [color1, setColor1] = useState('#939497')
    const [color, setColor] = useState('#939497')
    const [present, setPresent] = useState(false)
    const [gajab, setGajab] = useState([])
    const [dxx, setDxx] = useState([])


    const GetUsrNm = async () =>{

        try {
            const respnse = await axios.get('https://ehs-q3hx.onrender.com/api/fetchUser/'+ID)
            console.log(respnse.data)
            setDxx(respnse.data[0].name)
            if (respnse.data[0].reports ){
                console.log("present")
                setGajab(respnse.data[0].reports)
                setPresent(true)
            }else {
                console.log("false")
                setPresent(true)
            }
        } catch (e) {
            console.log(e)
        }
    }

    useEffect(()=>{
        GetUsrNm()
    },[])
//
    
    function presc() {
        setHell(false)
        setPrez(true)
        setColor('#939497')
        setColor1('#E55771')
    }
    function health() {
        setPrez(false)
        setHell(true)
        setColor1('#939497')
        setColor('#E55771')
    }



    return(
        <>
        <div className={s.whole_screen}>
            <div className={s.upar}>
                <div className={s.title}> {Hname}</div>
                <i> <FontAwesomeIcon icon={["fa", "circle-plus",]} size={"3x"} style={{color: "#E55771",}}/> </i>
            </div>
            <div className={s.sub_upar}>
                <button onClick={presc} style={{background:color1}} >Prescription History</button>
                <button onClick={health} style={{background:color}} >Health History</button>
            </div>
            <div className={s.side}>
                <Sidebar/>
            </div>

            <div className={s.main_maal}>
                { prez && <div>
                    {data.data.toReversed().map((item)=>(

                        <div key={item.id} className={s.card}>
                            <span className={s.p_name} >{item.diagnosis_data.cause}</span>
                            <span>Diagnosed on: {item.appointment_data.date}</span>
                            <span>Diagnosed by: {item.appointment_data.doctor_id}</span>
                            <span>Mediactions: {item.diagnosis_data.priscription.map((item, index)=>(
                                <div key={index}>
                                    <span> {index+1} : {item.drugName}</span>
                                </div>
                                ))}</span>
                        </div>

                        ))}
            </div> }
                { hellz && <div>
                        {present && <div>
                            {gajab.map((item, index)=>(
                                <div key={index} className={s.card}>
                                    <span className={s.p_name} >{item.title}</span>
                                    <span>{item.date}</span>
                                    <span><a href={item.fileURL} target={"_blank"} rel="noreferrer">{item.fileURL}</a></span>

                                </div>
                            ))}
                </div>}
            </div>}




            </div>
            <div className={s.sub_main}>
                <div className={s.p_text}>
                    <span className={s.p_name}>{dxx} </span>
                    <span>age:</span>
                    <span>height:</span>
                    <span>weight:</span>
                </div>
                <div className={s.problems}>
                    <span>High BP</span>
                    <span>Pre-dib</span>
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
export default connect(mapStateToProps, {updateData})(Dig_History)