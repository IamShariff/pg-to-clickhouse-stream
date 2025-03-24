# Docker Setup Guide

## Step 1: Stop already running-postgres Image
```sh
docker stop lz-postgres
```

## Step 2: Make `init.sh` Executable
```sh
chmod +x connect/init.sh
```

## Step 3: Start Services with Docker Compose
```sh
docker-compose up -d --build
```

## Step 4: Verify Connectors

### List all connectors:
```sh
curl -s http://localhost:8083/connectors | jq
```

### Check specific connector status:
```sh
curl -s http://localhost:8083/connectors/postgres-connector/status | jq
curl -s http://localhost:8083/connectors/clickhouse-sink/status | jq
```

## Step 5: Access PostgreSQL

### Open PostgreSQL in terminal:
```sh
docker exec -it postgres-cdc-kafka-postgres-1 psql -U postgres -d phoenix
```

### Add dummy data:
```sql
INSERT INTO shifts (name) VALUES ('Hello World');
```

## Step 6: Access Kafka UI Manager
Open your browser and go to:
```
http://localhost:8080
```
Verify that you can see topics and messages.

## Step 7: Access ClickHouse

### Open ClickHouse in terminal:
```sh
docker exec -it postgres-cdc-kafka-clickhouse-1 clickhouse-client -u admin --password admin
```

### Query data:
```sql
SELECT * FROM phoenix.shifts;
```
