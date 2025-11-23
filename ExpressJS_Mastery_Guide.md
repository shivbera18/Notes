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


---

## 12. Custom Middleware Patterns

### Middleware Factory Pattern

Create reusable middleware generators:

```javascript
// Middleware factory for logging
const createLogger = (options = {}) => {
  const { prefix = 'LOG', includeBody = false } = options;
  
  return (req, res, next) => {
    console.log(`[${prefix}] ${req.method} ${req.url}`);
    
    if (includeBody && req.body) {
      console.log(`[${prefix}] Body:`, req.body);
    }
    
    next();
  };
};

// Usage
app.use(createLogger({ prefix: 'API', includeBody: true }));
```

### Async Error Handler Pattern

```javascript
// Wrapper for async route handlers
const asyncHandler = (fn) => (req, res, next) => {
  Promise.resolve(fn(req, res, next)).catch(next);
};

// Usage
app.get('/users/:id', asyncHandler(async (req, res) => {
  const user = await User.findById(req.params.id);
  if (!user) throw new Error('User not found');
  res.json(user);
}));
```

### Request ID Middleware

```javascript
const { v4: uuidv4 } = require('uuid');

const requestId = (req, res, next) => {
  req.id = uuidv4();
  res.set('X-Request-ID', req.id);
  next();
};

app.use(requestId);
```

### Response Time Middleware

```javascript
const responseTime = (req, res, next) => {
  const start = process.hrtime();
  
  res.on('finish', () => {
    const [seconds, nanoseconds] = process.hrtime(start);
    const duration = seconds * 1000 + nanoseconds / 1000000;
    res.set('X-Response-Time', `${duration.toFixed(2)}ms`);
  });
  
  next();
};

app.use(responseTime);
```

### Request Timeout Middleware

```javascript
const timeout = (ms) => {
  return (req, res, next) => {
    const timer = setTimeout(() => {
      res.status(408).json({ error: 'Request timeout' });
    }, ms);
    
    res.on('finish', () => clearTimeout(timer));
    next();
  };
};

app.use(timeout(30000)); // 30 second timeout
```

### API Key Authentication Middleware

```javascript
const apiKeyAuth = (req, res, next) => {
  const apiKey = req.get('X-API-Key');
  
  if (!apiKey) {
    return res.status(401).json({ error: 'API key required' });
  }
  
  // Validate API key (check database, cache, etc.)
  if (apiKey !== process.env.API_KEY) {
    return res.status(403).json({ error: 'Invalid API key' });
  }
  
  next();
};

app.use('/api', apiKeyAuth);
```

### Request Sanitization Middleware

```javascript
const sanitize = require('express-mongo-sanitize');
const xss = require('xss-clean');

// Prevent NoSQL injection
app.use(sanitize());

// Prevent XSS attacks
app.use(xss());

// Custom sanitization
const customSanitize = (req, res, next) => {
  if (req.body) {
    Object.keys(req.body).forEach(key => {
      if (typeof req.body[key] === 'string') {
        req.body[key] = req.body[key].trim();
      }
    });
  }
  next();
};

app.use(customSanitize);
```

---

## 13. Error Handling Middleware

### Basic Error Handler

```javascript
app.use((err, req, res, next) => {
  console.error(err.stack);
  
  res.status(err.status || 500).json({
    error: {
      message: err.message,
      ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
    }
  });
});
```

### Advanced Error Handler

```javascript
class AppError extends Error {
  constructor(message, statusCode) {
    super(message);
    this.statusCode = statusCode;
    this.status = `${statusCode}`.startsWith('4') ? 'fail' : 'error';
    this.isOperational = true;
    
    Error.captureStackTrace(this, this.constructor);
  }
}

// Error handler middleware
const errorHandler = (err, req, res, next) => {
  err.statusCode = err.statusCode || 500;
  err.status = err.status || 'error';
  
  if (process.env.NODE_ENV === 'development') {
    res.status(err.statusCode).json({
      status: err.status,
      error: err,
      message: err.message,
      stack: err.stack
    });
  } else {
    // Production error response
    if (err.isOperational) {
      res.status(err.statusCode).json({
        status: err.status,
        message: err.message
      });
    } else {
      // Programming or unknown error
      console.error('ERROR 💥', err);
      res.status(500).json({
        status: 'error',
        message: 'Something went wrong'
      });
    }
  }
};

app.use(errorHandler);

// Usage
app.get('/users/:id', async (req, res, next) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      throw new AppError('User not found', 404);
    }
    res.json(user);
  } catch (err) {
    next(err);
  }
});
```

### Specific Error Handlers

```javascript
// Handle different error types
const errorHandler = (err, req, res, next) => {
  let error = { ...err };
  error.message = err.message;
  
  // Mongoose bad ObjectId
  if (err.name === 'CastError') {
    const message = 'Resource not found';
    error = new AppError(message, 404);
  }
  
  // Mongoose duplicate key
  if (err.code === 11000) {
    const message = 'Duplicate field value entered';
    error = new AppError(message, 400);
  }
  
  // Mongoose validation error
  if (err.name === 'ValidationError') {
    const message = Object.values(err.errors).map(e => e.message).join(', ');
    error = new AppError(message, 400);
  }
  
  // JWT errors
  if (err.name === 'JsonWebTokenError') {
    const message = 'Invalid token';
    error = new AppError(message, 401);
  }
  
  if (err.name === 'TokenExpiredError') {
    const message = 'Token expired';
    error = new AppError(message, 401);
  }
  
  res.status(error.statusCode || 500).json({
    status: error.status || 'error',
    message: error.message || 'Server Error'
  });
};
```

### 404 Handler

```javascript
// Must be after all other routes
app.use((req, res, next) => {
  res.status(404).json({
    status: 'fail',
    message: `Cannot find ${req.originalUrl} on this server`
  });
});
```

### Unhandled Rejection Handler

```javascript
// In server.js
const server = app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

process.on('unhandledRejection', (err) => {
  console.log('UNHANDLED REJECTION! 💥 Shutting down...');
  console.log(err.name, err.message);
  server.close(() => {
    process.exit(1);
  });
});

process.on('uncaughtException', (err) => {
  console.log('UNCAUGHT EXCEPTION! 💥 Shutting down...');
  console.log(err.name, err.message);
  process.exit(1);
});
```

---

## Part IV: Database Integration

---

## 14. MongoDB & Mongoose

### Setup and Connection

```bash
npm install mongoose
```

```javascript
const mongoose = require('mongoose');

// Basic connection
mongoose.connect('mongodb://localhost:27017/myapp')
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.error('MongoDB connection error:', err));

// With options
mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  serverSelectionTimeoutMS: 5000,
  socketTimeoutMS: 45000,
})
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.error('MongoDB connection error:', err));

// Connection events
mongoose.connection.on('connected', () => {
  console.log('Mongoose connected to DB');
});

mongoose.connection.on('error', (err) => {
  console.log('Mongoose connection error:', err);
});

mongoose.connection.on('disconnected', () => {
  console.log('Mongoose disconnected');
});

// Graceful shutdown
process.on('SIGINT', async () => {
  await mongoose.connection.close();
  process.exit(0);
});
```

### Defining Schemas and Models

```javascript
const mongoose = require('mongoose');
const { Schema } = mongoose;

// User Schema
const userSchema = new Schema({
  name: {
    type: String,
    required: [true, 'Name is required'],
    trim: true,
    minlength: [2, 'Name must be at least 2 characters'],
    maxlength: [50, 'Name cannot exceed 50 characters']
  },
  email: {
    type: String,
    required: true,
    unique: true,
    lowercase: true,
    trim: true,
    match: [/^\S+@\S+\.\S+$/, 'Please enter a valid email']
  },
  password: {
    type: String,
    required: true,
    minlength: 8,
    select: false // Don't include in queries by default
  },
  age: {
    type: Number,
    min: [0, 'Age cannot be negative'],
    max: [150, 'Age seems unrealistic']
  },
  role: {
    type: String,
    enum: ['user', 'admin', 'moderator'],
    default: 'user'
  },
  isActive: {
    type: Boolean,
    default: true
  },
  avatar: String,
  createdAt: {
    type: Date,
    default: Date.now
  },
  updatedAt: Date
}, {
  timestamps: true // Automatically manage createdAt and updatedAt
});

// Create model
const User = mongoose.model('User', userSchema);

module.exports = User;
```

### Schema Methods and Statics

```javascript
// Instance methods
userSchema.methods.comparePassword = async function(candidatePassword) {
  return await bcrypt.compare(candidatePassword, this.password);
};

userSchema.methods.generateAuthToken = function() {
  return jwt.sign({ id: this._id }, process.env.JWT_SECRET);
};

// Static methods
userSchema.statics.findByEmail = function(email) {
  return this.findOne({ email });
};

userSchema.statics.findActive = function() {
  return this.find({ isActive: true });
};

// Virtual properties
userSchema.virtual('fullName').get(function() {
  return `${this.firstName} ${this.lastName}`;
});

// Middleware (hooks)
userSchema.pre('save', async function(next) {
  // Only hash password if it's modified
  if (!this.isModified('password')) return next();
  
  this.password = await bcrypt.hash(this.password, 12);
  next();
});

userSchema.pre('save', function(next) {
  this.updatedAt = Date.now();
  next();
});

userSchema.post('save', function(doc, next) {
  console.log('User saved:', doc._id);
  next();
});

// Query middleware
userSchema.pre(/^find/, function(next) {
  this.find({ isActive: { $ne: false } });
  next();
});
```

### CRUD Operations

```javascript
const User = require('./models/User');

// CREATE
app.post('/api/users', async (req, res) => {
  try {
    const user = new User(req.body);
    await user.save();
    
    // Or use create
    // const user = await User.create(req.body);
    
    res.status(201).json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// READ - Get all
app.get('/api/users', async (req, res) => {
  try {
    const users = await User.find();
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// READ - Get one
app.get('/api/users/:id', async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// UPDATE
app.put('/api/users/:id', async (req, res) => {
  try {
    const user = await User.findByIdAndUpdate(
      req.params.id,
      req.body,
      { 
        new: true,           // Return updated document
        runValidators: true  // Run schema validators
      }
    );
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// DELETE
app.delete('/api/users/:id', async (req, res) => {
  try {
    const user = await User.findByIdAndDelete(req.params.id);
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json({ message: 'User deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

### Advanced Queries

```javascript
// Filtering
app.get('/api/users', async (req, res) => {
  try {
    const users = await User.find({ role: 'admin', isActive: true });
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Query operators
const users = await User.find({
  age: { $gte: 18, $lte: 65 },        // Greater than or equal, Less than or equal
  role: { $in: ['admin', 'moderator'] }, // In array
  name: { $regex: /john/i }            // Regex match
});

// Sorting
const users = await User.find().sort({ createdAt: -1 }); // -1 for descending
const users = await User.find().sort('name -age'); // name ascending, age descending

// Limiting and pagination
const page = parseInt(req.query.page) || 1;
const limit = parseInt(req.query.limit) || 10;
const skip = (page - 1) * limit;

const users = await User.find()
  .limit(limit)
  .skip(skip)
  .sort({ createdAt: -1 });

const total = await User.countDocuments();

res.json({
  users,
  pagination: {
    page,
    limit,
    total,
    pages: Math.ceil(total / limit)
  }
});

// Selecting fields
const users = await User.find().select('name email'); // Only these fields
const users = await User.find().select('-password'); // Exclude password

// Population (relationships)
const postSchema = new Schema({
  title: String,
  author: {
    type: Schema.Types.ObjectId,
    ref: 'User'
  }
});

const posts = await Post.find().populate('author');
const posts = await Post.find().populate('author', 'name email'); // Select specific fields
const posts = await Post.find().populate({
  path: 'author',
  select: 'name email',
  match: { isActive: true }
});
```

### Aggregation Pipeline

```javascript
// Group and count
const stats = await User.aggregate([
  { $match: { isActive: true } },
  { $group: {
    _id: '$role',
    count: { $sum: 1 },
    avgAge: { $avg: '$age' }
  }},
  { $sort: { count: -1 } }
]);

// Complex aggregation
const result = await Order.aggregate([
  // Stage 1: Match orders from last 30 days
  { $match: {
    createdAt: { $gte: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000) }
  }},
  
  // Stage 2: Lookup user information
  { $lookup: {
    from: 'users',
    localField: 'userId',
    foreignField: '_id',
    as: 'user'
  }},
  
  // Stage 3: Unwind user array
  { $unwind: '$user' },
  
  // Stage 4: Group by user
  { $group: {
    _id: '$userId',
    userName: { $first: '$user.name' },
    totalOrders: { $sum: 1 },
    totalAmount: { $sum: '$amount' },
    avgAmount: { $avg: '$amount' }
  }},
  
  // Stage 5: Sort by total amount
  { $sort: { totalAmount: -1 } },
  
  // Stage 6: Limit results
  { $limit: 10 }
]);
```

### Transactions

```javascript
const session = await mongoose.startSession();
session.startTransaction();

try {
  // Create user
  const user = await User.create([{
    name: 'John',
    email: 'john@example.com'
  }], { session });
  
  // Create related profile
  await Profile.create([{
    userId: user[0]._id,
    bio: 'Hello world'
  }], { session });
  
  await session.commitTransaction();
  res.json({ success: true });
} catch (error) {
  await session.abortTransaction();
  res.status(500).json({ error: error.message });
} finally {
  session.endSession();
}
```


---

## 15. SQL Databases (PostgreSQL, MySQL)

### PostgreSQL with pg Library

```bash
npm install pg
```

```javascript
const { Pool } = require('pg');

// Create connection pool
const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  max: 20,                    // Maximum pool size
  idleTimeoutMillis: 30000,   // Close idle clients after 30 seconds
  connectionTimeoutMillis: 2000,
});

// Test connection
pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Database connection error:', err);
  } else {
    console.log('Database connected:', res.rows[0]);
  }
});

// CRUD Operations
app.get('/api/users', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM users ORDER BY created_at DESC');
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/api/users/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query('SELECT * FROM users WHERE id = $1', [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/users', async (req, res) => {
  try {
    const { name, email, age } = req.body;
    const result = await pool.query(
      'INSERT INTO users (name, email, age) VALUES ($1, $2, $3) RETURNING *',
      [name, email, age]
    );
    
    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.put('/api/users/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { name, email, age } = req.body;
    
    const result = await pool.query(
      'UPDATE users SET name = $1, email = $2, age = $3, updated_at = NOW() WHERE id = $4 RETURNING *',
      [name, email, age, id]
    );
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json(result.rows[0]);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.delete('/api/users/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query('DELETE FROM users WHERE id = $1 RETURNING *', [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json({ message: 'User deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Transactions
app.post('/api/transfer', async (req, res) => {
  const client = await pool.connect();
  
  try {
    await client.query('BEGIN');
    
    const { fromAccount, toAccount, amount } = req.body;
    
    // Deduct from sender
    await client.query(
      'UPDATE accounts SET balance = balance - $1 WHERE id = $2',
      [amount, fromAccount]
    );
    
    // Add to receiver
    await client.query(
      'UPDATE accounts SET balance = balance + $1 WHERE id = $2',
      [amount, toAccount]
    );
    
    await client.query('COMMIT');
    res.json({ message: 'Transfer successful' });
  } catch (error) {
    await client.query('ROLLBACK');
    res.status(500).json({ error: error.message });
  } finally {
    client.release();
  }
});
```

---

## 16. ORMs & Query Builders

### Sequelize (SQL ORM)

```bash
npm install sequelize pg pg-hstore
```

```javascript
const { Sequelize, DataTypes } = require('sequelize');

// Initialize Sequelize
const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    dialect: 'postgres',
    logging: false,
    pool: {
      max: 5,
      min: 0,
      acquire: 30000,
      idle: 10000
    }
  }
);

// Test connection
sequelize.authenticate()
  .then(() => console.log('Database connected'))
  .catch(err => console.error('Unable to connect:', err));

// Define Model
const User = sequelize.define('User', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
    validate: {
      len: [2, 50]
    }
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
    unique: true,
    validate: {
      isEmail: true
    }
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false
  },
  role: {
    type: DataTypes.ENUM('user', 'admin', 'moderator'),
    defaultValue: 'user'
  },
  isActive: {
    type: DataTypes.BOOLEAN,
    defaultValue: true
  }
}, {
  timestamps: true,
  hooks: {
    beforeCreate: async (user) => {
      user.password = await bcrypt.hash(user.password, 12);
    }
  }
});

// Associations
const Post = sequelize.define('Post', {
  title: DataTypes.STRING,
  content: DataTypes.TEXT
});

User.hasMany(Post, { foreignKey: 'userId', as: 'posts' });
Post.belongsTo(User, { foreignKey: 'userId', as: 'author' });

// Sync models
sequelize.sync({ alter: true });

// CRUD with Sequelize
app.get('/api/users', async (req, res) => {
  try {
    const users = await User.findAll({
      attributes: ['id', 'name', 'email', 'role'],
      where: { isActive: true },
      order: [['createdAt', 'DESC']],
      limit: 10
    });
    
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/api/users/:id', async (req, res) => {
  try {
    const user = await User.findByPk(req.params.id, {
      include: [{
        model: Post,
        as: 'posts'
      }]
    });
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/users', async (req, res) => {
  try {
    const user = await User.create(req.body);
    res.status(201).json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.put('/api/users/:id', async (req, res) => {
  try {
    const [updated] = await User.update(req.body, {
      where: { id: req.params.id }
    });
    
    if (!updated) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    const user = await User.findByPk(req.params.id);
    res.json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.delete('/api/users/:id', async (req, res) => {
  try {
    const deleted = await User.destroy({
      where: { id: req.params.id }
    });
    
    if (!deleted) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json({ message: 'User deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

### Prisma (Modern ORM)

```bash
npm install prisma @prisma/client
npx prisma init
```

**prisma/schema.prisma:**

```prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}

model User {
  id        String   @id @default(uuid())
  name      String
  email     String   @unique
  password  String
  role      Role     @default(USER)
  isActive  Boolean  @default(true)
  posts     Post[]
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

model Post {
  id        String   @id @default(uuid())
  title     String
  content   String
  published Boolean  @default(false)
  author    User     @relation(fields: [authorId], references: [id])
  authorId  String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

enum Role {
  USER
  ADMIN
  MODERATOR
}
```

```javascript
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// CRUD with Prisma
app.get('/api/users', async (req, res) => {
  try {
    const users = await prisma.user.findMany({
      select: {
        id: true,
        name: true,
        email: true,
        role: true
      },
      where: { isActive: true },
      orderBy: { createdAt: 'desc' },
      take: 10
    });
    
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/api/users/:id', async (req, res) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: req.params.id },
      include: { posts: true }
    });
    
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/users', async (req, res) => {
  try {
    const user = await prisma.user.create({
      data: req.body
    });
    
    res.status(201).json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.put('/api/users/:id', async (req, res) => {
  try {
    const user = await prisma.user.update({
      where: { id: req.params.id },
      data: req.body
    });
    
    res.json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.delete('/api/users/:id', async (req, res) => {
  try {
    await prisma.user.delete({
      where: { id: req.params.id }
    });
    
    res.json({ message: 'User deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Graceful shutdown
process.on('beforeExit', async () => {
  await prisma.$disconnect();
});
```

---

## Part V: Authentication & Security

---

## 17. Authentication Strategies

### Password Hashing with bcrypt

```bash
npm install bcryptjs
```

```javascript
const bcrypt = require('bcryptjs');

// Hash password
const hashPassword = async (password) => {
  const salt = await bcrypt.genSalt(12);
  return await bcrypt.hash(password, salt);
};

// Compare password
const comparePassword = async (candidatePassword, hashedPassword) => {
  return await bcrypt.compare(candidatePassword, hashedPassword);
};

// Registration
app.post('/api/auth/register', async (req, res) => {
  try {
    const { name, email, password } = req.body;
    
    // Check if user exists
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(409).json({ error: 'Email already registered' });
    }
    
    // Hash password
    const hashedPassword = await hashPassword(password);
    
    // Create user
    const user = await User.create({
      name,
      email,
      password: hashedPassword
    });
    
    // Remove password from response
    const userResponse = user.toObject();
    delete userResponse.password;
    
    res.status(201).json(userResponse);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Login
app.post('/api/auth/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    // Find user (include password field)
    const user = await User.findOne({ email }).select('+password');
    
    if (!user) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    // Check password
    const isMatch = await comparePassword(password, user.password);
    
    if (!isMatch) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    // Generate token (covered in next section)
    const token = generateToken(user._id);
    
    res.json({
      token,
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        role: user.role
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

---

## 18. JWT & Session Management

### JWT (JSON Web Tokens)

```bash
npm install jsonwebtoken
```

```javascript
const jwt = require('jsonwebtoken');

// Generate JWT
const generateToken = (userId) => {
  return jwt.sign(
    { id: userId },
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRE || '7d' }
  );
};

// Verify JWT
const verifyToken = (token) => {
  return jwt.verify(token, process.env.JWT_SECRET);
};

// Authentication middleware
const authenticate = async (req, res, next) => {
  try {
    // Get token from header
    const authHeader = req.headers.authorization;
    
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({ error: 'No token provided' });
    }
    
    const token = authHeader.split(' ')[1];
    
    // Verify token
    const decoded = verifyToken(token);
    
    // Get user from database
    const user = await User.findById(decoded.id).select('-password');
    
    if (!user) {
      return res.status(401).json({ error: 'User not found' });
    }
    
    // Attach user to request
    req.user = user;
    next();
  } catch (error) {
    if (error.name === 'JsonWebTokenError') {
      return res.status(401).json({ error: 'Invalid token' });
    }
    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({ error: 'Token expired' });
    }
    res.status(500).json({ error: 'Authentication failed' });
  }
};

// Authorization middleware
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

// Protected routes
app.get('/api/profile', authenticate, (req, res) => {
  res.json({ user: req.user });
});

app.delete('/api/users/:id', authenticate, authorize('admin'), async (req, res) => {
  // Only admins can delete users
  // Implementation here
});

// Refresh token pattern
const generateRefreshToken = (userId) => {
  return jwt.sign(
    { id: userId },
    process.env.REFRESH_TOKEN_SECRET,
    { expiresIn: '30d' }
  );
};

app.post('/api/auth/login', async (req, res) => {
  // ... login logic
  
  const accessToken = generateToken(user._id);
  const refreshToken = generateRefreshToken(user._id);
  
  // Store refresh token in database
  user.refreshToken = refreshToken;
  await user.save();
  
  res.json({
    accessToken,
    refreshToken,
    user: { id: user._id, name: user.name, email: user.email }
  });
});

app.post('/api/auth/refresh', async (req, res) => {
  try {
    const { refreshToken } = req.body;
    
    if (!refreshToken) {
      return res.status(401).json({ error: 'Refresh token required' });
    }
    
    const decoded = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
    const user = await User.findById(decoded.id);
    
    if (!user || user.refreshToken !== refreshToken) {
      return res.status(401).json({ error: 'Invalid refresh token' });
    }
    
    const newAccessToken = generateToken(user._id);
    
    res.json({ accessToken: newAccessToken });
  } catch (error) {
    res.status(401).json({ error: 'Invalid refresh token' });
  }
});
```

### Session-based Authentication

```bash
npm install express-session connect-mongo
```

```javascript
const session = require('express-session');
const MongoStore = require('connect-mongo');

app.use(session({
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false,
  store: MongoStore.create({
    mongoUrl: process.env.MONGODB_URI,
    ttl: 24 * 60 * 60 // 1 day
  }),
  cookie: {
    secure: process.env.NODE_ENV === 'production', // HTTPS only in production
    httpOnly: true,
    maxAge: 1000 * 60 * 60 * 24 // 1 day
  }
}));

// Login with sessions
app.post('/api/auth/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    
    const user = await User.findOne({ email }).select('+password');
    if (!user || !(await user.comparePassword(password))) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    // Create session
    req.session.userId = user._id;
    req.session.role = user.role;
    
    res.json({
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        role: user.role
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Session authentication middleware
const sessionAuth = (req, res, next) => {
  if (!req.session.userId) {
    return res.status(401).json({ error: 'Not authenticated' });
  }
  next();
};

// Protected route
app.get('/api/profile', sessionAuth, async (req, res) => {
  const user = await User.findById(req.session.userId);
  res.json({ user });
});

// Logout
app.post('/api/auth/logout', (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      return res.status(500).json({ error: 'Could not log out' });
    }
    res.clearCookie('connect.sid');
    res.json({ message: 'Logged out successfully' });
  });
});
```


---

## 19. Security Best Practices

### Essential Security Headers with Helmet

```javascript
const helmet = require('helmet');

app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'", "https://fonts.googleapis.com"],
      fontSrc: ["'self'", "https://fonts.gstatic.com"],
      scriptSrc: ["'self'"],
      imgSrc: ["'self'", "data:", "https:"],
    }
  },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true
  }
}));
```

### Input Validation and Sanitization

```javascript
const { body, param, query, validationResult } = require('express-validator');
const mongoSanitize = require('express-mongo-sanitize');
const xss = require('xss-clean');

// Prevent NoSQL injection
app.use(mongoSanitize());

// Prevent XSS attacks
app.use(xss());

// Validation example
app.post('/api/users',
  body('email').isEmail().normalizeEmail(),
  body('password').isLength({ min: 8 }).matches(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/),
  body('name').trim().escape().isLength({ min: 2, max: 50 }),
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    // Process request
  }
);
```

### CSRF Protection

```bash
npm install csurf
```

```javascript
const csrf = require('csurf');
const csrfProtection = csrf({ cookie: true });

app.use(csrfProtection);

app.get('/form', (req, res) => {
  res.render('form', { csrfToken: req.csrfToken() });
});

app.post('/process', csrfProtection, (req, res) => {
  res.send('Form processed');
});
```

### Rate Limiting

```javascript
const rateLimit = require('express-rate-limit');

// General limiter
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  message: 'Too many requests from this IP'
});

// Strict limiter for auth endpoints
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 5,
  skipSuccessfulRequests: true
});

app.use('/api/', limiter);
app.use('/api/auth/', authLimiter);
```

### SQL Injection Prevention

```javascript
// ✅ GOOD: Using parameterized queries
app.get('/users/:id', async (req, res) => {
  const result = await pool.query(
    'SELECT * FROM users WHERE id = $1',
    [req.params.id]
  );
});

// ❌ BAD: String concatenation
app.get('/users/:id', async (req, res) => {
  const result = await pool.query(
    `SELECT * FROM users WHERE id = ${req.params.id}` // VULNERABLE!
  );
});
```

### Secure Password Storage

```javascript
const bcrypt = require('bcryptjs');

// Hash password with salt rounds
const hashPassword = async (password) => {
  return await bcrypt.hash(password, 12); // 12 rounds is recommended
};

// Never store plain text passwords
// Never use weak hashing (MD5, SHA1)
// Always use bcrypt, scrypt, or argon2
```

---

## 20. OAuth & Third-Party Auth

### Passport.js Setup

```bash
npm install passport passport-local passport-jwt passport-google-oauth20
```

```javascript
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const GoogleStrategy = require('passport-google-oauth20').Strategy;

// Local Strategy
passport.use(new LocalStrategy(
  { usernameField: 'email' },
  async (email, password, done) => {
    try {
      const user = await User.findOne({ email }).select('+password');
      
      if (!user) {
        return done(null, false, { message: 'Invalid credentials' });
      }
      
      const isMatch = await user.comparePassword(password);
      
      if (!isMatch) {
        return done(null, false, { message: 'Invalid credentials' });
      }
      
      return done(null, user);
    } catch (error) {
      return done(error);
    }
  }
));

// JWT Strategy
const jwtOptions = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: process.env.JWT_SECRET
};

passport.use(new JwtStrategy(jwtOptions, async (payload, done) => {
  try {
    const user = await User.findById(payload.id);
    
    if (user) {
      return done(null, user);
    }
    
    return done(null, false);
  } catch (error) {
    return done(error, false);
  }
}));

// Google OAuth Strategy
passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: '/api/auth/google/callback'
  },
  async (accessToken, refreshToken, profile, done) => {
    try {
      // Check if user exists
      let user = await User.findOne({ googleId: profile.id });
      
      if (!user) {
        // Create new user
        user = await User.create({
          googleId: profile.id,
          name: profile.displayName,
          email: profile.emails[0].value,
          avatar: profile.photos[0].value
        });
      }
      
      return done(null, user);
    } catch (error) {
      return done(error, false);
    }
  }
));

// Initialize passport
app.use(passport.initialize());

// Routes
app.post('/api/auth/login',
  passport.authenticate('local', { session: false }),
  (req, res) => {
    const token = generateToken(req.user._id);
    res.json({ token, user: req.user });
  }
);

app.get('/api/auth/google',
  passport.authenticate('google', { scope: ['profile', 'email'] })
);

app.get('/api/auth/google/callback',
  passport.authenticate('google', { session: false }),
  (req, res) => {
    const token = generateToken(req.user._id);
    res.redirect(`/auth-success?token=${token}`);
  }
);

// Protected route
app.get('/api/profile',
  passport.authenticate('jwt', { session: false }),
  (req, res) => {
    res.json({ user: req.user });
  }
);
```

---

## Part VI: Advanced Patterns

---

## 21. REST API Design

### RESTful Principles

```javascript
// Resource-based URLs
GET    /api/users           // Get all users
GET    /api/users/:id       // Get single user
POST   /api/users           // Create user
PUT    /api/users/:id       // Update user (full)
PATCH  /api/users/:id       // Update user (partial)
DELETE /api/users/:id       // Delete user

// Nested resources
GET    /api/users/:id/posts           // Get user's posts
POST   /api/users/:id/posts           // Create post for user
GET    /api/users/:id/posts/:postId   // Get specific post
```

### API Versioning

```javascript
// URL versioning
app.use('/api/v1', require('./routes/v1'));
app.use('/api/v2', require('./routes/v2'));

// Header versioning
app.use((req, res, next) => {
  const version = req.get('API-Version') || 'v1';
  req.apiVersion = version;
  next();
});
```

### Pagination, Filtering, Sorting

```javascript
app.get('/api/users', async (req, res) => {
  try {
    // Pagination
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const skip = (page - 1) * limit;
    
    // Filtering
    const filter = {};
    if (req.query.role) filter.role = req.query.role;
    if (req.query.isActive) filter.isActive = req.query.isActive === 'true';
    if (req.query.search) {
      filter.$or = [
        { name: { $regex: req.query.search, $options: 'i' } },
        { email: { $regex: req.query.search, $options: 'i' } }
      ];
    }
    
    // Sorting
    const sort = {};
    if (req.query.sortBy) {
      const parts = req.query.sortBy.split(':');
      sort[parts[0]] = parts[1] === 'desc' ? -1 : 1;
    } else {
      sort.createdAt = -1;
    }
    
    // Field selection
    const select = req.query.fields ? req.query.fields.split(',').join(' ') : '';
    
    // Execute query
    const users = await User.find(filter)
      .select(select)
      .sort(sort)
      .skip(skip)
      .limit(limit);
    
    const total = await User.countDocuments(filter);
    
    res.json({
      data: users,
      pagination: {
        page,
        limit,
        total,
        pages: Math.ceil(total / limit)
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Usage:
// GET /api/users?page=2&limit=20&role=admin&sortBy=name:asc&fields=name,email&search=john
```

### HATEOAS (Hypermedia)

```javascript
app.get('/api/users/:id', async (req, res) => {
  const user = await User.findById(req.params.id);
  
  res.json({
    data: user,
    links: {
      self: `/api/users/${user._id}`,
      posts: `/api/users/${user._id}/posts`,
      update: {
        href: `/api/users/${user._id}`,
        method: 'PUT'
      },
      delete: {
        href: `/api/users/${user._id}`,
        method: 'DELETE'
      }
    }
  });
});
```

### API Response Format

```javascript
// Success response
const successResponse = (res, data, statusCode = 200) => {
  res.status(statusCode).json({
    status: 'success',
    data
  });
};

// Error response
const errorResponse = (res, message, statusCode = 500) => {
  res.status(statusCode).json({
    status: 'error',
    message
  });
};

// Usage
app.get('/api/users', async (req, res) => {
  try {
    const users = await User.find();
    successResponse(res, { users });
  } catch (error) {
    errorResponse(res, error.message, 500);
  }
});
```

---

## 22. GraphQL with Express

```bash
npm install graphql express-graphql
```

```javascript
const { graphqlHTTP } = require('express-graphql');
const { buildSchema } = require('graphql');

// Define schema
const schema = buildSchema(`
  type User {
    id: ID!
    name: String!
    email: String!
    posts: [Post!]!
  }
  
  type Post {
    id: ID!
    title: String!
    content: String!
    author: User!
  }
  
  type Query {
    user(id: ID!): User
    users: [User!]!
    post(id: ID!): Post
    posts: [Post!]!
  }
  
  type Mutation {
    createUser(name: String!, email: String!): User!
    createPost(title: String!, content: String!, authorId: ID!): Post!
  }
`);

// Define resolvers
const root = {
  user: async ({ id }) => {
    return await User.findById(id);
  },
  users: async () => {
    return await User.find();
  },
  post: async ({ id }) => {
    return await Post.findById(id);
  },
  posts: async () => {
    return await Post.find();
  },
  createUser: async ({ name, email }) => {
    const user = await User.create({ name, email });
    return user;
  },
  createPost: async ({ title, content, authorId }) => {
    const post = await Post.create({ title, content, author: authorId });
    return post;
  }
};

// Setup GraphQL endpoint
app.use('/graphql', graphqlHTTP({
  schema: schema,
  rootValue: root,
  graphiql: true // Enable GraphiQL interface
}));
```

---

## 23. WebSockets & Real-time

### Socket.io Integration

```bash
npm install socket.io
```

```javascript
const express = require('express');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
  cors: {
    origin: '*',
    methods: ['GET', 'POST']
  }
});

// Socket.io middleware
io.use((socket, next) => {
  const token = socket.handshake.auth.token;
  
  if (!token) {
    return next(new Error('Authentication error'));
  }
  
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    socket.userId = decoded.id;
    next();
  } catch (error) {
    next(new Error('Authentication error'));
  }
});

// Connection handling
io.on('connection', (socket) => {
  console.log('User connected:', socket.userId);
  
  // Join room
  socket.on('join-room', (roomId) => {
    socket.join(roomId);
    socket.to(roomId).emit('user-joined', socket.userId);
  });
  
  // Send message
  socket.on('send-message', (data) => {
    io.to(data.roomId).emit('new-message', {
      userId: socket.userId,
      message: data.message,
      timestamp: new Date()
    });
  });
  
  // Typing indicator
  socket.on('typing', (roomId) => {
    socket.to(roomId).emit('user-typing', socket.userId);
  });
  
  // Disconnect
  socket.on('disconnect', () => {
    console.log('User disconnected:', socket.userId);
  });
});

// Start server
server.listen(3000, () => {
  console.log('Server running on port 3000');
});
```

### Real-time Notifications

```javascript
// Emit notification to specific user
const sendNotification = (userId, notification) => {
  io.to(userId).emit('notification', notification);
};

// REST endpoint that triggers real-time update
app.post('/api/posts', authenticate, async (req, res) => {
  try {
    const post = await Post.create({
      ...req.body,
      author: req.user._id
    });
    
    // Notify followers in real-time
    const followers = await User.find({ following: req.user._id });
    followers.forEach(follower => {
      sendNotification(follower._id.toString(), {
        type: 'new-post',
        message: `${req.user.name} created a new post`,
        postId: post._id
      });
    });
    
    res.status(201).json(post);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});
```

---

## 24. File Uploads & Processing

### Multer Configuration

```javascript
const multer = require('multer');
const path = require('path');
const sharp = require('sharp'); // Image processing

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

// File filter
const fileFilter = (req, file, cb) => {
  const allowedTypes = /jpeg|jpg|png|gif/;
  const extname = allowedTypes.test(path.extname(file.originalname).toLowerCase());
  const mimetype = allowedTypes.test(file.mimetype);
  
  if (extname && mimetype) {
    cb(null, true);
  } else {
    cb(new Error('Only images are allowed'));
  }
};

const upload = multer({
  storage: storage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
  fileFilter: fileFilter
});

// Single file upload
app.post('/api/upload', upload.single('image'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'No file uploaded' });
    }
    
    res.json({
      message: 'File uploaded successfully',
      file: {
        filename: req.file.filename,
        path: req.file.path,
        size: req.file.size
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Multiple files
app.post('/api/upload-multiple', upload.array('images', 5), async (req, res) => {
  try {
    const files = req.files.map(file => ({
      filename: file.filename,
      path: file.path,
      size: file.size
    }));
    
    res.json({ message: 'Files uploaded successfully', files });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Image processing with Sharp
app.post('/api/upload-avatar', upload.single('avatar'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'No file uploaded' });
    }
    
    const filename = `avatar-${req.user._id}-${Date.now()}.jpeg`;
    const filepath = path.join('uploads/avatars', filename);
    
    // Resize and optimize image
    await sharp(req.file.path)
      .resize(200, 200)
      .jpeg({ quality: 90 })
      .toFile(filepath);
    
    // Delete original file
    fs.unlinkSync(req.file.path);
    
    // Update user avatar
    req.user.avatar = filename;
    await req.user.save();
    
    res.json({ message: 'Avatar updated', avatar: filename });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});
```

---

## 25. Caching Strategies

### Redis Caching

```bash
npm install redis
```

```javascript
const redis = require('redis');
const client = redis.createClient({
  host: process.env.REDIS_HOST,
  port: process.env.REDIS_PORT
});

client.on('error', (err) => console.error('Redis error:', err));
client.on('connect', () => console.log('Redis connected'));

// Cache middleware
const cache = (duration) => {
  return async (req, res, next) => {
    const key = `cache:${req.originalUrl}`;
    
    try {
      const cachedData = await client.get(key);
      
      if (cachedData) {
        return res.json(JSON.parse(cachedData));
      }
      
      // Store original res.json
      const originalJson = res.json.bind(res);
      
      // Override res.json
      res.json = (data) => {
        client.setEx(key, duration, JSON.stringify(data));
        originalJson(data);
      };
      
      next();
    } catch (error) {
      next();
    }
  };
};

// Usage
app.get('/api/users', cache(300), async (req, res) => {
  const users = await User.find();
  res.json(users);
});

// Clear cache
app.post('/api/users', async (req, res) => {
  const user = await User.create(req.body);
  
  // Clear users cache
  await client.del('cache:/api/users');
  
  res.status(201).json(user);
});
```

### Memory Caching

```javascript
const NodeCache = require('node-cache');
const cache = new NodeCache({ stdTTL: 300 }); // 5 minutes default

const cacheMiddleware = (req, res, next) => {
  const key = req.originalUrl;
  const cachedData = cache.get(key);
  
  if (cachedData) {
    return res.json(cachedData);
  }
  
  const originalJson = res.json.bind(res);
  res.json = (data) => {
    cache.set(key, data);
    originalJson(data);
  };
  
  next();
};

app.get('/api/users', cacheMiddleware, async (req, res) => {
  const users = await User.find();
  res.json(users);
});
```


---

## Part VII: Testing & Production

---

## 26. Testing Express Applications

### Setup Testing Environment

```bash
npm install --save-dev jest supertest @types/jest
npm install --save-dev mongodb-memory-server # For MongoDB testing
```

**package.json:**

```json
{
  "scripts": {
    "test": "jest --coverage",
    "test:watch": "jest --watch"
  },
  "jest": {
    "testEnvironment": "node",
    "coveragePathIgnorePatterns": ["/node_modules/"]
  }
}
```

### Unit Testing

```javascript
// utils/math.js
exports.add = (a, b) => a + b;
exports.multiply = (a, b) => a * b;

// utils/math.test.js
const { add, multiply } = require('./math');

describe('Math utilities', () => {
  test('add should return sum of two numbers', () => {
    expect(add(2, 3)).toBe(5);
    expect(add(-1, 1)).toBe(0);
  });
  
  test('multiply should return product of two numbers', () => {
    expect(multiply(2, 3)).toBe(6);
    expect(multiply(0, 5)).toBe(0);
  });
});
```

### Integration Testing with Supertest

```javascript
// app.test.js
const request = require('supertest');
const app = require('./app');
const mongoose = require('mongoose');
const User = require('./models/User');

// Setup and teardown
beforeAll(async () => {
  await mongoose.connect(process.env.TEST_DB_URI);
});

afterAll(async () => {
  await mongoose.connection.close();
});

beforeEach(async () => {
  await User.deleteMany({});
});

describe('User API', () => {
  describe('POST /api/users', () => {
    test('should create a new user', async () => {
      const userData = {
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123'
      };
      
      const response = await request(app)
        .post('/api/users')
        .send(userData)
        .expect(201);
      
      expect(response.body).toHaveProperty('_id');
      expect(response.body.name).toBe(userData.name);
      expect(response.body.email).toBe(userData.email);
      expect(response.body).not.toHaveProperty('password');
    });
    
    test('should return 400 for invalid email', async () => {
      const userData = {
        name: 'John Doe',
        email: 'invalid-email',
        password: 'password123'
      };
      
      const response = await request(app)
        .post('/api/users')
        .send(userData)
        .expect(400);
      
      expect(response.body).toHaveProperty('error');
    });
  });
  
  describe('GET /api/users', () => {
    test('should return all users', async () => {
      // Create test users
      await User.create([
        { name: 'User 1', email: 'user1@example.com', password: 'pass123' },
        { name: 'User 2', email: 'user2@example.com', password: 'pass123' }
      ]);
      
      const response = await request(app)
        .get('/api/users')
        .expect(200);
      
      expect(response.body).toHaveLength(2);
    });
  });
  
  describe('GET /api/users/:id', () => {
    test('should return user by id', async () => {
      const user = await User.create({
        name: 'John Doe',
        email: 'john@example.com',
        password: 'pass123'
      });
      
      const response = await request(app)
        .get(`/api/users/${user._id}`)
        .expect(200);
      
      expect(response.body.name).toBe(user.name);
    });
    
    test('should return 404 for non-existent user', async () => {
      const fakeId = new mongoose.Types.ObjectId();
      
      await request(app)
        .get(`/api/users/${fakeId}`)
        .expect(404);
    });
  });
});

describe('Authentication', () => {
  test('should login with valid credentials', async () => {
    // Create user
    await request(app)
      .post('/api/auth/register')
      .send({
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123'
      });
    
    // Login
    const response = await request(app)
      .post('/api/auth/login')
      .send({
        email: 'john@example.com',
        password: 'password123'
      })
      .expect(200);
    
    expect(response.body).toHaveProperty('token');
    expect(response.body).toHaveProperty('user');
  });
  
  test('should reject invalid credentials', async () => {
    await request(app)
      .post('/api/auth/login')
      .send({
        email: 'wrong@example.com',
        password: 'wrongpass'
      })
      .expect(401);
  });
  
  test('should access protected route with valid token', async () => {
    // Register and login
    await request(app)
      .post('/api/auth/register')
      .send({
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123'
      });
    
    const loginResponse = await request(app)
      .post('/api/auth/login')
      .send({
        email: 'john@example.com',
        password: 'password123'
      });
    
    const token = loginResponse.body.token;
    
    // Access protected route
    const response = await request(app)
      .get('/api/profile')
      .set('Authorization', `Bearer ${token}`)
      .expect(200);
    
    expect(response.body.user.email).toBe('john@example.com');
  });
  
  test('should reject access without token', async () => {
    await request(app)
      .get('/api/profile')
      .expect(401);
  });
});
```

### Mocking and Stubbing

```javascript
// Mock database calls
jest.mock('./models/User');
const User = require('./models/User');

test('should handle database errors', async () => {
  User.find.mockRejectedValue(new Error('Database error'));
  
  const response = await request(app)
    .get('/api/users')
    .expect(500);
  
  expect(response.body.error).toBe('Database error');
});

// Mock external API
jest.mock('axios');
const axios = require('axios');

test('should fetch data from external API', async () => {
  const mockData = { data: { id: 1, name: 'Test' } };
  axios.get.mockResolvedValue(mockData);
  
  const response = await request(app)
    .get('/api/external-data')
    .expect(200);
  
  expect(response.body).toEqual(mockData.data);
});
```

---

## 27. Performance Optimization

### Compression

```javascript
const compression = require('compression');

app.use(compression({
  filter: (req, res) => {
    if (req.headers['x-no-compression']) {
      return false;
    }
    return compression.filter(req, res);
  },
  level: 6 // Compression level (0-9)
}));
```

### Database Query Optimization

```javascript
// ❌ BAD: N+1 query problem
app.get('/api/posts', async (req, res) => {
  const posts = await Post.find();
  
  for (let post of posts) {
    post.author = await User.findById(post.authorId); // N queries!
  }
  
  res.json(posts);
});

// ✅ GOOD: Use populate or join
app.get('/api/posts', async (req, res) => {
  const posts = await Post.find().populate('author');
  res.json(posts);
});

// ✅ GOOD: Select only needed fields
app.get('/api/users', async (req, res) => {
  const users = await User.find()
    .select('name email avatar')
    .lean(); // Convert to plain JavaScript objects (faster)
  
  res.json(users);
});

// Create indexes for frequently queried fields
userSchema.index({ email: 1 });
userSchema.index({ createdAt: -1 });
postSchema.index({ author: 1, createdAt: -1 });
```

### Response Caching

```javascript
// Cache-Control headers
app.get('/api/static-data', (req, res) => {
  res.set('Cache-Control', 'public, max-age=3600'); // 1 hour
  res.json(data);
});

// ETag support
app.set('etag', 'strong');

app.get('/api/data', (req, res) => {
  const data = getData();
  const etag = generateETag(data);
  
  if (req.headers['if-none-match'] === etag) {
    return res.sendStatus(304); // Not Modified
  }
  
  res.set('ETag', etag);
  res.json(data);
});
```

### Connection Pooling

```javascript
// MongoDB connection pooling
mongoose.connect(process.env.MONGODB_URI, {
  maxPoolSize: 10,
  minPoolSize: 5,
  socketTimeoutMS: 45000,
});

// PostgreSQL connection pooling
const pool = new Pool({
  max: 20,
  min: 5,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});
```

### Clustering

```javascript
const cluster = require('cluster');
const os = require('os');

if (cluster.isMaster) {
  const numCPUs = os.cpus().length;
  
  console.log(`Master process ${process.pid} is running`);
  console.log(`Forking ${numCPUs} workers...`);
  
  for (let i = 0; i < numCPUs; i++) {
    cluster.fork();
  }
  
  cluster.on('exit', (worker, code, signal) => {
    console.log(`Worker ${worker.process.pid} died`);
    console.log('Starting a new worker...');
    cluster.fork();
  });
} else {
  const app = require('./app');
  
  app.listen(3000, () => {
    console.log(`Worker ${process.pid} started`);
  });
}
```

### Async/Await Best Practices

```javascript
// ❌ BAD: Sequential execution
async function getUsers() {
  const user1 = await User.findById(id1);
  const user2 = await User.findById(id2);
  const user3 = await User.findById(id3);
  return [user1, user2, user3];
}

// ✅ GOOD: Parallel execution
async function getUsers() {
  const [user1, user2, user3] = await Promise.all([
    User.findById(id1),
    User.findById(id2),
    User.findById(id3)
  ]);
  return [user1, user2, user3];
}
```

---

## 28. Deployment & DevOps

### Environment Configuration

```javascript
// config/env.js
require('dotenv').config();

module.exports = {
  env: process.env.NODE_ENV || 'development',
  port: process.env.PORT || 3000,
  database: {
    uri: process.env.MONGODB_URI,
    options: {
      useNewUrlParser: true,
      useUnifiedTopology: true
    }
  },
  jwt: {
    secret: process.env.JWT_SECRET,
    expire: process.env.JWT_EXPIRE || '7d'
  },
  redis: {
    host: process.env.REDIS_HOST,
    port: process.env.REDIS_PORT
  }
};
```

### Docker Setup

**Dockerfile:**

```dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application files
COPY . .

# Expose port
EXPOSE 3000

# Start application
CMD ["node", "server.js"]
```

**docker-compose.yml:**

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - MONGODB_URI=mongodb://mongo:27017/myapp
      - REDIS_HOST=redis
    depends_on:
      - mongo
      - redis
    restart: unless-stopped
  
  mongo:
    image: mongo:6
    volumes:
      - mongo-data:/data/db
    restart: unless-stopped
  
  redis:
    image: redis:7-alpine
    restart: unless-stopped

volumes:
  mongo-data:
```

### PM2 Process Manager

```bash
npm install -g pm2
```

**ecosystem.config.js:**

```javascript
module.exports = {
  apps: [{
    name: 'my-app',
    script: './server.js',
    instances: 'max',
    exec_mode: 'cluster',
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production'
    },
    error_file: './logs/err.log',
    out_file: './logs/out.log',
    log_date_format: 'YYYY-MM-DD HH:mm:ss',
    max_memory_restart: '1G',
    autorestart: true,
    watch: false
  }]
};
```

```bash
# Start application
pm2 start ecosystem.config.js --env production

# Monitor
pm2 monit

# Logs
pm2 logs

# Restart
pm2 restart my-app

# Stop
pm2 stop my-app

# Startup script
pm2 startup
pm2 save
```

### Nginx Reverse Proxy

**/etc/nginx/sites-available/myapp:**

```nginx
server {
    listen 80;
    server_name example.com www.example.com;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
    
    # Static files
    location /static {
        alias /var/www/myapp/public;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

### SSL with Let's Encrypt

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Get certificate
sudo certbot --nginx -d example.com -d www.example.com

# Auto-renewal
sudo certbot renew --dry-run
```

---

## 29. Monitoring & Logging

### Winston Logger

```bash
npm install winston winston-daily-rotate-file
```

```javascript
const winston = require('winston');
const DailyRotateFile = require('winston-daily-rotate-file');

const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  defaultMeta: { service: 'my-app' },
  transports: [
    // Error logs
    new DailyRotateFile({
      filename: 'logs/error-%DATE%.log',
      datePattern: 'YYYY-MM-DD',
      level: 'error',
      maxFiles: '30d'
    }),
    
    // Combined logs
    new DailyRotateFile({
      filename: 'logs/combined-%DATE%.log',
      datePattern: 'YYYY-MM-DD',
      maxFiles: '30d'
    })
  ]
});

// Console logging in development
if (process.env.NODE_ENV !== 'production') {
  logger.add(new winston.transports.Console({
    format: winston.format.combine(
      winston.format.colorize(),
      winston.format.simple()
    )
  }));
}

// Usage
logger.info('Server started', { port: 3000 });
logger.error('Database connection failed', { error: err.message });
logger.warn('High memory usage', { usage: process.memoryUsage() });

// Middleware
app.use((req, res, next) => {
  logger.info('Request received', {
    method: req.method,
    url: req.url,
    ip: req.ip
  });
  next();
});
```

### Application Monitoring

```bash
npm install express-status-monitor
```

```javascript
const statusMonitor = require('express-status-monitor');

app.use(statusMonitor({
  title: 'My App Status',
  path: '/status',
  spans: [{
    interval: 1,
    retention: 60
  }],
  chartVisibility: {
    cpu: true,
    mem: true,
    load: true,
    responseTime: true,
    rps: true,
    statusCodes: true
  }
}));

// Access at http://localhost:3000/status
```

### Health Check Endpoint

```javascript
app.get('/health', async (req, res) => {
  const healthcheck = {
    uptime: process.uptime(),
    message: 'OK',
    timestamp: Date.now(),
    checks: {}
  };
  
  try {
    // Database check
    await mongoose.connection.db.admin().ping();
    healthcheck.checks.database = 'OK';
  } catch (error) {
    healthcheck.checks.database = 'FAILED';
    healthcheck.message = 'DEGRADED';
  }
  
  try {
    // Redis check
    await redis.ping();
    healthcheck.checks.redis = 'OK';
  } catch (error) {
    healthcheck.checks.redis = 'FAILED';
    healthcheck.message = 'DEGRADED';
  }
  
  const status = healthcheck.message === 'OK' ? 200 : 503;
  res.status(status).json(healthcheck);
});
```

### Error Tracking with Sentry

```bash
npm install @sentry/node
```

```javascript
const Sentry = require('@sentry/node');

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV,
  tracesSampleRate: 1.0
});

// Request handler must be first
app.use(Sentry.Handlers.requestHandler());

// All routes here

// Error handler must be last
app.use(Sentry.Handlers.errorHandler());
```

---

## 30. Microservices Architecture

### Service Communication

```javascript
// User Service
const express = require('express');
const app = express();

app.get('/api/users/:id', async (req, res) => {
  const user = await User.findById(req.params.id);
  res.json(user);
});

app.listen(3001);

// Order Service
const axios = require('axios');

app.post('/api/orders', async (req, res) => {
  const { userId, items } = req.body;
  
  // Call User Service
  const userResponse = await axios.get(`http://user-service:3001/api/users/${userId}`);
  const user = userResponse.data;
  
  // Create order
  const order = await Order.create({
    user: userId,
    items,
    total: calculateTotal(items)
  });
  
  res.status(201).json(order);
});

app.listen(3002);
```

### Message Queue with RabbitMQ

```bash
npm install amqplib
```

```javascript
const amqp = require('amqplib');

// Publisher
async function publishMessage(queue, message) {
  const connection = await amqp.connect(process.env.RABBITMQ_URL);
  const channel = await connection.createChannel();
  
  await channel.assertQueue(queue, { durable: true });
  channel.sendToQueue(queue, Buffer.from(JSON.stringify(message)), {
    persistent: true
  });
  
  await channel.close();
  await connection.close();
}

// Consumer
async function consumeMessages(queue, handler) {
  const connection = await amqp.connect(process.env.RABBITMQ_URL);
  const channel = await connection.createChannel();
  
  await channel.assertQueue(queue, { durable: true });
  channel.prefetch(1);
  
  channel.consume(queue, async (msg) => {
    const content = JSON.parse(msg.content.toString());
    
    try {
      await handler(content);
      channel.ack(msg);
    } catch (error) {
      channel.nack(msg);
    }
  });
}

// Usage
app.post('/api/orders', async (req, res) => {
  const order = await Order.create(req.body);
  
  // Publish to queue
  await publishMessage('order-created', {
    orderId: order._id,
    userId: order.userId
  });
  
  res.status(201).json(order);
});

// Email service consuming messages
consumeMessages('order-created', async (data) => {
  const order = await Order.findById(data.orderId);
  const user = await User.findById(data.userId);
  
  await sendEmail(user.email, 'Order Confirmation', order);
});
```

### API Gateway Pattern

```javascript
const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();

// Route to different services
app.use('/api/users', createProxyMiddleware({
  target: 'http://user-service:3001',
  changeOrigin: true
}));

app.use('/api/orders', createProxyMiddleware({
  target: 'http://order-service:3002',
  changeOrigin: true
}));

app.use('/api/products', createProxyMiddleware({
  target: 'http://product-service:3003',
  changeOrigin: true
}));

app.listen(3000);
```

---

## Conclusion

This guide has covered Express.js from fundamentals to advanced production-ready patterns. Key takeaways:

1. **Middleware is Everything**: Understanding the middleware stack is crucial
2. **Security First**: Always implement proper authentication, validation, and security headers
3. **Database Optimization**: Use indexes, connection pooling, and efficient queries
4. **Error Handling**: Implement comprehensive error handling and logging
5. **Testing**: Write tests for critical functionality
6. **Performance**: Use caching, compression, and clustering
7. **Production Ready**: Monitor, log, and deploy with proper DevOps practices

### Next Steps

- Build a complete REST API project
- Implement real-time features with WebSockets
- Deploy to production with Docker and CI/CD
- Explore GraphQL and microservices
- Study advanced patterns and architectures

### Resources

- [Express.js Official Documentation](https://expressjs.com/)
- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)
- [MDN Web Docs - HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP)
- [REST API Design Best Practices](https://restfulapi.net/)

---

**Happy Coding! 🚀**

