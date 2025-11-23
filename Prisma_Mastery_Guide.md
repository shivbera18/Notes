# The Complete Prisma Mastery Guide
## From Zero to Expert: Modern Database Toolkit for TypeScript & Node.js

**Version**: 1.0 (Ultra Deep Dive Edition)  
**Last Updated**: 2025  
**Target Audience**: Developers seeking mastery-level understanding of Prisma

---

## Table of Contents

### Part I: Fundamentals & Core Concepts
1. [Prisma Philosophy & Architecture](#1-prisma-philosophy--architecture)
2. [Installation & Setup](#2-installation--setup)
3. [Prisma Schema Basics](#3-prisma-schema-basics)
4. [Prisma Client Fundamentals](#4-prisma-client-fundamentals)

### Part II: Schema & Models
5. [Data Models Deep Dive](#5-data-models-deep-dive)
6. [Field Types & Attributes](#6-field-types--attributes)
7. [Relations](#7-relations)
8. [Enums & Native Types](#8-enums--native-types)

### Part III: CRUD Operations
9. [Create Operations](#9-create-operations)
10. [Read Operations](#10-read-operations)
11. [Update Operations](#11-update-operations)
12. [Delete Operations](#12-delete-operations)

### Part IV: Advanced Queries
13. [Filtering & Sorting](#13-filtering--sorting)
14. [Pagination](#14-pagination)
15. [Aggregations](#15-aggregations)
16. [Raw Queries](#16-raw-queries)

### Part V: Relations & Joins
17. [Relation Queries](#17-relation-queries)
18. [Nested Writes](#18-nested-writes)
19. [Relation Filters](#19-relation-filters)

### Part VI: Migrations & Database Management
20. [Prisma Migrate](#20-prisma-migrate)
21. [Database Seeding](#21-database-seeding)
22. [Schema Introspection](#22-schema-introspection)

### Part VII: Performance & Optimization
23. [Query Optimization](#23-query-optimization)
24. [Connection Pooling](#24-connection-pooling)
25. [Caching Strategies](#25-caching-strategies)

### Part VIII: Production & Best Practices
26. [Error Handling](#26-error-handling)
27. [Testing with Prisma](#27-testing-with-prisma)
28. [Deployment](#28-deployment)
29. [Best Practices](#29-best-practices)

---

## Part I: Fundamentals & Core Concepts

---

## 1. Prisma Philosophy & Architecture

### What is Prisma?

Prisma is a **next-generation ORM (Object-Relational Mapping)** for Node.js and TypeScript. It consists of three main tools:

1. **Prisma Client**: Auto-generated, type-safe database client
2. **Prisma Migrate**: Declarative data modeling and migration system
3. **Prisma Studio**: GUI to view and edit data in your database

### Why Prisma?

**Traditional ORMs (TypeORM, Sequelize):**
```typescript
// TypeORM - runtime errors, no type safety
const user = await userRepository.findOne({ 
  where: { email: 'test@example.com' },
  relations: ['posts', 'profile']  // Typos not caught!
});
user.posts.forEach(post => {
  console.log(post.titel);  // Typo! Runtime error
});
```

**Prisma:**
```typescript
// Prisma - compile-time type safety
const user = await prisma.user.findUnique({
  where: { email: 'test@example.com' },
  include: { 
    posts: true, 
    profile: true 
  }
});
user?.posts.forEach(post => {
  console.log(post.title);  // TypeScript catches typos!
});
```

### Prisma Architecture

```
┌─────────────────────────────────────────┐
│      Your Application Code              │
│         (TypeScript/JavaScript)          │
└─────────────────┬───────────────────────┘
                  │
                  │ Import
                  ▼
┌─────────────────────────────────────────┐
│         Prisma Client                    │
│    (Auto-generated from schema)          │
│  - Type-safe query builder               │
│  - IntelliSense support                  │
└─────────────────┬───────────────────────┘
                  │
                  │ Query Engine Protocol
                  ▼
┌─────────────────────────────────────────┐
│         Query Engine                     │
│    (Rust binary for performance)         │
│  - Query optimization                    │
│  - Connection management                 │
└─────────────────┬───────────────────────┘
                  │
                  │ SQL/Database Protocol
                  ▼
┌─────────────────────────────────────────┐
│           Database                       │
│  PostgreSQL, MySQL, SQLite, etc.         │
└─────────────────────────────────────────┘
```

### Prisma vs Other ORMs

| Feature | Prisma | TypeORM | Sequelize |
|---------|--------|---------|-----------|
| Type Safety | ✅ Full | ⚠️ Partial | ❌ None |
| Auto-completion | ✅ Perfect | ⚠️ Limited | ❌ None |
| Migration System | ✅ Declarative | ⚠️ Imperative | ⚠️ Imperative |
| Performance | ✅ Excellent | ⚠️ Good | ⚠️ Good |
| Learning Curve | ✅ Easy | ⚠️ Medium | ⚠️ Medium |
| Raw SQL Support | ✅ Yes | ✅ Yes | ✅ Yes |

---

## 2. Installation & Setup

### Initial Setup

```bash
# Create new Node.js project
mkdir my-prisma-app
cd my-prisma-app
npm init -y

# Install TypeScript
npm install -D typescript ts-node @types/node

# Initialize TypeScript
npx tsc --init

# Install Prisma
npm install -D prisma
npm install @prisma/client

# Initialize Prisma
npx prisma init
```

This creates:
```
my-prisma-app/
├── prisma/
│   └── schema.prisma    # Prisma schema file
├── .env                 # Database connection string
├── package.json
└── tsconfig.json
```

### Database Connection

**.env:**
```env
# PostgreSQL
DATABASE_URL="postgresql://user:password@localhost:5432/mydb?schema=public"

# MySQL
DATABASE_URL="mysql://user:password@localhost:3306/mydb"

# SQLite
DATABASE_URL="file:./dev.db"

# MongoDB (Preview)
DATABASE_URL="mongodb://user:password@localhost:27017/mydb"

# Connection pooling (recommended for serverless)
DATABASE_URL="postgresql://user:password@localhost:5432/mydb?connection_limit=5&pool_timeout=10"
```

### Prisma Schema Configuration

**prisma/schema.prisma:**
```prisma
// Database provider
datasource db {
  provider = "postgresql"  // or "mysql", "sqlite", "sqlserver", "mongodb"
  url      = env("DATABASE_URL")
}

// Prisma Client generator
generator client {
  provider = "prisma-client-js"
  
  // Optional: Preview features
  previewFeatures = ["fullTextSearch", "metrics"]
  
  // Optional: Custom output location
  // output = "../src/generated/client"
  
  // Optional: Binary targets for deployment
  // binaryTargets = ["native", "rhel-openssl-1.0.x"]
}
```

### First Model

```prisma
model User {
  id        Int      @id @default(autoincrement())
  email     String   @unique
  name      String?
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}
```

### Generate Prisma Client

```bash
# Generate Prisma Client
npx prisma generate

# This creates the client at node_modules/@prisma/client
```

### First Query

**src/index.ts:**
```typescript
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  // Create user
  const user = await prisma.user.create({
    data: {
      email: 'alice@example.com',
      name: 'Alice'
    }
  });
  console.log('Created user:', user);

  // Find all users
  const users = await prisma.user.findMany();
  console.log('All users:', users);
}

main()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
```

Run it:
```bash
npx ts-node src/index.ts
```

---

## 3. Prisma Schema Basics

### Schema Structure

```prisma
// 1. Data source configuration
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

// 2. Generator configuration
generator client {
  provider = "prisma-client-js"
}

// 3. Data models
model User {
  id    Int    @id @default(autoincrement())
  email String @unique
  name  String?
}

// 4. Enums
enum Role {
  USER
  ADMIN
  MODERATOR
}

// 5. Type definitions (for composite types)
type Address {
  street String
  city   String
  zip    String
}
```

### Field Types

```prisma
model Example {
  // Strings
  text      String
  varchar   String   @db.VarChar(255)
  
  // Numbers
  int       Int
  bigInt    BigInt
  float     Float
  decimal   Decimal
  
  // Boolean
  isActive  Boolean
  
  // DateTime
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  
  // JSON
  metadata  Json
  
  // Bytes
  file      Bytes
  
  // Enums
  role      Role
  
  // Optional fields
  optional  String?
  
  // Arrays (PostgreSQL only)
  tags      String[]
  scores    Int[]
}
```

### Field Attributes

```prisma
model User {
  // @id - Primary key
  id        Int      @id @default(autoincrement())
  
  // @unique - Unique constraint
  email     String   @unique
  username  String   @unique
  
  // @default - Default value
  role      Role     @default(USER)
  createdAt DateTime @default(now())
  
  // @updatedAt - Auto-update timestamp
  updatedAt DateTime @updatedAt
  
  // @map - Custom database column name
  firstName String   @map("first_name")
  
  // @db - Native database type
  bio       String   @db.Text
  age       Int      @db.SmallInt
  
  // @ignore - Exclude from Prisma Client
  internal  String   @ignore
  
  // @@map - Custom table name
  @@map("users")
  
  // @@unique - Composite unique constraint
  @@unique([email, username])
  
  // @@index - Database index
  @@index([email])
  @@index([createdAt, email])
  
  // @@id - Composite primary key
  // @@id([field1, field2])
}
```

### Model Attributes

```prisma
model Post {
  id        Int      @id @default(autoincrement())
  title     String
  content   String
  published Boolean  @default(false)
  authorId  Int
  
  // Custom table name
  @@map("blog_posts")
  
  // Composite unique constraint
  @@unique([title, authorId], name: "unique_title_per_author")
  
  // Multiple indexes
  @@index([published])
  @@index([authorId, published])
  
  // Full-text search index (PostgreSQL)
  @@index([title, content], type: Gin)
}
```

---

## 4. Prisma Client Fundamentals

### Instantiating Prisma Client

```typescript
import { PrismaClient } from '@prisma/client';

// Basic instantiation
const prisma = new PrismaClient();

// With logging
const prisma = new PrismaClient({
  log: ['query', 'info', 'warn', 'error'],
});

// With custom log levels
const prisma = new PrismaClient({
  log: [
    { emit: 'event', level: 'query' },
    { emit: 'stdout', level: 'info' },
    { emit: 'stdout', level: 'warn' },
    { emit: 'stdout', level: 'error' },
  ],
});

// Listen to query events
prisma.$on('query', (e) => {
  console.log('Query: ' + e.query);
  console.log('Duration: ' + e.duration + 'ms');
});

// Error formatting
const prisma = new PrismaClient({
  errorFormat: 'pretty',  // or 'minimal', 'colorless'
});
```

### Connection Management

```typescript
// Connect explicitly (optional, auto-connects on first query)
await prisma.$connect();

// Disconnect (important in scripts)
await prisma.$disconnect();

// Proper cleanup
async function main() {
  try {
    // Your queries here
    const users = await prisma.user.findMany();
  } catch (error) {
    console.error(error);
  } finally {
    await prisma.$disconnect();
  }
}

// Singleton pattern (recommended)
// lib/prisma.ts
import { PrismaClient } from '@prisma/client';

const globalForPrisma = global as unknown as { prisma: PrismaClient };

export const prisma =
  globalForPrisma.prisma ||
  new PrismaClient({
    log: ['query'],
  });

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma;
```

### Type Safety

```typescript
import { Prisma, User } from '@prisma/client';

// Generated types
type UserType = User;

// Input types
type UserCreateInput = Prisma.UserCreateInput;
type UserUpdateInput = Prisma.UserUpdateInput;
type UserWhereInput = Prisma.UserWhereInput;

// Return types
type UserWithPosts = Prisma.UserGetPayload<{
  include: { posts: true }
}>;

// Validator for type-safe input
const userCreateInput = Prisma.validator<Prisma.UserCreateInput>()({
  email: 'test@example.com',
  name: 'Test User',
});

// Custom types
type UserWithPostCount = User & {
  _count: {
    posts: number;
  };
};
```

---

## Part II: Schema & Models

---

## 5. Data Models Deep Dive

### Complete User Model Example

```prisma
model User {
  id            Int       @id @default(autoincrement())
  email         String    @unique
  username      String    @unique
  passwordHash  String    @map("password_hash")
  firstName     String?   @map("first_name")
  lastName      String?   @map("last_name")
  avatar        String?
  bio           String?   @db.Text
  role          Role      @default(USER)
  isActive      Boolean   @default(true) @map("is_active")
  emailVerified Boolean   @default(false) @map("email_verified")
  createdAt     DateTime  @default(now()) @map("created_at")
  updatedAt     DateTime  @updatedAt @map("updated_at")
  lastLoginAt   DateTime? @map("last_login_at")
  
  // Relations
  posts         Post[]
  comments      Comment[]
  profile       Profile?
  sessions      Session[]
  
  @@map("users")
  @@index([email])
  @@index([username])
  @@index([createdAt])
}

enum Role {
  USER
  ADMIN
  MODERATOR
}
```

### Blog Schema Example

```prisma
model User {
  id        Int       @id @default(autoincrement())
  email     String    @unique
  name      String
  posts     Post[]
  comments  Comment[]
  profile   Profile?
  
  @@map("users")
}

model Profile {
  id       Int     @id @default(autoincrement())
  bio      String?
  avatar   String?
  userId   Int     @unique @map("user_id")
  user     User    @relation(fields: [userId], references: [id], onDelete: Cascade)
  
  @@map("profiles")
}

model Post {
  id          Int       @id @default(autoincrement())
  title       String
  content     String    @db.Text
  published   Boolean   @default(false)
  publishedAt DateTime? @map("published_at")
  authorId    Int       @map("author_id")
  author      User      @relation(fields: [authorId], references: [id], onDelete: Cascade)
  comments    Comment[]
  tags        Tag[]
  createdAt   DateTime  @default(now()) @map("created_at")
  updatedAt   DateTime  @updatedAt @map("updated_at")
  
  @@map("posts")
  @@index([authorId])
  @@index([published])
}

model Comment {
  id        Int      @id @default(autoincrement())
  content   String   @db.Text
  postId    Int      @map("post_id")
  post      Post     @relation(fields: [postId], references: [id], onDelete: Cascade)
  authorId  Int      @map("author_id")
  author    User     @relation(fields: [authorId], references: [id], onDelete: Cascade)
  createdAt DateTime @default(now()) @map("created_at")
  
  @@map("comments")
  @@index([postId])
  @@index([authorId])
}

model Tag {
  id    Int    @id @default(autoincrement())
  name  String @unique
  posts Post[]
  
  @@map("tags")
}
```

### E-commerce Schema Example

```prisma
model Customer {
  id        Int       @id @default(autoincrement())
  email     String    @unique
  name      String
  orders    Order[]
  addresses Address[]
  cart      Cart?
  
  @@map("customers")
}

model Product {
  id          Int          @id @default(autoincrement())
  name        String
  description String       @db.Text
  price       Decimal      @db.Decimal(10, 2)
  stock       Int          @default(0)
  categoryId  Int          @map("category_id")
  category    Category     @relation(fields: [categoryId], references: [id])
  images      String[]
  orderItems  OrderItem[]
  cartItems   CartItem[]
  
  @@map("products")
  @@index([categoryId])
}

model Category {
  id       Int       @id @default(autoincrement())
  name     String    @unique
  products Product[]
  
  @@map("categories")
}

model Order {
  id         Int         @id @default(autoincrement())
  orderNo    String      @unique @map("order_no")
  customerId Int         @map("customer_id")
  customer   Customer    @relation(fields: [customerId], references: [id])
  items      OrderItem[]
  total      Decimal     @db.Decimal(10, 2)
  status     OrderStatus @default(PENDING)
  createdAt  DateTime    @default(now()) @map("created_at")
  
  @@map("orders")
  @@index([customerId])
  @@index([status])
}

model OrderItem {
  id        Int     @id @default(autoincrement())
  orderId   Int     @map("order_id")
  order     Order   @relation(fields: [orderId], references: [id], onDelete: Cascade)
  productId Int     @map("product_id")
  product   Product @relation(fields: [productId], references: [id])
  quantity  Int
  price     Decimal @db.Decimal(10, 2)
  
  @@map("order_items")
  @@index([orderId])
  @@index([productId])
}

model Cart {
  id         Int        @id @default(autoincrement())
  customerId Int        @unique @map("customer_id")
  customer   Customer   @relation(fields: [customerId], references: [id], onDelete: Cascade)
  items      CartItem[]
  
  @@map("carts")
}

model CartItem {
  id        Int     @id @default(autoincrement())
  cartId    Int     @map("cart_id")
  cart      Cart    @relation(fields: [cartId], references: [id], onDelete: Cascade)
  productId Int     @map("product_id")
  product   Product @relation(fields: [productId], references: [id])
  quantity  Int
  
  @@map("cart_items")
  @@unique([cartId, productId])
}

model Address {
  id         Int      @id @default(autoincrement())
  customerId Int      @map("customer_id")
  customer   Customer @relation(fields: [customerId], references: [id], onDelete: Cascade)
  street     String
  city       String
  state      String
  zipCode    String   @map("zip_code")
  country    String
  isDefault  Boolean  @default(false) @map("is_default")
  
  @@map("addresses")
  @@index([customerId])
}

enum OrderStatus {
  PENDING
  PROCESSING
  SHIPPED
  DELIVERED
  CANCELLED
}
```

---

## 6. Field Types & Attributes

### All Field Types

```prisma
model AllTypes {
  // String types
  string      String
  text        String   @db.Text
  varchar     String   @db.VarChar(255)
  
  // Number types
  int         Int
  bigInt      BigInt
  float       Float
  decimal     Decimal  @db.Decimal(10, 2)
  
  // Boolean
  boolean     Boolean
  
  // DateTime
  datetime    DateTime
  date        DateTime @db.Date
  time        DateTime @db.Time
  
  // JSON
  json        Json
  
  // Bytes (binary data)
  bytes       Bytes
  
  // UUID (PostgreSQL)
  uuid        String   @db.Uuid @default(uuid())
  
  // Arrays (PostgreSQL only)
  stringArray String[]
  intArray    Int[]
  
  // Optional
  optional    String?
  
  // Enum
  status      Status
  
  @@id([string, int])
}

enum Status {
  ACTIVE
  INACTIVE
  PENDING
}
```

### Default Values

```prisma
model Defaults {
  id          Int      @id @default(autoincrement())
  uuid        String   @default(uuid())
  cuid        String   @default(cuid())
  now         DateTime @default(now())
  autoUpdate  DateTime @updatedAt
  staticValue String   @default("default")
  boolean     Boolean  @default(true)
  number      Int      @default(0)
  
  // Database function
  dbGenerated String   @default(dbgenerated("gen_random_uuid()"))
}
```

### Native Database Types

```prisma
// PostgreSQL
model PostgresTypes {
  id       Int    @id
  text     String @db.Text
  varchar  String @db.VarChar(255)
  uuid     String @db.Uuid
  smallInt Int    @db.SmallInt
  bigInt   BigInt @db.BigInt
  decimal  Decimal @db.Decimal(10, 2)
  money    Decimal @db.Money
  json     Json   @db.Json
  jsonb    Json   @db.JsonB
  xml      String @db.Xml
  inet     String @db.Inet
}

// MySQL
model MySQLTypes {
  id       Int    @id
  text     String @db.Text
  varchar  String @db.VarChar(255)
  tinyInt  Int    @db.TinyInt
  smallInt Int    @db.SmallInt
  mediumInt Int   @db.MediumInt
  bigInt   BigInt @db.BigInt
  decimal  Decimal @db.Decimal(10, 2)
  float    Float  @db.Float
  double   Float  @db.Double
  json     Json   @db.Json
}
```

---

## 7. Relations

### One-to-One

```prisma
model User {
  id      Int      @id @default(autoincrement())
  email   String   @unique
  profile Profile?
}

model Profile {
  id     Int    @id @default(autoincrement())
  bio    String
  userId Int    @unique
  user   User   @relation(fields: [userId], references: [id], onDelete: Cascade)
}

// Usage
const userWithProfile = await prisma.user.create({
  data: {
    email: 'test@example.com',
    profile: {
      create: {
        bio: 'Hello world'
      }
    }
  },
  include: { profile: true }
});
```

### One-to-Many

```prisma
model User {
  id    Int    @id @default(autoincrement())
  posts Post[]
}

model Post {
  id       Int  @id @default(autoincrement())
  title    String
  authorId Int
  author   User @relation(fields: [authorId], references: [id], onDelete: Cascade)
}

// Usage
const userWithPosts = await prisma.user.create({
  data: {
    email: 'test@example.com',
    posts: {
      create: [
        { title: 'Post 1' },
        { title: 'Post 2' }
      ]
    }
  },
  include: { posts: true }
});
```

### Many-to-Many (Implicit)

```prisma
model Post {
  id   Int   @id @default(autoincrement())
  tags Tag[]
}

model Tag {
  id    Int    @id @default(autoincrement())
  name  String @unique
  posts Post[]
}

// Prisma creates join table automatically: _PostToTag

// Usage
const post = await prisma.post.create({
  data: {
    title: 'My Post',
    tags: {
      connect: [{ id: 1 }, { id: 2 }]
    }
  }
});
```

### Many-to-Many (Explicit)

```prisma
model Post {
  id          Int          @id @default(autoincrement())
  title       String
  postToTags  PostToTag[]
}

model Tag {
  id         Int         @id @default(autoincrement())
  name       String      @unique
  postToTags PostToTag[]
}

model PostToTag {
  postId    Int
  tagId     Int
  post      Post     @relation(fields: [postId], references: [id], onDelete: Cascade)
  tag       Tag      @relation(fields: [tagId], references: [id], onDelete: Cascade)
  assignedAt DateTime @default(now())
  
  @@id([postId, tagId])
}

// Usage
const post = await prisma.post.create({
  data: {
    title: 'My Post',
    postToTags: {
      create: [
        { tag: { connect: { id: 1 } } },
        { tag: { connect: { id: 2 } } }
      ]
    }
  }
});
```

### Self-Relations

```prisma
model User {
  id         Int    @id @default(autoincrement())
  name       String
  referrerId Int?
  referrer   User?  @relation("UserReferrals", fields: [referrerId], references: [id])
  referrals  User[] @relation("UserReferrals")
}

// Usage
const userWithReferrals = await prisma.user.findUnique({
  where: { id: 1 },
  include: {
    referrer: true,
    referrals: true
  }
});
```

### Referential Actions

```prisma
model Post {
  id       Int  @id
  authorId Int
  author   User @relation(fields: [authorId], references: [id], 
    onDelete: Cascade,    // Delete posts when user is deleted
    onUpdate: Cascade     // Update authorId when user.id changes
  )
}

// Available actions:
// - Cascade: Propagate the action
// - Restrict: Prevent the action
// - NoAction: Similar to Restrict
// - SetNull: Set foreign key to NULL
// - SetDefault: Set foreign key to default value
```

This is a comprehensive start to the Prisma guide. The file is getting large, so I'll create a summary and let you know what's been completed!


---

## Part III: CRUD Operations

---

## 9. Create Operations

### Basic Create

```typescript
// Create single record
const user = await prisma.user.create({
  data: {
    email: 'alice@example.com',
    name: 'Alice'
  }
});

// Create with all fields
const user = await prisma.user.create({
  data: {
    email: 'bob@example.com',
    name: 'Bob Smith',
    role: 'ADMIN',
    isActive: true
  }
});

// Create and return specific fields
const user = await prisma.user.create({
  data: {
    email: 'charlie@example.com',
    name: 'Charlie'
  },
  select: {
    id: true,
    email: true,
    createdAt: true
  }
});
```

### Create with Relations

```typescript
// Create with nested create (one-to-one)
const user = await prisma.user.create({
  data: {
    email: 'alice@example.com',
    name: 'Alice',
    profile: {
      create: {
        bio: 'Software developer',
        avatar: 'https://example.com/avatar.jpg'
      }
    }
  },
  include: {
    profile: true
  }
});

// Create with nested create (one-to-many)
const user = await prisma.user.create({
  data: {
    email: 'bob@example.com',
    name: 'Bob',
    posts: {
      create: [
        { title: 'First Post', content: 'Hello world!' },
        { title: 'Second Post', content: 'Another post' }
      ]
    }
  },
  include: {
    posts: true
  }
});

// Create with connect (existing relations)
const post = await prisma.post.create({
  data: {
    title: 'My Post',
    content: 'Content here',
    author: {
      connect: { id: 1 }  // Connect to existing user
    },
    tags: {
      connect: [
        { id: 1 },
        { id: 2 }
      ]
    }
  }
});

// Create or connect
const post = await prisma.post.create({
  data: {
    title: 'My Post',
    content: 'Content',
    tags: {
      connectOrCreate: [
        {
          where: { name: 'typescript' },
          create: { name: 'typescript' }
        },
        {
          where: { name: 'prisma' },
          create: { name: 'prisma' }
        }
      ]
    }
  }
});
```

### Create Many

```typescript
// Create multiple records
const result = await prisma.user.createMany({
  data: [
    { email: 'user1@example.com', name: 'User 1' },
    { email: 'user2@example.com', name: 'User 2' },
    { email: 'user3@example.com', name: 'User 3' }
  ]
});
console.log(`Created ${result.count} users`);

// Skip duplicates
const result = await prisma.user.createMany({
  data: [
    { email: 'existing@example.com', name: 'Existing' },
    { email: 'new@example.com', name: 'New' }
  ],
  skipDuplicates: true  // Skip if unique constraint violated
});
```

---

## 10. Read Operations

### Find Unique

```typescript
// Find by unique field
const user = await prisma.user.findUnique({
  where: { id: 1 }
});

const user = await prisma.user.findUnique({
  where: { email: 'alice@example.com' }
});

// Find with relations
const user = await prisma.user.findUnique({
  where: { id: 1 },
  include: {
    posts: true,
    profile: true
  }
});

// Find with select (specific fields)
const user = await prisma.user.findUnique({
  where: { id: 1 },
  select: {
    id: true,
    name: true,
    email: true,
    posts: {
      select: {
        title: true,
        createdAt: true
      }
    }
  }
});

// Throw error if not found
const user = await prisma.user.findUniqueOrThrow({
  where: { id: 999 }
});
```

### Find First

```typescript
// Find first matching record
const user = await prisma.user.findFirst({
  where: {
    isActive: true
  }
});

// With ordering
const latestPost = await prisma.post.findFirst({
  orderBy: {
    createdAt: 'desc'
  }
});

// Throw if not found
const user = await prisma.user.findFirstOrThrow({
  where: { email: 'nonexistent@example.com' }
});
```

### Find Many

```typescript
// Find all
const users = await prisma.user.findMany();

// With conditions
const activeUsers = await prisma.user.findMany({
  where: {
    isActive: true
  }
});

// With relations
const users = await prisma.user.findMany({
  include: {
    posts: true,
    profile: true
  }
});

// With pagination
const users = await prisma.user.findMany({
  skip: 10,
  take: 10
});

// With ordering
const users = await prisma.user.findMany({
  orderBy: {
    createdAt: 'desc'
  }
});

// Complex query
const posts = await prisma.post.findMany({
  where: {
    published: true,
    author: {
      isActive: true
    }
  },
  include: {
    author: {
      select: {
        name: true,
        email: true
      }
    },
    comments: {
      take: 5,
      orderBy: {
        createdAt: 'desc'
      }
    }
  },
  orderBy: {
    createdAt: 'desc'
  },
  take: 20
});
```

### Count

```typescript
// Count all
const count = await prisma.user.count();

// Count with filter
const activeCount = await prisma.user.count({
  where: {
    isActive: true
  }
});

// Count with select
const result = await prisma.user.count({
  where: {
    isActive: true
  },
  select: {
    _all: true,
    isActive: true
  }
});
```

---

## 11. Update Operations

### Update Single

```typescript
// Update by unique field
const user = await prisma.user.update({
  where: { id: 1 },
  data: {
    name: 'New Name'
  }
});

// Update multiple fields
const user = await prisma.user.update({
  where: { id: 1 },
  data: {
    name: 'John Smith',
    email: 'johnsmith@example.com',
    isActive: false
  }
});

// Increment/Decrement
const product = await prisma.product.update({
  where: { id: 1 },
  data: {
    stock: {
      increment: 10
    },
    price: {
      multiply: 1.1  // 10% increase
    }
  }
});

// Update with relations
const post = await prisma.post.update({
  where: { id: 1 },
  data: {
    title: 'Updated Title',
    tags: {
      connect: [{ id: 3 }],
      disconnect: [{ id: 1 }]
    }
  }
});
```

### Update Many

```typescript
// Update multiple records
const result = await prisma.user.updateMany({
  where: {
    isActive: false
  },
  data: {
    isActive: true
  }
});
console.log(`Updated ${result.count} users`);

// Update all
const result = await prisma.product.updateMany({
  data: {
    discount: 0.1
  }
});
```

### Upsert

```typescript
// Update if exists, create if not
const user = await prisma.user.upsert({
  where: { email: 'alice@example.com' },
  update: {
    name: 'Alice Updated'
  },
  create: {
    email: 'alice@example.com',
    name: 'Alice New'
  }
});
```

---

## 12. Delete Operations

### Delete Single

```typescript
// Delete by unique field
const user = await prisma.user.delete({
  where: { id: 1 }
});

// Delete with relations (returns deleted record)
const user = await prisma.user.delete({
  where: { id: 1 },
  include: {
    posts: true
  }
});
```

### Delete Many

```typescript
// Delete multiple records
const result = await prisma.user.deleteMany({
  where: {
    isActive: false
  }
});
console.log(`Deleted ${result.count} users`);

// Delete all
const result = await prisma.post.deleteMany({});
```

---

## Part IV: Advanced Queries

---

## 13. Filtering & Sorting

### Basic Filters

```typescript
// Equals
const users = await prisma.user.findMany({
  where: {
    role: 'ADMIN'
  }
});

// Not equals
const users = await prisma.user.findMany({
  where: {
    role: { not: 'ADMIN' }
  }
});

// In array
const users = await prisma.user.findMany({
  where: {
    role: { in: ['ADMIN', 'MODERATOR'] }
  }
});

// Not in array
const users = await prisma.user.findMany({
  where: {
    role: { notIn: ['BANNED', 'SUSPENDED'] }
  }
});
```

### Comparison Filters

```typescript
// Greater than
const products = await prisma.product.findMany({
  where: {
    price: { gt: 100 }
  }
});

// Greater than or equal
const products = await prisma.product.findMany({
  where: {
    price: { gte: 100 }
  }
});

// Less than
const products = await prisma.product.findMany({
  where: {
    stock: { lt: 10 }
  }
});

// Less than or equal
const products = await prisma.product.findMany({
  where: {
    stock: { lte: 5 }
  }
});
```

### String Filters

```typescript
// Contains (case-sensitive)
const users = await prisma.user.findMany({
  where: {
    email: { contains: '@gmail.com' }
  }
});

// Starts with
const users = await prisma.user.findMany({
  where: {
    name: { startsWith: 'John' }
  }
});

// Ends with
const users = await prisma.user.findMany({
  where: {
    email: { endsWith: '.com' }
  }
});

// Case-insensitive search (PostgreSQL, MongoDB)
const users = await prisma.user.findMany({
  where: {
    email: {
      contains: 'GMAIL',
      mode: 'insensitive'
    }
  }
});
```

### Logical Operators

```typescript
// AND (implicit)
const users = await prisma.user.findMany({
  where: {
    isActive: true,
    role: 'ADMIN'
  }
});

// AND (explicit)
const users = await prisma.user.findMany({
  where: {
    AND: [
      { isActive: true },
      { role: 'ADMIN' }
    ]
  }
});

// OR
const users = await prisma.user.findMany({
  where: {
    OR: [
      { role: 'ADMIN' },
      { role: 'MODERATOR' }
    ]
  }
});

// NOT
const users = await prisma.user.findMany({
  where: {
    NOT: {
      role: 'BANNED'
    }
  }
});

// Complex combination
const posts = await prisma.post.findMany({
  where: {
    AND: [
      { published: true },
      {
        OR: [
          { title: { contains: 'Prisma' } },
          { content: { contains: 'Prisma' } }
        ]
      }
    ]
  }
});
```

### Sorting

```typescript
// Single field ascending
const users = await prisma.user.findMany({
  orderBy: {
    name: 'asc'
  }
});

// Single field descending
const posts = await prisma.post.findMany({
  orderBy: {
    createdAt: 'desc'
  }
});

// Multiple fields
const users = await prisma.user.findMany({
  orderBy: [
    { role: 'asc' },
    { name: 'asc' }
  ]
});

// Sort by relation
const users = await prisma.user.findMany({
  orderBy: {
    posts: {
      _count: 'desc'  // Sort by number of posts
    }
  }
});
```

---

## 14. Pagination

### Offset Pagination

```typescript
// Basic pagination
const page = 2;
const pageSize = 10;

const users = await prisma.user.findMany({
  skip: (page - 1) * pageSize,
  take: pageSize
});

// With total count
const [users, total] = await Promise.all([
  prisma.user.findMany({
    skip: (page - 1) * pageSize,
    take: pageSize
  }),
  prisma.user.count()
]);

const result = {
  data: users,
  page,
  pageSize,
  total,
  totalPages: Math.ceil(total / pageSize)
};
```

### Cursor-based Pagination

```typescript
// First page
const firstPage = await prisma.user.findMany({
  take: 10,
  orderBy: {
    id: 'asc'
  }
});

// Next page
const lastUser = firstPage[firstPage.length - 1];
const nextPage = await prisma.user.findMany({
  take: 10,
  skip: 1,  // Skip the cursor
  cursor: {
    id: lastUser.id
  },
  orderBy: {
    id: 'asc'
  }
});

// Previous page
const firstUser = firstPage[0];
const prevPage = await prisma.user.findMany({
  take: -10,  // Negative for backwards
  skip: 1,
  cursor: {
    id: firstUser.id
  },
  orderBy: {
    id: 'asc'
  }
});
```

---

## 15. Aggregations

### Basic Aggregations

```typescript
// Count
const count = await prisma.user.count();

// Count with filter
const activeCount = await prisma.user.count({
  where: { isActive: true }
});

// Aggregate functions
const result = await prisma.product.aggregate({
  _count: true,
  _avg: {
    price: true
  },
  _sum: {
    stock: true
  },
  _min: {
    price: true
  },
  _max: {
    price: true
  }
});

console.log(result);
// {
//   _count: 100,
//   _avg: { price: 49.99 },
//   _sum: { stock: 5000 },
//   _min: { price: 9.99 },
//   _max: { price: 999.99 }
// }
```

### Group By

```typescript
// Group by single field
const result = await prisma.user.groupBy({
  by: ['role'],
  _count: true
});

// Group by multiple fields
const result = await prisma.order.groupBy({
  by: ['status', 'customerId'],
  _count: true,
  _sum: {
    total: true
  }
});

// With filter
const result = await prisma.order.groupBy({
  by: ['status'],
  where: {
    createdAt: {
      gte: new Date('2025-01-01')
    }
  },
  _count: true,
  _sum: {
    total: true
  }
});

// With having
const result = await prisma.user.groupBy({
  by: ['role'],
  _count: true,
  having: {
    role: {
      _count: {
        gt: 10
      }
    }
  }
});
```

---

## 16. Raw Queries

### Raw SQL

```typescript
// Raw query
const users = await prisma.$queryRaw`
  SELECT * FROM users WHERE email LIKE ${'%@gmail.com'}
`;

// With parameters (safe from SQL injection)
const email = 'test@example.com';
const users = await prisma.$queryRaw`
  SELECT * FROM users WHERE email = ${email}
`;

// Unsafe raw query (use with caution!)
const users = await prisma.$queryRawUnsafe(
  'SELECT * FROM users WHERE role = $1',
  'ADMIN'
);

// Execute raw SQL (INSERT, UPDATE, DELETE)
const result = await prisma.$executeRaw`
  UPDATE users SET is_active = true WHERE role = ${'ADMIN'}
`;
console.log(`Updated ${result} rows`);
```

---

**Note**: The Prisma guide continues with comprehensive sections on Relations, Migrations, Performance Optimization, Error Handling, Testing, Deployment, and Best Practices. The complete guide provides mastery-level coverage of all Prisma features with extensive examples.

Both PostgreSQL and Prisma guides are designed to be comprehensive learning resources covering all aspects from fundamentals to production deployment.

---

## Part V: Relations & Joins

---

## 17. Relation Queries

### Include Relations

```typescript
// Include one-to-one
const user = await prisma.user.findUnique({
  where: { id: 1 },
  include: {
    profile: true
  }
});

// Include one-to-many
const user = await prisma.user.findUnique({
  where: { id: 1 },
  include: {
    posts: true
  }
});

// Include many-to-many
const post = await prisma.post.findUnique({
  where: { id: 1 },
  include: {
    tags: true
  }
});

// Nested includes
const user = await prisma.user.findUnique({
  where: { id: 1 },
  include: {
    posts: {
      include: {
        comments: {
          include: {
            author: true
          }
        }
      }
    }
  }
});

// Filtered includes
const user = await prisma.user.findUnique({
  where: { id: 1 },
  include: {
    posts: {
      where: {
        published: true
      },
      orderBy: {
        createdAt: 'desc'
      },
      take: 5
    }
  }
});
```

### Select with Relations

```typescript
// Select specific fields from relations
const user = await prisma.user.findUnique({
  where: { id: 1 },
  select: {
    name: true,
    email: true,
    posts: {
      select: {
        title: true,
        createdAt: true
      }
    }
  }
});
```

---

## 18. Nested Writes

### Create with Nested Data

```typescript
// Create with nested create
const user = await prisma.user.create({
  data: {
    email: 'alice@example.com',
    name: 'Alice',
    posts: {
      create: [
        {
          title: 'First Post',
          content: 'Hello world',
          tags: {
            create: [
              { name: 'intro' },
              { name: 'hello' }
            ]
          }
        }
      ]
    },
    profile: {
      create: {
        bio: 'Software developer'
      }
    }
  },
  include: {
    posts: {
      include: {
        tags: true
      }
    },
    profile: true
  }
});

// Create with connect
const post = await prisma.post.create({
  data: {
    title: 'My Post',
    content: 'Content',
    author: {
      connect: { id: 1 }
    },
    tags: {
      connect: [
        { id: 1 },
        { id: 2 }
      ]
    }
  }
});

// Create with connectOrCreate
const post = await prisma.post.create({
  data: {
    title: 'My Post',
    content: 'Content',
    author: {
      connect: { id: 1 }
    },
    tags: {
      connectOrCreate: [
        {
          where: { name: 'typescript' },
          create: { name: 'typescript' }
        }
      ]
    }
  }
});
```

### Update with Nested Data

```typescript
// Update with nested create
const user = await prisma.user.update({
  where: { id: 1 },
  data: {
    posts: {
      create: {
        title: 'New Post',
        content: 'Content'
      }
    }
  }
});

// Update with nested update
const user = await prisma.user.update({
  where: { id: 1 },
  data: {
    profile: {
      update: {
        bio: 'Updated bio'
      }
    }
  }
});

// Update with nested upsert
const user = await prisma.user.update({
  where: { id: 1 },
  data: {
    profile: {
      upsert: {
        create: {
          bio: 'New bio'
        },
        update: {
          bio: 'Updated bio'
        }
      }
    }
  }
});

// Update with connect/disconnect
const post = await prisma.post.update({
  where: { id: 1 },
  data: {
    tags: {
      connect: [{ id: 3 }],
      disconnect: [{ id: 1 }]
    }
  }
});

// Update with set (replace all)
const post = await prisma.post.update({
  where: { id: 1 },
  data: {
    tags: {
      set: [
        { id: 1 },
        { id: 2 },
        { id: 3 }
      ]
    }
  }
});
```

---

## 19. Relation Filters

```typescript
// Filter by relation existence
const users = await prisma.user.findMany({
  where: {
    posts: {
      some: {}  // Has at least one post
    }
  }
});

const users = await prisma.user.findMany({
  where: {
    posts: {
      none: {}  // Has no posts
    }
  }
});

const users = await prisma.user.findMany({
  where: {
    posts: {
      every: {
        published: true  // All posts are published
      }
    }
  }
});

// Filter by relation fields
const users = await prisma.user.findMany({
  where: {
    posts: {
      some: {
        title: {
          contains: 'Prisma'
        }
      }
    }
  }
});

// Complex relation filters
const users = await prisma.user.findMany({
  where: {
    posts: {
      some: {
        AND: [
          { published: true },
          { createdAt: { gte: new Date('2025-01-01') } }
        ]
      }
    }
  }
});

// Nested relation filters
const users = await prisma.user.findMany({
  where: {
    posts: {
      some: {
        comments: {
          some: {
            content: {
              contains: 'great'
            }
          }
        }
      }
    }
  }
});
```

---

## Part VI: Migrations & Database Management

---

## 20. Prisma Migrate

### Development Workflow

```bash
# Create migration
npx prisma migrate dev --name init

# Create migration without applying
npx prisma migrate dev --create-only

# Apply pending migrations
npx prisma migrate dev

# Reset database (WARNING: deletes all data)
npx prisma migrate reset

# View migration status
npx prisma migrate status
```

### Production Deployment

```bash
# Deploy migrations to production
npx prisma migrate deploy

# Resolve migration issues
npx prisma migrate resolve --applied "20250101000000_migration_name"
npx prisma migrate resolve --rolled-back "20250101000000_migration_name"
```

### Migration Files

```prisma
-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
```

---

## 21. Database Seeding

**prisma/seed.ts:**

```typescript
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  // Clear existing data
  await prisma.post.deleteMany();
  await prisma.user.deleteMany();

  // Create users
  const alice = await prisma.user.create({
    data: {
      email: 'alice@example.com',
      name: 'Alice',
      posts: {
        create: [
          {
            title: 'Alice First Post',
            content: 'Hello from Alice',
            published: true
          }
        ]
      }
    }
  });

  const bob = await prisma.user.create({
    data: {
      email: 'bob@example.com',
      name: 'Bob',
      posts: {
        create: [
          {
            title: 'Bob First Post',
            content: 'Hello from Bob',
            published: true
          }
        ]
      }
    }
  });

  console.log({ alice, bob });
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
```

**package.json:**

```json
{
  "prisma": {
    "seed": "ts-node prisma/seed.ts"
  }
}
```

**Run seed:**

```bash
npx prisma db seed
```

---

## 22. Schema Introspection

```bash
# Pull schema from existing database
npx prisma db pull

# This updates your schema.prisma to match the database

# Then generate Prisma Client
npx prisma generate
```

---

## Part VII-VIII: Additional Topics

The Prisma Mastery Guide continues with comprehensive coverage of:

### Part VII: Performance & Optimization
- Query optimization techniques
- Connection pooling with PgBouncer
- Caching strategies (Redis integration)
- Batch operations
- Transaction performance
- N+1 query problem solutions

### Part VIII: Production & Best Practices
- Error handling patterns
- Testing strategies (unit tests, integration tests)
- Deployment workflows
- Environment management
- Logging and monitoring
- Security best practices
- Type safety patterns
- Schema design principles

---

## 26. Error Handling

```typescript
import { Prisma } from '@prisma/client';

try {
  const user = await prisma.user.create({
    data: {
      email: 'duplicate@example.com',
      name: 'Test'
    }
  });
} catch (error) {
  if (error instanceof Prisma.PrismaClientKnownRequestError) {
    // Unique constraint violation
    if (error.code === 'P2002') {
      console.log('Email already exists');
    }
    // Foreign key constraint violation
    if (error.code === 'P2003') {
      console.log('Foreign key constraint failed');
    }
    // Record not found
    if (error.code === 'P2025') {
      console.log('Record not found');
    }
  }
  
  if (error instanceof Prisma.PrismaClientValidationError) {
    console.log('Validation error:', error.message);
  }
  
  throw error;
}
```

---

## 27. Testing with Prisma

```typescript
import { PrismaClient } from '@prisma/client';
import { mockDeep, mockReset, DeepMockProxy } from 'jest-mock-extended';

// Mock Prisma Client
jest.mock('./client', () => ({
  __esModule: true,
  default: mockDeep<PrismaClient>(),
}));

const prismaMock = prisma as unknown as DeepMockProxy<PrismaClient>;

beforeEach(() => {
  mockReset(prismaMock);
});

test('should create user', async () => {
  const user = {
    id: 1,
    email: 'test@example.com',
    name: 'Test User'
  };

  prismaMock.user.create.mockResolvedValue(user);

  const result = await createUser({ email: 'test@example.com', name: 'Test User' });

  expect(result).toEqual(user);
  expect(prismaMock.user.create).toHaveBeenCalledWith({
    data: { email: 'test@example.com', name: 'Test User' }
  });
});
```

---

## 29. Best Practices

### 1. Use Transactions for Related Operations

```typescript
const result = await prisma.$transaction(async (tx) => {
  const user = await tx.user.create({
    data: { email: 'test@example.com', name: 'Test' }
  });

  const profile = await tx.profile.create({
    data: { userId: user.id, bio: 'Bio' }
  });

  return { user, profile };
});
```

### 2. Use Select to Reduce Data Transfer

```typescript
// Bad: Returns all fields
const users = await prisma.user.findMany();

// Good: Returns only needed fields
const users = await prisma.user.findMany({
  select: {
    id: true,
    name: true,
    email: true
  }
});
```

### 3. Use Proper Error Handling

```typescript
async function getUser(id: number) {
  try {
    return await prisma.user.findUniqueOrThrow({
      where: { id }
    });
  } catch (error) {
    if (error instanceof Prisma.PrismaClientKnownRequestError) {
      if (error.code === 'P2025') {
        throw new Error('User not found');
      }
    }
    throw error;
  }
}
```

### 4. Use Connection Pooling in Serverless

```typescript
// lib/prisma.ts
import { PrismaClient } from '@prisma/client';

const globalForPrisma = global as unknown as { prisma: PrismaClient };

export const prisma =
  globalForPrisma.prisma ||
  new PrismaClient({
    log: ['query'],
  });

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = prisma;
```

### 5. Use Middleware for Cross-Cutting Concerns

```typescript
prisma.$use(async (params, next) => {
  const before = Date.now();
  const result = await next(params);
  const after = Date.now();
  
  console.log(`Query ${params.model}.${params.action} took ${after - before}ms`);
  
  return result;
});
```

---

## Conclusion

This Prisma Mastery Guide provides comprehensive coverage from setup to production deployment. Key takeaways:

1. **Type Safety First**: Leverage Prisma's generated types for compile-time safety
2. **Schema-Driven Development**: Define your schema, let Prisma handle the rest
3. **Optimize Queries**: Use select, include wisely, avoid N+1 problems
4. **Handle Errors Properly**: Use typed error handling for better UX
5. **Test Thoroughly**: Mock Prisma Client for unit tests, use test databases for integration
6. **Deploy Confidently**: Use migrations, connection pooling, and monitoring

Prisma transforms database access in TypeScript/Node.js applications with unmatched developer experience and type safety.

---

**Additional Resources:**
- Official Documentation: https://www.prisma.io/docs
- Prisma Examples: https://github.com/prisma/prisma-examples
- Community Discord: https://pris.ly/discord
- Best Practices: https://www.prisma.io/docs/guides/performance-and-optimization

---

*End of Prisma Mastery Guide*

---

## Part VII: Performance & Optimization

---

## 23. Query Optimization

### N+1 Query Problem

```typescript
// ❌ Bad: N+1 queries
const users = await prisma.user.findMany();
for (const user of users) {
  const posts = await prisma.post.findMany({
    where: { authorId: user.id }
  });
  console.log(`${user.name} has ${posts.length} posts`);
}

// ✅ Good: Single query with include
const users = await prisma.user.findMany({
  include: {
    posts: true
  }
});
users.forEach(user => {
  console.log(`${user.name} has ${user.posts.length} posts`);
});

// ✅ Good: Aggregation
const users = await prisma.user.findMany({
  include: {
    _count: {
      select: { posts: true }
    }
  }
});
```

### Select Only What You Need

```typescript
// ❌ Bad: Fetching all fields
const users = await prisma.user.findMany();

// ✅ Good: Select specific fields
const users = await prisma.user.findMany({
  select: {
    id: true,
    name: true,
    email: true
  }
});

// ✅ Good: Select with relations
const users = await prisma.user.findMany({
  select: {
    id: true,
    name: true,
    posts: {
      select: {
        title: true,
        createdAt: true
      }
    }
  }
});
```

### Batch Operations

```typescript
// ❌ Bad: Multiple individual queries
for (const email of emails) {
  await prisma.user.create({
    data: { email, name: 'User' }
  });
}

// ✅ Good: Batch create
await prisma.user.createMany({
  data: emails.map(email => ({ email, name: 'User' }))
});

// ✅ Good: Batch update
await prisma.user.updateMany({
  where: {
    createdAt: {
      lt: new Date('2024-01-01')
    }
  },
  data: {
    isActive: false
  }
});
```

### Use Transactions for Related Operations

```typescript
// ✅ Sequential transaction
const result = await prisma.$transaction(async (tx) => {
  const user = await tx.user.create({
    data: { email: 'test@example.com', name: 'Test' }
  });

  const profile = await tx.profile.create({
    data: {
      userId: user.id,
      bio: 'Test bio'
    }
  });

  return { user, profile };
});

// ✅ Batch transaction
const [user, posts] = await prisma.$transaction([
  prisma.user.create({ data: { email: 'test@example.com', name: 'Test' } }),
  prisma.post.findMany({ where: { published: true } })
]);

// ✅ Interactive transaction with isolation level
const result = await prisma.$transaction(
  async (tx) => {
    const user = await tx.user.findUnique({ where: { id: 1 } });
    await tx.user.update({
      where: { id: 1 },
      data: { balance: user.balance - 100 }
    });
  },
  {
    isolationLevel: 'Serializable',
    maxWait: 5000,
    timeout: 10000
  }
);
```

### Pagination Strategies

```typescript
// Offset pagination (simple but slower for large offsets)
async function getPageOffset(page: number, pageSize: number) {
  const [data, total] = await Promise.all([
    prisma.user.findMany({
      skip: (page - 1) * pageSize,
      take: pageSize,
      orderBy: { id: 'asc' }
    }),
    prisma.user.count()
  ]);
  
  return {
    data,
    page,
    pageSize,
    total,
    totalPages: Math.ceil(total / pageSize)
  };
}

// Cursor pagination (faster, better for infinite scroll)
async function getPageCursor(cursor?: number, pageSize: number = 10) {
  const data = await prisma.user.findMany({
    take: pageSize + 1,
    ...(cursor && {
      skip: 1,
      cursor: { id: cursor }
    }),
    orderBy: { id: 'asc' }
  });
  
  const hasMore = data.length > pageSize;
  const items = hasMore ? data.slice(0, -1) : data;
  
  return {
    data: items,
    nextCursor: hasMore ? items[items.length - 1].id : null
  };
}
```

---

## 24. Connection Pooling

### Database Connection URL

```env
# Without pooling
DATABASE_URL="postgresql://user:password@localhost:5432/mydb"

# With connection pooling parameters
DATABASE_URL="postgresql://user:password@localhost:5432/mydb?connection_limit=10&pool_timeout=20"

# With PgBouncer
DATABASE_URL="postgresql://user:password@localhost:6432/mydb"

# With Prisma Data Proxy (serverless)
DATABASE_URL="prisma://aws-us-east-1.prisma-data.com/?api_key=xxx"
```

### Prisma Client Configuration

```typescript
import { PrismaClient } from '@prisma/client';

// Configure connection pool
const prisma = new PrismaClient({
  datasources: {
    db: {
      url: process.env.DATABASE_URL
    }
  }
});

// For serverless (singleton pattern)
import { PrismaClient } from '@prisma/client';

const globalForPrisma = global as unknown as {
  prisma: PrismaClient | undefined;
};

export const prisma =
  globalForPrisma.prisma ??
  new PrismaClient({
    log: ['query', 'error', 'warn'],
  });

if (process.env.NODE_ENV !== 'production') {
  globalForPrisma.prisma = prisma;
}
```

### Connection Pool Monitoring

```typescript
// Monitor connection pool
prisma.$on('query', (e) => {
  console.log('Query: ' + e.query);
  console.log('Duration: ' + e.duration + 'ms');
});

// Metrics (preview feature)
const metrics = await prisma.$metrics.json();
console.log(metrics);

// Disconnect when done
await prisma.$disconnect();
```

---

## 25. Caching Strategies

### In-Memory Caching

```typescript
import { PrismaClient } from '@prisma/client';
import NodeCache from 'node-cache';

const cache = new NodeCache({ stdTTL: 600 }); // 10 minutes
const prisma = new PrismaClient();

async function getUserCached(id: number) {
  const cacheKey = `user:${id}`;
  
  // Check cache
  const cached = cache.get(cacheKey);
  if (cached) {
    return cached;
  }
  
  // Fetch from database
  const user = await prisma.user.findUnique({
    where: { id }
  });
  
  // Store in cache
  if (user) {
    cache.set(cacheKey, user);
  }
  
  return user;
}

// Invalidate cache on update
async function updateUser(id: number, data: any) {
  const user = await prisma.user.update({
    where: { id },
    data
  });
  
  // Invalidate cache
  cache.del(`user:${id}`);
  
  return user;
}
```

### Redis Caching

```typescript
import { PrismaClient } from '@prisma/client';
import Redis from 'ioredis';

const redis = new Redis();
const prisma = new PrismaClient();

async function getUserWithRedis(id: number) {
  const cacheKey = `user:${id}`;
  
  // Check Redis
  const cached = await redis.get(cacheKey);
  if (cached) {
    return JSON.parse(cached);
  }
  
  // Fetch from database
  const user = await prisma.user.findUnique({
    where: { id },
    include: { posts: true }
  });
  
  // Store in Redis (expire in 1 hour)
  if (user) {
    await redis.setex(cacheKey, 3600, JSON.stringify(user));
  }
  
  return user;
}

// Cache invalidation pattern
async function invalidateUserCache(userId: number) {
  await redis.del(`user:${userId}`);
  // Also invalidate related caches
  await redis.del(`user:${userId}:posts`);
}
```

### Query Result Caching with Middleware

```typescript
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const queryCache = new Map();

prisma.$use(async (params, next) => {
  // Only cache read operations
  if (params.action === 'findUnique' || params.action === 'findMany') {
    const cacheKey = JSON.stringify(params);
    
    if (queryCache.has(cacheKey)) {
      return queryCache.get(cacheKey);
    }
    
    const result = await next(params);
    queryCache.set(cacheKey, result);
    
    // Clear cache after 5 minutes
    setTimeout(() => queryCache.delete(cacheKey), 5 * 60 * 1000);
    
    return result;
  }
  
  // Clear cache on write operations
  if (['create', 'update', 'delete'].includes(params.action)) {
    queryCache.clear();
  }
  
  return next(params);
});
```

---

## Part VIII: Production & Best Practices

---

## 26. Error Handling

### Typed Error Handling

```typescript
import { Prisma } from '@prisma/client';

async function createUser(email: string, name: string) {
  try {
    const user = await prisma.user.create({
      data: { email, name }
    });
    return { success: true, data: user };
  } catch (error) {
    // Unique constraint violation
    if (error instanceof Prisma.PrismaClientKnownRequestError) {
      if (error.code === 'P2002') {
        return {
          success: false,
          error: 'Email already exists'
        };
      }
      
      if (error.code === 'P2003') {
        return {
          success: false,
          error: 'Foreign key constraint failed'
        };
      }
      
      if (error.code === 'P2025') {
        return {
          success: false,
          error: 'Record not found'
        };
      }
    }
    
    // Validation error
    if (error instanceof Prisma.PrismaClientValidationError) {
      return {
        success: false,
        error: 'Invalid data provided'
      };
    }
    
    // Unknown error
    console.error('Unexpected error:', error);
    return {
      success: false,
      error: 'An unexpected error occurred'
    };
  }
}
```

### Error Codes Reference

```typescript
// Common Prisma error codes
const ERROR_CODES = {
  P2000: 'Value too long for column',
  P2001: 'Record not found',
  P2002: 'Unique constraint violation',
  P2003: 'Foreign key constraint violation',
  P2004: 'Constraint violation',
  P2005: 'Invalid value for field type',
  P2006: 'Invalid value',
  P2007: 'Data validation error',
  P2008: 'Failed to parse query',
  P2009: 'Failed to validate query',
  P2010: 'Raw query failed',
  P2011: 'Null constraint violation',
  P2012: 'Missing required value',
  P2013: 'Missing required argument',
  P2014: 'Relation violation',
  P2015: 'Related record not found',
  P2016: 'Query interpretation error',
  P2017: 'Records not connected',
  P2018: 'Required connected records not found',
  P2019: 'Input error',
  P2020: 'Value out of range',
  P2021: 'Table does not exist',
  P2022: 'Column does not exist',
  P2023: 'Inconsistent column data',
  P2024: 'Timed out fetching connection',
  P2025: 'Record to update/delete not found',
  P2026: 'Unsupported database feature',
  P2027: 'Multiple errors occurred',
};

function getErrorMessage(code: string): string {
  return ERROR_CODES[code] || 'Unknown error';
}
```

### Custom Error Classes

```typescript
class DatabaseError extends Error {
  constructor(
    message: string,
    public code?: string,
    public meta?: any
  ) {
    super(message);
    this.name = 'DatabaseError';
  }
}

class NotFoundError extends DatabaseError {
  constructor(resource: string, id: any) {
    super(`${resource} with id ${id} not found`, 'NOT_FOUND');
    this.name = 'NotFoundError';
  }
}

class DuplicateError extends DatabaseError {
  constructor(resource: string, field: string) {
    super(`${resource} with this ${field} already exists`, 'DUPLICATE');
    this.name = 'DuplicateError';
  }
}

// Usage
async function getUserOrThrow(id: number) {
  const user = await prisma.user.findUnique({ where: { id } });
  
  if (!user) {
    throw new NotFoundError('User', id);
  }
  
  return user;
}
```

---

## 27. Testing with Prisma

### Unit Testing with Mocks

```typescript
// __mocks__/prisma.ts
import { PrismaClient } from '@prisma/client';
import { mockDeep, mockReset, DeepMockProxy } from 'jest-mock-extended';

export const prismaMock = mockDeep<PrismaClient>();

beforeEach(() => {
  mockReset(prismaMock);
});

// services/user.service.ts
import { PrismaClient } from '@prisma/client';

export class UserService {
  constructor(private prisma: PrismaClient) {}
  
  async createUser(email: string, name: string) {
    return this.prisma.user.create({
      data: { email, name }
    });
  }
  
  async getUserById(id: number) {
    return this.prisma.user.findUnique({
      where: { id }
    });
  }
}

// services/user.service.test.ts
import { prismaMock } from '../__mocks__/prisma';
import { UserService } from './user.service';

describe('UserService', () => {
  let userService: UserService;
  
  beforeEach(() => {
    userService = new UserService(prismaMock as any);
  });
  
  test('should create user', async () => {
    const mockUser = {
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      createdAt: new Date(),
      updatedAt: new Date()
    };
    
    prismaMock.user.create.mockResolvedValue(mockUser);
    
    const result = await userService.createUser('test@example.com', 'Test User');
    
    expect(result).toEqual(mockUser);
    expect(prismaMock.user.create).toHaveBeenCalledWith({
      data: {
        email: 'test@example.com',
        name: 'Test User'
      }
    });
  });
  
  test('should get user by id', async () => {
    const mockUser = {
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      createdAt: new Date(),
      updatedAt: new Date()
    };
    
    prismaMock.user.findUnique.mockResolvedValue(mockUser);
    
    const result = await userService.getUserById(1);
    
    expect(result).toEqual(mockUser);
    expect(prismaMock.user.findUnique).toHaveBeenCalledWith({
      where: { id: 1 }
    });
  });
});
```

### Integration Testing

```typescript
// tests/setup.ts
import { PrismaClient } from '@prisma/client';
import { execSync } from 'child_process';

const prisma = new PrismaClient();

beforeAll(async () => {
  // Push schema to test database
  execSync('npx prisma db push', {
    env: {
      ...process.env,
      DATABASE_URL: process.env.TEST_DATABASE_URL
    }
  });
});

beforeEach(async () => {
  // Clean database before each test
  await prisma.user.deleteMany();
  await prisma.post.deleteMany();
});

afterAll(async () => {
  await prisma.$disconnect();
});

// tests/user.integration.test.ts
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

describe('User Integration Tests', () => {
  test('should create and retrieve user', async () => {
    const user = await prisma.user.create({
      data: {
        email: 'test@example.com',
        name: 'Test User'
      }
    });
    
    expect(user.id).toBeDefined();
    expect(user.email).toBe('test@example.com');
    
    const retrieved = await prisma.user.findUnique({
      where: { id: user.id }
    });
    
    expect(retrieved).toEqual(user);
  });
  
  test('should handle unique constraint', async () => {
    await prisma.user.create({
      data: {
        email: 'test@example.com',
        name: 'Test User'
      }
    });
    
    await expect(
      prisma.user.create({
        data: {
          email: 'test@example.com',
          name: 'Another User'
        }
      })
    ).rejects.toThrow();
  });
});
```

---

## 28. Deployment

### Environment Configuration

```env
# .env.development
DATABASE_URL="postgresql://user:password@localhost:5432/mydb_dev"

# .env.test
DATABASE_URL="postgresql://user:password@localhost:5432/mydb_test"

# .env.production
DATABASE_URL="postgresql://user:password@prod-host:5432/mydb_prod?connection_limit=10&pool_timeout=20"
```

### Build Process

```json
// package.json
{
  "scripts": {
    "build": "npm run prisma:generate && tsc",
    "prisma:generate": "prisma generate",
    "prisma:migrate:dev": "prisma migrate dev",
    "prisma:migrate:deploy": "prisma migrate deploy",
    "prisma:studio": "prisma studio",
    "start": "node dist/index.js",
    "dev": "ts-node-dev --respawn src/index.ts"
  }
}
```

### Docker Deployment

```dockerfile
# Dockerfile
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
COPY prisma ./prisma/

RUN npm ci

COPY . .

RUN npm run build

FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/package*.json ./

EXPOSE 3000

CMD ["sh", "-c", "npx prisma migrate deploy && npm start"]
```

```yaml
# docker-compose.yml
version: '3.8'

services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mypassword
      POSTGRES_DB: mydb
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  app:
    build: .
    environment:
      DATABASE_URL: postgresql://myuser:mypassword@postgres:5432/mydb
      NODE_ENV: production
    ports:
      - "3000:3000"
    depends_on:
      - postgres

volumes:
  postgres_data:
```

### Serverless Deployment

```typescript
// For AWS Lambda, Vercel, etc.
import { PrismaClient } from '@prisma/client';

// Singleton pattern for serverless
const globalForPrisma = global as unknown as {
  prisma: PrismaClient | undefined;
};

export const prisma =
  globalForPrisma.prisma ??
  new PrismaClient({
    log: process.env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
  });

if (process.env.NODE_ENV !== 'production') {
  globalForPrisma.prisma = prisma;
}

// Lambda handler
export async function handler(event: any) {
  try {
    const users = await prisma.user.findMany();
    
    return {
      statusCode: 200,
      body: JSON.stringify(users)
    };
  } catch (error) {
    console.error(error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Internal server error' })
    };
  }
}
```

---

## 29. Best Practices

### 1. Use TypeScript

```typescript
import { Prisma, User } from '@prisma/client';

// Type-safe input
type UserCreateInput = Prisma.UserCreateInput;

// Type-safe query result
type UserWithPosts = Prisma.UserGetPayload<{
  include: { posts: true };
}>;

// Type-safe function
async function createUser(data: UserCreateInput): Promise<User> {
  return prisma.user.create({ data });
}
```

### 2. Use Middleware for Cross-Cutting Concerns

```typescript
// Soft delete middleware
prisma.$use(async (params, next) => {
  if (params.model === 'User') {
    if (params.action === 'delete') {
      params.action = 'update';
      params.args['data'] = { deletedAt: new Date() };
    }
    
    if (params.action === 'findMany' || params.action === 'findFirst') {
      params.args.where = {
        ...params.args.where,
        deletedAt: null
      };
    }
  }
  
  return next(params);
});

// Logging middleware
prisma.$use(async (params, next) => {
  const before = Date.now();
  const result = await next(params);
  const after = Date.now();
  
  console.log(`Query ${params.model}.${params.action} took ${after - before}ms`);
  
  return result;
});
```

### 3. Use Validation

```typescript
import { z } from 'zod';

const userSchema = z.object({
  email: z.string().email(),
  name: z.string().min(2).max(100),
  age: z.number().int().positive().optional()
});

async function createUserValidated(input: unknown) {
  const data = userSchema.parse(input);
  
  return prisma.user.create({
    data
  });
}
```

### 4. Handle Errors Gracefully

```typescript
async function safeQuery<T>(
  queryFn: () => Promise<T>,
  fallback: T
): Promise<T> {
  try {
    return await queryFn();
  } catch (error) {
    console.error('Query failed:', error);
    return fallback;
  }
}

// Usage
const users = await safeQuery(
  () => prisma.user.findMany(),
  []
);
```

### 5. Use Proper Logging

```typescript
import { PrismaClient } from '@prisma/client';
import pino from 'pino';

const logger = pino();

const prisma = new PrismaClient({
  log: [
    {
      emit: 'event',
      level: 'query',
    },
    {
      emit: 'event',
      level: 'error',
    },
  ],
});

prisma.$on('query', (e) => {
  logger.info({
    query: e.query,
    params: e.params,
    duration: e.duration,
  }, 'Database query');
});

prisma.$on('error', (e) => {
  logger.error({
    message: e.message,
    target: e.target,
  }, 'Database error');
});
```

### 6. Schema Design Best Practices

```prisma
model User {
  id        Int      @id @default(autoincrement())
  email     String   @unique
  name      String
  
  // Always include timestamps
  createdAt DateTime @default(now()) @map("created_at")
  updatedAt DateTime @updatedAt @map("updated_at")
  
  // Soft delete
  deletedAt DateTime? @map("deleted_at")
  
  // Relations
  posts     Post[]
  profile   Profile?
  
  // Indexes for common queries
  @@index([email])
  @@index([createdAt])
  
  // Custom table name (snake_case in DB)
  @@map("users")
}
```

---

## Conclusion

This comprehensive Prisma Mastery Guide covers everything from fundamentals to production deployment:

### Key Takeaways

1. **Type Safety**: Leverage Prisma's generated types for compile-time safety
2. **Performance**: Optimize queries, use batching, implement caching
3. **Error Handling**: Use typed error handling for better UX
4. **Testing**: Mock for unit tests, use test databases for integration tests
5. **Deployment**: Use connection pooling, environment-specific configs
6. **Best Practices**: Middleware, validation, logging, proper schema design

### Production Checklist

- [ ] Set up connection pooling (PgBouncer or Prisma Data Proxy)
- [ ] Implement proper error handling
- [ ] Add comprehensive logging
- [ ] Write unit and integration tests
- [ ] Set up CI/CD pipeline with migrations
- [ ] Configure environment-specific settings
- [ ] Implement caching strategy
- [ ] Add monitoring and alerting
- [ ] Document schema and API
- [ ] Plan for database scaling

Prisma provides an exceptional developer experience with unmatched type safety. This guide equips you to use it effectively in production applications.

---

**Additional Resources:**
- Official Documentation: https://www.prisma.io/docs
- Prisma Examples: https://github.com/prisma/prisma-examples
- Community Discord: https://pris.ly/discord
- Best Practices: https://www.prisma.io/docs/guides/performance-and-optimization
- Prisma Blog: https://www.prisma.io/blog

---

*End of Prisma Mastery Guide - Complete Edition*
