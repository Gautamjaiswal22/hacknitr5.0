import s from './doc_p.module.css'
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { library } from '@fortawesome/fontawesome-svg-core'
import { faCirclePlus} from '@fortawesome/free-solid-svg-icons'
import {useEffect, useState} from "react";
import axios from "axios";
import Sidebar from "../../sidebar.jsx";
import ss from './dlg.module.css'
import * as React from 'react';
import Button from '@mui/material/Button';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogTitle from '@mui/material/DialogTitle';
import {LinearProgress} from "@mui/material";
import {updateData} from "../../../../redux-stuff/form_action.js";
import {connect} from "react-redux";
library.add(faCirclePlus)


function Doc_Prof({hid, id, Hname}) {

    const [open, setOpen] = React.useState(false);
    const [ email, setemail] = useState('')
    const [ special, setspecial] = useState('')
    const [ d_name, setd_name] = useState('')
    const [ phone, setphone] = useState('')
    const [data, setDataIn] = useState('')
    const [loading, setloading] = useState(false)
    const [data1, setdata1] = useState([])
    const handleClickOpen = () => {
        setOpen(true);
    };

    
    const [name, setname] = useState('');

//        useEffect(()=>{
//            axios.get('').then(respnse=>{
//                setname(respnse.data)
//            })
//        },[])
//    console.log(id, data)
    const submitThis = async (e) => {
        e.preventDefault();
//        setOpen(false);
        setloading(true)

        const info = {name:d_name, spec:special, email:email, phone:phone}
        console.log(info)

        try {
            const response = await axios.post('https://ehs-q3hx.onrender.com/api/addDoc/'+hid,info);
            console.log(response.data)
            setloading(false)
        } catch (error) {
            console.error(error)
            setloading(false)
        }

    }

    function close() {
        setOpen(false);
    }
    const getDocs = async () =>{
        //        setloading(true)
        try {
            const response = await axios.get('https://ehs-q3hx.onrender.com/api/fetchDR/'+id)
            //            console.log(response.data)
            setdata1(response.data)
            //            setloading(false)
        }catch (e) {
            console.log(e)
            //            setloading(false)
        }
    }
    useEffect(()=>{
        getDocs()
    },[])
    
    return(
        <>
        <div className={s.whole_screen}>
            <div className={s.upar}>
                <div className={s.title}> {Hname} </div>
                <i> <FontAwesomeIcon icon={["fa", "circle-plus",]} size={"3x"} style={{color: "#E55771",}}/> </i>
            </div>
            <div className={s.sub_upar}>
                <div className={s.login_button}>
                    <button onClick={handleClickOpen} >Create New Doctor Profile</button>
                    <React.Fragment>
                        <Dialog
                            open={open}
                            aria-labelledby="alert-dialog-title"
                            aria-describedby="alert-dialog-description"
                            >
                            <DialogTitle id="alert-dialog-title">
                                {"Doctor Profile"}
                            </DialogTitle>
                            <DialogContent>
                                <div className={ss.box}>

                                    <div className={ss.inp}>
                                        <div className={ss.semi_inp} >
                                            <label>Email Address</label>
                                            <input type="text" placeholder={'Email ID'}
                                                value={email} onChange={(e)=>setemail(e.target.value)}   />
                                        </div>
                                        <div className={ss.semi_inp}>
                                            <label>Speciality</label>
                                            <input type="text" name="special" id="special"
                                                value={special} onChange={(e)=>setspecial(e.target.value)}/>
                                        </div>

                                    </div>

                                    <div className={ss.inps}>
                                        <div className={ss.semi_inp} >
                                            <label>Name</label>
                                            <input type="text" name="d_name" id="d_name"
                                                value={d_name} onChange={(e)=>setd_name(e.target.value)}/>
                                        </div>
                                        <div className={ss.semi_inp} >
                                            <label>Phone Number</label>
                                            <input type="text" name="phone" id="phone"
                                                value={phone} onChange={(e)=>setphone(e.target.value)}/>
                                        </div>
                                    </div>

                                </div>
                            </DialogContent>
                            <DialogActions>
                                <Button onClick={submitThis} autoFocus>
                                    Create
                                </Button>
                                <Button onClick={close} autoFocus>
                                    Close
                                </Button>
                            </DialogActions>
                            { loading && <LinearProgress />}
                        </Dialog>
                    </React.Fragment>
                </div>
                <div className={s.title}>Doctor Staff</div>
            </div>
            <div className={s.side}>
                <Sidebar/>
            </div>

            <div className={s.main_maal}>

                {data1.map((item, index) => (

                    <div className={s.card} key={index}>
                        <span className={s.p_name} >{item.fullname}</span>
                        <span>{item.speciality}</span>
                        <span>{item.email}</span>
                    </div>
                    ))
                }



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
export default connect(mapStateToProps, {updateData})(Doc_Prof)