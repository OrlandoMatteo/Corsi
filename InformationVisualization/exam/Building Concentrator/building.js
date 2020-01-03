var tenant = "dauin";

var mqtt = require('mqtt'),
    mqtt_client = mqtt.connect({ 
		host:'pc-orlando-lab4.polito.it',
		port:1883,
		clientId:'Concentrator', 
		clean:true, 
		username:'matlab', 
		password:'matlab'
    });

var client = require('./client'),
	host = 'localhost',
	port = 5001,
	c = new client(host, port);

c.receive();
	
mqtt_client.on('connect',function(){
});	

c.on('data',function(obj){
	console.log(obj.payload);
	payload = JSON.stringify(obj.payload)
	mqtt_client.publish(obj.topic,payload,function(err){
		if(err)
			console.log(err)
	});		
})

