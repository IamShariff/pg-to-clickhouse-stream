FROM confluentinc/cp-kafka-connect:7.4.0

# Install Debezium PostgreSQL connector using confluent-hub (latest version)
RUN confluent-hub install --no-prompt debezium/debezium-connector-postgresql:latest

# Install ClickHouse Kafka Connect Sink connector using confluent-hub (latest version)
RUN confluent-hub install --no-prompt clickhouse/clickhouse-kafka-connect:latest

# Install Confluent Connect Transforms plugin (already using latest)
RUN confluent-hub install --no-prompt confluentinc/connect-transforms:latest

