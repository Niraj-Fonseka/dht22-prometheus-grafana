docker run -d -p 3000:3000 --name grafana grafana/grafana:6.5.0

sudo docker run -d -p 9090:9090 --name=prometheus -v $(pwd)/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml -v $(pwd)/prometheus/targets.json:/etc/prometheus/targets.json prom/prometheus --config.file=/etc/prometheus/prometheus.yml
