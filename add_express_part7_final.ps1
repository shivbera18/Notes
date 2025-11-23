$targetFile = "c:\Users\Shiv\Desktop\Notes\ExpressJS_Mastery_Guide.md"

# Part VII - Testing and Production
$content5 = @'

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

'@

Add-Content -Path $targetFile -Value $content5
Write-Host "Added Part VII (sections 26-30): Testing, Performance, Deployment, Monitoring, Microservices"
Write-Host "Express.js Mastery Guide is now complete!"
