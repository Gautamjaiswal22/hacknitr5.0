import s from './camp.module.css'
import Sidebar from "../sidebar.jsx";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCirclePlus} from '@fortawesome/free-solid-svg-icons'
import {useState} from "react";
import axios from "axios";
import {updateData} from "../../../redux-stuff/form_action.js";
import {connect} from "react-redux";
import {Backdrop} from "@mui/material";
import Box from "@mui/material/Box";
import CircularProgress from "@mui/material/CircularProgress";
library.add(faCirclePlus)




function Camp_page({Hname,hid, id}) {
    
    const [title, settitle] = useState('')
    const [age, setage] = useState('')
    const [pin, setpin] = useState('')
    const [startdate, setstartdate] = useState('')
    const [enddate, setenddate] = useState('')
    const [boost, setboost] = useState(false)
    const [data, setdata] = useState('')
    const [loading, setLoading] = useState(false);


    const submitThis = async () => {
        setLoading(true)
        const info = {title:title, age:age, pin:pin, start_date:startdate, end_date:enddate, boost:boost}
        console.log(info)

        try {

            const response = await axios.post('https://ehs-q3hx.onrender.com/api/postCamp/'+hid,info);
            console.log(response.data)
            setdata(response.data)
            setLoading(false)
        } catch (error) {
            console.error(error)
        } finally {
            setLoading(false)
        }
    }

    const handleDropdownChange = (event) => {
        const selectedValue = event.target.value;
        const newValue = selectedValue === 'true';
        setboost(newValue);
    };

    return(
        <>
        <div className={s.whole_screen}>
            <div className={s.upar}>
                <div className={s.title}> {Hname} </div>
                <i> <FontAwesomeIcon icon={["fa", "circle-plus",]} size={"3x"} style={{color: "#E55771",}}/> </i>
            </div>
            <div className={s.sub_upar}>
                <div className={s.title}> Create Camp Event </div>
            </div>
            <div className={s.side}>
                <Sidebar/>
            </div>

            <div className={s.main_maal}>
                
                <div className={s.inp_fields}>
                    <div className={s.semi_input}>
                        <label htmlFor="">Camp Title</label>
                        <input type="text" name="text"
                            value={title} onChange={(e)=>settitle(e.target.value)}
                            id="text" placeholder='Enter Full Name  ' required/>
                    </div>
                    <div className={s.semi_input}>
                        <label htmlFor="">Age Group</label>
                        <input type="number"
                            value={age} onChange={(e)=>setage(e.target.value)}
                            placeholder='Enter Age Group' required/>
                    </div>
                    <div className={s.semi_input}>
                        <label htmlFor="">PIN</label>
                        <input type="number" name="pin"
                            value={pin} onChange={(e)=> setpin(e.target.value)}
                            id="staff-number" placeholder='PIN Code' required/>
                    </div>
                </div>
                <div className={s.inp_fields}>
                    <div className={s.semi_input}>
                        <label htmlFor="">Start Date</label>
                        <input type="date" name="date"
                            value={startdate} onChange={(e)=> setstartdate(e.target.value)}
                            id="city-text" placeholder='Enter City Name' required/>
                    </div>
                    <div className={s.semi_input}>
                        <label htmlFor="">End date</label>
                        <input type="date" name="state"
                            value={enddate} onChange={(e)=> setenddate(e.target.value)}
                            id="telephone" placeholder='For patients to contact' required/>
                    </div>
                    <div className={s.semi_input}>
                        <label htmlFor="">Boost Reach</label>
                        <select id="dropdown" onChange={handleDropdownChange}>
                            <option value="true">True</option>
                            <option value="false">False</option>
                        </select>
                    </div>
                </div>
                <div className={s.amount}>
                    <span>Amount Payable </span>
                </div>
                <div className={s.button_pay}>
                    <button onClick={submitThis} >Save and Continue</button>
                </div>
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
        )
}
const mapStateToProps = (state) => {
    return {
        hid:state.data.hid,
        id: state.data.id,
        Hname: state.data.Hname,
    };
};

export default connect(mapStateToProps, {updateData})(Camp_page)