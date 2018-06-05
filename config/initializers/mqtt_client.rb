
require 'mqtt'
require 'net/https'
require 'uri'


 @sensors = Sensor.all
  
@sensors.each do |s|

  #  namespace = s.namespace
  mqtt_token = s.mqtt_token
  mqtt_topic = s.mqtt_topic
  sensor_id = s.id
  sensor_name = s.name
  
  Thread.new do 

    begin
    # mqtt_token = "mqtt://delads:dd31d3fbed2942fa8e8d7eb6ac6d6eee@io.adafruit.com"
    # mqtt_topic = "delads/feeds/temperature"

      MQTT::Client.connect(mqtt_token) do |c|
          
          c.subscribe(mqtt_topic)       
          puts ("MQTT_CLIENT Thread started : " + sensor_name);
          
          ## Let's send a trigger to IFTTT if max temp is reached
          c.get do |topic,message|
            puts "#{topic}: #{message}"
      
            
            if(topic == mqtt_topic)

              # time = Time.now.rfc2822
              #rounded = Time.at((t.to_time.to_i / 60.0).round * 60)

              # We should not be holding connections open to the database in a thread
              # Let's call an api endpoint to change the values instead
              # we are going to hardcode this for now into 2 locations
              # http://io.delads.com and http://localhost:3000 (as there is no way of finding out this info)


              # uri_list = ['http://io.delads.com/api/createtimeseries',
              #             'http://io.delads.com/api/setsensorpropertyvalue']

              uri_list = ['http://localhost:3000/api/createtimeseries',
                             'http://localhost:3000/api/setsensorpropertyvalue']

              uri_list.each do |link|
                uri = URI(link)
                params = { :sensor_id => sensor_id, :property_value => message }
                uri.query = URI.encode_www_form(params)
                res = Net::HTTP.get_response(uri)
                puts res.body if res.is_a?(Net::HTTPSuccess)
              end

            end  # enf id
          end # end do
      end # end do

    rescue => e
      puts "Exception Message: #{ e.message }"
      puts "Exception Backtrace: #{ e.backtrace }"

    ensure
      ActiveRecord::Base.connection_pool.release_connection
    end # end begin

  end  # end thread

  

end # end looping through all thermostats

# rounds a Time or DateTime to the neares 15 minutes
# def round_to_1_minute(t)
#  rounded = Time.at((t.to_time.to_i / 60.0).round * 60)
#  t.is_a?(DateTime) ? rounded.to_datetime : rounded
# end

