# The Complete PostgreSQL Mastery Guide
## From Zero to Expert: Deep Dive into the World's Most Advanced Open Source Database

**Version**: 1.0 (Ultra Deep Dive Edition)  
**Last Updated**: 2025  
**Target Audience**: Developers seeking mastery-level understanding of PostgreSQL

---

## Table of Contents

### Part I: Fundamentals & Core Concepts
1. [PostgreSQL Philosophy & Architecture](#1-postgresql-philosophy--architecture)
2. [Installation & Setup](#2-installation--setup)
3. [Database Basics](#3-database-basics)
4. [psql Command Line Tool](#4-psql-command-line-tool)

### Part II: Data Types & Schema Design
5. [Data Types Deep Dive](#5-data-types-deep-dive)
6. [Tables & Constraints](#6-tables--constraints)
7. [Schema Design Principles](#7-schema-design-principles)
8. [Normalization & Denormalization](#8-normalization--denormalization)

### Part III: Queries & Data Manipulation
9. [SELECT Queries Mastery](#9-select-queries-mastery)
10. [INSERT, UPDATE, DELETE](#10-insert-update-delete)
11. [Joins Deep Dive](#11-joins-deep-dive)
12. [Subqueries & CTEs](#12-subqueries--ctes)

### Part IV: Advanced Queries
13. [Window Functions](#13-window-functions)
14. [Aggregations & Grouping](#14-aggregations--grouping)
15. [JSON & JSONB](#15-json--jsonb)
16. [Full-Text Search](#16-full-text-search)

### Part V: Indexes & Performance
17. [Index Types & Strategies](#17-index-types--strategies)
18. [Query Optimization](#18-query-optimization)
19. [EXPLAIN & Query Plans](#19-explain--query-plans)
20. [Performance Tuning](#20-performance-tuning)

### Part VI: Transactions & Concurrency
21. [Transactions & ACID](#21-transactions--acid)
22. [Isolation Levels](#22-isolation-levels)
23. [Locking Mechanisms](#23-locking-mechanisms)
24. [MVCC Architecture](#24-mvcc-architecture)

### Part VII: Advanced Features
25. [Views & Materialized Views](#25-views--materialized-views)
26. [Triggers & Functions](#26-triggers--functions)
27. [Stored Procedures](#27-stored-procedures)
28. [Extensions](#28-extensions)

### Part VIII: Security & Administration
29. [User Management & Roles](#29-user-management--roles)
30. [Backup & Recovery](#30-backup--recovery)
31. [Replication](#31-replication)
32. [Monitoring & Maintenance](#32-monitoring--maintenance)

### Part IX: Production Best Practices
33. [Connection Pooling](#33-connection-pooling)
34. [Partitioning](#34-partitioning)
35. [High Availability](#35-high-availability)
36. [Migration Strategies](#36-migration-strategies)

---

## Part I: Fundamentals & Core Concepts

---

## 1. PostgreSQL Philosophy & Architecture

### What is PostgreSQL?

PostgreSQL (often called "Postgres") is an **advanced, open-source, object-relational database management system (ORDBMS)**. It's known for:

- **ACID Compliance**: Full support for transactions
- **Extensibility**: Custom data types, functions, and operators
- **Standards Compliance**: Follows SQL standards closely
- **Advanced Features**: JSON, full-text search, geospatial data
- **Reliability**: Battle-tested in production for decades

### PostgreSQL vs Other Databases

**PostgreSQL vs MySQL:**
```sql
-- PostgreSQL supports advanced features
-- 1. True BOOLEAN type
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  is_active BOOLEAN DEFAULT true  -- PostgreSQL
);

-- MySQL uses TINYINT(1)
-- is_active TINYINT(1) DEFAULT 1

-- 2. Array types
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  tags TEXT[]  -- PostgreSQL native arrays
);

-- 3. JSON with indexing
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  metadata JSONB  -- Binary JSON with indexing
);
CREATE INDEX idx_metadata ON products USING GIN (metadata);

-- 4. Advanced constraints
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  status TEXT CHECK (status IN ('pending', 'shipped', 'delivered')),
  total DECIMAL(10,2) CHECK (total >= 0),
  CONSTRAINT valid_dates CHECK (shipped_at >= created_at)
);
```

### PostgreSQL Architecture

```
┌─────────────────────────────────────────┐
│         Client Application              │
└─────────────────┬───────────────────────┘
                  │ TCP/IP (Port 5432)
┌─────────────────▼───────────────────────┐
│         Postmaster (Main Process)       │
└─────────────────┬───────────────────────┘
                  │
    ┌─────────────┼─────────────┐
    │             │             │
┌───▼────┐  ┌────▼───┐  ┌──────▼──────┐
│Backend │  │Backend │  │  Background │
│Process │  │Process │  │  Processes  │
└───┬────┘  └────┬───┘  └──────┬──────┘
    │            │             │
    └────────────┼─────────────┘
                 │
    ┌────────────▼─────────────┐
    │    Shared Memory         │
    │  - Shared Buffers        │
    │  - WAL Buffers           │
    │  - Lock Tables           │
    └────────────┬─────────────┘
                 │
    ┌────────────▼─────────────┐
    │    Data Directory        │
    │  - Data Files            │
    │  - WAL Files             │
    │  - Config Files          │
    └──────────────────────────┘
```

**Key Components:**

1. **Postmaster**: Main server process that listens for connections
2. **Backend Processes**: One per client connection
3. **Shared Memory**: Communication between processes
4. **WAL (Write-Ahead Log)**: Transaction logging for durability
5. **Background Workers**: Autovacuum, checkpointer, stats collector

---

## 2. Installation & Setup

### Installation

**Ubuntu/Debian:**
```bash
# Add PostgreSQL repository
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Install PostgreSQL
sudo apt update
sudo apt install postgresql-15 postgresql-contrib-15

# Start service
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

**macOS:**
```bash
# Using Homebrew
brew install postgresql@15

# Start service
brew services start postgresql@15
```

**Windows:**
Download installer from postgresql.org

### Initial Configuration

```bash
# Switch to postgres user
sudo -i -u postgres

# Access PostgreSQL prompt
psql

# Create a new user
CREATE USER myuser WITH PASSWORD 'mypassword';

# Create a database
CREATE DATABASE mydb OWNER myuser;

# Grant privileges
GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;

# Exit
\q
```

### Connection String Format

```
postgresql://[user[:password]@][host][:port][/database][?param=value]

# Examples:
postgresql://localhost/mydb
postgresql://user:pass@localhost:5432/mydb
postgresql://user:pass@localhost/mydb?sslmode=require
```

### Configuration Files

**postgresql.conf** (Main configuration):
```conf
# Connection Settings
listen_addresses = '*'          # Listen on all interfaces
port = 5432
max_connections = 100

# Memory Settings
shared_buffers = 256MB          # 25% of RAM (recommended)
effective_cache_size = 1GB      # 50-75% of RAM
work_mem = 4MB                  # Per operation
maintenance_work_mem = 64MB     # For VACUUM, CREATE INDEX

# WAL Settings
wal_level = replica
max_wal_size = 1GB
min_wal_size = 80MB

# Query Planning
random_page_cost = 1.1          # For SSD (default 4.0 for HDD)
effective_io_concurrency = 200  # For SSD

# Logging
logging_collector = on
log_directory = 'log'
log_filename = 'postgresql-%Y-%m-%d.log'
log_statement = 'all'           # Log all queries (dev only)
log_duration = on
log_min_duration_statement = 1000  # Log slow queries (>1s)
```

**pg_hba.conf** (Authentication):
```conf
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# Local connections
local   all             all                                     peer

# IPv4 local connections
host    all             all             127.0.0.1/32            md5

# IPv6 local connections
host    all             all             ::1/128                 md5

# Allow remote connections (be careful!)
host    all             all             0.0.0.0/0               md5
```

---

## 3. Database Basics

### Creating Databases

```sql
-- Basic database creation
CREATE DATABASE mydb;

-- With owner
CREATE DATABASE mydb OWNER myuser;

-- With encoding and locale
CREATE DATABASE mydb
  ENCODING 'UTF8'
  LC_COLLATE = 'en_US.UTF-8'
  LC_CTYPE = 'en_US.UTF-8'
  TEMPLATE template0;

-- List all databases
\l
SELECT datname FROM pg_database;

-- Connect to database
\c mydb

-- Drop database (must not be connected to it)
DROP DATABASE mydb;
DROP DATABASE IF EXISTS mydb;
```

### Schemas

Schemas are namespaces within a database:

```sql
-- Create schema
CREATE SCHEMA sales;
CREATE SCHEMA hr;

-- Create table in schema
CREATE TABLE sales.orders (
  id SERIAL PRIMARY KEY,
  amount DECIMAL(10,2)
);

CREATE TABLE hr.employees (
  id SERIAL PRIMARY KEY,
  name TEXT
);

-- Set search path (default schema)
SET search_path TO sales, public;
SHOW search_path;

-- Query with schema prefix
SELECT * FROM sales.orders;
SELECT * FROM hr.employees;

-- List all schemas
\dn
SELECT schema_name FROM information_schema.schemata;

-- Drop schema
DROP SCHEMA sales CASCADE;  -- CASCADE drops all objects in schema
```

### Tablespaces

Tablespaces define physical storage locations:

```sql
-- Create tablespace
CREATE TABLESPACE fast_storage
  LOCATION '/mnt/ssd/postgresql';

-- Create table in tablespace
CREATE TABLE large_data (
  id SERIAL PRIMARY KEY,
  data TEXT
) TABLESPACE fast_storage;

-- Move table to different tablespace
ALTER TABLE large_data SET TABLESPACE pg_default;

-- List tablespaces
\db
SELECT spcname FROM pg_tablespace;
```

---

## 4. psql Command Line Tool

### Essential psql Commands

```sql
-- Connection
\c dbname              -- Connect to database
\c dbname username     -- Connect as specific user
\conninfo              -- Display connection info

-- Information
\l                     -- List databases
\dt                    -- List tables
\dt+                   -- List tables with sizes
\d tablename           -- Describe table
\d+ tablename          -- Detailed table description
\dn                    -- List schemas
\df                    -- List functions
\dv                    -- List views
\di                    -- List indexes
\du                    -- List users/roles

-- Execution
\i filename.sql        -- Execute SQL file
\o output.txt          -- Send output to file
\o                     -- Stop output redirect

-- Formatting
\x                     -- Toggle expanded display
\x auto                -- Auto expanded for wide results
\pset format wrapped   -- Wrap long lines
\timing                -- Show query execution time

-- Editing
\e                     -- Open editor for last query
\ef function_name      -- Edit function

-- Variables
\set myvar 'value'     -- Set variable
SELECT :'myvar';       -- Use variable

-- Help
\?                     -- psql command help
\h                     -- SQL command help
\h SELECT              -- Help for specific command

-- Quit
\q                     -- Exit psql
```

### Useful psql Tricks

```sql
-- Pretty print JSON
SELECT jsonb_pretty(metadata) FROM products LIMIT 1;

-- Show query execution time
\timing on
SELECT COUNT(*) FROM large_table;

-- Expanded output for wide tables
\x auto
SELECT * FROM users WHERE id = 1;

-- Save query results to CSV
\copy (SELECT * FROM users) TO '/tmp/users.csv' CSV HEADER;

-- Import CSV
\copy users FROM '/tmp/users.csv' CSV HEADER;

-- Watch query (refresh every 2 seconds)
\watch 2
SELECT COUNT(*) FROM active_sessions;

-- Show table sizes
SELECT
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
```

---

## Part II: Data Types & Schema Design

---

## 5. Data Types Deep Dive

### Numeric Types

```sql
CREATE TABLE numeric_examples (
  -- Integer types
  tiny_int SMALLINT,        -- -32768 to 32767 (2 bytes)
  normal_int INTEGER,       -- -2B to 2B (4 bytes)
  big_int BIGINT,          -- -9 quintillion to 9 quintillion (8 bytes)
  
  -- Auto-increment
  auto_id SERIAL,          -- Auto-incrementing INTEGER
  big_auto_id BIGSERIAL,   -- Auto-incrementing BIGINT
  
  -- Decimal types
  exact_decimal DECIMAL(10,2),    -- Exact: 10 digits, 2 after decimal
  exact_numeric NUMERIC(10,2),    -- Same as DECIMAL
  
  -- Floating point (approximate)
  float_real REAL,                -- 6 decimal digits precision
  float_double DOUBLE PRECISION,  -- 15 decimal digits precision
  
  -- Special numeric
  money_val MONEY                 -- Currency (-92233720368547758.08 to +92233720368547758.07)
);

-- Examples
INSERT INTO numeric_examples (tiny_int, exact_decimal, float_real) VALUES
  (100, 123.45, 123.456789),
  (-500, 999.99, 0.000001);

-- Arithmetic operations
SELECT 
  10 / 3 AS integer_division,        -- 3
  10.0 / 3 AS decimal_division,      -- 3.333...
  10 % 3 AS modulo,                  -- 1
  2 ^ 10 AS power,                   -- 1024
  |/ 25 AS square_root,              -- 5
  @ -15 AS absolute_value;           -- 15
```

### Character Types

```sql
CREATE TABLE string_examples (
  -- Variable length (recommended)
  name VARCHAR(100),        -- Max 100 chars, stores actual length
  description TEXT,         -- Unlimited length
  
  -- Fixed length (padded with spaces)
  code CHAR(5),            -- Always 5 chars
  
  -- Case-insensitive (with citext extension)
  email CITEXT             -- CREATE EXTENSION citext;
);

-- String operations
SELECT
  'Hello' || ' ' || 'World' AS concatenation,
  UPPER('hello') AS uppercase,
  LOWER('HELLO') AS lowercase,
  INITCAP('hello world') AS title_case,
  LENGTH('hello') AS length,
  SUBSTRING('hello' FROM 1 FOR 3) AS substring,
  POSITION('ll' IN 'hello') AS position,
  REPLACE('hello', 'l', 'L') AS replace,
  TRIM('  hello  ') AS trim,
  SPLIT_PART('a,b,c', ',', 2) AS split,
  REPEAT('*', 5) AS repeat,
  REVERSE('hello') AS reverse;

-- Pattern matching
SELECT * FROM users WHERE
  name LIKE 'John%'           -- Starts with John
  OR name ILIKE '%smith%'     -- Contains smith (case-insensitive)
  OR name ~ '^[A-Z]'          -- Regex: starts with capital letter
  OR name ~* 'admin'          -- Regex: contains admin (case-insensitive)
  OR name SIMILAR TO '%(admin|user)%';  -- SQL standard regex
```

### Date and Time Types

```sql
CREATE TABLE datetime_examples (
  -- Date only
  birth_date DATE,                    -- 4713 BC to 5874897 AD
  
  -- Time only
  wake_time TIME,                     -- 00:00:00 to 24:00:00
  wake_time_tz TIME WITH TIME ZONE,  -- With timezone
  
  -- Date and time
  created_at TIMESTAMP,               -- No timezone
  updated_at TIMESTAMPTZ,             -- With timezone (recommended!)
  
  -- Interval
  duration INTERVAL                   -- Time span
);

-- Current date/time
SELECT
  CURRENT_DATE AS today,
  CURRENT_TIME AS now_time,
  CURRENT_TIMESTAMP AS now,
  NOW() AS now_tz,
  CLOCK_TIMESTAMP() AS exact_now,     -- Changes during transaction
  TRANSACTION_TIMESTAMP() AS tx_time; -- Same throughout transaction

-- Date arithmetic
SELECT
  NOW() + INTERVAL '1 day' AS tomorrow,
  NOW() - INTERVAL '1 week' AS last_week,
  NOW() + INTERVAL '2 hours 30 minutes' AS later,
  AGE(TIMESTAMP '2000-01-01') AS age_since_y2k,
  DATE_PART('year', NOW()) AS current_year,
  EXTRACT(MONTH FROM NOW()) AS current_month,
  DATE_TRUNC('day', NOW()) AS start_of_day,
  DATE_TRUNC('month', NOW()) AS start_of_month;

-- Formatting
SELECT
  TO_CHAR(NOW(), 'YYYY-MM-DD') AS iso_date,
  TO_CHAR(NOW(), 'Mon DD, YYYY') AS formatted_date,
  TO_CHAR(NOW(), 'HH24:MI:SS') AS time_24h,
  TO_TIMESTAMP('2025-01-15 14:30:00', 'YYYY-MM-DD HH24:MI:SS') AS parsed;

-- Timezone handling
SELECT
  NOW() AT TIME ZONE 'UTC' AS utc_time,
  NOW() AT TIME ZONE 'America/New_York' AS ny_time,
  TIMEZONE('UTC', NOW()) AS utc_time2;

-- Useful date queries
SELECT * FROM orders WHERE
  created_at >= NOW() - INTERVAL '7 days'  -- Last 7 days
  AND created_at < DATE_TRUNC('day', NOW()); -- Before today
```

### Boolean Type

```sql
CREATE TABLE boolean_examples (
  is_active BOOLEAN DEFAULT true,
  is_verified BOOLEAN
);

-- Boolean values
INSERT INTO boolean_examples VALUES
  (true, false),
  ('yes', 'no'),    -- Accepted
  ('1', '0'),       -- Accepted
  ('t', 'f');       -- Accepted

-- Boolean operations
SELECT
  true AND false AS and_op,
  true OR false AS or_op,
  NOT true AS not_op,
  true IS TRUE AS is_true,
  NULL IS NULL AS is_null;

-- Queries
SELECT * FROM users WHERE is_active;  -- Same as = true
SELECT * FROM users WHERE NOT is_active;  -- Same as = false
SELECT * FROM users WHERE is_verified IS NULL;
```

### Array Types

```sql
CREATE TABLE array_examples (
  tags TEXT[],
  scores INTEGER[],
  matrix INTEGER[][]  -- Multi-dimensional
);

-- Insert arrays
INSERT INTO array_examples VALUES
  (ARRAY['postgres', 'database', 'sql'], ARRAY[95, 87, 92], NULL),
  ('{"tag1", "tag2"}', '{100, 90}', '{{1,2},{3,4}}');

-- Array operations
SELECT
  ARRAY[1,2,3] || ARRAY[4,5] AS concatenate,
  ARRAY[1,2,3] || 4 AS append,
  ARRAY_LENGTH(ARRAY[1,2,3], 1) AS length,
  ARRAY_POSITION(ARRAY['a','b','c'], 'b') AS position,
  ARRAY_REMOVE(ARRAY[1,2,3,2], 2) AS remove,
  ARRAY_REPLACE(ARRAY[1,2,3], 2, 99) AS replace,
  ARRAY_TO_STRING(ARRAY['a','b','c'], ',') AS to_string,
  STRING_TO_ARRAY('a,b,c', ',') AS from_string;

-- Array queries
SELECT * FROM array_examples WHERE
  'postgres' = ANY(tags)           -- Contains element
  OR tags @> ARRAY['sql']          -- Contains array
  OR tags && ARRAY['database']     -- Overlaps
  OR ARRAY_LENGTH(tags, 1) > 2;    -- Length greater than 2

-- Unnest array to rows
SELECT UNNEST(ARRAY[1,2,3]) AS value;
SELECT UNNEST(tags) AS tag FROM array_examples;
```

### JSON and JSONB

```sql
CREATE TABLE json_examples (
  data JSON,      -- Text-based, preserves formatting
  metadata JSONB  -- Binary, faster, supports indexing (recommended!)
);

-- Insert JSON
INSERT INTO json_examples VALUES
  ('{"name": "John", "age": 30}', '{"city": "NYC", "tags": ["dev", "sql"]}'),
  ('{"name": "Jane", "age": 25}', '{"city": "LA", "tags": ["design"]}');

-- JSON operators
SELECT
  data->>'name' AS name_text,              -- Get as text
  data->'age' AS age_json,                 -- Get as JSON
  metadata->'tags'->0 AS first_tag,        -- Array access
  metadata#>'{tags,0}' AS first_tag_path,  -- Path access
  metadata @> '{"city": "NYC"}' AS contains,
  metadata ? 'city' AS has_key;

-- JSON functions
SELECT
  JSON_BUILD_OBJECT('name', 'John', 'age', 30) AS build_object,
  JSON_BUILD_ARRAY(1, 2, 3) AS build_array,
  JSONB_SET('{"a": 1}', '{b}', '2') AS set_value,
  JSONB_INSERT('{"a": 1}', '{b}', '2') AS insert_value,
  JSONB_PRETTY(metadata) AS pretty_print,
  JSONB_ARRAY_LENGTH(metadata->'tags') AS array_length;

-- JSON queries
SELECT * FROM json_examples WHERE
  metadata->>'city' = 'NYC'
  OR metadata @> '{"tags": ["dev"]}'
  OR metadata ? 'city'
  OR JSONB_ARRAY_LENGTH(metadata->'tags') > 1;

-- Create index on JSONB
CREATE INDEX idx_metadata ON json_examples USING GIN (metadata);
CREATE INDEX idx_city ON json_examples ((metadata->>'city'));
```

### UUID Type

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE uuid_examples (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL
);

-- Generate UUIDs
SELECT
  uuid_generate_v1() AS uuid_v1,  -- Time-based
  uuid_generate_v4() AS uuid_v4;  -- Random (recommended)

-- Insert with UUID
INSERT INTO uuid_examples (user_id) VALUES
  (uuid_generate_v4()),
  ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11');
```

### Enum Types

```sql
-- Create enum type
CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy');
CREATE TYPE order_status AS ENUM ('pending', 'processing', 'shipped', 'delivered', 'cancelled');

CREATE TABLE person (
  name TEXT,
  current_mood mood
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  status order_status DEFAULT 'pending'
);

-- Insert enum values
INSERT INTO person VALUES ('John', 'happy');
INSERT INTO orders (status) VALUES ('processing');

-- Query enum
SELECT * FROM orders WHERE status = 'pending';
SELECT * FROM person WHERE current_mood > 'sad';  -- Enums are ordered

-- Alter enum (add value)
ALTER TYPE order_status ADD VALUE 'refunded' AFTER 'cancelled';

-- List enum values
SELECT enum_range(NULL::order_status);
```

### Geometric Types

```sql
CREATE TABLE geometric_examples (
  location POINT,           -- (x,y)
  area BOX,                -- ((x1,y1),(x2,y2))
  path_line PATH,          -- [(x1,y1),...]
  circle_area CIRCLE       -- <(x,y),r>
);

-- Insert geometric data
INSERT INTO geometric_examples VALUES
  (POINT(1,2), BOX(POINT(0,0), POINT(10,10)), NULL, CIRCLE(POINT(5,5), 3));

-- Geometric operations
SELECT
  POINT(1,2) <-> POINT(4,6) AS distance,
  BOX(POINT(0,0), POINT(10,10)) @> POINT(5,5) AS contains,
  CIRCLE(POINT(0,0), 5) && CIRCLE(POINT(3,3), 2) AS overlaps;
```

---

## 6. Tables & Constraints

### Creating Tables

```sql
-- Basic table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table with all constraint types
CREATE TABLE orders (
  -- Primary key
  id BIGSERIAL PRIMARY KEY,
  
  -- Foreign key
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  
  -- Not null
  total DECIMAL(10,2) NOT NULL,
  
  -- Check constraint
  status TEXT CHECK (status IN ('pending', 'paid', 'shipped', 'delivered')),
  quantity INTEGER CHECK (quantity > 0),
  
  -- Unique constraint
  order_number VARCHAR(50) UNIQUE,
  
  -- Composite unique
  UNIQUE (user_id, order_number),
  
  -- Default values
  created_at TIMESTAMPTZ DEFAULT NOW(),
  is_active BOOLEAN DEFAULT true,
  
  -- Computed/Generated column (PostgreSQL 12+)
  total_with_tax DECIMAL(10,2) GENERATED ALWAYS AS (total * 1.1) STORED,
  
  -- Check constraint with multiple columns
  CONSTRAINT valid_dates CHECK (shipped_at >= created_at)
);

-- Table with inheritance (PostgreSQL feature)
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  salary DECIMAL(10,2)
);

CREATE TABLE managers (
  department TEXT
) INHERITS (employees);

-- Temporary table (dropped at end of session)
CREATE TEMP TABLE session_data (
  key TEXT,
  value TEXT
);

-- Unlogged table (faster, but not crash-safe)
CREATE UNLOGGED TABLE cache (
  key TEXT PRIMARY KEY,
  value TEXT,
  expires_at TIMESTAMPTZ
);
```

### Primary Keys

```sql
-- Single column primary key
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name TEXT
);

-- Composite primary key
CREATE TABLE order_items (
  order_id INTEGER,
  product_id INTEGER,
  quantity INTEGER,
  PRIMARY KEY (order_id, product_id)
);

-- Named primary key
CREATE TABLE categories (
  id SERIAL,
  name TEXT,
  CONSTRAINT pk_categories PRIMARY KEY (id)
);

-- UUID primary key
CREATE TABLE sessions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  data JSONB
);
```

### Foreign Keys

```sql
-- Basic foreign key
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  title TEXT
);

-- Foreign key with actions
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  post_id INTEGER REFERENCES posts(id)
    ON DELETE CASCADE      -- Delete comments when post is deleted
    ON UPDATE CASCADE,     -- Update comment.post_id when post.id changes
  user_id INTEGER REFERENCES users(id)
    ON DELETE SET NULL,    -- Set to NULL when user is deleted
  content TEXT
);

-- Named foreign key
CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  product_id INTEGER,
  CONSTRAINT fk_product FOREIGN KEY (product_id)
    REFERENCES products(id)
    ON DELETE RESTRICT     -- Prevent deletion if reviews exist
);

-- Composite foreign key
CREATE TABLE order_item_reviews (
  id SERIAL PRIMARY KEY,
  order_id INTEGER,
  product_id INTEGER,
  rating INTEGER,
  FOREIGN KEY (order_id, product_id)
    REFERENCES order_items(order_id, product_id)
);

-- Self-referencing foreign key
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name TEXT,
  manager_id INTEGER REFERENCES employees(id)
);
```

### Check Constraints

```sql
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  price DECIMAL(10,2) CHECK (price > 0),
  discount_percent INTEGER CHECK (discount_percent BETWEEN 0 AND 100),
  stock INTEGER CHECK (stock >= 0),
  
  -- Named check constraint
  CONSTRAINT valid_price CHECK (price > 0 AND price < 1000000),
  
  -- Multi-column check
  CONSTRAINT valid_discount CHECK (
    (discount_percent = 0 AND price > 0) OR
    (discount_percent > 0 AND price * (1 - discount_percent/100.0) > 0)
  )
);

-- Add check constraint to existing table
ALTER TABLE products
ADD CONSTRAINT check_name_length CHECK (LENGTH(name) >= 3);

-- Drop check constraint
ALTER TABLE products
DROP CONSTRAINT check_name_length;
```

### Unique Constraints

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username TEXT UNIQUE,  -- Column constraint
  email TEXT,
  phone TEXT,
  
  -- Table constraint
  UNIQUE (email),
  
  -- Named unique constraint
  CONSTRAINT uq_phone UNIQUE (phone),
  
  -- Composite unique
  UNIQUE (email, username),
  
  -- Partial unique index (PostgreSQL feature)
  -- Only enforce uniqueness where is_active = true
  CONSTRAINT uq_active_email UNIQUE (email) WHERE (is_active = true)
);

-- Add unique constraint
ALTER TABLE users
ADD CONSTRAINT uq_username UNIQUE (username);

-- Drop unique constraint
ALTER TABLE users
DROP CONSTRAINT uq_username;
```

### Default Values

```sql
CREATE TABLE logs (
  id SERIAL PRIMARY KEY,
  message TEXT,
  level TEXT DEFAULT 'INFO',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  user_id INTEGER DEFAULT CURRENT_USER::INTEGER,
  random_id UUID DEFAULT uuid_generate_v4(),
  
  -- Function as default
  expires_at TIMESTAMPTZ DEFAULT (NOW() + INTERVAL '30 days')
);

-- Add default to existing column
ALTER TABLE logs
ALTER COLUMN level SET DEFAULT 'DEBUG';

-- Remove default
ALTER TABLE logs
ALTER COLUMN level DROP DEFAULT;
```

---

## 7. Schema Design Principles

### One-to-Many Relationship

```sql
-- Users can have many posts
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username TEXT UNIQUE NOT NULL
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  content TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Query
SELECT u.username, p.title
FROM users u
JOIN posts p ON u.id = p.user_id;
```

### Many-to-Many Relationship

```sql
-- Students can enroll in many courses, courses can have many students
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE courses (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

-- Junction/Join table
CREATE TABLE enrollments (
  student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
  course_id INTEGER REFERENCES courses(id) ON DELETE CASCADE,
  enrolled_at TIMESTAMPTZ DEFAULT NOW(),
  grade TEXT,
  PRIMARY KEY (student_id, course_id)
);

-- Query: Get all courses for a student
SELECT c.name, e.grade
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
WHERE s.id = 1;
```

### One-to-One Relationship

```sql
-- User has one profile
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  email TEXT UNIQUE NOT NULL
);

CREATE TABLE user_profiles (
  user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  bio TEXT,
  avatar_url TEXT,
  date_of_birth DATE
);

-- Alternative: Put profile data in users table if always needed
```

### Self-Referencing Relationship

```sql
-- Employee hierarchy
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  manager_id INTEGER REFERENCES employees(id),
  title TEXT
);

-- Query: Get employee and their manager
SELECT 
  e.name AS employee,
  m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

-- Recursive query: Get all subordinates
WITH RECURSIVE subordinates AS (
  SELECT id, name, manager_id, 1 AS level
  FROM employees
  WHERE id = 1  -- Start with CEO
  
  UNION ALL
  
  SELECT e.id, e.name, e.manager_id, s.level + 1
  FROM employees e
  JOIN subordinates s ON e.manager_id = s.id
)
SELECT * FROM subordinates;
```

### Polymorphic Associations

```sql
-- Comments can belong to posts OR photos
-- Approach 1: Separate tables (recommended)
CREATE TABLE post_comments (
  id SERIAL PRIMARY KEY,
  post_id INTEGER REFERENCES posts(id) ON DELETE CASCADE,
  content TEXT
);

CREATE TABLE photo_comments (
  id SERIAL PRIMARY KEY,
  photo_id INTEGER REFERENCES photos(id) ON DELETE CASCADE,
  content TEXT
);

-- Approach 2: Single table with type column (less type-safe)
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  commentable_type TEXT NOT NULL,  -- 'post' or 'photo'
  commentable_id INTEGER NOT NULL,
  content TEXT,
  CHECK (commentable_type IN ('post', 'photo'))
);

-- Approach 3: Nullable foreign keys (not recommended)
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  post_id INTEGER REFERENCES posts(id),
  photo_id INTEGER REFERENCES photos(id),
  content TEXT,
  CHECK (
    (post_id IS NOT NULL AND photo_id IS NULL) OR
    (post_id IS NULL AND photo_id IS NOT NULL)
  )
);
```

---

## 8. Normalization & Denormalization

### Normal Forms

**1NF (First Normal Form):**
- Atomic values (no arrays or lists in a single column)
- Each row is unique

```sql
-- ❌ Not 1NF
CREATE TABLE orders_bad (
  id SERIAL PRIMARY KEY,
  customer_name TEXT,
  items TEXT  -- 'apple,banana,orange' - NOT atomic!
);

-- ✅ 1NF
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name TEXT
);

CREATE TABLE order_items (
  order_id INTEGER REFERENCES orders(id),
  item_name TEXT,
  PRIMARY KEY (order_id, item_name)
);
```

**2NF (Second Normal Form):**
- Must be in 1NF
- No partial dependencies (all non-key columns depend on entire primary key)

```sql
-- ❌ Not 2NF
CREATE TABLE order_items_bad (
  order_id INTEGER,
  product_id INTEGER,
  product_name TEXT,  -- Depends only on product_id, not full key!
  quantity INTEGER,
  PRIMARY KEY (order_id, product_id)
);

-- ✅ 2NF
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name TEXT
);

CREATE TABLE order_items (
  order_id INTEGER,
  product_id INTEGER REFERENCES products(id),
  quantity INTEGER,
  PRIMARY KEY (order_id, product_id)
);
```

**3NF (Third Normal Form):**
- Must be in 2NF
- No transitive dependencies

```sql
-- ❌ Not 3NF
CREATE TABLE employees_bad (
  id SERIAL PRIMARY KEY,
  name TEXT,
  department_id INTEGER,
  department_name TEXT,  -- Depends on department_id, not employee id!
  department_location TEXT
);

-- ✅ 3NF
CREATE TABLE departments (
  id SERIAL PRIMARY KEY,
  name TEXT,
  location TEXT
);

CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name TEXT,
  department_id INTEGER REFERENCES departments(id)
);
```

### When to Denormalize

Denormalization can improve read performance at the cost of write complexity:

```sql
-- Normalized (3NF)
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE order_items (
  order_id INTEGER REFERENCES orders(id),
  product_id INTEGER REFERENCES products(id),
  quantity INTEGER,
  price DECIMAL(10,2),
  PRIMARY KEY (order_id, product_id)
);

-- Denormalized: Add total to orders table
ALTER TABLE orders ADD COLUMN total DECIMAL(10,2);

-- Update total with trigger
CREATE OR REPLACE FUNCTION update_order_total()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE orders
  SET total = (
    SELECT SUM(quantity * price)
    FROM order_items
    WHERE order_id = NEW.order_id
  )
  WHERE id = NEW.order_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_order_total
AFTER INSERT OR UPDATE OR DELETE ON order_items
FOR EACH ROW EXECUTE FUNCTION update_order_total();
```

This is a comprehensive start to the PostgreSQL guide. Would you like me to continue with the remaining sections, or would you prefer I create the Prisma guide next?

---

## Part III: Queries & Data Manipulation

---

## 9. SELECT Queries Mastery

### Basic SELECT

```sql
-- Select all columns
SELECT * FROM users;

-- Select specific columns
SELECT id, name, email FROM users;

-- Select with alias
SELECT 
  id AS user_id,
  name AS full_name,
  email AS contact_email
FROM users;

-- Select distinct values
SELECT DISTINCT city FROM users;
SELECT DISTINCT ON (city) city, name FROM users;  -- PostgreSQL specific

-- Select with expressions
SELECT 
  name,
  UPPER(email) AS email_upper,
  LENGTH(name) AS name_length,
  created_at::DATE AS signup_date
FROM users;
```

### WHERE Clause

```sql
-- Basic conditions
SELECT * FROM products WHERE price > 100;
SELECT * FROM products WHERE category = 'Electronics';
SELECT * FROM products WHERE stock <= 0;

-- Multiple conditions
SELECT * FROM products WHERE 
  price > 100 
  AND category = 'Electronics'
  AND stock > 0;

-- OR conditions
SELECT * FROM products WHERE 
  category = 'Electronics' 
  OR category = 'Computers';

-- IN operator
SELECT * FROM products WHERE 
  category IN ('Electronics', 'Computers', 'Phones');

-- BETWEEN
SELECT * FROM products WHERE 
  price BETWEEN 100 AND 500;

-- LIKE pattern matching
SELECT * FROM users WHERE 
  name LIKE 'John%'           -- Starts with John
  OR email LIKE '%@gmail.com' -- Ends with @gmail.com
  OR name LIKE '%smith%';     -- Contains smith

-- ILIKE (case-insensitive, PostgreSQL)
SELECT * FROM users WHERE name ILIKE '%john%';

-- Regular expressions
SELECT * FROM users WHERE 
  email ~ '^[a-z]+@gmail\.com$'     -- Regex match
  OR name ~* 'admin';                -- Case-insensitive regex

-- IS NULL / IS NOT NULL
SELECT * FROM users WHERE phone IS NULL;
SELECT * FROM users WHERE phone IS NOT NULL;

-- NOT operator
SELECT * FROM products WHERE NOT (price > 1000);
SELECT * FROM products WHERE category NOT IN ('Food', 'Drinks');
```

### ORDER BY

```sql
-- Single column
SELECT * FROM products ORDER BY price;
SELECT * FROM products ORDER BY price DESC;

-- Multiple columns
SELECT * FROM products 
ORDER BY category ASC, price DESC;

-- Order by expression
SELECT * FROM users 
ORDER BY LENGTH(name) DESC;

-- Order by column position
SELECT name, email FROM users 
ORDER BY 1;  -- Order by first column (name)

-- NULLS FIRST / NULLS LAST
SELECT * FROM users 
ORDER BY phone NULLS LAST;
```

### LIMIT and OFFSET

```sql
-- Limit results
SELECT * FROM products LIMIT 10;

-- Pagination
SELECT * FROM products 
LIMIT 10 OFFSET 20;  -- Skip 20, get next 10

-- Alternative syntax (PostgreSQL)
SELECT * FROM products 
OFFSET 20 ROWS 
FETCH FIRST 10 ROWS ONLY;
```

### Aggregate Functions

```sql
-- Count
SELECT COUNT(*) FROM users;
SELECT COUNT(DISTINCT city) FROM users;
SELECT COUNT(*) FILTER (WHERE is_active = true) FROM users;  -- PostgreSQL

-- Sum
SELECT SUM(price) FROM products;
SELECT SUM(price * quantity) AS total_value FROM order_items;

-- Average
SELECT AVG(price) FROM products;
SELECT ROUND(AVG(price), 2) FROM products;

-- Min/Max
SELECT MIN(price), MAX(price) FROM products;

-- String aggregation
SELECT STRING_AGG(name, ', ') FROM products;  -- PostgreSQL
SELECT STRING_AGG(name, ', ' ORDER BY name) FROM products;

-- Array aggregation
SELECT ARRAY_AGG(name) FROM products;  -- PostgreSQL
SELECT ARRAY_AGG(name ORDER BY name) FROM products;

-- JSON aggregation
SELECT JSON_AGG(row_to_json(products)) FROM products;  -- PostgreSQL
```

---

## 10. INSERT, UPDATE, DELETE

### INSERT

```sql
-- Insert single row
INSERT INTO users (name, email) 
VALUES ('John Doe', 'john@example.com');

-- Insert multiple rows
INSERT INTO users (name, email) VALUES
  ('Alice', 'alice@example.com'),
  ('Bob', 'bob@example.com'),
  ('Charlie', 'charlie@example.com');

-- Insert with RETURNING (PostgreSQL)
INSERT INTO users (name, email) 
VALUES ('Jane', 'jane@example.com')
RETURNING id, name, created_at;

-- Insert from SELECT
INSERT INTO archived_users (name, email)
SELECT name, email FROM users WHERE is_active = false;

-- Insert with ON CONFLICT (UPSERT)
INSERT INTO users (id, name, email) 
VALUES (1, 'John', 'john@example.com')
ON CONFLICT (id) DO NOTHING;

INSERT INTO users (email, name) 
VALUES ('john@example.com', 'John Doe')
ON CONFLICT (email) DO UPDATE 
SET name = EXCLUDED.name, updated_at = NOW();

-- Insert with DEFAULT values
INSERT INTO users (name, email, role) 
VALUES ('Admin', 'admin@example.com', DEFAULT);

-- Insert entire row with DEFAULT
INSERT INTO users DEFAULT VALUES;
```

### UPDATE

```sql
-- Update single column
UPDATE users SET name = 'John Smith' WHERE id = 1;

-- Update multiple columns
UPDATE users 
SET 
  name = 'John Smith',
  email = 'johnsmith@example.com',
  updated_at = NOW()
WHERE id = 1;

-- Update with expression
UPDATE products 
SET price = price * 1.1  -- 10% increase
WHERE category = 'Electronics';

-- Update from another table
UPDATE products p
SET stock = s.quantity
FROM stock s
WHERE p.id = s.product_id;

-- Update with RETURNING
UPDATE users 
SET is_active = false 
WHERE last_login < NOW() - INTERVAL '1 year'
RETURNING id, name, email;

-- Conditional update
UPDATE products
SET 
  discount = CASE
    WHEN price > 1000 THEN 0.2
    WHEN price > 500 THEN 0.1
    ELSE 0.05
  END;
```

### DELETE

```sql
-- Delete specific rows
DELETE FROM users WHERE id = 1;

-- Delete with condition
DELETE FROM users WHERE is_active = false;

-- Delete all rows (be careful!)
DELETE FROM users;

-- Delete with RETURNING
DELETE FROM users 
WHERE last_login < NOW() - INTERVAL '2 years'
RETURNING id, name, email;

-- Delete with subquery
DELETE FROM order_items 
WHERE order_id IN (
  SELECT id FROM orders WHERE status = 'cancelled'
);

-- Delete from multiple tables (using USING)
DELETE FROM order_items oi
USING orders o
WHERE oi.order_id = o.id AND o.status = 'cancelled';

-- TRUNCATE (faster than DELETE for all rows)
TRUNCATE TABLE users;
TRUNCATE TABLE users RESTART IDENTITY;  -- Reset auto-increment
TRUNCATE TABLE users CASCADE;  -- Also truncate dependent tables
```

---

## 11. Joins Deep Dive

### INNER JOIN

```sql
-- Basic inner join
SELECT 
  u.name,
  p.title
FROM users u
INNER JOIN posts p ON u.id = p.user_id;

-- Multiple joins
SELECT 
  u.name AS author,
  p.title AS post,
  c.content AS comment
FROM users u
INNER JOIN posts p ON u.id = p.user_id
INNER JOIN comments c ON p.id = c.post_id;

-- Join with WHERE
SELECT 
  u.name,
  p.title
FROM users u
INNER JOIN posts p ON u.id = p.user_id
WHERE p.published = true AND u.is_active = true;
```

### LEFT JOIN (LEFT OUTER JOIN)

```sql
-- Get all users and their posts (including users with no posts)
SELECT 
  u.name,
  p.title
FROM users u
LEFT JOIN posts p ON u.id = p.user_id;

-- Find users with no posts
SELECT 
  u.name
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
WHERE p.id IS NULL;

-- Count posts per user (including users with 0 posts)
SELECT 
  u.name,
  COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
GROUP BY u.id, u.name;
```

### RIGHT JOIN (RIGHT OUTER JOIN)

```sql
-- Get all posts and their authors (including posts with no author)
SELECT 
  u.name,
  p.title
FROM users u
RIGHT JOIN posts p ON u.id = p.user_id;
```

### FULL OUTER JOIN

```sql
-- Get all users and posts, including unmatched rows from both
SELECT 
  u.name,
  p.title
FROM users u
FULL OUTER JOIN posts p ON u.id = p.user_id;

-- Find unmatched rows from either table
SELECT 
  u.name,
  p.title
FROM users u
FULL OUTER JOIN posts p ON u.id = p.user_id
WHERE u.id IS NULL OR p.id IS NULL;
```

### CROSS JOIN

```sql
-- Cartesian product (every combination)
SELECT 
  u.name,
  p.title
FROM users u
CROSS JOIN posts p;

-- Useful for generating combinations
SELECT 
  d.date,
  u.name
FROM generate_series(
  '2025-01-01'::date,
  '2025-01-31'::date,
  '1 day'
) AS d(date)
CROSS JOIN users u;
```

### SELF JOIN

```sql
-- Find employees and their managers
SELECT 
  e.name AS employee,
  m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

-- Find users from the same city
SELECT 
  u1.name AS user1,
  u2.name AS user2,
  u1.city
FROM users u1
INNER JOIN users u2 ON u1.city = u2.city AND u1.id < u2.id;
```

### JOIN with USING

```sql
-- When column names are the same
SELECT *
FROM orders
INNER JOIN order_items USING (order_id);

-- Equivalent to:
SELECT *
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id;
```

### LATERAL JOIN

```sql
-- For each user, get their 3 most recent posts
SELECT 
  u.name,
  p.title,
  p.created_at
FROM users u
CROSS JOIN LATERAL (
  SELECT title, created_at
  FROM posts
  WHERE user_id = u.id
  ORDER BY created_at DESC
  LIMIT 3
) p;
```

---

## 12. Subqueries & CTEs

### Scalar Subqueries

```sql
-- Subquery returning single value
SELECT 
  name,
  price,
  (SELECT AVG(price) FROM products) AS avg_price,
  price - (SELECT AVG(price) FROM products) AS diff_from_avg
FROM products;
```

### Subqueries in WHERE

```sql
-- IN subquery
SELECT name FROM users
WHERE id IN (
  SELECT DISTINCT user_id FROM orders
);

-- EXISTS subquery
SELECT name FROM users u
WHERE EXISTS (
  SELECT 1 FROM orders o WHERE o.user_id = u.id
);

-- NOT EXISTS
SELECT name FROM users u
WHERE NOT EXISTS (
  SELECT 1 FROM orders o WHERE o.user_id = u.id
);

-- Comparison subquery
SELECT name, salary FROM employees
WHERE salary > (
  SELECT AVG(salary) FROM employees
);

-- ALL/ANY
SELECT name FROM products
WHERE price > ALL (
  SELECT price FROM products WHERE category = 'Budget'
);

SELECT name FROM products
WHERE price > ANY (
  SELECT price FROM products WHERE category = 'Premium'
);
```

### Subqueries in FROM (Derived Tables)

```sql
SELECT 
  category,
  avg_price
FROM (
  SELECT 
    category,
    AVG(price) AS avg_price
  FROM products
  GROUP BY category
) AS category_averages
WHERE avg_price > 100;
```

### Common Table Expressions (CTEs)

```sql
-- Basic CTE
WITH active_users AS (
  SELECT id, name, email
  FROM users
  WHERE is_active = true
)
SELECT * FROM active_users WHERE email LIKE '%@gmail.com';

-- Multiple CTEs
WITH 
  active_users AS (
    SELECT id, name FROM users WHERE is_active = true
  ),
  recent_orders AS (
    SELECT user_id, COUNT(*) AS order_count
    FROM orders
    WHERE created_at > NOW() - INTERVAL '30 days'
    GROUP BY user_id
  )
SELECT 
  u.name,
  COALESCE(o.order_count, 0) AS orders_last_30_days
FROM active_users u
LEFT JOIN recent_orders o ON u.id = o.user_id;

-- CTE with INSERT/UPDATE/DELETE
WITH deleted_users AS (
  DELETE FROM users
  WHERE is_active = false
  RETURNING id, name, email
)
INSERT INTO archived_users (user_id, name, email)
SELECT id, name, email FROM deleted_users;
```

### Recursive CTEs

```sql
-- Generate series
WITH RECURSIVE numbers AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM numbers WHERE n < 10
)
SELECT * FROM numbers;

-- Employee hierarchy
WITH RECURSIVE employee_hierarchy AS (
  -- Base case: top-level employees
  SELECT id, name, manager_id, 1 AS level
  FROM employees
  WHERE manager_id IS NULL
  
  UNION ALL
  
  -- Recursive case: employees with managers
  SELECT e.id, e.name, e.manager_id, eh.level + 1
  FROM employees e
  INNER JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT * FROM employee_hierarchy ORDER BY level, name;

-- Category tree
WITH RECURSIVE category_tree AS (
  SELECT id, name, parent_id, name AS path
  FROM categories
  WHERE parent_id IS NULL
  
  UNION ALL
  
  SELECT c.id, c.name, c.parent_id, ct.path || ' > ' || c.name
  FROM categories c
  INNER JOIN category_tree ct ON c.parent_id = ct.id
)
SELECT * FROM category_tree;
```

---

**Note**: This PostgreSQL guide continues with many more sections covering Window Functions, Aggregations, JSON operations, Full-Text Search, Indexes, Performance Tuning, Transactions, Advanced Features, Security, and Production Best Practices. The complete guide would be extremely long (5000+ lines). 

Similarly, the Prisma guide continues with comprehensive sections on CRUD Operations, Advanced Queries, Relations, Migrations, Performance Optimization, Testing, and Deployment.

Both guides are structured to provide mastery-level understanding with extensive code examples and detailed explanations throughout all topics.

---

## Part IV: Advanced Queries & Optimization

---

## 13. Window Functions

Window functions perform calculations across a set of rows related to the current row.

```sql
-- ROW_NUMBER: Assign unique number to each row
SELECT 
  name,
  department,
  salary,
  ROW_NUMBER() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- RANK: Rank with gaps for ties
SELECT 
  name,
  department,
  salary,
  RANK() OVER (ORDER BY salary DESC) AS rank
FROM employees;

-- DENSE_RANK: Rank without gaps
SELECT 
  name,
  department,
  salary,
  DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;

-- PARTITION BY: Window per group
SELECT 
  name,
  department,
  salary,
  RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM employees;

-- LAG/LEAD: Access previous/next row
SELECT 
  date,
  revenue,
  LAG(revenue) OVER (ORDER BY date) AS prev_revenue,
  LEAD(revenue) OVER (ORDER BY date) AS next_revenue,
  revenue - LAG(revenue) OVER (ORDER BY date) AS revenue_change
FROM daily_sales;

-- FIRST_VALUE/LAST_VALUE
SELECT 
  name,
  department,
  salary,
  FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS highest_in_dept,
  LAST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS lowest_in_dept
FROM employees;

-- NTH_VALUE
SELECT 
  name,
  salary,
  NTH_VALUE(salary, 2) OVER (ORDER BY salary DESC) AS second_highest_salary
FROM employees;

-- Running totals
SELECT 
  date,
  amount,
  SUM(amount) OVER (ORDER BY date) AS running_total
FROM transactions;

-- Moving average
SELECT 
  date,
  price,
  AVG(price) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_avg_7days
FROM stock_prices;
```

---

## 14. Aggregations & Grouping

```sql
-- Basic GROUP BY
SELECT 
  category,
  COUNT(*) AS product_count,
  AVG(price) AS avg_price,
  SUM(stock) AS total_stock
FROM products
GROUP BY category;

-- Multiple columns
SELECT 
  category,
  brand,
  COUNT(*) AS count
FROM products
GROUP BY category, brand;

-- HAVING clause
SELECT 
  category,
  AVG(price) AS avg_price
FROM products
GROUP BY category
HAVING AVG(price) > 100;

-- FILTER clause (PostgreSQL)
SELECT 
  category,
  COUNT(*) AS total_products,
  COUNT(*) FILTER (WHERE price > 100) AS expensive_products,
  AVG(price) FILTER (WHERE stock > 0) AS avg_price_in_stock
FROM products
GROUP BY category;

-- GROUPING SETS
SELECT 
  category,
  brand,
  SUM(sales) AS total_sales
FROM products
GROUP BY GROUPING SETS (
  (category, brand),
  (category),
  ()
);

-- ROLLUP (hierarchical aggregation)
SELECT 
  category,
  brand,
  SUM(sales) AS total_sales
FROM products
GROUP BY ROLLUP (category, brand);

-- CUBE (all combinations)
SELECT 
  category,
  brand,
  SUM(sales) AS total_sales
FROM products
GROUP BY CUBE (category, brand);
```

---

## 15. JSON & JSONB

```sql
-- JSON operators
SELECT 
  data->>'name' AS name,
  data->'age' AS age_json,
  data#>'{address,city}' AS city
FROM users;

-- JSON functions
SELECT 
  JSON_BUILD_OBJECT(
    'id', id,
    'name', name,
    'email', email
  ) AS user_json
FROM users;

-- JSON aggregation
SELECT 
  category,
  JSON_AGG(
    JSON_BUILD_OBJECT(
      'name', name,
      'price', price
    )
  ) AS products
FROM products
GROUP BY category;

-- JSONB contains
SELECT * FROM products
WHERE metadata @> '{"featured": true}';

-- JSONB key exists
SELECT * FROM products
WHERE metadata ? 'discount';

-- Update JSONB
UPDATE products
SET metadata = JSONB_SET(
  metadata,
  '{discount}',
  '0.15'
)
WHERE id = 1;

-- Remove JSONB key
UPDATE products
SET metadata = metadata - 'old_field';
```

---

## 16. Full-Text Search

```sql
-- Create text search vector
ALTER TABLE articles ADD COLUMN search_vector TSVECTOR;

UPDATE articles
SET search_vector = 
  TO_TSVECTOR('english', COALESCE(title, '') || ' ' || COALESCE(content, ''));

-- Create index
CREATE INDEX idx_search ON articles USING GIN (search_vector);

-- Basic search
SELECT title, content
FROM articles
WHERE search_vector @@ TO_TSQUERY('english', 'postgresql & database');

-- Ranked search
SELECT 
  title,
  TS_RANK(search_vector, query) AS rank
FROM articles, TO_TSQUERY('english', 'postgresql | database') query
WHERE search_vector @@ query
ORDER BY rank DESC;

-- Highlight matches
SELECT 
  title,
  TS_HEADLINE('english', content, query) AS highlighted
FROM articles, TO_TSQUERY('english', 'postgresql') query
WHERE search_vector @@ query;
```

---

## Part V: Indexes & Performance

---

## 17. Index Types & Strategies

```sql
-- B-tree index (default, most common)
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_name ON users(name);

-- Unique index
CREATE UNIQUE INDEX idx_users_username ON users(username);

-- Partial index (conditional)
CREATE INDEX idx_active_users ON users(email) WHERE is_active = true;

-- Composite index
CREATE INDEX idx_users_city_age ON users(city, age);

-- Expression index
CREATE INDEX idx_users_lower_email ON users(LOWER(email));

-- GIN index (for arrays, JSONB, full-text)
CREATE INDEX idx_products_tags ON products USING GIN (tags);
CREATE INDEX idx_products_metadata ON products USING GIN (metadata);

-- GiST index (for geometric data, ranges)
CREATE INDEX idx_locations ON places USING GIST (location);

-- BRIN index (for very large tables with natural ordering)
CREATE INDEX idx_logs_created ON logs USING BRIN (created_at);

-- Hash index (equality comparisons only)
CREATE INDEX idx_users_id_hash ON users USING HASH (id);

-- List indexes
\di
SELECT * FROM pg_indexes WHERE tablename = 'users';

-- Drop index
DROP INDEX idx_users_email;
```

---

## 18. Query Optimization

```sql
-- Use EXPLAIN to see query plan
EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';

-- EXPLAIN ANALYZE (actually runs the query)
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';

-- Optimization techniques:

-- 1. Use indexes
CREATE INDEX idx_users_email ON users(email);

-- 2. Avoid SELECT *
SELECT id, name, email FROM users;  -- Better than SELECT *

-- 3. Use LIMIT
SELECT * FROM users ORDER BY created_at DESC LIMIT 10;

-- 4. Use EXISTS instead of IN for subqueries
SELECT * FROM users u
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id);

-- 5. Use JOIN instead of subqueries when possible
SELECT u.name, COUNT(o.id)
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name;

-- 6. Avoid functions on indexed columns in WHERE
-- Bad:
SELECT * FROM users WHERE LOWER(email) = 'test@example.com';
-- Good:
CREATE INDEX idx_users_lower_email ON users(LOWER(email));
SELECT * FROM users WHERE LOWER(email) = 'test@example.com';

-- 7. Use covering indexes
CREATE INDEX idx_users_covering ON users(email) INCLUDE (name, created_at);
```

---

## 19. EXPLAIN & Query Plans

```sql
-- Basic EXPLAIN
EXPLAIN SELECT * FROM users WHERE id = 1;

-- EXPLAIN with costs
EXPLAIN (COSTS true) SELECT * FROM users WHERE email = 'test@example.com';

-- EXPLAIN ANALYZE (runs query)
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';

-- Detailed output
EXPLAIN (ANALYZE, BUFFERS, VERBOSE) 
SELECT u.name, COUNT(o.id)
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name;

-- Understanding output:
-- - Seq Scan: Full table scan (slow for large tables)
-- - Index Scan: Using index (fast)
-- - Index Only Scan: Using covering index (fastest)
-- - Bitmap Index Scan: Multiple index scans combined
-- - Hash Join: Join using hash table
-- - Nested Loop: Join using loops (good for small datasets)
-- - cost=0.00..10.00: Estimated cost (startup..total)
-- - rows=100: Estimated rows
-- - actual time=0.01..0.05: Actual time (ms)
```

---

## 20. Performance Tuning

```sql
-- Vacuum (reclaim space)
VACUUM users;
VACUUM FULL users;  -- More aggressive, locks table
VACUUM ANALYZE users;  -- Also update statistics

-- Analyze (update statistics)
ANALYZE users;

-- Reindex
REINDEX TABLE users;
REINDEX INDEX idx_users_email;

-- Check table bloat
SELECT 
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename) - pg_relation_size(schemaname||'.'||tablename)) AS external_size
FROM pg_tables
WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Find slow queries
SELECT 
  query,
  calls,
  total_time,
  mean_time,
  max_time
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;

-- Find missing indexes
SELECT 
  schemaname,
  tablename,
  attname,
  n_distinct,
  correlation
FROM pg_stats
WHERE schemaname = 'public'
  AND n_distinct > 100
  AND correlation < 0.1;
```

---

## Part VI-IX: Additional Topics

The PostgreSQL Mastery Guide continues with comprehensive coverage of:

### Part VI: Transactions & Concurrency
- Transaction basics and ACID properties
- Isolation levels (Read Uncommitted, Read Committed, Repeatable Read, Serializable)
- Locking mechanisms (row-level, table-level, advisory locks)
- MVCC (Multi-Version Concurrency Control) architecture
- Deadlock detection and prevention

### Part VII: Advanced Features
- Views and Materialized Views
- Triggers and Functions (PL/pgSQL)
- Stored Procedures
- Extensions (PostGIS, pg_trgm, uuid-ossp, etc.)
- Foreign Data Wrappers

### Part VIII: Security & Administration
- User management and roles
- Row-level security
- Backup strategies (pg_dump, pg_basebackup)
- Point-in-time recovery
- Replication (streaming, logical)
- Monitoring and maintenance

### Part IX: Production Best Practices
- Connection pooling (PgBouncer, Pgpool-II)
- Table partitioning (range, list, hash)
- High availability setups
- Migration strategies
- Performance monitoring
- Disaster recovery planning

---

## Conclusion

This PostgreSQL Mastery Guide provides comprehensive coverage from fundamentals to advanced production topics. Key takeaways:

1. **Master the Basics**: Understand data types, constraints, and queries thoroughly
2. **Leverage PostgreSQL Features**: Use advanced types (JSONB, arrays), window functions, and CTEs
3. **Optimize Performance**: Create appropriate indexes, analyze query plans, tune configuration
4. **Ensure Data Integrity**: Use transactions, constraints, and proper isolation levels
5. **Plan for Scale**: Implement connection pooling, partitioning, and replication
6. **Monitor and Maintain**: Regular VACUUM, ANALYZE, and performance monitoring

PostgreSQL is a powerful, feature-rich database. This guide equips you with the knowledge to use it effectively in production environments.

---

**Additional Resources:**
- Official Documentation: https://www.postgresql.org/docs/
- PostgreSQL Wiki: https://wiki.postgresql.org/
- Performance Tips: https://wiki.postgresql.org/wiki/Performance_Optimization
- Community: https://www.postgresql.org/community/

---

*End of PostgreSQL Mastery Guide*

---

## Part VI: Transactions & Concurrency

---

## 21. Transactions & ACID

### Transaction Basics

```sql
-- Begin transaction
BEGIN;

-- Or
START TRANSACTION;

-- Perform operations
INSERT INTO accounts (user_id, balance) VALUES (1, 1000);
UPDATE accounts SET balance = balance - 100 WHERE user_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE user_id = 2;

-- Commit (save changes)
COMMIT;

-- Or rollback (undo changes)
ROLLBACK;
```

### ACID Properties

```sql
-- Atomicity: All or nothing
BEGIN;
  UPDATE accounts SET balance = balance - 100 WHERE id = 1;
  UPDATE accounts SET balance = balance + 100 WHERE id = 2;
  -- If any statement fails, all are rolled back
COMMIT;

-- Consistency: Database remains in valid state
BEGIN;
  UPDATE accounts SET balance = balance - 100 WHERE id = 1;
  -- This would violate check constraint if balance < 0
  -- Transaction would be rolled back
COMMIT;

-- Isolation: Concurrent transactions don't interfere
-- (See isolation levels section)

-- Durability: Committed changes are permanent
-- PostgreSQL uses WAL (Write-Ahead Logging) for durability
```

### Savepoints

```sql
BEGIN;
  INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com');
  
  SAVEPOINT sp1;
  
  INSERT INTO users (name, email) VALUES ('Bob', 'bob@example.com');
  
  SAVEPOINT sp2;
  
  INSERT INTO users (name, email) VALUES ('Charlie', 'charlie@example.com');
  
  -- Rollback to sp2 (undoes Charlie insert)
  ROLLBACK TO SAVEPOINT sp2;
  
  -- Rollback to sp1 (undoes Bob insert)
  ROLLBACK TO SAVEPOINT sp1;
  
  -- Release savepoint (can't rollback to it anymore)
  RELEASE SAVEPOINT sp1;
  
COMMIT;  -- Only Alice is inserted
```

### Transaction Isolation in Practice

```sql
-- Read committed (default)
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
  SELECT * FROM products WHERE id = 1;
  -- Another transaction can modify this row
  -- Next read might see different data
  SELECT * FROM products WHERE id = 1;
COMMIT;

-- Repeatable read
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
  SELECT * FROM products WHERE id = 1;
  -- Same row will show same data throughout transaction
  SELECT * FROM products WHERE id = 1;
COMMIT;

-- Serializable
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
  SELECT SUM(balance) FROM accounts;
  -- No concurrent transaction can modify accounts
  INSERT INTO accounts (balance) VALUES (100);
COMMIT;
```

---

## 22. Isolation Levels

### Read Uncommitted (Not supported in PostgreSQL)

PostgreSQL treats this as Read Committed.

### Read Committed (Default)

```sql
-- Session 1
BEGIN;
SELECT balance FROM accounts WHERE id = 1;  -- Returns 1000

-- Session 2
BEGIN;
UPDATE accounts SET balance = 500 WHERE id = 1;
COMMIT;

-- Session 1 (continued)
SELECT balance FROM accounts WHERE id = 1;  -- Returns 500 (sees committed change)
COMMIT;
```

**Phenomena allowed:**
- Non-repeatable reads: Same query returns different results
- Phantom reads: New rows appear in range queries

### Repeatable Read

```sql
-- Session 1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT balance FROM accounts WHERE id = 1;  -- Returns 1000

-- Session 2
BEGIN;
UPDATE accounts SET balance = 500 WHERE id = 1;
COMMIT;

-- Session 1 (continued)
SELECT balance FROM accounts WHERE id = 1;  -- Still returns 1000
COMMIT;
```

**Phenomena prevented:**
- Dirty reads
- Non-repeatable reads

**Phenomena allowed:**
- Phantom reads (in theory, but PostgreSQL prevents this too)

### Serializable

```sql
-- Session 1
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT SUM(balance) FROM accounts;  -- Returns 5000

-- Session 2
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
INSERT INTO accounts (balance) VALUES (1000);
COMMIT;

-- Session 1 (continued)
SELECT SUM(balance) FROM accounts;  -- Still returns 5000
-- If we try to insert based on this sum, we get serialization error
INSERT INTO audit (total) VALUES (5000);
COMMIT;  -- ERROR: could not serialize access
```

**Phenomena prevented:**
- All anomalies
- Serialization errors may occur instead

---

## 23. Locking Mechanisms

### Row-Level Locks

```sql
-- FOR UPDATE: Exclusive lock for update
BEGIN;
SELECT * FROM products WHERE id = 1 FOR UPDATE;
-- Other transactions can't UPDATE/DELETE this row
UPDATE products SET stock = stock - 1 WHERE id = 1;
COMMIT;

-- FOR NO KEY UPDATE: Allows foreign key checks
BEGIN;
SELECT * FROM users WHERE id = 1 FOR NO KEY UPDATE;
-- Other transactions can still reference this row
UPDATE users SET name = 'New Name' WHERE id = 1;
COMMIT;

-- FOR SHARE: Shared lock
BEGIN;
SELECT * FROM products WHERE id = 1 FOR SHARE;
-- Other transactions can read but not modify
COMMIT;

-- FOR KEY SHARE: Weakest lock
BEGIN;
SELECT * FROM users WHERE id = 1 FOR KEY SHARE;
-- Other transactions can update non-key columns
COMMIT;

-- SKIP LOCKED: Skip locked rows
SELECT * FROM queue WHERE processed = false
FOR UPDATE SKIP LOCKED
LIMIT 1;

-- NOWAIT: Don't wait for locks
SELECT * FROM products WHERE id = 1
FOR UPDATE NOWAIT;  -- ERROR if locked
```

### Table-Level Locks

```sql
-- ACCESS SHARE: Acquired by SELECT
SELECT * FROM products;

-- ROW SHARE: Acquired by SELECT FOR UPDATE
LOCK TABLE products IN ROW SHARE MODE;

-- ROW EXCLUSIVE: Acquired by INSERT, UPDATE, DELETE
LOCK TABLE products IN ROW EXCLUSIVE MODE;

-- SHARE: Allows concurrent reads
LOCK TABLE products IN SHARE MODE;

-- EXCLUSIVE: Allows only reads
LOCK TABLE products IN EXCLUSIVE MODE;

-- ACCESS EXCLUSIVE: Most restrictive
LOCK TABLE products IN ACCESS EXCLUSIVE MODE;
```

### Advisory Locks

```sql
-- Session-level advisory lock
SELECT pg_advisory_lock(12345);
-- Do work
SELECT pg_advisory_unlock(12345);

-- Try lock (non-blocking)
SELECT pg_try_advisory_lock(12345);  -- Returns true/false

-- Transaction-level advisory lock
BEGIN;
SELECT pg_advisory_xact_lock(12345);
-- Lock automatically released on commit/rollback
COMMIT;

-- Use case: Application-level locking
SELECT pg_advisory_lock(hashtext('process_orders'));
-- Process orders
SELECT pg_advisory_unlock(hashtext('process_orders'));
```

---

## 24. MVCC Architecture

### Multi-Version Concurrency Control

PostgreSQL uses MVCC to handle concurrent transactions:

```sql
-- Each row has hidden columns:
-- xmin: Transaction ID that created the row
-- xmax: Transaction ID that deleted/updated the row
-- ctid: Physical location

-- View hidden columns
SELECT xmin, xmax, ctid, * FROM users;

-- When you UPDATE a row, PostgreSQL:
-- 1. Marks old row as deleted (sets xmax)
-- 2. Creates new row version (new xmin)
-- 3. Old version remains for concurrent transactions

UPDATE users SET name = 'New Name' WHERE id = 1;

-- VACUUM removes old row versions
VACUUM users;

-- VACUUM FULL reclaims space (locks table)
VACUUM FULL users;

-- Auto-vacuum (runs automatically)
-- Configured in postgresql.conf
```

### Transaction ID Wraparound

```sql
-- Check transaction ID age
SELECT datname, age(datfrozenxid) 
FROM pg_database 
ORDER BY age(datfrozenxid) DESC;

-- Prevent wraparound
VACUUM FREEZE users;

-- Emergency: Prevent shutdown
-- Set autovacuum_freeze_max_age in postgresql.conf
```

---

## Part VII: Advanced Features

---

## 25. Views & Materialized Views

### Regular Views

```sql
-- Create view
CREATE VIEW active_users AS
SELECT id, name, email, created_at
FROM users
WHERE is_active = true;

-- Use view
SELECT * FROM active_users;

-- View with joins
CREATE VIEW user_post_count AS
SELECT 
  u.id,
  u.name,
  COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
GROUP BY u.id, u.name;

-- Updatable view
CREATE VIEW simple_users AS
SELECT id, name, email FROM users;

-- Can insert/update through view
INSERT INTO simple_users (name, email) 
VALUES ('Alice', 'alice@example.com');

-- Replace view
CREATE OR REPLACE VIEW active_users AS
SELECT id, name, email, created_at, last_login
FROM users
WHERE is_active = true;

-- Drop view
DROP VIEW active_users;
```

### Materialized Views

```sql
-- Create materialized view (stores results)
CREATE MATERIALIZED VIEW user_stats AS
SELECT 
  u.id,
  u.name,
  COUNT(p.id) AS post_count,
  COUNT(c.id) AS comment_count
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
LEFT JOIN comments c ON u.id = c.user_id
GROUP BY u.id, u.name;

-- Create index on materialized view
CREATE INDEX idx_user_stats_post_count 
ON user_stats(post_count);

-- Query materialized view (fast!)
SELECT * FROM user_stats WHERE post_count > 10;

-- Refresh materialized view
REFRESH MATERIALIZED VIEW user_stats;

-- Refresh without locking
REFRESH MATERIALIZED VIEW CONCURRENTLY user_stats;
-- Requires unique index

-- Drop materialized view
DROP MATERIALIZED VIEW user_stats;
```

---

## 26. Triggers & Functions

### Functions (PL/pgSQL)

```sql
-- Simple function
CREATE OR REPLACE FUNCTION get_user_count()
RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT COUNT(*) FROM users);
END;
$$ LANGUAGE plpgsql;

-- Use function
SELECT get_user_count();

-- Function with parameters
CREATE OR REPLACE FUNCTION get_user_by_email(user_email TEXT)
RETURNS TABLE(id INTEGER, name TEXT, email TEXT) AS $$
BEGIN
  RETURN QUERY
  SELECT u.id, u.name, u.email
  FROM users u
  WHERE u.email = user_email;
END;
$$ LANGUAGE plpgsql;

-- Use function
SELECT * FROM get_user_by_email('alice@example.com');

-- Function with INOUT parameters
CREATE OR REPLACE FUNCTION calculate_tax(
  IN amount DECIMAL,
  IN tax_rate DECIMAL,
  OUT total DECIMAL,
  OUT tax DECIMAL
) AS $$
BEGIN
  tax := amount * tax_rate;
  total := amount + tax;
END;
$$ LANGUAGE plpgsql;

-- Use function
SELECT * FROM calculate_tax(100, 0.1);
```

### Triggers

```sql
-- Create trigger function
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger
CREATE TRIGGER trigger_update_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

-- Trigger for audit logging
CREATE TABLE audit_log (
  id SERIAL PRIMARY KEY,
  table_name TEXT,
  operation TEXT,
  old_data JSONB,
  new_data JSONB,
  changed_at TIMESTAMP DEFAULT NOW()
);

CREATE OR REPLACE FUNCTION audit_trigger()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO audit_log (table_name, operation, new_data)
    VALUES (TG_TABLE_NAME, TG_OP, row_to_json(NEW));
    RETURN NEW;
  ELSIF TG_OP = 'UPDATE' THEN
    INSERT INTO audit_log (table_name, operation, old_data, new_data)
    VALUES (TG_TABLE_NAME, TG_OP, row_to_json(OLD), row_to_json(NEW));
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    INSERT INTO audit_log (table_name, operation, old_data)
    VALUES (TG_TABLE_NAME, TG_OP, row_to_json(OLD));
    RETURN OLD;
  END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER users_audit
AFTER INSERT OR UPDATE OR DELETE ON users
FOR EACH ROW EXECUTE FUNCTION audit_trigger();

-- Conditional trigger
CREATE TRIGGER check_stock
BEFORE UPDATE ON products
FOR EACH ROW
WHEN (NEW.stock < 0)
EXECUTE FUNCTION prevent_negative_stock();

-- Drop trigger
DROP TRIGGER trigger_update_updated_at ON users;
```

---

## 27. Stored Procedures

```sql
-- Create procedure (PostgreSQL 11+)
CREATE OR REPLACE PROCEDURE transfer_funds(
  from_account INTEGER,
  to_account INTEGER,
  amount DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
  -- Check balance
  IF (SELECT balance FROM accounts WHERE id = from_account) < amount THEN
    RAISE EXCEPTION 'Insufficient funds';
  END IF;
  
  -- Perform transfer
  UPDATE accounts SET balance = balance - amount WHERE id = from_account;
  UPDATE accounts SET balance = balance + amount WHERE id = to_account;
  
  -- Log transaction
  INSERT INTO transactions (from_account, to_account, amount)
  VALUES (from_account, to_account, amount);
  
  COMMIT;
END;
$$;

-- Call procedure
CALL transfer_funds(1, 2, 100.00);

-- Procedure with transaction control
CREATE OR REPLACE PROCEDURE process_orders()
LANGUAGE plpgsql
AS $$
DECLARE
  order_record RECORD;
BEGIN
  FOR order_record IN 
    SELECT * FROM orders WHERE status = 'pending'
  LOOP
    BEGIN
      -- Process order
      UPDATE orders SET status = 'processing' WHERE id = order_record.id;
      -- More processing...
      UPDATE orders SET status = 'completed' WHERE id = order_record.id;
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        UPDATE orders SET status = 'failed' WHERE id = order_record.id;
        COMMIT;
    END;
  END LOOP;
END;
$$;
```

---

## 28. Extensions

```sql
-- List available extensions
SELECT * FROM pg_available_extensions;

-- List installed extensions
\dx
SELECT * FROM pg_extension;

-- Install extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "hstore";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- UUID extension
SELECT uuid_generate_v4();

-- pg_trgm (fuzzy text search)
CREATE EXTENSION pg_trgm;
CREATE INDEX idx_users_name_trgm ON users USING GIN (name gin_trgm_ops);

SELECT * FROM users WHERE name % 'Jon';  -- Finds 'John', 'Jonathan', etc.

-- hstore (key-value store)
CREATE EXTENSION hstore;

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name TEXT,
  attributes HSTORE
);

INSERT INTO products (name, attributes) VALUES
  ('Laptop', 'brand=>Dell, ram=>16GB, cpu=>i7');

SELECT * FROM products WHERE attributes->'brand' = 'Dell';

-- PostGIS (geospatial)
CREATE EXTENSION postgis;

CREATE TABLE locations (
  id SERIAL PRIMARY KEY,
  name TEXT,
  location GEOGRAPHY(POINT)
);

INSERT INTO locations (name, location) VALUES
  ('New York', ST_MakePoint(-74.006, 40.7128));

-- Find nearby locations
SELECT name FROM locations
WHERE ST_DWithin(
  location,
  ST_MakePoint(-74.0, 40.7),
  10000  -- 10km
);

-- Drop extension
DROP EXTENSION "uuid-ossp";
```

---

## Part VIII: Security & Administration

---

## 29. User Management & Roles

```sql
-- Create user
CREATE USER alice WITH PASSWORD 'secure_password';

-- Create role
CREATE ROLE readonly;
CREATE ROLE admin WITH LOGIN PASSWORD 'admin_password';

-- Grant privileges
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
GRANT ALL PRIVILEGES ON DATABASE mydb TO admin;
GRANT SELECT, INSERT, UPDATE ON users TO alice;

-- Grant on specific columns
GRANT SELECT (id, name, email) ON users TO alice;

-- Grant on schema
GRANT USAGE ON SCHEMA public TO alice;
GRANT CREATE ON SCHEMA public TO alice;

-- Grant role to user
GRANT readonly TO alice;

-- Revoke privileges
REVOKE INSERT ON users FROM alice;
REVOKE readonly FROM alice;

-- Alter user
ALTER USER alice WITH PASSWORD 'new_password';
ALTER USER alice WITH SUPERUSER;
ALTER USER alice WITH NOSUPERUSER;

-- Set default privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO readonly;

-- Row-level security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

CREATE POLICY user_isolation ON users
  FOR ALL
  TO alice
  USING (user_id = current_user_id());

-- View permissions
\du  -- List users
\dp users  -- List table permissions
SELECT * FROM information_schema.table_privileges WHERE grantee = 'alice';

-- Drop user
DROP USER alice;
DROP ROLE readonly;
```

---

## 30. Backup & Recovery

```sql
-- Logical backup with pg_dump
-- Backup single database
pg_dump mydb > mydb_backup.sql
pg_dump -Fc mydb > mydb_backup.dump  -- Custom format (compressed)

-- Backup specific tables
pg_dump -t users -t posts mydb > tables_backup.sql

-- Backup all databases
pg_dumpall > all_databases.sql

-- Restore from backup
psql mydb < mydb_backup.sql
pg_restore -d mydb mydb_backup.dump

-- Physical backup (base backup)
pg_basebackup -D /backup/data -Ft -z -P

-- Point-in-time recovery (PITR)
-- 1. Enable WAL archiving in postgresql.conf
wal_level = replica
archive_mode = on
archive_command = 'cp %p /archive/%f'

-- 2. Take base backup
pg_basebackup -D /backup/base -Ft -z -P

-- 3. Restore to point in time
-- Stop PostgreSQL
-- Restore base backup
-- Create recovery.conf
restore_command = 'cp /archive/%f %p'
recovery_target_time = '2025-01-15 14:30:00'

-- Continuous archiving
-- Configure in postgresql.conf
archive_mode = on
archive_command = 'test ! -f /archive/%f && cp %p /archive/%f'
```

---

## 31. Replication

### Streaming Replication

```sql
-- Primary server (postgresql.conf)
wal_level = replica
max_wal_senders = 3
wal_keep_size = 64MB

-- Create replication user
CREATE ROLE replicator WITH REPLICATION LOGIN PASSWORD 'rep_password';

-- Configure pg_hba.conf
host replication replicator standby_ip/32 md5

-- Standby server
-- Take base backup
pg_basebackup -h primary_ip -D /var/lib/postgresql/data -U replicator -P

-- Create standby.signal file
touch /var/lib/postgresql/data/standby.signal

-- Configure postgresql.conf
primary_conninfo = 'host=primary_ip port=5432 user=replicator password=rep_password'

-- Start standby server
```

### Logical Replication

```sql
-- Publisher (primary)
CREATE PUBLICATION my_publication FOR ALL TABLES;
-- Or specific tables
CREATE PUBLICATION my_publication FOR TABLE users, posts;

-- Subscriber (replica)
CREATE SUBSCRIPTION my_subscription
CONNECTION 'host=primary_ip dbname=mydb user=replicator password=rep_password'
PUBLICATION my_publication;

-- Monitor replication
SELECT * FROM pg_stat_replication;  -- On primary
SELECT * FROM pg_stat_subscription;  -- On subscriber

-- Drop replication
DROP SUBSCRIPTION my_subscription;  -- On subscriber
DROP PUBLICATION my_publication;     -- On primary
```

---

## 32. Monitoring & Maintenance

```sql
-- Database size
SELECT 
  pg_database.datname,
  pg_size_pretty(pg_database_size(pg_database.datname)) AS size
FROM pg_database
ORDER BY pg_database_size(pg_database.datname) DESC;

-- Table sizes
SELECT
  schemaname,
  tablename,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS total_size,
  pg_size_pretty(pg_relation_size(schemaname||'.'||tablename)) AS table_size,
  pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename) - pg_relation_size(schemaname||'.'||tablename)) AS indexes_size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;

-- Active queries
SELECT 
  pid,
  usename,
  application_name,
  client_addr,
  state,
  query,
  query_start
FROM pg_stat_activity
WHERE state = 'active';

-- Kill query
SELECT pg_cancel_backend(pid);  -- Graceful
SELECT pg_terminate_backend(pid);  -- Forceful

-- Locks
SELECT 
  l.pid,
  l.mode,
  l.granted,
  a.query
FROM pg_locks l
JOIN pg_stat_activity a ON l.pid = a.pid;

-- Cache hit ratio
SELECT 
  sum(heap_blks_read) as heap_read,
  sum(heap_blks_hit)  as heap_hit,
  sum(heap_blks_hit) / (sum(heap_blks_hit) + sum(heap_blks_read)) as ratio
FROM pg_statio_user_tables;

-- Index usage
SELECT 
  schemaname,
  tablename,
  indexname,
  idx_scan,
  idx_tup_read,
  idx_tup_fetch
FROM pg_stat_user_indexes
ORDER BY idx_scan ASC;

-- Vacuum progress
SELECT * FROM pg_stat_progress_vacuum;

-- Replication lag
SELECT 
  client_addr,
  state,
  sent_lsn,
  write_lsn,
  flush_lsn,
  replay_lsn,
  sync_state,
  pg_wal_lsn_diff(sent_lsn, replay_lsn) AS lag_bytes
FROM pg_stat_replication;
```

---

## Part IX: Production Best Practices

---

## 33. Connection Pooling

### PgBouncer Configuration

```ini
# pgbouncer.ini
[databases]
mydb = host=localhost port=5432 dbname=mydb

[pgbouncer]
listen_addr = *
listen_port = 6432
auth_type = md5
auth_file = /etc/pgbouncer/userlist.txt
pool_mode = transaction
max_client_conn = 1000
default_pool_size = 25
min_pool_size = 5
reserve_pool_size = 5
reserve_pool_timeout = 3
max_db_connections = 100
```

### Application Configuration

```javascript
// Node.js with pg
const { Pool } = require('pg');

const pool = new Pool({
  host: 'localhost',
  port: 6432,  // PgBouncer port
  database: 'mydb',
  user: 'myuser',
  password: 'mypassword',
  max: 20,  // Maximum pool size
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

// Use pool
const result = await pool.query('SELECT * FROM users');
```

---

## 34. Partitioning

### Range Partitioning

```sql
-- Create partitioned table
CREATE TABLE orders (
  id SERIAL,
  user_id INTEGER,
  total DECIMAL(10,2),
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

-- Create partitions
CREATE TABLE orders_2024_q1 PARTITION OF orders
  FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE orders_2024_q2 PARTITION OF orders
  FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE orders_2024_q3 PARTITION OF orders
  FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

CREATE TABLE orders_2024_q4 PARTITION OF orders
  FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

-- Insert data (automatically routed to correct partition)
INSERT INTO orders (user_id, total, created_at)
VALUES (1, 99.99, '2024-05-15');

-- Query (automatically uses correct partition)
SELECT * FROM orders WHERE created_at >= '2024-04-01' AND created_at < '2024-07-01';
```

### List Partitioning

```sql
CREATE TABLE users (
  id SERIAL,
  name TEXT,
  country TEXT NOT NULL,
  PRIMARY KEY (id, country)
) PARTITION BY LIST (country);

CREATE TABLE users_us PARTITION OF users
  FOR VALUES IN ('US', 'USA');

CREATE TABLE users_eu PARTITION OF users
  FOR VALUES IN ('UK', 'DE', 'FR');

CREATE TABLE users_asia PARTITION OF users
  FOR VALUES IN ('JP', 'CN', 'IN');
```

### Hash Partitioning

```sql
CREATE TABLE logs (
  id SERIAL,
  message TEXT,
  created_at TIMESTAMP,
  PRIMARY KEY (id)
) PARTITION BY HASH (id);

CREATE TABLE logs_0 PARTITION OF logs
  FOR VALUES WITH (MODULUS 4, REMAINDER 0);

CREATE TABLE logs_1 PARTITION OF logs
  FOR VALUES WITH (MODULUS 4, REMAINDER 1);

CREATE TABLE logs_2 PARTITION OF logs
  FOR VALUES WITH (MODULUS 4, REMAINDER 2);

CREATE TABLE logs_3 PARTITION OF logs
  FOR VALUES WITH (MODULUS 4, REMAINDER 3);
```

---

## 35. High Availability

### Failover Setup

```sql
-- Use tools like:
-- - Patroni (automatic failover)
-- - repmgr (replication manager)
-- - Pgpool-II (connection pooling + load balancing)

-- Manual failover
-- On standby:
pg_ctl promote -D /var/lib/postgresql/data

-- Or create trigger file
touch /var/lib/postgresql/data/promote.trigger
```

### Load Balancing

```sql
-- Use HAProxy or Pgpool-II
-- HAProxy configuration example:
listen postgres
  bind *:5432
  mode tcp
  option tcplog
  balance roundrobin
  server pg1 10.0.0.1:5432 check
  server pg2 10.0.0.2:5432 check backup
```

---

## 36. Migration Strategies

### Zero-Downtime Migrations

```sql
-- 1. Add new column (nullable)
ALTER TABLE users ADD COLUMN new_email TEXT;

-- 2. Backfill data (in batches)
DO $$
DECLARE
  batch_size INTEGER := 1000;
  last_id INTEGER := 0;
BEGIN
  LOOP
    UPDATE users
    SET new_email = email
    WHERE id > last_id AND id <= last_id + batch_size
      AND new_email IS NULL;
    
    EXIT WHEN NOT FOUND;
    last_id := last_id + batch_size;
    COMMIT;
  END LOOP;
END $$;

-- 3. Add constraint
ALTER TABLE users ALTER COLUMN new_email SET NOT NULL;
ALTER TABLE users ADD CONSTRAINT uq_new_email UNIQUE (new_email);

-- 4. Drop old column
ALTER TABLE users DROP COLUMN email;

-- 5. Rename column
ALTER TABLE users RENAME COLUMN new_email TO email;
```

### Blue-Green Deployment

```sql
-- 1. Create new schema
CREATE SCHEMA blue;
CREATE SCHEMA green;

-- 2. Deploy to green
-- Create tables in green schema
-- Migrate data

-- 3. Switch traffic
ALTER DATABASE mydb SET search_path TO green, public;

-- 4. Cleanup old schema
DROP SCHEMA blue CASCADE;
```

---

## Conclusion

This comprehensive PostgreSQL Mastery Guide covers everything from fundamentals to advanced production topics:

### Key Takeaways

1. **Data Modeling**: Use appropriate data types, constraints, and normalization
2. **Query Optimization**: Leverage indexes, EXPLAIN, and query planning
3. **Transactions**: Understand ACID, isolation levels, and MVCC
4. **Advanced Features**: Use CTEs, window functions, JSON, full-text search
5. **Security**: Implement proper authentication, authorization, and row-level security
6. **High Availability**: Set up replication, failover, and load balancing
7. **Monitoring**: Track performance metrics, slow queries, and resource usage
8. **Maintenance**: Regular VACUUM, ANALYZE, backups, and updates

### Production Checklist

- [ ] Configure connection pooling (PgBouncer/Pgpool-II)
- [ ] Set up streaming replication
- [ ] Implement automated backups
- [ ] Configure monitoring (pg_stat_statements, logs)
- [ ] Tune postgresql.conf for your workload
- [ ] Create appropriate indexes
- [ ] Set up row-level security if needed
- [ ] Plan for partitioning large tables
- [ ] Document disaster recovery procedures
- [ ] Regular security updates

PostgreSQL is one of the most powerful and feature-rich databases available. This guide provides the foundation to use it effectively at scale.

---

*End of PostgreSQL Mastery Guide - Complete Edition*
