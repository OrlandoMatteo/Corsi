from flask import Flask, render_template
from flask_socketio import SocketIO, emit
import json
import os
import time
import re
from random import randint, choice
import scipy.io as sio

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret_key'
socketio = SocketIO(app)
port = int(os.getenv('VCAP_APP_PORT', 5000))

data=sio.loadmat('values.mat')

@app.route('/')
def index():
    return render_template('index.html')
@app.route('/jsonData')
def jsonData():
    return json.dumps(json.load(open('jsonData.json')))

@app.route('/jsonDatatree')
def jsonDatatree():
    return json.dumps(json.load(open('jsonDatatree.json')))

@app.route('/grid')
def grid():
    return render_template('grid.html')
@app.route('/test')
def test():
    return render_template('test.html')
@app.route('/test2')
def test2():
    return render_template('test2.html')

@app.route('/network')
def network():
    return render_template('networkbackup.html')

@app.route('/getInitData')
def getInitData():
    data=[{"time":time.strftime("%a %b %d %Y %H:%M:%S"),"P":randint(0,100),"Q":randint(0,100)} for i in range(100)]
    return json.dumps(data)
@app.route('/getData')
def getData():
    data={"time":time.strftime("%a %b %d %Y %H:%M:%S"),"P":randint(0,100),"Q":randint(0,100)}
    return json.dumps(data)



if __name__ == '__main__':
    socketio.run(app, debug=True, port=port)