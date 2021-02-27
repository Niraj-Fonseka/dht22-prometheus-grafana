import Adafruit_DHT
import time
from prometheus_client import start_http_server, Gauge

DHT_SENSOR = Adafruit_DHT.DHT22
DHT_PIN = 4
 
# Create a metric to track time spent and requests made.
g_temperature = Gauge('dht_temperature', 'Temperature in degrees celsius', ['room'])
g_humidity = Gauge('dht_humidity', 'Relative Humidity in percent', ['room'])


def update_sensor_data(temperature, humidity,room):
    """Get sensor data and set on prometheus client."""

    if abs(temperature) < 100:
        g_temperature.labels(room).set('{0:0.1f}'.format(temperature))

    if humidity >= 0 and humidity < 100:
        g_humidity.labels(room).set('{0:0.1f}'.format(humidity))


print("starting prometheus server")
start_http_server(8001)

while True:
    humidity, temperature = Adafruit_DHT.read(DHT_SENSOR, DHT_PIN)
    if humidity is not None and temperature is not None:
        update_sensor_data(temperature,humidity,"room_name")
    else:
        print("Sensor failure");
    time.sleep(1); #checks every second
