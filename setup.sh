sudo pip3 install Adafruit_DHT

sudo pip3 install prometheus_client

mkdir -p /opt/dht_exporter

cat dht_exporter.service | envsubst > /etc/systemd/system/dht_exporter.service
retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Error creating /etc/systemd/system/dht_exporter.service"
fi

cp -r  sensor_prometheus.py /opt/dht_exporter/sensor_prometheus.py

sudo systemctl enable dht_exporter.service

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Error enabling dht_exporter.service"
fi

sudo systemctl start dht_exporter

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Error starting dht_exporter.service"
fi
