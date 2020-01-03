var net = require('net'),
	util = require('util'),
	events = require('events'),
	EventEmitter = events.EventEmitter,
	chunk = '';

function Client(host, port){
	EventEmitter.call(this);
    this.socket = new net.Socket();
    this.socket.connect(port, host, function() {
        console.log('Connected');
    });
	this.queue = [];
}

util.inherits(Client,EventEmitter);

Client.prototype.send = function (data){
    this.socket.write(data+'\n');
}

Client.prototype.receive = function (){
    var that = this;
    this.socket.on('data', function(data) {
		chunk += data.toString(); // Add string on the end of the variable 'chunk'
		d_index = chunk.indexOf('%'); // Find the delimiter

		// While loop to keep going until no delimiter can be found
		while (d_index > -1) {         
			try {
				string = chunk.substring(0,d_index); // Create string up until the delimiter
				json = JSON.parse(string); // Parse the current string
				that.emit('data',json);
			}catch (err) {
			  console.log(err);
			}
			chunk = chunk.substring(d_index+1); // Cuts off the processed chunk
			d_index = chunk.indexOf('%'); // Find the new delimiter
		}
    });
}

Client.prototype.disconnect = function (){
    this.socket.on('close', function() {
        console.log('Connection closed');
        this.socket.destroy();
    });
}


module.exports = Client;