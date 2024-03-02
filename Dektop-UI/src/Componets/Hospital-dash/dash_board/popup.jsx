//import React from "react";
import Dialog from "@mui/material/Dialog";
import DialogContentText from "@mui/material/DialogContentText";
import DialogTitle from "@mui/material/DialogTitle";
import DialogActions from "@mui/material/DialogActions";
import DialogContent from "@mui/material/DialogContent";
import Button from "@mui/material/Button";
import axios from "axios";
import {useState} from "react";
import {LinearProgress, Paper, Typography} from "@mui/material";
import s from './dash.module.css'

import CircularProgress from '@mui/material/CircularProgress';


function Popup_box({open, onClose, aid, id}) {
//    const [open, setOpen] = React.useState(false);
    const [data, setdata] = useState([])
    const [loading, setloading] = useState(false)
    const [ass, setass] = useState('Assign')

    const getDocs = async () =>{
//        setloading(true)
        try {
            const response = await axios.get('https://ehs-q3hx.onrender.com/api/fetchDR/'+id)
//            console.log(response.data)
            setdata(response.data)
//            setloading(false)
        }catch (e) {
            console.log(e)
//            setloading(false)
        }
    }
    if (open){
        setTimeout(()=>{
            getDocs()
        },500)
    }
    const appoint = async () =>{
        setloading(true)

        const info = {
            appointmentId: aid,
            doctorId:data.docID
        }
        console.log(info)
        try {
            const response = await axios.put('https://ehs-q3hx.onrender.com/api/assignDoctor', info)
            console.log(response.data)
            setass("Assigned")
            setloading(false)
        }catch (e) {
            console.log(e)
            setloading(false)
        }
    }

    return (
        <div>

            <Dialog open={open} onClose={onClose}>
                <DialogTitle>{"Available Doctors"}</DialogTitle>
                <DialogContent >
                    {data.map((item) => (
                            <Paper key={item.id} elevation={3} style={{ padding: '10px', margin: '10px' }}>
                                <Typography>Doctor {item.fullname} : {item.speciality}  <button onClick={

                                async () =>{
                                    setloading(true)

                                    const info = {
                                        appointmentId: aid,
                                        doctorId:item.docID
                                    }
                                    console.log(info)
                                    try {
                                        const response = await axios.put('https://ehs-q3hx.onrender.com/api/assignDoctor', info)
                                        console.log(response.data)
                                        setass("Assigned")
                                        setloading(false)
                                    }catch (e) {
                                        console.log(e)
                                        setloading(false)
                                    }
                                }}>{ass}</button>

                                </Typography>


                            </Paper>
                            ))}
                </DialogContent>
                {
            loading && <LinearProgress />
            }
                <DialogActions>
                    <Button onClick={onClose}
                        color="primary" autoFocus>
                        Close
                    </Button>
                </DialogActions>
            </Dialog>

        </div>
        );
}
export default Popup_box