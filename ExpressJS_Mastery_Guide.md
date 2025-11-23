# The Complete Express.js Mastery Guide
## From Zero to Expert: Deep Dive into Node.js Web Framework

**Version**: 3.0 (Ultra Deep Dive Edition)  
**Last Updated**: 2025  
**Target Audience**: Developers seeking mastery-level understanding of Express.js

---

## Table of Contents

### Part I: Fundamentals & Core Concepts
1. [Express Philosophy & Mental Model](#1-express-philosophy--mental-model)
2. [Environment Setup & Project Structure](#2-environment-setup--project-structure)
3. [Request-Response Cycle Deep Dive](#3-request-response-cycle-deep-dive)
4. [Routing: The Complete Guide](#4-routing-the-complete-guide)
5. [Middleware Architecture](#5-middleware-architecture)

### Part II: Request & Response Handling
6. [Request Object Deep Dive](#6-request-object-deep-dive)
7. [Response Object Deep Dive](#7-response-object-deep-dive)
8. [Template Engines](#8-template-engines)
9. [Static File Serving](#9-static-file-serving)

### Part III: Advanced Middleware
10. [Built-in Middleware](#10-built-in-middleware)
11. [Third-Party Middleware](#11-third-party-middleware)
12. [Custom Middleware Patterns](#12-custom-middleware-patterns)
13. [Error Handling Middleware](#13-error-handling-middleware)

### Part IV: Database Integration
14. [MongoDB & Mongoose](#14-mongodb--mongoose)
15. [SQL Databases (PostgreSQL, MySQL)](#15-sql-databases)
16. [ORMs & Query Builders](#16-orms--query-builders)

### Part V: Authentication & Security
17. [Authentication Strategies](#17-authentication-strategies)
18. [JWT & Session Management](#18-jwt--session-management)
19. [Security Best Practices](#19-security-best-practices)
20. [OAuth & Third-Party Auth](#20-oauth--third-party-auth)

### Part VI: Advanced Patterns
21. [REST API Design](#21-rest-api-design)
22. [GraphQL with Express](#22-graphql-with-express)
23. [WebSockets & Real-time](#23-websockets--real-time)
24. [File Uploads & Processing](#24-file-uploads--processing)
25. [Caching Strategies](#25-caching-strategies)

### Part VII: Testing & Production
26. [Testing Express Applications](#26-testing-express-applications)
27. [Performance Optimization](#27-performance-optimization)
28. [Deployment & DevOps](#28-deployment--devops)
29. [Monitoring & Logging](#29-monitoring--logging)
30. [Microservices Architecture](#30-microservices-architecture)

---

## Part I: Fundamentals & Core Concepts

---

## 1. Express Philosophy & Mental Model

### What is Express.js?

Express.js is a **minimal, unopinionated, and flexible** Node.js web application framework. Let's break this down:

**Minimal**: Express provides only the essential features needed for web applications. It's not a full-stack framework like Django or Rails.

**Unopinionated**: Express doesn't force you into a specific structure or way of doing things. You have complete freedom.

**Flexible**: You can build anything from simple APIs to complex web applications.

```javascript
// This is all you need for a basic server
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
```

### The Express Philosophy

1. **Middleware-based**: Everything in Express is middleware. The request flows through a chain of middleware functions.

2. **HTTP abstraction**: Express wraps Node.js's http module, making it easier to work with requests and responses.

3. **Routing**: Clean, intuitive routing system for organizing your application logic.

4. **Performance**: Thin wrapper over Node.js with minimal overhead.

### How Express Differs from Plain Node.js

**Plain Node.js HTTP Server:**

```javascript
const http = require('http');

const server = http.createServer((req, res) => {
  if (req.url === '/' && req.method === 'GET') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello World');
  } else if (req.url === '/api/users' && req.method === 'GET') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ users: [] }));
  } else if (req.url === '/api/users' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => {
      body += chunk.toString();
    });
    req.on('end', () => {
      const data = JSON.parse(body);
      res.writeHead(201, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ success: true, data }));
    });
  } else {
    res.writeHead(404);
    res.end('Not Found');
  }
});

server.listen(3000);
```

**Express Equivalent:**

```javascript
const express = require('express');
const app = express();

app.use(express.json()); // Parse JSON bodies

app.get('/', (req, res) => {
  res.send('Hello World');
});

app.get('/api/users', (req, res) => {
  res.json({ users: [] });
});

app.post('/api/users', (req, res) => {
  const data = req.body;
  res.status(201).json({ success: true, data });
});

// 404 handler
app.use((req, res) => {
  res.status(404).send('Not Found');
});

app.listen(3000);
```

**Benefits of Express:**
- Much cleaner and more readable
- Built-in JSON parsing
- Elegant routing
- Response helpers (`res.json()`, `res.send()`, etc.)
- Automatic content-type headers

### The Middleware Stack Concept

Express is fundamentally a series of middleware function calls. Think of it as a pipeline:

```
Request → Middleware 1 → Middleware 2 → Route Handler → Middleware 3 → Response
```

```javascript
const express = require('express');
const app = express();

// Middleware 1: Logger
app.use((req, res, next) => {
  console.log(`${req.method} ${req.url}`);
  next(); // Pass to next middleware
});

// Middleware 2: Add timestamp
app.use((req, res, next) => {
  req.timestamp = Date.now();
  next();
});

// Route Handler
app.get('/', (req, res) => {
  res.send(`Request received at ${req.timestamp}`);
});

app.listen(3000);
```

**Key Concepts:**
- Middleware functions have access to `req`, `res`, and `next`
- `next()` passes control to the next middleware
- Middleware executes in the order it's defined
- If you don't call `next()`, the chain stops

---

## 2. Environment Setup & Project Structure

### Initial Setup

**Prerequisites:**
- Node.js (v18+ recommended)
- npm or yarn
- A code editor (VS Code recommended)

**Create a New Project:**

```bash
# Create project directory
mkdir my-express-app
cd my-express-app

# Initialize npm
npm init -y

# Install Express
npm install express

# Install development dependencies
npm install --save-dev nodemon
```

### Essential Dependencies

```bash
# Core
npm install express

# Environment variables
npm install dotenv

# Middleware
npm install cors helmet compression morgan

# Database (choose based on your needs)
npm install mongoose              # MongoDB
npm install pg sequelize           # PostgreSQL
npm install mysql2 sequelize       # MySQL

# Authentication
npm install bcryptjs jsonwebtoken passport

# Validation
npm install joi express-validator

# File uploads
npm install multer

# Development
npm install --save-dev nodemon eslint prettier
```

### Project Structure (Best Practices)

**Small to Medium App:**

```
my-express-app/
├── src/
│   ├── config/           # Configuration files
│   │   ├── database.js
│   │   └── env.js
│   ├── controllers/      # Route controllers
│   │   ├── auth.controller.js
│   │   └── user.controller.js
│   ├── middleware/       # Custom middleware
│   │   ├── auth.middleware.js
│   │   ├── error.middleware.js
│   │   └── validation.middleware.js
│   ├── models/          # Database models
│   │   └── user.model.js
│   ├── routes/          # Route definitions
│   │   ├── auth.routes.js
│   │   └── user.routes.js
│   ├── services/        # Business logic
│   │   └── user.service.js
│   ├── utils/           # Utility functions
│   │   ├── logger.js
│   │   └── helpers.js
│   ├── validations/     # Validation schemas
│   │   └── user.validation.js
│   └── app.js           # Express app setup
├── tests/               # Test files
├── public/              # Static files
├── .env                 # Environment variables
├── .gitignore
├── package.json
└── server.js            # Entry point
```

**Large Enterprise App:**

```
my-express-app/
├── src/
│   ├── api/
│   │   ├── v1/
│   │   │   ├── auth/
│   │   │   │   ├── auth.controller.js
│   │   │   │   ├── auth.service.js
│   │   │   │   ├── auth.routes.js
│   │   │   │   ├── auth.validation.js
│   │   │   │   └── auth.test.js
│   │   │   ├── users/
│   │   │   │   ├── user.controller.js
│   │   │   │   ├── user.service.js
│   │   │   │   ├── user.routes.js
│   │   │   │   ├── user.model.js
│   │   │   │   └── user.test.js
│   │   │   └── index.js
│   │   └── v2/
│   ├── config/
│   ├── database/
│   │   ├── migrations/
│   │   ├── seeders/
│   │   └── connection.js
│   ├── middleware/
│   ├── shared/
│   │   ├── constants/
│   │   ├── enums/
│   │   └── types/
│   ├── utils/
│   └── app.js
├── tests/
│   ├── integration/
│   └── unit/
├── docs/
├── scripts/
└── server.js
```

### Essential Configuration Files

**package.json:**

```json
{
  "name": "my-express-app",
  "version": "1.0.0",
  "description": "Express.js application",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js",
    "test": "jest --coverage",
    "lint": "eslint .",
    "format": "prettier --write ."
  },
  "keywords": ["express", "api"],
  "author": "",
  "license": "MIT",
  "dependencies": {
    "express": "^4.18.2"
  },
  "devDependencies": {
    "nodemon": "^3.0.1"
  }
}
```

**.env:**

```env
# Server
NODE_ENV=development
PORT=3000
HOST=localhost

# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=myapp
DB_USER=postgres
DB_PASSWORD=password

# Authentication
JWT_SECRET=your-super-secret-jwt-key-change-this
JWT_EXPIRE=24h

# External APIs
API_KEY=your-api-key
```

**.gitignore:**

```
node_modules/
.env
.env.local
.env.*.local
npm-debug.log*
yarn-debug.log*
yarn-error.log*
dist/
build/
coverage/
.DS_Store
```

**server.js (Entry Point):**

```javascript
require('dotenv').config();
const app = require('./src/app');

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV}`);
});
```

**src/app.js (Application Setup):**

```javascript
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');

const app = express();

// Middleware
app.use(helmet()); // Security headers
app.use(cors()); // Enable CORS
app.use(morgan('dev')); // Logging
app.use(express.json()); // Parse JSON bodies
app.use(express.urlencoded({ extended: true })); // Parse URL-encoded bodies

// Routes
app.use('/api/v1/auth', require('./routes/auth.routes'));
app.use('/api/v1/users', require('./routes/user.routes'));

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date() });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(err.status || 500).json({
    error: {
      message: err.message,
      ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
    }
  });
});

module.exports = app;
```

---

## 3. Request-Response Cycle Deep Dive

### The Complete Flow

When a client makes a request to an Express server, here's what happens:

```
1. Client sends HTTP request
   ↓
2. Node.js receives request
   ↓
3. Express parses request
   ↓
4. Request enters middleware stack
   ↓
5. Middleware functions execute (logging, parsing, auth, etc.)
   ↓
6. Router matches route
   ↓
7. Route handler executes
   ↓
8. Response is sent back
   ↓
9. Client receives response
```

### Detailed Example

```javascript
const express = require('express');
const app = express();

// Step 1: Global middleware - executes for ALL requests
app.use((req, res, next) => {
  console.log('1. Request received');
  console.log(`   Method: ${req.method}`);
  console.log(`   URL: ${req.url}`);
  next();
});

// Step 2: Body parsing middleware
app.use(express.json());
app.use((req, res, next) => {
  console.log('2. Body parsed');
  if (req.body) console.log(`   Body:`, req.body);
  next();
});

// Step 3: Route-specific middleware
const validateUser = (req, res, next) => {
  console.log('3. Validating user data');
  if (!req.body.name) {
    return res.status(400).json({ error: 'Name is required' });
  }
  next();
};

// Step 4: Route handler
app.post('/api/users', validateUser, (req, res) => {
  console.log('4. Route handler executing');
  const user = {
    id: Date.now(),
    name: req.body.name
  };
  console.log('5. Sending response');
  res.status(201).json(user);
});

// Step 5: Error handling
app.use((err, req, res, next) => {
  console.error('Error occurred:', err.message);
  res.status(500).json({ error: 'Something went wrong' });
});

app.listen(3000);
```

**Test this with:**

```bash
curl -X POST http://localhost:3000/api/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John"}'
```

**Console Output:**
```
1. Request received
   Method: POST
   URL: /api/users
2. Body parsed
   Body: { name: 'John' }
3. Validating user data
4. Route handler executing
5. Sending response
```

### Understanding `next()`

The `next()` function is crucial in Express. It controls the flow:

```javascript
// 1. Call next() with no arguments - continue to next middleware
app.use((req, res, next) => {
  console.log('Middleware 1');
  next(); // Go to next middleware
});

// 2. Pass error to next() - skip to error handler
app.use((req, res, next) => {
  const error = new Error('Something went wrong');
  next(error); // Skip all normal middleware, go to error handler
});

// 3. Don't call next() - stop the chain
app.use((req, res, next) => {
  res.send('Response sent, chain ends here');
  // No next() call - subsequent middleware won't execute
});

// 4. Pass 'route' to skip remaining route handlers
app.get('/user/:id', 
  (req, res, next) => {
    if (req.params.id === '0') {
      next('route'); // Skip to next route
    } else {
      next(); // Continue to next handler
    }
  },
  (req, res) => {
    res.send('Regular user');
  }
);

app.get('/user/:id', (req, res) => {
  res.send('Special route for id 0');
});
```

### Request Object Properties

The `req` object represents the HTTP request and has many useful properties:

```javascript
app.get('/demo', (req, res) => {
  console.log({
    // URL properties
    originalUrl: req.originalUrl,    // '/api/users?sort=name'
    path: req.path,                  // '/api/users'
    query: req.query,                // { sort: 'name' }
    params: req.params,              // { id: '123' } from /users/:id
    
    // HTTP properties
    method: req.method,              // 'GET'
    protocol: req.protocol,          // 'http' or 'https'
    hostname: req.hostname,          // 'localhost'
    ip: req.ip,                      // '::1'
    
    // Headers
    headers: req.headers,            // All headers as object
    get: req.get('Content-Type'),    // Get specific header
    
    // Body (requires middleware)
    body: req.body,                  // Parsed body
    
    // Cookies (requires cookie-parser)
    cookies: req.cookies,
    
    // Other
    secure: req.secure,              // true if HTTPS
    xhr: req.xhr,                    // true if AJAX request
    fresh: req.fresh,                // true if cache is fresh
    stale: req.stale                 // opposite of fresh
  });
  
  res.send('Check console for request details');
});
```

### Response Object Methods

The `res` object represents the HTTP response:

```javascript
app.get('/response-demo', (req, res) => {
  // Send different types of responses
  
  // 1. Send plain text
  res.send('Hello World');
  
  // 2. Send JSON
  res.json({ message: 'Hello', user: 'John' });
  
  // 3. Send with status code
  res.status(201).json({ created: true });
  
  // 4. Send file
  res.sendFile('/path/to/file.pdf');
  
  // 5. Download file
  res.download('/path/to/file.pdf', 'myfile.pdf');
  
  // 6. Redirect
  res.redirect('/new-url');
  res.redirect(301, '/permanent-url');
  
  // 7. Render template
  res.render('index', { title: 'Home' });
  
  // 8. Set headers
  res.set('Content-Type', 'text/html');
  res.set({
    'Content-Type': 'text/plain',
    'X-Custom-Header': 'value'
  });
  
  // 9. Set cookies
  res.cookie('name', 'value', { maxAge: 900000, httpOnly: true });
  res.clearCookie('name');
  
  // 10. End response without data
  res.end();
  
  // 11. Send status only
  res.sendStatus(200); // Sends "OK"
  res.sendStatus(404); // Sends "Not Found"
});
```

### Response Status Code Best Practices

```javascript
// 2xx Success
app.post('/users', (req, res) => {
  // 200 OK - Generic success
  res.status(200).json({ user });
  
  // 201 Created - Resource created successfully
  res.status(201).json({ user });
  
  // 204 No Content - Success but no response body
  res.status(204).send();
});

// 3xx Redirection
app.get('/old-route', (req, res) => {
  // 301 Moved Permanently
  res.redirect(301, '/new-route');
  
  // 302 Found - Temporary redirect
  res.redirect(302, '/temp-route');
});

// 4xx Client Errors
app.post('/login', (req, res) => {
  // 400 Bad Request - Invalid input
  res.status(400).json({ error: 'Invalid email format' });
  
  // 401 Unauthorized - Not authenticated
  res.status(401).json({ error: 'Please log in' });
  
  // 403 Forbidden - Authenticated but not authorized
  res.status(403).json({ error: 'Access denied' });
  
  // 404 Not Found - Resource doesn't exist
  res.status(404).json({ error: 'User not found' });
  
  // 409 Conflict - Resource conflict (e.g., duplicate)
  res.status(409).json({ error: 'Email already exists' });
  
  // 422 Unprocessable Entity - Validation failed
  res.status(422).json({ 
    errors: [{ field: 'email', message: 'Invalid email' }]
  });
});

// 5xx Server Errors
app.get('/data', (req, res) => {
  // 500 Internal Server Error - Generic server error
  res.status(500).json({ error: 'Something went wrong' });
  
  // 503 Service Unavailable - Server temporarily down
  res.status(503).json({ error: 'Service maintenance' });
});
```

---

## 4. Routing: The Complete Guide

### Basic Routing

Routes define how your application responds to client requests at specific endpoints.

```javascript
const express = require('express');
const app = express();

// Basic HTTP methods
app.get('/', (req, res) => {
  res.send('GET request');
});

app.post('/', (req, res) => {
  res.send('POST request');
});

app.put('/', (req, res) => {
  res.send('PUT request');
});

app.delete('/', (req, res) => {
  res.send('DELETE request');
});

app.patch('/', (req, res) => {
  res.send('PATCH request');
});

// Handle all HTTP methods
app.all('/all', (req, res) => {
  res.send(`${req.method} request to /all`);
});
```

### Route Parameters

```javascript
// Simple parameter
app.get('/users/:userId', (req, res) => {
  const { userId } = req.params;
  res.json({ userId });
});

// Multiple parameters
app.get('/users/:userId/posts/:postId', (req, res) => {
  const { userId, postId } = req.params;
  res.json({ userId, postId });
});

// Optional parameter (with ?)
app.get('/users/:userId/posts/:postId?', (req, res) => {
  // postId might be undefined
  const { userId, postId } = req.params;
  res.json({ userId, postId: postId || 'all' });
});

// Parameter with regex pattern
app.get('/users/:userId(\\d+)', (req, res) => {
  // Only matches if userId is numeric
  res.json({ userId: req.params.userId });
});

// Custom parameter validation
app.param('userId', (req, res, next, userId) => {
  // This runs before any route with :userId parameter
  console.log('Validating userId:', userId);
  
  if (!userId.match(/^\d+$/)) {
    return res.status(400).json({ error: 'Invalid user ID' });
  }
  
  // You can attach data to req for use in route handlers
  req.user = { id: userId }; // Simulating database lookup
  next();
});

app.get('/users/:userId', (req, res) => {
  // req.user is already available from app.param
  res.json(req.user);
});
```

### Query Parameters

```javascript
// URL: /search?q=express&category=tutorial&page=2

app.get('/search', (req, res) => {
  const { q, category, page = 1 } = req.query;
  
  res.json({
    searchTerm: q,
    category: category,
    page: parseInt(page),
    query: req.query // All query params as object
  });
});

// Advanced query handling
app.get('/products', (req, res) => {
  const {
    sort = 'createdAt',
    order = 'desc',
    limit = 10,
    page = 1,
    ...filters
  } = req.query;
  
  res.json({
    pagination: { page: parseInt(page), limit: parseInt(limit) },
    sorting: { sort, order },
    filters
  });
});
```

### Express Router

For better organization, use `express.Router()` to create modular route handlers.

**routes/users.routes.js:**

```javascript
const express = require('express');
const router = express.Router();

// Middleware specific to this router
router.use((req, res, next) => {
  console.log('User routes accessed:', Date.now());
  next();
});

// Define routes
router.get('/', (req, res) => {
  res.json({ message: 'Get all users' });
});

router.get('/:id', (req, res) => {
  res.json({ message: `Get user ${req.params.id}` });
});

router.post('/', (req, res) => {
  res.status(201).json({ message: 'User created' });
});

router.put('/:id', (req, res) => {
  res.json({ message: `Update user ${req.params.id}` });
});

router.delete('/:id', (req, res) => {
  res.json({ message: `Delete user ${req.params.id}` });
});

module.exports = router;
```

**app.js:**

```javascript
const express = require('express');
const app = express();
const userRoutes = require('./routes/users.routes');

// Mount the router
app.use('/api/users', userRoutes);

app.listen(3000);
```

### Nested Routers

```javascript
// routes/api/v1/index.js
const express = require('express');
const router = express.Router();

const userRoutes = require('./users.routes');
const postRoutes = require('./posts.routes');
const commentRoutes = require('./comments.routes');

router.use('/users', userRoutes);
router.use('/posts', postRoutes);
router.use('/comments', commentRoutes);

module.exports = router;

// app.js
const apiV1 = require('./routes/api/v1');
app.use('/api/v1', apiV1);

// Now you have routes like:
// /api/v1/users
// /api/v1/posts
// /api/v1/comments
```

### Route Chainability

```javascript
// Instead of this:
app.get('/users', getUsers);
app.post('/users', createUser);
app.delete('/users', deleteUsers);

// You can chain:
app.route('/users')
  .get(getUsers)
  .post(createUser)
  .delete(deleteUsers);

// With middleware:
app.route('/users/:id')
  .all(authenticateUser) // Runs for all methods
  .get(getUser)
  .put(updateUser)
  .delete(deleteUser);
```

### Route Organization Pattern (MVC-style)

**controllers/user.controller.js:**

```javascript
// GET /api/users
exports.getAllUsers = async (req, res) => {
  try {
    const users = await User.find();
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// GET /api/users/:id
exports.getUserById = async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// POST /api/users
exports.createUser = async (req, res) => {
  try {
    const user = new User(req.body);
    await user.save();
    res.status(201).json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// PUT /api/users/:id
exports.updateUser = async (req, res) => {
  try {
    const user = await User.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true, runValidators: true }
    );
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// DELETE /api/users/:id
exports.deleteUser = async (req, res) => {
  try {
    const user = await User.findByIdAndDelete(req.params.id);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json({ message: 'User deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};
```

**routes/user.routes.js:**

```javascript
const express = require('express');
const router = express.Router();
const userController = require('../controllers/user.controller');
const { authenticate, authorize } = require('../middleware/auth.middleware');

router.get('/', userController.getAllUsers);
router.get('/:id', userController.getUserById);
router.post('/', authenticate, userController.createUser);
router.put('/:id', authenticate, userController.updateUser);
router.delete('/:id', authenticate, authorize('admin'), userController.deleteUser);

module.exports = router;
```

### Advanced Routing Patterns

**Route Wildcards:**

```javascript
// Match any route ending with 'user'
app.get('/*user', (req, res) => {
  res.send('Matched!');
});
// Matches: /admin/user, /api/user, etc.

// Match specific pattern
app.get('/api/*/users', (req, res) => {
  res.send('Users endpoint');
});
// Matches: /api/v1/users, /api/v2/users, etc.
```

**Route Regex:**

```javascript
// Match routes with regex
app.get(/.*fly$/, (req, res) => {
  res.send('Matched routes ending with fly');
});
// Matches: /butterfly, /dragonfly

// Capturing groups
app.get(/^\/users\/(\d+)$/, (req, res) => {
  const userId = req.params[0]; // First capture group
  res.send(`User ID: ${userId}`);
});
```

**Conditional Routes:**

```javascript
const isFeatureEnabled = (featureName) => {
  return (req, res, next) => {
    if (process.env[featureName] === 'true') {
      next();
    } else {
      res.status(404).json({ error: 'Feature not available' });
    }
  };
};

app.get('/beta-feature', 
  isFeatureEnabled('BETA_FEATURES_ENABLED'),
  (req, res) => {
    res.json({ message: 'Beta feature!' });
  }
);
```

---

## 5. Middleware Architecture

### What is Middleware?

Middleware functions are functions that have access to the request object (`req`), response object (`res`), and the next middleware function in the application's request-response cycle.

```javascript
// Basic middleware structure
function myMiddleware(req, res, next) {
  // Do something with req/res
  console.log('Middleware executed');
  
  // Call next() to pass control to next middleware
  next();
}

app.use(myMiddleware);
```

### Types of Middleware

**1. Application-level Middleware**

Bound to the app object using `app.use()` or `app.METHOD()`.

```javascript
const express = require('express');
const app = express();

// Runs for ALL requests
app.use((req, res, next) => {
  console.log('Time:', Date.now());
  next();
});

// Runs only for GET requests to /user/:id
app.get('/user/:id', (req, res, next) => {
  console.log('Request Type:', req.method);
  next();
}, (req, res) => {
  res.send('User Info');
});

// Multiple middleware for a single route
app.get('/example', 
  middleware1,
  middleware2,
  middleware3,
  finalHandler
);
```

**2. Router-level Middleware**

Works the same as application-level but bound to `express.Router()`.

```javascript
const router = express.Router();

// Router-level middleware
router.use((req, res, next) => {
  console.log('Router middleware');
  next();
});

router.get('/users', (req, res) => {
  res.send('Users list');
});

app.use('/api', router);
```

**3. Error-handling Middleware**

Has four arguments instead of three: `(err, req, res, next)`.

```javascript
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});
```

**4. Built-in Middleware**

Express has built-in middleware functions:

```javascript
// Parse JSON bodies
app.use(express.json());

// Parse URL-encoded bodies
app.use(express.urlencoded({ extended: true }));

// Serve static files
app.use(express.static('public'));

// Serve static files with virtual path
app.use('/static', express.static('public'));
```

**5. Third-party Middleware**

```javascript
const morgan = require('morgan');
const helmet = require('helmet');
const cors = require('cors');
const compression = require('compression');

// HTTP request logger
app.use(morgan('combined'));

// Security headers
app.use(helmet());

// Enable CORS
app.use(cors());

// Compress responses
app.use(compression());
```

### Middleware Execution Order

**Critical**: Middleware executes in the order it's defined!

```javascript
const express = require('express');
const app = express();

// 1. This runs first for ALL requests
app.use((req, res, next) => {
  console.log('1: Global middleware');
  next();
});

// 2. This only runs for /api/* routes
app.use('/api', (req, res, next) => {
  console.log('2: API middleware');
  next();
});

// 3. Route handler
app.get('/api/users', (req, res) => {
  console.log('3: Route handler');
  res.send('Users');
});

// 4. This never runs for successful requests
app.use((req, res, next) => {
  console.log('4: After route handler (only runs if route not found)');
  res.status(404).send('Not found');
});

// 5. Error handler (only runs if error occurred)
app.use((err, req, res, next) => {
  console.log('5: Error handler');
  res.status(500).send('Error!');
});

// Request to /api/users logs:
// 1: Global middleware
// 2: API middleware
// 3: Route handler
```

### Writing Custom Middleware

**Logger Middleware:**

```javascript
const logger = (req, res, next) => {
  const start = Date.now();
  
  // Log when response is finished
  res.on('finish', () => {
    const duration = Date.now() - start;
    console.log(`${req.method} ${req.originalUrl} - ${res.statusCode} - ${duration}ms`);
  });
  
  next();
};

app.use(logger);
```

**Authentication Middleware:**

```javascript
const authenticate = (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1];
  
  if (!token) {
    return res.status(401).json({ error: 'No token provided' });
  }
  
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded; // Attach user to request
    next();
  } catch (error) {
    return res.status(401).json({ error: 'Invalid token' });
  }
};

// Use it on protected routes
app.get('/api/profile', authenticate, (req, res) => {
  res.json({ user: req.user });
});
```

**Authorization Middleware:**

```javascript
const authorize = (...roles) => {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Not authenticated' });
    }
    
    if (!roles.includes(req.user.role)) {
      return res.status(403).json({ error: 'Not authorized' });
    }
    
    next();
  };
};

// Usage
app.delete('/api/users/:id',
  authenticate,
  authorize('admin', 'moderator'),
  deleteUser
);
```

**Validation Middleware:**

```javascript
const validateUser = (req, res, next) => {
  const { name, email, age } = req.body;
  const errors = [];
  
  if (!name || name.trim().length < 2) {
    errors.push({ field: 'name', message: 'Name must be at least 2 characters' });
  }
  
  if (!email || !email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
    errors.push({ field: 'email', message: 'Invalid email format' });
  }
  
  if (age && (age < 0 || age > 150)) {
    errors.push({ field: 'age', message: 'Age must be between 0 and 150' });
  }
  
  if (errors.length > 0) {
    return res.status(400).json({ errors });
  }
  
  next();
};

app.post('/api/users', validateUser, createUser);
```

**Rate Limiting Middleware:**

```javascript
const rateLimit = (windowMs, maxRequests) => {
  const requests = new Map();
  
  return (req, res, next) => {
    const key = req.ip;
    const now = Date.now();
    
    if (!requests.has(key)) {
      requests.set(key, []);
    }
    
    const userRequests = requests.get(key);
    
    // Remove old requests outside the window
    const validRequests = userRequests.filter(
      time => now - time < windowMs
    );
    
    if (validRequests.length >= maxRequests) {
      return res.status(429).json({
        error: 'Too many requests',
        retryAfter: Math.ceil((validRequests[0] + windowMs - now) / 1000)
      });
    }
    
    validRequests.push(now);
    requests.set(key, validRequests);
    next();
  };
};

// Allow 100 requests per 15 minutes
app.use('/api', rateLimit(15 * 60 * 1000, 100));
```

**Async Middleware Wrapper:**

```javascript
// Wrapper to handle async errors automatically
const asyncHandler = (fn) => {
  return (req, res, next) => {
    Promise.resolve(fn(req, res, next)).catch(next);
  };
};

// Usage
app.get('/api/users/:id', asyncHandler(async (req, res) => {
  const user = await User.findById(req.params.id);
  if (!user) {
    throw new Error('User not found'); // Automatically caught and passed to error handler
  }
  res.json(user);
}));
```

### Conditional Middleware

```javascript
// Only apply middleware if condition is met
const conditionalMiddleware = (condition, middleware) => {
  return (req, res, next) => {
    if (condition(req)) {
      return middleware(req, res, next);
    }
    next();
  };
};

// Usage: Only log in development
app.use(
  conditionalMiddleware(
    () => process.env.NODE_ENV === 'development',
    morgan('dev')
  )
);

// Only authenticate on production
app.use(
  conditionalMiddleware(
    () => process.env.NODE_ENV === 'production',
    authenticate
  )
);
```

### Middleware Best Practices

```javascript
// ✅ DO: Keep middleware focused and single-purpose
const logRequest = (req, res, next) => {
  console.log(`${req.method} ${req.url}`);
  next();
};

// ❌ DON'T: Create middleware that does too much
const doEverything = (req, res, next) => {
  // Logging
  console.log('Request');
  // Authentication
  if (!req.user) return res.status(401).send();
  // Validation
  if (!req.body.name) return res.status(400).send();
  // Business logic
  // ... too much responsibility
  next();
};

// ✅ DO: Handle errors properly
const goodMiddleware = (req, res, next) => {
  try {
    // Do something
    next();
  } catch (error) {
    next(error); // Pass error to error handler
  }
};

// ❌ DON'T: Swallow errors
const badMiddleware = (req, res, next) => {
  try {
    // Do something
  } catch (error) {
    console.error(error); // Error is lost!
    next();
  }
};

// ✅ DO: Always call next() or send a response
const completeMiddleware = (req, res, next) => {
  if (condition) {
    return res.send('Response'); // Chain ends
  }
  next(); // Continue to next middleware
};

// ❌ DON'T: Forget to call next() or send response
const incompleteMiddleware = (req, res, next) => {
  console.log('Logged');
  // Forgot next()! Request hangs forever
};
```


### Request Methods in Detail

**req.get(header)** - Get header value:

```javascript
app.get('/headers', (req, res) => {
  const contentType = req.get('Content-Type');
  const userAgent = req.get('User-Agent');
  const authorization = req.get('Authorization');
  
  res.json({ contentType, userAgent, authorization });
});
```

**req.accepts(types)** - Check accepted content types:

```javascript
app.get('/data', (req, res) => {
  // Client sends Accept header
  if (req.accepts('json')) {
    res.json({ data: 'JSON response' });
  } else if (req.accepts('html')) {
    res.send('<h1>HTML response</h1>');
  } else if (req.accepts('text')) {
    res.send('Text response');
  } else {
    res.status(406).send('Not Acceptable');
  }
});
```

**req.is(type)** - Check Content-Type:

```javascript
app.post('/upload', (req, res) => {
  if (req.is('application/json')) {
    // Process JSON
  } else if (req.is('multipart/form-data')) {
    // Process file upload
  } else if (req.is('application/x-www-form-urlencoded')) {
    // Process form data
  } else {
    res.status(415).send('Unsupported Media Type');
  }
});
```

### Working with Request Body

**JSON Body:**

```javascript
app.use(express.json()); // Enable JSON parsing

app.post('/api/users', (req, res) => {
  const { name, email, age } = req.body;
  
  // Validate and process
  if (!name || !email) {
    return res.status(400).json({ error: 'Name and email required' });
  }
  
  res.status(201).json({ id: 1, name, email, age });
});
```

**URL-encoded Body (Form Data):**

```javascript
app.use(express.urlencoded({ extended: true }));

app.post('/login', (req, res) => {
  const { username, password } = req.body;
  // Process login
});
```

---

## 7. Response Object Deep Dive

### Response Methods Complete Reference

```javascript
// Send responses
res.send(data)                  // Send string, buffer, object, array
res.json(data)                  // Send JSON
res.jsonp(data)                 // Send JSONP
res.sendFile(path)              // Send file
res.download(path, filename)    // Download file
res.render(view, locals)        // Render template
res.redirect([status,] path)    // Redirect
res.end()                       // End response

// Set response properties
res.status(code)                // Set status code
res.set(field, value)           // Set header
res.type(type)                  // Set Content-Type
res.cookie(name, value, options)    // Set cookie
res.clearCookie(name, options)      // Clear cookie
```

### Sending Different Response Types

**JSON:**

```javascript
app.get('/json', (req, res) => {
  res.json({
    message: 'Success',
    data: { id: 1, name: 'John' },
    timestamp: new Date()
  });
});
```

**Files:**

```javascript
const path = require('path');

app.get('/download', (req, res) => {
  const file = path.join(__dirname, 'files', 'document.pdf');
  res.download(file);
});

app.get('/view', (req, res) => {
  const file = path.join(__dirname, 'files', 'image.jpg');
  res.sendFile(file);
});
```

### Cookies

```javascript
// Setting cookies
app.get('/set-cookie', (req, res) => {
  res.cookie('user', 'john', {
    maxAge: 900000,        // 15 minutes
    httpOnly: true,        // Not accessible via JavaScript
    secure: true,          // Only sent over HTTPS
    signed: true,          // Signed cookie
    sameSite: 'strict'     // CSRF protection
  });
  
  res.send('Cookies set');
});

// Reading cookies (requires cookie-parser)
const cookieParser = require('cookie-parser');
app.use(cookieParser('secret-key'));

app.get('/get-cookie', (req, res) => {
  const user = req.signedCookies.user;
  res.json({ user });
});
```

---

## Part III: Advanced Middleware

---

## 10. Built-in Middleware

Express includes several built-in middleware functions:

### express.json()

Parses incoming requests with JSON payloads.

```javascript
app.use(express.json());

// With options
app.use(express.json({
  limit: '10mb',           // Maximum request body size
  strict: true,            // Only parse arrays and objects
  type: 'application/json' // Content-Type to parse
}));

app.post('/api/data', (req, res) => {
  console.log(req.body); // Parsed JSON object
  res.json({ received: true });
});
```

### express.urlencoded()

Parses incoming requests with URL-encoded payloads (traditional HTML forms).

```javascript
app.use(express.urlencoded({ extended: true }));

// extended: true - uses qs library (supports nested objects)
// extended: false - uses querystring library (simple)

app.post('/form', (req, res) => {
  console.log(req.body); // Parsed form data
  res.send('Form received');
});
```

**Difference between extended true and false:**

```javascript
// With extended: true
// form: user[name]=John&user[email]=john@example.com
// Becomes: { user: { name: 'John', email: 'john@example.com' } }

// With extended: false
// form: user[name]=John&user[email]=john@example.com
// Becomes: { 'user[name]': 'John', 'user[email]': 'john@example.com' }
```

### express.static()

Serves static files.

```javascript
app.use(express.static('public'));

// With options
app.use(express.static('public', {
  maxAge: '1d',           // Cache max-age
  dotfiles: 'ignore',     // How to treat dotfiles
  index: 'index.html',    // Directory index file
  setHeaders: (res, path) => {
    res.set('X-Timestamp', Date.now());
  }
}));
```

### express.raw()

Parses incoming request body as a Buffer.

```javascript
app.use(express.raw({ type: 'application/octet-stream' }));

app.post('/binary', (req, res) => {
  console.log(req.body); // Buffer
  res.send('Binary data received');
});
```

### express.text()

Parses incoming request body as a string.

```javascript
app.use(express.text({ type: 'text/plain' }));

app.post('/text', (req, res) => {
  console.log(req.body); // String
  res.send(`Received: ${req.body}`);
});
```

---

## 11. Third-Party Middleware

### CORS (Cross-Origin Resource Sharing)

```bash
npm install cors
```

```javascript
const cors = require('cors');

// Enable all CORS requests
app.use(cors());

// Configure CORS
app.use(cors({
  origin: 'https://example.com',           // Allow specific origin
  origin: ['https://example1.com', 'https://example2.com'], // Multiple origins
  origin: (origin, callback) => {          // Dynamic origin
    const allowedOrigins = ['https://example.com'];
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  methods: ['GET', 'POST', 'PUT', 'DELETE'], // Allowed methods
  allowedHeaders: ['Content-Type', 'Authorization'], // Allowed headers
  credentials: true,                       // Allow cookies
  maxAge: 3600                            // Preflight cache time
}));

// Enable CORS for specific route
app.get('/api/public', cors(), (req, res) => {
  res.json({ message: 'Public API' });
});
```

### Helmet (Security Headers)

```bash
npm install helmet
```

```javascript
const helmet = require('helmet');

// Use all default protections
app.use(helmet());

// Or customize
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'", "trusted-cdn.com"]
    }
  },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true
  }
}));
```

**What Helmet does:**
- Sets `X-DNS-Prefetch-Control`
- Sets `X-Frame-Options` (clickjacking protection)
- Sets `X-Content-Type-Options` (MIME sniffing protection)
- Sets `Strict-Transport-Security` (HTTPS enforcement)
- Sets `Content-Security-Policy`
- Removes `X-Powered-By` header

### Morgan (HTTP Logger)

```bash
npm install morgan
```

```javascript
const morgan = require('morgan');

// Predefined formats
app.use(morgan('combined')); // Apache combined format
app.use(morgan('common'));   // Apache common format
app.use(morgan('dev'));      // Colored, concise
app.use(morgan('tiny'));     // Minimal
app.use(morgan('short'));    // Shorter than default

// Custom format
app.use(morgan(':method :url :status :response-time ms'));

// Custom tokens
morgan.token('custom-id', (req) => req.id);
app.use(morgan(':custom-id :method :url'));

// Log to file
const fs = require('fs');
const path = require('path');
const accessLogStream = fs.createWriteStream(
  path.join(__dirname, 'access.log'),
  { flags: 'a' }
);
app.use(morgan('combined', { stream: accessLogStream  }));

// Conditional logging
app.use(morgan('combined', {
  skip: (req, res) => res.statusCode < 400 // Only log errors
}));
```

### Compression

```bash
npm install compression
```

```javascript
const compression = require('compression');

// Enable compression
app.use(compression());

// With options
app.use(compression({
  filter: (req, res) => {
    if (req.headers['x-no-compression']) {
      return false; // Don't compress
    }
    return compression.filter(req, res);
  },
  level: 6,  // Compression level (0-9)
  threshold: 1024  // Only compress if response > 1KB
}));
```

### Express Rate Limit

```bash
npm install express-rate-limit
```

```javascript
const rateLimit = require('express-rate-limit');

// Create limiter
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100,                 // Limit each IP to 100 requests per windowMs
  standardHeaders: true,    // Return rate limit info in headers
  legacyHeaders: false,
  message: 'Too many requests, please try again later'
});

// Apply to all requests
app.use(limiter);

// Apply to specific routes
app.use('/api/', limiter);

// Different limits for different routes
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 5,
  message: 'Too many login attempts'
});

app.post('/login', authLimiter, loginHandler);

// Custom key generator
const userLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  keyGenerator: (req) => req.user?.id || req.ip
});
```

### Express Validator

```bash
npm install express-validator
```

```javascript
const { body, validationResult } = require('express-validator');

app.post('/register',
  // Validation rules
  body('email').isEmail().normalizeEmail(),
  body('password').isLength({ min: 8 }).withMessage('Password must be at least 8 characters'),
  body('username').trim().isLength({ min: 3, max: 20 }),
  body('age').optional().isInt({ min: 0, max: 150 }),
  
  // Handle validation
  (req, res) => {
    const errors = validationResult(req);
    
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    
    // Process valid data
    res.json({ message: 'User registered successfully' });
  }
);

// Custom validators
body('email').custom(async (value) => {
  const user = await User.findOne({ email: value });
  if (user) {
    throw new Error('Email already exists');
  }
});

// Sanitization
body('name').trim().escape();
body('email').normalizeEmail();
```

### Multer (File Upload)

```bash
npm install multer
```

```javascript
const multer = require('multer');

// Memory storage
const upload = multer({ storage: multer.memoryStorage() });

// Disk storage
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
  }
});

const upload2 = multer({
  storage: storage,
  limits: {
    fileSize: 5 * 1024 * 1024 // 5MB max
  },
  fileFilter: (req, file, cb) => {
    const allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
    if (allowedTypes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('Invalid file type'));
    }
  }
});

// Single file upload
app.post('/upload', upload.single('avatar'), (req, res) => {
  // req.file contains the file
  console.log(req.file);
  res.json({ file: req.file });
});

// Multiple files
app.post('/upload-multiple', upload.array('photos', 10), (req, res) => {
  // req.files contains array of files
  console.log(req.files);
  res.json({ files: req.files });
});

// Multiple fields
app.post('/upload-fields',
  upload.fields([
    { name: 'avatar', maxCount: 1 },
    { name: 'gallery', maxCount: 8 }
  ]),
  (req, res) => {
    // req.files is an object with field names as keys
    res.json({ files: req.files });
  }
);
```

### Express Session

```bash
npm install express-session
```

```javascript
const session = require('express-session');

app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: false,
  cookie: {
    secure: true,      // Requires HTTPS
    httpOnly: true,
    maxAge: 1000 * 60 * 60 * 24 // 1 day
  },
  store: // Use a session store for production
}));

// Using sessions
app.post('/login', (req, res) => {
  req.session.userId = user.id;
  req.session.username = user.username;
  res.json({ message: 'Logged in' });
});

app.get('/profile', (req, res) => {
  if (!req.session.userId) {
    return res.status(401).json({ error: 'Not logged in' });
  }
  res.json({ userId: req.session.userId });
});

app.post('/logout', (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      return res.status(500).json({ error: 'Could not log out' });
    }
    res.json({ message: 'Logged out' });
  });
});
```

