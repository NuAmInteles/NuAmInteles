import React, { Component } from 'react';
import Recorder from './Recorder';
import './App.css';
document.title = "Nu am inteles!"
class App extends Component {
  render() {
    return (
      
      <div className="App">
        <header className="App-header">
          <h1>
            Scuze, <b>nu am inteles</b>
          </h1>
          <br>



          
          </br>
          <p>Transcriere audio in limba romana</p>
          
          <Recorder />          
        </header>
      </div>
    );
  }
}

export default App;
