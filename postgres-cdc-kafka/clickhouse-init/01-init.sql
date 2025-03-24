CREATE DATABASE IF NOT EXISTS phoenix;

CREATE TABLE IF NOT EXISTS phoenix.shifts
(
    id Int32,
    name String,
    _version UInt64 MATERIALIZED toUnixTimestamp(now()),
    _is_deleted UInt8 DEFAULT 0
)
ENGINE = ReplacingMergeTree(_version)
ORDER BY id;