from flask import Flask, render_template ,request
from flask_socketio import SocketIO, emit
import json
import os
import time

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret_key'
#port = int(os.getenv('VCAP_APP_PORT', 5000))

dataset=json.load(open('dataset.json'))

instant=0

@app.route('/')
def index():
    return render_template('test3.html')


@app.route('/jsonDatatree')
def jsonDatatree():
    return json.dumps(json.load(open('jsonDatatree.json')))


@app.route('/dataframe')
def getDataframe():
    s_ID=request.args.get('id')
    return json.dumps(dataset[s_ID])

if __name__ == '__main__':
    app.run()