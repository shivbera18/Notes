$targetFile = "c:\Users\Shiv\Desktop\Notes\ExpressJS_Mastery_Guide.md"

# Part III continuation - Error Handling and Custom Middleware
$content2 = @'

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

'@

Add-Content -Path $targetFile -Value $content2
Write-Host "Added sections 12-14 (Custom Middleware, Error Handling, MongoDB)"
