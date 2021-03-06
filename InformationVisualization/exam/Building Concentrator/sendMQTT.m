function result = sendMQTT(server,values,date)

    topic = 'dauin/input/json/estimator/concentrator/';
    
    json = ['{'...
        '"topic":"toChange",'...
        '"payload":{'...
            '"hardwareId": "toChange",'...
            '"type": "DeviceMeasurements",'...
            '"request":{'...
                '"measurements": {'...
                    '"electricity.power.active.estimation.l1":toChange,'...
                    '"electricity.power.active.estimation.l2":toChange,'...
                    '"electricity.power.active.estimation.l3":toChange,'...
                    '"electricity.power.active.uncertainty.l1":toChange,'...
                    '"electricity.power.active.uncertainty.l2":toChange,'...
                    '"electricity.power.active.uncertainty.l3":toChange,'...
                    '"electricity.power.reactive.estimation.l1":toChange,'...
                    '"electricity.power.reactive.estimation.l2":toChange,'...
                    '"electricity.power.reactive.estimation.l3":toChange,'...
                    '"electricity.power.reactive.uncertainty.l1":toChange,'...
                    '"electricity.power.reactive.uncertainty.l2":toChange,'...
                    '"electricity.power.reactive.uncertainty.l3":toChange,'...
                    '"electricity.instantaneous.rms.voltage.estimation.l1":toChange,'...
                    '"electricity.instantaneous.rms.voltage.estimation.l2":toChange,'...
                    '"electricity.instantaneous.rms.voltage.estimation.l3":toChange,'...
                    '"electricity.instantaneous.rms.voltage.uncertainty.l1":toChange,'...
                    '"electricity.instantaneous.rms.voltage.uncertainty.l2":toChange,'...
                    '"electricity.instantaneous.rms.voltage.uncertainty.l3":toChange'...
                '},'...
                '"eventDate": "toChange",'...
                '"updateState": true,'...
                '"metadata": {}'...
            '}'...
        '}'...
    '}'];
        
    %% reset jsonbatch JSON
    JSON = org.json.JSONObject(json);

    %% set topic
    JSON.put('topic',strcat(topic,values.hardwareIds{1,2}));

    %% set measurements
    JSON.get('payload').put('hardwareId',values.hardwareIds{1,1});
    %% set eventDate
    JSON.get('payload').get('request').put('eventDate',date);
    %% set device hardwareId
    JSON.get('payload').get('request').get('measurements').put('electricity.power.active.estimation.l1',values.electricity.power.active.estimation.l1);
    JSON.get('payload').get('request').get('measurements').put('electricity.power.active.estimation.l2',values.electricity.power.active.estimation.l2);
    JSON.get('payload').get('request').get('measurements').put('electricity.power.active.estimation.l3',values.electricity.power.active.estimation.l3);
    JSON.get('payload').get('request').get('measurements').put('electricity.power.active.uncertainty.l1',values.electricity.power.active.uncertainty.l1);
    JSON.get('payload').get('request').get('measurements').put('electricity.power.active.uncertainty.l2',values.electricity.power.active.uncertainty.l2);
    JSON.get('payload').get('request').get('measurements').put('electricity.power.active.uncertainty.l3',values.electricity.power.active.uncertainty.l3);
    JSON.get('payload').get('request').get('measurements').put('electricity.power.reactive.estimation.l1',values.electricity.power.reactive.estimation.l1);
    JSON.get('payload').get('request').get('measurements').put('electricity.power.reactive.estimation.l2',values.electricity.power.reactive.estimation.l2);
    JSON.get('payload').get('request').get('measurements').put('electricity.power.reactive.estimation.l3',values.electricity.power.reactive.estimation.l3);
    JSON.get('payload').get('request').get('measurements').put('electricity.power.reactive.uncertainty.l1',values.electricity.power.reactive.uncertainty.l1);
    JSON.get('payload').get('request').get('measurements').put('electricity.power.reactive.uncertainty.l2',values.electricity.power.reactive.uncertainty.l2);
    JSON.get('payload').get('request').get('measurements').put('electricity.power.reactive.uncertainty.l3',values.electricity.power.reactive.uncertainty.l3);
    JSON.get('payload').get('request').get('measurements').put('electricity.instantaneous.rms.voltage.estimation.l1',values.electricity.instantaneous.rms.voltage.estimation.l1);
    JSON.get('payload').get('request').get('measurements').put('electricity.instantaneous.rms.voltage.estimation.l2',values.electricity.instantaneous.rms.voltage.estimation.l2);
    JSON.get('payload').get('request').get('measurements').put('electricity.instantaneous.rms.voltage.estimation.l3',values.electricity.instantaneous.rms.voltage.estimation.l3);
    JSON.get('payload').get('request').get('measurements').put('electricity.instantaneous.rms.voltage.uncertainty.l1',values.electricity.instantaneous.rms.voltage.uncertainty.l1);
    JSON.get('payload').get('request').get('measurements').put('electricity.instantaneous.rms.voltage.uncertainty.l2',values.electricity.instantaneous.rms.voltage.uncertainty.l2);
    JSON.get('payload').get('request').get('measurements').put('electricity.instantaneous.rms.voltage.uncertainty.l3',values.electricity.instantaneous.rms.voltage.uncertainty.l3);

    server.send(strcat(char(JSON.toString()),'%'));
        
    result = 1;
    
end	