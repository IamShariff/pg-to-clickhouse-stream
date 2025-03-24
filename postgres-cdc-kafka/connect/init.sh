#!/bin/bash

# Wait for Kafka Connect to become available
max_retries=10
retry_count=0

until [ $retry_count -ge $max_retries ]
do
    curl_status=$(curl -s -o /dev/null -w %{http_code} http://localhost:8083/connectors)
    if [ $curl_status -eq 200 ]; then
        break
    fi
    echo "Waiting for Kafka Connect... (attempt $((retry_count+1))"
    sleep 30
    retry_count=$((retry_count+1))
done

# Create PostgreSQL source connector
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" \
  http://localhost:8083/connectors/ -d @/config/debezium-connector.json

# Create ClickHouse sink connector with Debezium transform
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" \
  http://localhost:8083/connectors/ -d @/config/clickhouse-sink.json

# Keep the container running
tail -f /dev/null