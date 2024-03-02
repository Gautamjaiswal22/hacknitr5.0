//import React from "react";
import Dialog from "@mui/material/Dialog";
import DialogTitle from "@mui/material/DialogTitle";
import DialogActions from "@mui/material/DialogActions";
import DialogContent from "@mui/material/DialogContent";
import Button from "@mui/material/Button";
import DynamicFields from "./test.jsx";



function Popup_pres({open, onClose, aid, id, docid, hid}) {
    //    const [open, setOpen] = React.useState(false);

    return (
        <div>
            <Dialog open={open} onClose={onClose}>
                <DialogTitle>{"Add Prescribtion"}</DialogTitle>
                <DialogContent>
                    <DynamicFields aid={aid} id={id} docid={docid} hid={hid}/>
                </DialogContent>
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
export default Popup_pres