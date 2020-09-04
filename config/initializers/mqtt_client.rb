require 'mqtt'
require 'net/https'
require 'uri'

# Subscribe example
Thread.new do
  
  user = "f20c9dfe"
  password = "578f968814bd72ab"
  namespace = "delads/cleverlogger"
  
  lastTriggered = Time.now;
  
  # lets set this to 5 mins
  timeBetweenTriggers = 300000; 
  
  
  MQTT::Client.connect('mqtt://' + user + ':' + password + '@broker.shiftr.io') do |c|
      
       c.subscribe( '006_01' )
       c.subscribe( '006_02' )
       c.subscribe( '006_03' )
       c.subscribe( '006_04' )
       c.subscribe( '006_05' )
       c.subscribe( '006_06' )
       c.subscribe( '006_07' )
       c.subscribe( '006_08' )
       
       puts ("MQTT_CLIENT Thread started");
      
      # If you pass a block to the get method, then it will loop
      #c.get('temperature') do |topic,message|
      #  puts "#{topic}: #{message}"
      #end
      
      ## Let's send a trigger to IFTTT if max temp is reached
      c.get do |topic,message|
        puts "#{topic}: #{message}"


            #example message = 001_01 in the format of boardId_SensorId
            tokens = topic.split("_")
            io_board_id = tokens[0]
            io_sensor_id = tokens[1]
            io_property_value_in = message
            io_property_value_out = io_property_value_in.to_f
        
            sensors = Sensor.where(arduino_id: io_board_id + '-' + io_sensor_id)
            sensors.each do |sensor|
        
              # If this is a pressure sensor, then the raw value will be the
              # absolute pressure value at the current elevation. To calculate
              # the sea-level pressure, we need to see if the user has inputed
              # their elevation in meters. 
        
              # Let's assume sea-level and if there's a stored value then great
              if(sensor.sensor_type == 'Pressure' && sensor.altitude != nil)
                # Formula is 
                # rPresure = absPressure + altitude/8.3
                
                io_property_value_out = (io_property_value_in.to_f + (sensor.altitude.to_f/8.3)).round
        
              end
        
        
              sensor.property_value = io_property_value_out
              sensor.save
              
              time = Time.now
        
              # Let's round to the nearest/lowest 5 mins to all readings around the same
              # time fall into the same timeslot
              rounded_down = time-time.sec-time.min%5*60
        
        
              TimeSeries.create(:sensor_id => sensor.id, :property_value => io_property_value_out, :time => rounded_down);

            end   
        end
    end
end