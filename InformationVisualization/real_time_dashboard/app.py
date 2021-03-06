from flask import Flask, render_template ,request
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

dataframe=json.load(open('dataframe.json'))
dataset=json.load(open('dataset.json'))

instant=0

@app.route('/')
def index():
    return render_template('test2.html')
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
@app.route('/test3')
def test2():
    return render_template('test3.html')

@app.route('/network')
def network():
    return render_template('networkbackup.html')

@app.route('/getInitData')
def getInitData():
    data=[{"time":time.strftime("%a %b %d %Y %H:%M:%S"),"V":randint(0,100),"I":randint(0,100)} for i in range(2)]
    return json.dumps(data)
@app.route('/getData')
def getData():
    global instant
    s_ID=request.args.get('id')
    data=dataframe[instant]["values"][s_ID]
    #data['time']=time.strftime("%a %b %d %Y %H:%M:%S")
    instant+=1
    return json.dumps(data)

@app.route('/dataframe')
def getDataframe():
    s_ID=request.args.get('id')
    return json.dumps(dataset[s_ID])

if __name__ == '__main__':
    socketio.run(app, debug=True, port=port)