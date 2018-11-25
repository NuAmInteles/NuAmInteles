import React from 'react';
import { ReactMic } from 'react-mic';
import saveAs from 'file-saver';



export default class Recorder extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      record: false
    }

  }

  startRecording = () => {
    this.setState({
      record: true
    });
  }

  stopRecording = () => {
    this.setState({
      record: false
    });
  }

  onData(recordedBlob) {
    console.log('chunk of real-time data is: ', recordedBlob);
  }

  onStop(recordedBlob) {
    console.log('recordedBlob is: ', recordedBlob);

     saveAs(recordedBlob.blob, "test-aa.ogg");

    // var formData = new FormData();

    // formData.append('file', recordedBlob.blob);
    
    // fetch('http://127.0.0.1:5000/process', {
    //   method: 'POST',
    //   body: formData,
    //   headers: {
    //     "Content-Type": "multipart/form-data",
    //   }
    // })
    // .then(response => response.json())
    // .catch(error => console.error('Error:', error))
    // .then(response => console.log('Success:', JSON.stringify(response)));

  }

  render() {
    return (
      <div>
        <ReactMic
          record={this.state.record}
          className="sound-wave"
          onStop={this.onStop}
          onData={this.onData}
          strokeColor="#000000"
          backgroundColor="#FF4081" />
          <p>
        <button onClick={this.startRecording} type="button">Start</button>
        <button onClick={this.stopRecording} type="button">Stop</button>
        </p>
      </div>
    );
  }
}