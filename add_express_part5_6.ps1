$targetFile = "c:\Users\Shiv\Desktop\Notes\ExpressJS_Mastery_Guide.md"

# Continue Part V and add Part VI
$content4 = @'

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

'@

Add-Content -Path $targetFile -Value $content4
Write-Host "Added sections 19-25 (Security, OAuth, REST API, GraphQL, WebSockets, File Uploads, Caching)"
