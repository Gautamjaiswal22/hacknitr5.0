import { useState } from 'react'
import s from './doc.module.css'
import axios from 'axios'
import {useNavigate} from "react-router-dom";
import {Backdrop} from "@mui/material";
import CircularProgress from "@mui/material/CircularProgress";
import Box from "@mui/material/Box";

function Doc_signin() {

    const [doctor_id, setdoctor_id] = useState('')
    const [password , setpassword] = useState('')
    const [loading, setloading] = useState(false)
    const [data, setdata] = useState([])

    const navigate = useNavigate()

    const submitThis = async (e) => {
        e.preventDefault();
        setloading(true)
        const info = {docID:doctor_id, pass:password}

        try {
            const response = await axios.post('https://ehs-q3hx.onrender.com/api/loginDoc',info);
            console.log(response.data)
            setdata(response.data)
            setloading(false)
            gotoPage()
        } catch (error) {
            console.error(error)
            setloading(false)
        } 

    }

    function gotoPage() {
        const name = data.docData.fullname
        console.log()
        if (data.success === true){
            console.log("navigatig")
            navigate('/doc_dash', {state:{docid:doctor_id, name:name}})
        }
    }


    return (
        <>
        <div className={s.form}>
            <form action='' method='POST' onSubmit={submitThis}>
                <div className="title">
                    EHS Doctor Login
                </div>
                <div className={s.inp_fields}>
                    <input type="text" name="doctor_id" 
                        value={doctor_id} onChange={(e)=>setdoctor_id(e.target.value)}  
                        id="doctor_id" placeholder='Doctor ID' required/>
                    <input type="password" name="password" 
                        value={password} onChange={(e)=>setpassword(e.target.value)} 
                        id="password" placeholder='Password' required/>
                </div>
                <div className={s.login_button}>
                    <button type="submit" >Login</button>
                </div>
            </form>

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

export default Doc_signin