# The Complete React.js Mastery Guide
## From Zero to Expert: Internals, Patterns, and Production-Ready Code

**Version**: 3.0 (Ultra Deep Dive Edition)  
**Last Updated**: 2025  
**Target Audience**: Developers seeking mastery-level understanding of React

---

## Table of Contents

### Part I: Fundamentals & Core Concepts
1. [React Philosophy & Mental Model](#1-react-philosophy--mental-model)
2. [Environment Setup & Tooling](#2-environment-setup--tooling)
3. [JSX: The Complete Guide](#3-jsx-the-complete-guide)
4. [Components Deep Dive](#4-components-deep-dive)
5. [Props: Data Flow in React](#5-props-data-flow-in-react)

### Part II: State & Lifecycle
6. [State Management with useState](#6-state-management-with-usestate)
7. [Side Effects with useEffect](#7-side-effects-with-useeffect)
8. [The Complete Hooks Reference](#8-the-complete-hooks-reference)

### Part III: Interactivity & Forms
9. [Event Handling](#9-event-handling)
10. [Forms & Validation](#10-forms--validation)
11. [Lists & Keys](#11-lists--keys)

### Part IV: Routing
12. [React Router Complete Guide](#12-react-router-complete-guide)

### Part V: Advanced Patterns
13. [Component Composition Patterns](#13-component-composition-patterns)
14. [Advanced State Management](#14-advanced-state-management)
15. [Performance Optimization](#15-performance-optimization)

### Part VI: React Internals
16. [Virtual DOM & Reconciliation](#16-virtual-dom--reconciliation)
17. [Fiber Architecture](#17-fiber-architecture)
18. [Concurrent React](#18-concurrent-react)

### Part VII: Production & Best Practices
19. [Testing React Applications](#19-testing-react-applications)
20. [Error Handling & Boundaries](#20-error-handling--boundaries)
21. [TypeScript with React](#21-typescript-with-react)
22. [Best Practices & Patterns](#22-best-practices--patterns)

---

## Part I: Fundamentals & Core Concepts

---

## 1. React Philosophy & Mental Model

### What is React?

React is a **declarative, component-based JavaScript library** for building user interfaces. Let's break down what this means:

**Declarative Programming**: You describe *what* the UI should look like for any given state, not *how* to change it.

```javascript
// Imperative (jQuery-style)
const button = document.getElementById('myButton');
button.addEventListener('click', () => {
  const counter = document.getElementById('counter');
  counter.textContent = parseInt(counter.textContent) + 1;
});

// Declarative (React-style)
function Counter() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <p>{count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

### The Virtual DOM Concept

React maintains a lightweight copy of the actual DOM in memory (the Virtual DOM). When state changes:

1. React creates a new Virtual DOM tree
2. Compares it with the previous tree (diffing)
3. Calculates the minimum changes needed
4. Updates only those parts of the real DOM

**Why is this fast?**
- DOM manipulation is expensive (triggers reflows/repaints)
- JavaScript operations are cheap
- Batching multiple changes reduces browser work

### Unidirectional Data Flow

Data flows in one direction: **top-down** (parent → child) via props.

```
[App State]
    ↓ props
[Parent Component]
    ↓ props
[Child Component]
```

When child needs to communicate up, parent passes a callback function down.

---

## 2. Environment Setup & Tooling

### Modern React Project Setup

**Option 1: Vite (Recommended for 2025)**

Vite is blazingly fast and provides instant Hot Module Replacement (HMR).

```bash
# Create project
npm create vite@latest my-app -- --template react

# Navigate and install
cd my-app
npm install

# Start dev server
npm run dev
```

**Option 2: Create React App (Legacy, still widely used)**

```bash
npx create-react-app my-app
cd my-app
npm start
```

**Option 3: Next.js (Full-stack React framework)**

```bash
npx create-next-app@latest my-app
```

### Project Structure (Recommended)

```
my-app/
├── public/
│   └── index.html
├── src/
│   ├── components/      # Reusable components
│   │   ├── Button/
│   │   │   ├── Button.jsx
│   │   │   ├── Button.css
│   │   │   └── Button.test.jsx
│   ├── pages/          # Page components (if using routing)
│   ├── hooks/          # Custom hooks
│   ├── contexts/       # Context providers
│   ├── utils/          # Helper functions
│   ├── services/       # API calls
│   ├── App.jsx
│   └── main.jsx
├── package.json
└── vite.config.js
```

### Essential Dependencies

```bash
# Routing
npm install react-router-dom

# State Management
npm install zustand          # Lightweight
npm install @reduxjs/toolkit react-redux  # Advanced

# Server State
npm install @tanstack/react-query

# Forms
npm install react-hook-form
npm install zod              # Schema validation

# HTTP Client
npm install axios

# Testing
npm install -D vitest @testing-library/react @testing-library/jest-dom
```

---

## 3. JSX: The Complete Guide

### What is JSX?

JSX is a syntax extension that lets you write HTML-like code in JavaScript. It's **not** a template language—it's syntactic sugar for function calls.

### JSX Transformation

**Before (JSX):**
```jsx
const element = <h1 className="greeting">Hello, world!</h1>;
```

**After (Classic Transform - React 17-):**
```javascript
const element = React.createElement(
  'h1',
  { className: 'greeting' },
  'Hello, world!'
);
```

**After (New Transform - React 17+):**
```javascript
import { jsx as _jsx } from 'react/jsx-runtime';
const element = _jsx('h1', { 
  className: 'greeting', 
  children: 'Hello, world!' 
});
```

**Key Benefit**: You no longer need `import React from 'react'` in every file with the new transform.

### JSX Rules & Gotchas

#### 1. Single Root Element

**❌ Wrong:**
```jsx
function App() {
  return (
    <h1>Title</h1>
    <p>Paragraph</p>
  );
}
```

**✅ Correct (with Fragment):**
```jsx
function App() {
  return (
    <>
      <h1>Title</h1>
      <p>Paragraph</p>
    </>
  );
}
```

**✅ Correct (with array):**
```jsx
function App() {
  return [
    <h1 key="title">Title</h1>,
    <p key="para">Paragraph</p>
  ];
}
```

#### 2. Self-Closing Tags

All tags must be closed, even self-closing HTML elements.

```jsx
// ✅ Correct
<img src="photo.jpg" />
<input type="text" />
<br />

// ❌ Wrong
<img src="photo.jpg">
<input type="text">
<br>
```

#### 3. Reserved Words

Use `className` instead of `class`, `htmlFor` instead of `for`.

```jsx
<label htmlFor="name" className="label-primary">
  Name:
</label>
<input id="name" />
```

**Why?** `class` and `for` are reserved JavaScript keywords.

#### 4. JavaScript Expressions

Use `{}` to embed any JavaScript expression.

```jsx
const name = "Alice";
const time = new Date().toLocaleTimeString();
const isLoggedIn = true;

<div>
  <h1>Hello, {name}!</h1>
  <p>Current time: {time}</p>
  <p>Status: {isLoggedIn ? "Logged in" : "Guest"}</p>
  <p>Random: {Math.random()}</p>
</div>
```

**⚠️ Important**: You can embed *expressions*, not *statements*.

```jsx
// ✅ Expressions work
{user.name}
{1 + 2}
{isActive && <Component />}
{items.map(item => <li>{item}</li>)}

// ❌ Statements don't work
{if (condition) { ... }}  // Use ternary instead
{for (let i = 0; i < 10; i++) { ... }}  // Use map instead
```

### Conditional Rendering Patterns

#### Pattern 1: Ternary Operator

```jsx
function Greeting({ isLoggedIn }) {
  return (
    <div>
      {isLoggedIn ? (
        <h1>Welcome back!</h1>
      ) : (
        <h1>Please sign in.</h1>
      )}
    </div>
  );
}
```

#### Pattern 2: Logical AND

```jsx
function Mailbox({ unreadMessages }) {
  return (
    <div>
      <h1>Your Inbox</h1>
      {unreadMessages.length > 0 && (
        <h2>You have {unreadMessages.length} unread messages.</h2>
      )}
    </div>
  );
}
```

**⚠️ Gotcha**: Be careful with falsy values!

```jsx
const count = 0;

// ❌ This renders "0" on the screen!
{count && <p>Count: {count}</p>}

// ✅ Explicit boolean conversion
{count > 0 && <p>Count: {count}</p>}
{Boolean(count) && <p>Count: {count}</p>}
```

#### Pattern 3: Null for "render nothing"

```jsx
function Item({ item }) {
  if (!item) {
    return null;  // Component renders nothing
  }
  return <div>{item.name}</div>;
}
```

#### Pattern 4: IIFE for complex logic

```jsx
function ComplexConditional({ status }) {
  return (
    <div>
      {(() => {
        switch(status) {
          case 'loading': return <Spinner />;
          case 'error': return <Error />;
          case 'success': return <Data />;
          default: return null;
        }
      })()}
    </div>
  );
}
```

### Styling in JSX

#### Inline Styles

```jsx
const divStyle = {
  color: 'blue',
  backgroundColor: 'lightgray',  // camelCase!
  padding: '10px',
  fontSize: '16px'  // units required for numbers except unitless properties
};

<div style={divStyle}>Styled content</div>

// Or inline
<div style={{ margin: '20px', fontWeight: 'bold' }}>Text</div>
```

**Note**: Style values are in camelCase, not kebab-case.

---

## 4. Components Deep Dive

### Functional Components

The modern standard. A component is simply a function that returns JSX.

```jsx
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}

// Arrow function (equally valid)
const Welcome = (props) => {
  return <h1>Hello, {props.name}</h1>;
};

// Destructuring props
const Welcome = ({ name }) => <h1>Hello, {name}</h1>;
```

### Class Components (Legacy, but important to know)

Before Hooks (React 16.8), this was the only way to use state and lifecycle methods.

```jsx
import React, { Component } from 'react';

class Welcome extends Component {
  constructor(props) {
    super(props);
    this.state = { count: 0 };
    
    // Binding is necessary for event handlers
    this.handleClick = this.handleClick.bind(this);
  }

  componentDidMount() {
    console.log('Component mounted');
  }

  componentDidUpdate(prevProps, prevState) {
    console.log('Component updated');
  }

  componentWillUnmount() {
    console.log('Component will unmount');
  }

  handleClick() {
    this.setState({ count: this.state.count + 1 });
  }

  render() {
    return (
      <div>
        <p>{this.state.count}</p>
        <button onClick={this.handleClick}>Increment</button>
      </div>
    );
  }
}
```

**Modern Equivalent (Functional with Hooks):**

```jsx
import { useState, useEffect } from 'react';

function Welcome() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    console.log('Component mounted');
    return () => console.log('Component will unmount');
  }, []);

  useEffect(() => {
    console.log('Component updated');
  });

  const handleClick = () => setCount(count + 1);

  return (
    <div>
      <p>{count}</p>
      <button onClick={handleClick}>Increment</button>
    </div>
  );
}
```

### Component Naming Conventions

**✅ PascalCase for components:**
```jsx
function UserProfile() { }
function NavBar() { }
```

**❌ camelCase won't work:**
```jsx
// This is treated as a DOM tag, not a component!
function userProfile() { }
<userProfile />  // React looks for <userprofile> HTML element
```

---

## 5. Props: Data Flow in React

### Basic Props

Props are **read-only**. A component must never modify its own props.

```jsx
function Greeting({ name, age }) {
  // ❌ Never do this!
  // name = "Something else";
  
  return <h1>Hello, {name}. You are {age} years old.</h1>;
}

// Usage
<Greeting name="Alice" age={30} />
```

### Default Props

```jsx
function Button({ label = "Click me", variant = "primary" }) {
  return <button className={variant}>{label}</button>;
}

// Or with defaultProps (older pattern)
Button.defaultProps = {
  label: "Click me",
  variant: "primary"
};
```

### Props Destructuring Patterns

```jsx
// Basic destructuring
function User({ name, email }) {
  return <div>{name} - {email}</div>;
}

// With rest operator
function User({ name, ...otherProps }) {
  return <div {...otherProps}>{name}</div>;
}

// Nested destructuring
function User({ user: { name, address: { city } } }) {
  return <div>{name} from {city}</div>;
}

// With default values
function User({ name = "Guest", isAdmin = false }) {
  return <div>{name} {isAdmin && "(Admin)"}</div>;
}
```

### The `children` Prop

`children` is a special prop that contains the content between component tags.

```jsx
function Card({ children }) {
  return (
    <div className="card">
      {children}
    </div>
  );
}

// Usage
<Card>
  <h2>Title</h2>
  <p>Content here</p>
</Card>
```

**Advanced children manipulation:**

```jsx
import { Children } from 'react';

function List({ children }) {
  const items = Children.toArray(children);
  
  return (
    <ul>
      {items.map((child, index) => (
        <li key={index}>{child}</li>
      ))}
    </ul>
  );
}
```

### Spreading Props

```jsx
const userProps = {
  name: "Alice",
  age: 30,
  email: "alice@example.com"
};

// Spread all props
<User {...userProps} />

// Equivalent to:
<User name="Alice" age={30} email="alice@example.com" />

// Combine with explicit props (explicit props take precedence)
<User {...userProps} name="Bob" />  // name will be "Bob"
```

### Prop Validation (PropTypes)

```jsx
import PropTypes from 'prop-types';

function User({ name, age, email, role }) {
  return <div>{name}</div>;
}

User.propTypes = {
  name: PropTypes.string.isRequired,
  age: PropTypes.number,
  email: PropTypes.string,
  role: PropTypes.oneOf(['admin', 'user', 'guest']),
  onSave: PropTypes.func,
  config: PropTypes.shape({
    theme: PropTypes.string,
    lang: PropTypes.string
  })
};
```

**Note**: PropTypes are only checked in development mode.

---

## 6. State Management with useState

### The useState Hook

State is data that changes over time. When state changes, React re-renders the component.

```jsx
import { useState } from 'react';

function Counter() {
  // [stateVariable, setterFunction] = useState(initialValue)
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>+</button>
      <button onClick={() => setCount(count - 1)}>-</button>
      <button onClick={() => setCount(0)}>Reset</button>
    </div>
  );
}
```

### State Updates are Asynchronous

State updates don't happen immediately—they're scheduled.

```jsx
function Counter() {
  const [count, setCount] = useState(0);
  
  const handleClick = () => {
    setCount(count + 1);
    console.log(count);  // ❌ Still shows old value!
    // The component hasn't re-rendered yet
  };
  
  // ✅ To see the new value, use useEffect
  useEffect(() => {
    console.log('Count changed:', count);
  }, [count]);
}
```

### Functional Updates

When the new state depends on the previous state, use the functional form.

```jsx
// ❌ Problematic (multiple updates in sequence)
setCount(count + 1);
setCount(count + 1);  // Count only increases by 1, not 2!

// ✅ Correct (functional update)
setCount(prevCount => prevCount + 1);
setCount(prevCount => prevCount + 1);  // Count increases by 2
```

**Why does this happen?** State updates are batched. When you write `setCount(count + 1)` twice, both read the same `count` value (closure).

### Multiple State Variables

```jsx
function Form() {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [age, setAge] = useState(0);
  const [isSubscribed, setIsSubscribed] = useState(false);
  
  return (
    <form>
      <input 
        value={name} 
        onChange={(e) => setName(e.target.value)} 
      />
      <input 
        value={email} 
        onChange={(e) => setEmail(e.target.value)} 
      />
      {/* ... */}
    </form>
  );
}
```

### State with Objects

When state is an object, you must manually merge updates.

```jsx
function UserProfile() {
  const [user, setUser] = useState({
    name: 'Alice',
    email: 'alice@example.com',
    age: 30
  });
  
  const updateName = (newName) => {
    // ❌ Wrong - this replaces the entire object!
    setUser({ name: newName });
    
    // ✅ Correct - spread the existing state
    setUser({ ...user, name: newName });
    
    // ✅ Or functional form
    setUser(prevUser => ({ ...prevUser, name: newName }));
  };
  
  return <input value={user.name} onChange={(e) => updateName(e.target.value)} />;
}
```

### State with Arrays

```jsx
function TodoList() {
  const [todos, setTodos] = useState([]);
  
  // Add item
  const addTodo = (text) => {
    setTodos([...todos, { id: Date.now(), text }]);
  };
  
  // Remove item
  const removeTodo = (id) => {
    setTodos(todos.filter(todo => todo.id !== id));
  };
  
  // Update item
  const updateTodo = (id, newText) => {
    setTodos(todos.map(todo => 
      todo.id === id ? { ...todo, text: newText } : todo
    ));
  };
  
  return (
    <div>
      {todos.map(todo => (
        <div key={todo.id}>
          {todo.text}
          <button onClick={() => removeTodo(todo.id)}>Delete</button>
        </div>
      ))}
    </div>
  );
}
```

### Lazy Initialization

If the initial state requires expensive computation, use a function.

```jsx
// ❌ This expensive function runs on every render!
const [data, setData] = useState(expensiveComputation());

// ✅ Function is called only once (on mount)
const [data, setData] = useState(() => expensiveComputation());

// Example: Reading from localStorage
const [user, setUser] = useState(() => {
  const saved = localStorage.getItem('user');
  return saved ? JSON.parse(saved) : null;
});
```

---

## 7. Side Effects with useEffect

`useEffect` is for performing side effects: data fetching, subscriptions, manually changing the DOM, timers, etc.

### Basic Syntax

```jsx
useEffect(() => {
  // Effect code runs after render
  
  return () => {
    // Cleanup function (optional)
  };
}, [dependencies]);
```

### Dependency Array Behaviors

#### No dependency array: Runs after every render

```jsx
useEffect(() => {
  console.log('Runs after every render');
});
```

#### Empty array: Runs only once (on mount)

```jsx
useEffect(() => {
  console.log('Runs once when component mounts');
  
  return () => {
    console.log('Runs when component unmounts');
  };
}, []);
```

#### With dependencies: Runs when dependencies change

```jsx
const [count, setCount] = useState(0);

useEffect(() => {
  console.log('Count changed to:', count);
}, [count]);  // Only re-runs when count changes
```

### Data Fetching with useEffect

```jsx
function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    // Reset state when userId changes
    setLoading(true);
    setError(null);
    
    fetch(`/api/users/${userId}`)
      .then(res => {
        if (!res.ok) throw new Error('Failed to fetch');
        return res.json();
      })
      .then(data => {
        setUser(data);
        setLoading(false);
      })
      .catch(err => {
        setError(err.message);
        setLoading(false);
      });
  }, [userId]);
  
  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error}</div>;
  return <div>{user.name}</div>;
}
```

### Race Conditions & Cleanup

If `userId` changes while a fetch is in progress, you'll have a race condition!

```jsx
useEffect(() => {
  let cancelled = false;  // Cleanup flag
  
  fetch(`/api/users/${userId}`)
    .then(res => res.json())
    .then(data => {
      if (!cancelled) {  // Only update if not cancelled
        setUser(data);
      }
    });
  
  return () => {
    cancelled = true;  // Cleanup: mark as cancelled
  };
}, [userId]);
```

**Better: Use AbortController (modern approach)**

```jsx
useEffect(() => {
  const controller = new AbortController();
  
  fetch(`/api/users/${userId}`, { signal: controller.signal })
    .then(res => res.json())
    .then(data => setUser(data))
    .catch(error => {
      if (error.name !== 'AbortError') {
        setError(error);
      }
    });
  
  return () => {
    controller.abort();  // Cleanup: cancel fetch
  };
}, [userId]);
```

### Event Listeners

```jsx
function WindowSize() {
  const [size, setSize] = useState({ width: window.innerWidth, height: window.innerHeight });
  
  useEffect(() => {
    const handleResize = () => {
      setSize({ width: window.innerWidth, height: window.innerHeight });
    };
    
    window.addEventListener('resize', handleResize);
    
    // Cleanup: remove listener when component unmounts
    return () => {
      window.removeEventListener('resize', handleResize);
    };
  }, []);  // Empty array = only set up once
  
  return <div>{size.width} x {size.height}</div>;
}
```

### Timers & Intervals

```jsx
function Timer() {
  const [seconds, setSeconds] = useState(0);
  
  useEffect(() => {
    const interval = setInterval(() => {
      setSeconds(s => s + 1);  // Functional update!
    }, 1000);
    
    // Cleanup: clear interval
    return () => clearInterval(interval);
  }, []);
  
  return <div>Seconds: {seconds}</div>;
}
```

### useEffect vs useLayoutEffect

**`useEffect`**: Runs **after** browser paint (asynchronous)
- Use for: data fetching, subscriptions, logging
- Doesn't block visual updates

**`useLayoutEffect`**: Runs **before** browser paint (synchronous)
- Use for: DOM measurements, preventing visual flicker
- Blocks visual updates until complete

```jsx
function Tooltip() {
  const [tooltip, setTooltip] = useState({ top: 0, left: 0 });
  const ref = useRef();
  
  useLayoutEffect(() => {
    // Measure DOM node position BEFORE paint
    const { top, left, height } = ref.current.getBoundingClientRect();
    setTooltip({ top: top + height, left });
  }, []);
  
  return (
    <div>
      <div ref={ref}>Hover me</div>
      <div style={{ position: 'absolute', ...tooltip }}>Tooltip</div>
    </div>
  );
}
```

---

## 8. The Complete Hooks Reference

### useContext

Share data without passing props through every level.

```jsx
import { createContext, useContext, useState } from 'react';

// 1. Create Context
const ThemeContext = createContext();

// 2. Provider Component
function App() {
  const [theme, setTheme] = useState('light');
  
  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      <Toolbar />
    </ThemeContext.Provider>
  );
}

// 3. Consumer Component
function ThemedButton() {
  const { theme, setTheme } = useContext(ThemeContext);
  
  return (
    <button 
      style={{ background: theme === 'dark' ? '#333' : '#fff' }}
      onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
    >
      Toggle Theme
    </button>
  );
}
```

### useReducer

Alternative to `useState` for complex state logic.

```jsx
import { useReducer } from 'react';

// 1. Define reducer function
function reducer(state, action) {
  switch (action.type) {
    case 'increment':
      return { count: state.count + 1 };
    case 'decrement':
      return { count: state.count - 1 };
    case 'reset':
      return { count: 0 };
    default:
      throw new Error(`Unknown action: ${action.type}`);
  }
}

// 2. Use in component
function Counter() {
  const [state, dispatch] = useReducer(reducer, { count: 0 });
  
  return (
    <div>
      <p>Count: {state.count}</p>
      <button onClick={() => dispatch({ type: 'increment' })}>+</button>
      <button onClick={() => dispatch({ type: 'decrement' })}>-</button>
      <button onClick={() => dispatch({ type: 'reset' })}>Reset</button>
    </div>
  );
}
```

**Complex Example: Todo App**

```jsx
function todoReducer(state, action) {
  switch (action.type) {
    case 'add':
      return [...state, { id: Date.now(), text: action.text, done: false }];
    case 'remove':
      return state.filter(todo => todo.id !== action.id);
    case 'toggle':
      return state.map(todo =>
        todo.id === action.id ? { ...todo, done: !todo.done } : todo
      );
    default:
      return state;
  }
}

function TodoApp() {
  const [todos, dispatch] = useReducer(todoReducer, []);
  const [input, setInput] = useState('');
  
  const handleSubmit = (e) => {
    e.preventDefault();
    dispatch({ type: 'add', text: input });
    setInput('');
  };
  
  return (
    <div>
      <form onSubmit={handleSubmit}>
        <input value={input} onChange={(e) => setInput(e.target.value)} />
        <button>Add</button>
      </form>
      
      {todos.map(todo => (
        <div key={todo.id}>
          <input 
            type="checkbox" 
            checked={todo.done}
            onChange={() => dispatch({ type: 'toggle', id: todo.id })}
          />
          <span style={{ textDecoration: todo.done ? 'line-through' : 'none' }}>
            {todo.text}
          </span>
          <button onClick={() => dispatch({ type: 'remove', id: todo.id })}>X</button>
        </div>
      ))}
    </div>
  );
}
```

### useRef

Persist values between renders without causing re-renders, or access DOM nodes directly.

**Use Case 1: DOM Access**

```jsx
function TextInput() {
  const inputRef = useRef(null);
  
  const focusInput = () => {
    inputRef.current.focus();
  };
  
  return (
    <div>
      <input ref={inputRef} />
      <button onClick={focusInput}>Focus Input</button>
    </div>
  );
}
```

**Use Case 2: Storing Mutable Values**

```jsx
function Timer() {
  const [count, setCount] = useState(0);
  const intervalRef = useRef(null);
  
  const start = () => {
    if (intervalRef.current !== null) return;  // Already running
    intervalRef.current = setInterval(() => {
      setCount(c => c + 1);
    }, 1000);
  };
  
  const stop = () => {
    clearInterval(intervalRef.current);
    intervalRef.current = null;
  };
  
  useEffect(() => {
    return () => clearInterval(intervalRef.current);  // Cleanup
  }, []);
  
  return (
    <div>
      <p>{count}</p>
      <button onClick={start}>Start</button>
      <button onClick={stop}>Stop</button>
    </div>
  );
}
```

**Use Case 3: Previous Value**

```jsx
function usePrevious(value) {
  const ref = useRef();
  
  useEffect(() => {
    ref.current = value;
  }, [value]);
  
  return ref.current;
}

// Usage
function Counter() {
  const [count, setCount] = useState(0);
  const prevCount = usePrevious(count);
  
  return (
    <div>
      <p>Now: {count}, Before: {prevCount}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

### useMemo

Memoize expensive calculations.

```jsx
import { useMemo, useState } from 'react';

function ExpensiveComponent({ items, filter }) {
  // This calculation only re-runs when items or filter changes
  const filteredItems = useMemo(() => {
    console.log('Filtering...');
    return items.filter(item => item.includes(filter));
  }, [items, filter]);
  
  return (
    <ul>
      {filteredItems.map((item, i) => <li key={i}>{item}</li>)}
    </ul>
  );
}
```

**When to use useMemo:**
✅ Expensive calculations
✅ Referential equality for deps/props
❌ Simple operations (overhead > benefit)

### useCallback

Memoize function definitions.

```jsx
import { useCallback, useState, memo } from 'react';

// Child component (memoized)
const Child = memo(function Child({ onClick }) {
  console.log('Child rendered');
  return <button onClick={onClick}>Click</button>;
});

function Parent() {
  const [count, setCount] = useState(0);
  const [other, setOther] = useState(0);
  
  // ❌ Without useCallback: new function every render → Child re-renders
  const handleClick = () => setCount(count + 1);
  
  // ✅ With useCallback: same function reference → Child doesn't re-render
  const handleClick = useCallback(() => {
    setCount(c => c + 1);
  }, []);  // No dependencies, function never changes
  
  return (
    <div>
      <p>Count: {count}</p>
      <p>Other: {other}</p>
      <button onClick={() => setOther(other + 1)}>Update Other</button>
      <Child onClick={handleClick} />
    </div>
  );
}
```

### Custom Hooks

Extract component logic into reusable functions. **Must start with "use"**.

**Example 1: useLocalStorage**

```jsx
function useLocalStorage(key, initialValue) {
  const [value, setValue] = useState(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      return initialValue;
    }
  });
  
  const setStoredValue = (newValue) => {
    try {
      setValue(newValue);
      window.localStorage.setItem(key, JSON.stringify(newValue));
    } catch (error) {
      console.error(error);
    }
  };
  
  return [value, setStoredValue];
}

// Usage
function App() {
  const [name, setName] = useLocalStorage('name', '');
  
  return (
    <input 
      value={name} 
      onChange={(e) => setName(e.target.value)} 
    />
  );
}
```

**Example 2: useFetch**

```jsx
function useFetch(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    const controller = new AbortController();
    
    fetch(url, { signal: controller.signal })
      .then(res => res.json())
      .then(setData)
      .catch(setError)
      .finally(() => setLoading(false));
    
    return () => controller.abort();
  }, [url]);
  
  return { data, loading, error };
}

// Usage
function UserProfile({ userId }) {
  const { data, loading, error } = useFetch(`/api/users/${userId}`);
  
  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  return <div>{data.name}</div>;
}
```

---

## 9. Event Handling

### Basic Event Handling

React events are **SyntheticEvents** (cross-browser wrapper around native events).

```jsx
function Button() {
  const handleClick = (event) => {
    event.preventDefault();  // Prevent default behavior
    event.stopPropagation();  // Stop event bubbling
    console.log('Clicked!', event.target);
  };
  
  return <button onClick={handleClick}>Click Me</button>;
}
```

### Passing Arguments to Event Handlers

```jsx
function TodoList() {
  const handleDelete = (id) => {
    console.log('Deleting', id);
  };
  
  return (
    <div>
      {/* Method 1: Arrow function */}
      <button onClick={() => handleDelete(123)}>Delete</button>
      
      {/* Method 2: bind */}
      <button onClick={handleDelete.bind(null, 123)}>Delete</button>
    </div>
  );
}
```

### Event Types

```jsx
function Events() {
  return (
    <div>
      {/* Mouse Events */}
      <button onClick={() => {}}>onClick</button>
      <div onMouseEnter={() => {}}>onMouseEnter</div>
      <div onMouseLeave={() => {}}>onMouseLeave</div>
      
      {/* Form Events */}
      <input onChange={(e) => {}} />
      <form onSubmit={(e) => e.preventDefault()}>
        <input />
      </form>
      
      {/* Keyboard Events */}
      <input 
        onKeyDown={(e) => console.log(e.key)}
        onKeyPress={(e) => {}}
        onKeyUp={(e) => {}}
      />
      
      {/* Focus Events */}
      <input 
        onFocus={() => {}}
        onBlur={() => {}}
      />
    </div>
  );
}
```

---

## 10. Forms & Validation

### Controlled Components

The React state is the "single source of truth".

```jsx
function LoginForm() {
  const [formData, setFormData] = useState({
    email: '',
    password: '',
    rememberMe: false
  });
  
  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value
    }));
  };
  
  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Submitted:', formData);
  };
  
  return (
    <form onSubmit={handleSubmit}>
      <input 
        name="email"
        type="email"
        value={formData.email}
        onChange={handleChange}
      />
      
      <input 
        name="password"
        type="password"
        value={formData.password}
        onChange={handleChange}
      />
      
      <label>
        <input 
          name="rememberMe"
          type="checkbox"
          checked={formData.rememberMe}
          onChange={handleChange}
        />
        Remember me
      </label>
      
      <button type="submit">Login</button>
    </form>
  );
}
```

### Multiple Input Types

```jsx
function AllInputs() {
  const [values, setValues] = useState({
    text: '',
    email: '',
    number: 0,
    date: '',
    textarea: '',
    select: '',
    radio: '',
    checkbox: false,
    file: null
  });
  
  const handleChange = (e) => {
    const { name, value, type, checked, files } = e.target;
    
    setValues(prev => ({
      ...prev,
      [name]: type === 'checkbox' ? checked 
            : type === 'file' ? files[0]
            : value
    }));
  };
  
  return (
    <form>
      <input type="text" name="text" value={values.text} onChange={handleChange} />
      <input type="email" name="email" value={values.email} onChange={handleChange} />
      <input type="number" name="number" value={values.number} onChange={handleChange} />
      <input type="date" name="date" value={values.date} onChange={handleChange} />
      
      <textarea name="textarea" value={values.textarea} onChange={handleChange} />
      
      <select name="select" value={values.select} onChange={handleChange}>
        <option value="">Choose...</option>
        <option value="a">Option A</option>
        <option value="b">Option B</option>
      </select>
      
      <label>
        <input type="radio" name="radio" value="yes" 
          checked={values.radio === 'yes'} onChange={handleChange} /> Yes
      </label>
      <label>
        <input type="radio" name="radio" value="no" 
          checked={values.radio === 'no'} onChange={handleChange} /> No
      </label>
      
      <label>
        <input type="checkbox" name="checkbox" 
          checked={values.checkbox} onChange={handleChange} /> Accept
      </label>
      
      <input type="file" name="file" onChange={handleChange} />
    </form>
  );
}
```

### Form Validation

```jsx
function SignupForm() {
  const [values, setValues] = useState({ email: '', password: '' });
  const [errors, setErrors] = useState({});
  const [touched, setTouched] = useState({});
  
  const validate = () => {
    const newErrors = {};
    
    if (!values.email) {
      newErrors.email = 'Email is required';
    } else if (!/\S+@\S+\.\S+/.test(values.email)) {
      newErrors.email = 'Email is invalid';
    }
    
    if (!values.password) {
      newErrors.password = 'Password is required';
    } else if (values.password.length < 6) {
      newErrors.password = 'Password must be at least 6 characters';
    }
    
    return newErrors;
  };
  
  const handleChange = (e) => {
    const { name, value } = e.target;
    setValues(prev => ({ ...prev, [name]: value }));
    
    // Clear error when user starts typing
    if (touched[name]) {
      setErrors(prev => ({ ...prev, [name]: '' }));
    }
  };
  
  const handleBlur = (e) => {
    const { name } = e.target;
    setTouched(prev => ({ ...prev, [name]: true }));
    
    const newErrors = validate();
    setErrors(newErrors);
  };
  
  const handleSubmit = (e) => {
    e.preventDefault();
    
    const newErrors = validate();
    setErrors(newErrors);
    
    if (Object.keys(newErrors).length === 0) {
      console.log('Form is valid!', values);
    }
  };
  
  return (
    <form onSubmit={handleSubmit}>
      <div>
        <input 
          name="email"
          value={values.email}
          onChange={handleChange}
          onBlur={handleBlur}
        />
        {errors.email && <span style={{color: 'red'}}>{errors.email}</span>}
      </div>
      
      <div>
        <input 
          name="password"
          type="password"
          value={values.password}
          onChange={handleChange}
          onBlur={handleBlur}
        />
        {errors.password && <span style={{color: 'red'}}>{errors.password}</span>}
      </div>
      
      <button type="submit">Sign Up</button>
    </form>
  );
}
```

---

## 11. Lists & Keys

### Rendering Lists

```jsx
function TodoList() {
  const todos = [
    { id: 1, text: 'Learn React' },
    { id: 2, text: 'Build a project' },
    { id: 3, text: 'Deploy it' }
  ];
  
  return (
    <ul>
      {todos.map(todo => (
        <li key={todo.id}>{todo.text}</li>
      ))}
    </ul>
  );
}
```

### Why Keys Matter

Keys help React identify which items have changed, are added, or are removed.

**❌ Bad: Using index as key**

```jsx
// Problems when list order changes or items are removed
{items.map((item, index) => (
  <Item key={index} {...item} />
))}
```

**✅ Good: Using unique IDs**

```jsx
{items.map(item => (
  <Item key={item.id} {...item} />
))}
```

**What happens without proper keys:**

```jsx
// Initial render
<li key={0}>Apple</li>
<li key={1}>Banana</li>

// After removing "Apple" - React reuses the DOM!
<li key={0}>Banana</li>  // React thinks this is still "Apple" 🐛
```

---

## 12. React Router Complete Guide

### Installation

```bash
npm install react-router-dom
```

### Basic Setup

```jsx
// main.jsx
import { createBrowserRouter, RouterProvider } from 'react-router-dom';

const router = createBrowserRouter([
  {
    path: '/',
    element: <Home />
  },
  {
    path: '/about',
    element: <About />
  },
  {
    path: '/contact',
    element: <Contact />
  }
]);

ReactDOM.createRoot(document.getElementById('root')).render(
  <RouterProvider router={router} />
);
```

### Navigation with Link

```jsx
import { Link, NavLink } from 'react-router-dom';

function Navigation() {
  return (
    <nav>
      <Link to="/">Home</Link>
      <Link to="/about">About</Link>
      
      {/* NavLink adds "active" class when route matches */}
      <NavLink 
        to="/contact"
        className={({ isActive }) => isActive ? 'nav-active' : ''}
      >
        Contact
      </NavLink>
    </nav>
  );
}
```

### Dynamic Routes

```jsx
const router = createBrowserRouter([
  {
    path: '/users/:userId',
    element: <UserProfile />
  }
]);

// In component
import { useParams } from 'react-router-dom';

function UserProfile() {
  const { userId } = useParams();
  
  return <div>User ID: {userId}</div>;
}
```

### Programmatic Navigation

```jsx
import { useNavigate } from 'react-router-dom';

function LoginForm() {
  const navigate = useNavigate();
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    // ... login logic
    navigate('/dashboard');  // Redirect after login
  };
  
  return <form onSubmit={handleSubmit}>...</form>;
}
```

### Nested Routes & Layouts

```jsx
import { Outlet } from 'react-router-dom';

function Layout() {
  return (
    <div>
      <header>Header</header>
      <Outlet />  {/* Child routes render here */}
      <footer>Footer</footer>
    </div>
  );
}

const router = createBrowserRouter([
  {
    path: '/',
    element: <Layout />,
    children: [
      { index: true, element: <Home /> },
      { path: 'about', element: <About /> },
      { path: 'contact', element: <Contact /> }
    ]
  }
]);
```

### Loaders (React Router 6.4+)

Fetch data before rendering the route.

```jsx
const router = createBrowserRouter([
  {
    path: '/users/:userId',
    element: <UserProfile />,
    loader: async ({ params }) => {
      const response = await fetch(`/api/users/${params.userId}`);
      if (!response.ok) throw new Error('User not found');
      return response.json();
    }
  }
]);

// In component
import { useLoaderData } from 'react-router-dom';

function UserProfile() {
  const user = useLoaderData();  // Data is already loaded!
  
  return <div>Hello, {user.name}</div>;
}
```

### Actions (Form Handling)

```jsx
import { Form, redirect } from 'react-router-dom';

const router = createBrowserRouter([
  {
    path: '/users/create',
    element: <CreateUser />,
    action: async ({ request }) => {
      const formData = await request.formData();
      const user = Object.fromEntries(formData);
      
      await fetch('/api/users', {
        method: 'POST',
        body: JSON.stringify(user)
      });
      
      return redirect('/users');
    }
  }
]);

function CreateUser() {
  return (
    <Form method="post">
      <input name="name" />
      <input name="email" />
      <button type="submit">Create</button>
    </Form>
  );
}
```

### Protected Routes

```jsx
function ProtectedRoute({ children }) {
  const { isAuthenticated } = useAuth();
  
  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }
  
  return children;
}

const router = createBrowserRouter([
  {
    path: '/dashboard',
    element: (
      <ProtectedRoute>
        <Dashboard />
      </ProtectedRoute>
    )
  }
]);
```

---

## 13. Component Composition Patterns

### Compound Components

Components that work together implicitly through context.

```jsx
import { createContext, useContext, useState } from 'react';

const TabContext = createContext();

function Tabs({ children }) {
  const [activeTab, setActiveTab] = useState(0);
  
  return (
    <TabContext.Provider value={{ activeTab, setActiveTab }}>
      <div>{children}</div>
    </TabContext.Provider>
  );
}

Tabs.List = function TabList({ children }) {
  return <div className="tab-list">{children}</div>;
};

Tabs.Tab = function Tab({ index, children }) {
  const { activeTab, setActiveTab } = useContext(TabContext);
  return (
    <button 
      className={activeTab === index ? 'active' : ''}
      onClick={() => setActiveTab(index)}
    >
      {children}
    </button>
  );
};

Tabs.Panel = function TabPanel({ index, children }) {
  const { activeTab } = useContext(TabContext);
  return activeTab === index ? <div>{children}</div> : null;
};

// Usage
<Tabs>
  <Tabs.List>
    <Tabs.Tab index={0}>Tab 1</Tabs.Tab>
    <Tabs.Tab index={1}>Tab 2</Tabs.Tab>
  </Tabs.List>
  
  <Tabs.Panel index={0}>Content 1</Tabs.Panel>
  <Tabs.Panel index={1}>Content 2</Tabs.Panel>
</Tabs>
```

### Render Props

```jsx
function DataFetcher({ url, render }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    fetch(url)
      .then(res => res.json())
      .then(data => {
        setData(data);
        setLoading(false);
      });
  }, [url]);
  
  return render({ data, loading });
}

// Usage
<DataFetcher 
  url="/api/users" 
  render={({ data, loading }) => (
    loading ? <Spinner /> : <UserList users={data} />
  )}
/>
```

### Higher-Order Components (HOC)

A function that takes a component and returns a new component.

```jsx
function withAuth(Component) {
  return function AuthenticatedComponent(props) {
    const { isAuthenticated } = useAuth();
    
    if (!isAuthenticated) {
      return <Navigate to="/login" />;
    }
    
    return <Component {...props} />;
  };
}

// Usage
const ProtectedDashboard = withAuth(Dashboard);
```

---

## 14. Advanced State Management

### Context API at Scale

Splitting contexts to avoid unnecessary re-renders.

```jsx
// ❌ Bad: Everything in one context
const AppContext = createContext();

function AppProvider({ children }) {
  const [user, setUser] = useState(null);
  const [theme, setTheme] = useState('light');
  const [notifications, setNotifications] = useState([]);
  
  // Any change re-renders ALL consumers!
  return (
    <AppContext.Provider value={{ user, theme, notifications }}>
      {children}
    </AppContext.Provider>
  );
}

// ✅ Good: Separate contexts
const UserContext = createContext();
const ThemeContext = createContext();
const NotificationContext = createContext();
```

### External State (Zustand)

```jsx
import create from 'zustand';

const useStore = create((set) => ({
  count: 0,
  increment: () => set((state) => ({ count: state.count + 1 })),
  decrement: () => set((state) => ({ count: state.count - 1 }))
}));

function Counter() {
  const { count, increment, decrement } = useStore();
  
  return (
    <div>
      <p>{count}</p>
      <button onClick={increment}>+</button>
      <button onClick={decrement}>-</button>
    </div>
  );
}
```

---

## 15. Performance Optimization

### React.memo

Prevent re-renders when props haven't changed.

```jsx
const ExpensiveComponent = React.memo(function ExpensiveComponent({ data }) {
  console.log('Rendering...');
  return <div>{data}</div>;
});

// Only re-renders when `data` changes
```

### useMemo & useCallback (Detailed)

```jsx
function ParentComponent() {
  const [count, setCount] = useState(0);
  const [items, setItems] = useState([]);
  
  // ❌ Without optimization
  const expensiveValue = items.filter(item => item.active);
  const handleClick = () => console.log('Clicked');
  
  // ✅ With optimization
  const expensiveValue = useMemo(
    () => items.filter(item => item.active),
    [items]
  );
  
  const handleClick = useCallback(
    () => console.log('Clicked'),
    []
  );
  
  return <ChildComponent onClick={handleClick} data={expensiveValue} />;
}
```

### Code Splitting

```jsx
import { lazy, Suspense } from 'react';

const HeavyComponent = lazy(() => import('./HeavyComponent'));

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <HeavyComponent />
    </Suspense>
  );
}
```

---

## 16. Virtual DOM & Reconciliation

React uses a diffing algorithm to determine what changed:

1. **Same type**: Update props
2. **Different type**: Destroy old tree, build new tree
3. **Keys**: Help identify which items changed

---

## 17. Fiber Architecture

Fiber is React's reconciliation engine that enables:
- **Incremental rendering**: Split work into chunks
- **Pause/resume**: Handle high-priority updates (user input)
- **Concurrency**: Multiple versions of UI in memory

---

## 18. Concurrent React

### useTransition

Mark state updates as non-urgent.

```jsx
import { useTransition, useState } from 'react';

function SearchList() {
  const [input, setInput] = useState('');
  const [list, setList] = useState(data);
  const [isPending, startTransition] = useTransition();
  
  const handleChange = (e) => {
    setInput(e.target.value);  // Urgent: updates immediately
    
    startTransition(() => {
      // Non-urgent: can be interrupted
      setList(filterData(e.target.value));
    });
  };
  
  return (
    <div>
      <input value={input} onChange={handleChange} />
      {isPending && <Spinner />}
      <List items={list} />
    </div>
  );
}
```

---

## 19. Testing React Applications

### React Testing Library

```jsx
import { render, screen, fireEvent } from '@testing-library/react';

test('counter increments', () => {
  render(<Counter />);
  
  const button = screen.getByRole('button', { name: /increment/i });
  const display = screen.getByText(/count: 0/i);
  
  fireEvent.click(button);
  
  expect(screen.getByText(/count: 1/i)).toBeInTheDocument();
});
```

---

## 20. Error Handling & Boundaries

```jsx
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }
  
  static getDerivedStateFromError(error) {
    return { hasError: true };
  }
  
  componentDidCatch(error, errorInfo) {
    console.log(error, errorInfo);
  }
  
  render() {
    if (this.state.hasError) {
      return <h1>Something went wrong.</h1>;
    }
    return this.props.children;
  }
}

// Usage
<ErrorBoundary>
  <App />
</ErrorBoundary>
```

---

## 21. TypeScript with React

```tsx
interface Props {
  name: string;
  age?: number;
  onClick: () => void;
}

const Component: React.FC<Props> = ({ name, age = 0, onClick }) => {
  return <div onClick={onClick}>{name} is {age}</div>;
};
```

---

## 22. Best Practices & Patterns

✅ **Do:**
- Keep components small and focused
- Use functional components + hooks
- Lift state up when needed
- Use custom hooks to extract logic
- Memoize expensive calculations

❌ **Don't:**
- Mutate state directly
- Use index as key for dynamic lists
- Put everything in global state
- Optimize prematurely

---

## Conclusion

You now have a comprehensive understanding of React from fundamentals to advanced internals. Keep building projects to cement your knowledge!

**Recommended Next Steps:**
1. Build a full-stack app with React + Node.js
2. Learn Next.js for server-side rendering
3. Study React Native for mobile
4. Contribute to open source React projects

Happy coding! 🚀
