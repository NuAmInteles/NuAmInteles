from flask import Flask, jsonify, request,redirect
from flask_cors import CORS, cross_origin
import os
from uuid import uuid4
import tempfile
from datetime import datetime

app = Flask(__name__)

cors = CORS(app, resources={r"/foo": {"origins": "http://localhost:port"}})

@app.route('/')
def index():
    return 'This is a simple API',200

@app.route('/process',methods=['GET','POST'])
@cross_origin(origin='localhost:3000')
def process():
    if request.method == 'POST':
        dir = tempfile.TemporaryDirectory()
        path = f'{dir.name}/audio_{uuid4()}.ogg'
        file = request.files['recorded_file']
        file.save(path)
        #os.system(f"echo {path}")
        dir.cleanup()
        #Do something with the file here
        #os.system("docker run --rm -v $(pwd)/data:/workspace/deepspeech.pytorch/data -w /workspace/deepspeech.pytorch deepspeech2.docker python transcribe.py --model-path data/model.pth  --audio-path = data/{}")
    else:
        return redirect('/')
    return jsonify({'Transcribe returned': "Current time is "+str(datetime.utcnow())+"."}),200

if __name__ == "__main__":
    app.run(debug=True,host="0.0.0.0")