import {useState} from "react";
import s from './test.module.css'
import Button from "@mui/material/Button";
import axios from "axios";
import {LinearProgress} from "@mui/material";

const DynamicFields = ( {aid, id, docid, hid} ) => {
  const [data, setData] = useState([]);
  const [drugName, setDrugName] = useState('');
  const [days, setDays] = useState('');
  const [morning, setMorning] = useState(false);
  const [afternoon, setAfternoon] = useState(false);
  const [night, setNight] = useState(false);
  const [cause, setCause] = useState('')
  const [loading, setLoading] = useState(false)

  const handleAddData = () => {
    // Add new data to the array
      setData([...data, { drugName, days, morning, afternoon, night }]);

      // Clear input fields
      setDrugName('');
      setDays('');
      setMorning(false);
      setAfternoon(false);
      setNight(false);
  };
  
  const submit = async ()=>{
      
      console.log(aid, id, docid, hid)
      setLoading(true)
      
      const info = {
          appointment_data: {
              appointmentId: aid,
              hospital_id: hid,
              doctor_id: docid,
              UHID: id
          },
          diagnosis_data: {
              cause: cause,
              priscription: data
          }
      }
      
      try {
          const response = await axios.post('https://ehs-q3hx.onrender.com/api/addDiagnosis', info)
          console.log('response', response.data)
          setLoading(false)
      }catch (e){
          console.log(e)
          setLoading(false)
      }
      
      
  }
  
  return (
      <div>
          <div className={s.toprow}>
              <div className={s.toprow_child}>
                  <label>Cause/Disease</label>
                  <input type="text" onChange={(e) => setCause(e.target.value)} />
              </div>
              <div className={s.toprow_child}>
                  <label>Days</label>
                  <input className={s.date} type="number" name="" id=""/>
              </div>
          </div>
          {data.map((item, index) => (
              <div className={s.temp} key={index}>
                  <p>{item.drugName} | {item.morning.toString()} | {item.afternoon.toString()} | {item.night.toString()} | {item.days}</p>
              </div>
              ))}

          <span className={s.subti} >Prescribe</span>
          <div className={s.midrow} >
          <input
              
              type="text"
              placeholder="Medication"
              value={drugName}
              onChange={(e) => setDrugName(e.target.value)}
          />
         

          {/* Render checkboxes */}
          <label >
              Morning
              <input
                  type="checkbox"
                  checked={morning}
                  onChange={() => setMorning(!morning)}
              />
          </label>
          <label>
              Afternoon
              <input
                  type="checkbox"
                  checked={afternoon}
                  onChange={() => setAfternoon(!afternoon)}
              />
          </label>
          <label>
              Night
              <input
                  type="checkbox"
                  checked={night}
                  onChange={() => setNight(!night)}
              />
          </label>
              <input
                  className={s.date}
                  type="number"
                  placeholder="Days"
                  value={days}
                  onChange={(e) => setDays(e.target.value)}
              />
          </div>

          {/* Button to add new data */}
          <button onClick={handleAddData}>Add More Fields</button>
          <Button onClick={submit}>SUBMIT</Button>
          {loading && <LinearProgress/>}
      </div>
      );
};

export default DynamicFields;
