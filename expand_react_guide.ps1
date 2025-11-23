$targetFile = "c:\Users\Shiv\Desktop\Notes\React_Mastery_Guide.md"

# Expand React guide with comprehensive additional content
$additionalContent = @'

---

## 23. Server Components & Next.js

### React Server Components (RSC)

Server Components allow you to render components on the server, reducing JavaScript bundle size and improving performance.

```jsx
// app/page.js (Server Component by default in Next.js 13+)
async function HomePage() {
  // This runs on the server
  const data = await fetch('https://api.example.com/data');
  const posts = await data.json();
  
  return (
    <div>
      <h1>Posts</h1>
      {posts.map(post => (
        <Post key={post.id} post={post} />
      ))}
    </div>
  );
}

export default HomePage;
```

**Server vs Client Components:**

```jsx
// Server Component (default)
// - Can use async/await
// - Direct database access
// - No useState, useEffect, or browser APIs
async function ServerComponent() {
  const data = await db.query('SELECT * FROM users');
  return <div>{data.map(...)}</div>;
}

// Client Component (with 'use client')
'use client';

import { useState } from 'react';

function ClientComponent() {
  const [count, setCount] = useState(0);
  
  return (
    <button onClick={() => setCount(count + 1)}>
      Count: {count}
    </button>
  );
}
```

### Next.js App Router (Next.js 13+)

**File-based Routing:**

```
app/
├── page.js                    // /
├── about/
│   └── page.js               // /about
├── blog/
│   ├── page.js               // /blog
│   └── [slug]/
│       └── page.js           // /blog/:slug
└── api/
    └── users/
        └── route.js          // /api/users
```

**Dynamic Routes:**

```jsx
// app/blog/[slug]/page.js
export default function BlogPost({ params }) {
  return <h1>Post: {params.slug}</h1>;
}

// Generate static paths
export async function generateStaticParams() {
  const posts = await getPosts();
  
  return posts.map((post) => ({
    slug: post.slug,
  }));
}
```

**Layouts:**

```jsx
// app/layout.js (Root Layout)
export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        <Header />
        <main>{children}</main>
        <Footer />
      </body>
    </html>
  );
}

// app/dashboard/layout.js (Nested Layout)
export default function DashboardLayout({ children }) {
  return (
    <div className="dashboard">
      <Sidebar />
      <div className="content">{children}</div>
    </div>
  );
}
```

**Loading & Error States:**

```jsx
// app/blog/loading.js
export default function Loading() {
  return <div>Loading posts...</div>;
}

// app/blog/error.js
'use client';

export default function Error({ error, reset }) {
  return (
    <div>
      <h2>Something went wrong!</h2>
      <p>{error.message}</p>
      <button onClick={() => reset()}>Try again</button>
    </div>
  );
}
```

**API Routes:**

```jsx
// app/api/users/route.js
import { NextResponse } from 'next/server';

export async function GET(request) {
  const users = await db.users.findMany();
  return NextResponse.json(users);
}

export async function POST(request) {
  const body = await request.json();
  const user = await db.users.create({ data: body });
  return NextResponse.json(user, { status: 201 });
}
```

**Data Fetching:**

```jsx
// Server Component - fetch with caching
async function Posts() {
  const res = await fetch('https://api.example.com/posts', {
    next: { revalidate: 3600 } // Revalidate every hour
  });
  const posts = await res.json();
  
  return <PostList posts={posts} />;
}

// No caching
const res = await fetch('https://api.example.com/posts', {
  cache: 'no-store'
});

// Static generation
const res = await fetch('https://api.example.com/posts', {
  cache: 'force-cache'
});
```

**Metadata:**

```jsx
// app/blog/[slug]/page.js
export async function generateMetadata({ params }) {
  const post = await getPost(params.slug);
  
  return {
    title: post.title,
    description: post.excerpt,
    openGraph: {
      title: post.title,
      description: post.excerpt,
      images: [post.image],
    },
  };
}
```

---

## 24. React Native Fundamentals

### Core Components

```jsx
import React from 'react';
import {
  View,
  Text,
  Image,
  ScrollView,
  TextInput,
  TouchableOpacity,
  StyleSheet
} from 'react-native';

function App() {
  const [text, setText] = React.useState('');
  
  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>My App</Text>
        <Image
          source={{ uri: 'https://example.com/logo.png' }}
          style={styles.logo}
        />
      </View>
      
      <TextInput
        style={styles.input}
        value={text}
        onChangeText={setText}
        placeholder="Enter text"
      />
      
      <TouchableOpacity
        style={styles.button}
        onPress={() => console.log('Pressed!')}
      >
        <Text style={styles.buttonText}>Press Me</Text>
      </TouchableOpacity>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
  },
  logo: {
    width: 50,
    height: 50,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ddd',
    padding: 10,
    margin: 20,
    borderRadius: 5,
  },
  button: {
    backgroundColor: '#007AFF',
    padding: 15,
    margin: 20,
    borderRadius: 5,
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
});

export default App;
```

### Flexbox Layout

```jsx
// Column layout (default)
<View style={{ flex: 1, flexDirection: 'column' }}>
  <View style={{ flex: 1, backgroundColor: 'red' }} />
  <View style={{ flex: 2, backgroundColor: 'blue' }} />
  <View style={{ flex: 1, backgroundColor: 'green' }} />
</View>

// Row layout
<View style={{ flexDirection: 'row' }}>
  <View style={{ flex: 1, backgroundColor: 'red' }} />
  <View style={{ flex: 1, backgroundColor: 'blue' }} />
</View>

// Alignment
<View style={{
  flex: 1,
  justifyContent: 'center',    // vertical alignment
  alignItems: 'center',         // horizontal alignment
}}>
  <Text>Centered</Text>
</View>
```

### Navigation (React Navigation)

```bash
npm install @react-navigation/native @react-navigation/native-stack
npm install react-native-screens react-native-safe-area-context
```

```jsx
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

const Stack = createNativeStackNavigator();

function HomeScreen({ navigation }) {
  return (
    <View>
      <Text>Home Screen</Text>
      <Button
        title="Go to Details"
        onPress={() => navigation.navigate('Details', { id: 123 })}
      />
    </View>
  );
}

function DetailsScreen({ route, navigation }) {
  const { id } = route.params;
  
  return (
    <View>
      <Text>Details Screen</Text>
      <Text>ID: {id}</Text>
      <Button title="Go Back" onPress={() => navigation.goBack()} />
    </View>
  );
}

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Details" component={DetailsScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
```

---

## 25. Advanced TypeScript Patterns

### Component Props with TypeScript

```tsx
// Basic props
interface ButtonProps {
  label: string;
  onClick: () => void;
  variant?: 'primary' | 'secondary';
  disabled?: boolean;
}

const Button: React.FC<ButtonProps> = ({
  label,
  onClick,
  variant = 'primary',
  disabled = false
}) => {
  return (
    <button
      onClick={onClick}
      disabled={disabled}
      className={`btn btn-${variant}`}
    >
      {label}
    </button>
  );
};

// Children props
interface CardProps {
  title: string;
  children: React.ReactNode;
}

const Card: React.FC<CardProps> = ({ title, children }) => {
  return (
    <div className="card">
      <h2>{title}</h2>
      <div>{children}</div>
    </div>
  );
};

// Generic components
interface ListProps<T> {
  items: T[];
  renderItem: (item: T) => React.ReactNode;
}

function List<T>({ items, renderItem }: ListProps<T>) {
  return (
    <ul>
      {items.map((item, index) => (
        <li key={index}>{renderItem(item)}</li>
      ))}
    </ul>
  );
}

// Usage
<List
  items={[1, 2, 3]}
  renderItem={(num) => <span>{num}</span>}
/>
```

### Hooks with TypeScript

```tsx
// useState with type inference
const [count, setCount] = useState(0); // inferred as number
const [name, setName] = useState(''); // inferred as string

// useState with explicit type
const [user, setUser] = useState<User | null>(null);

// useRef
const inputRef = useRef<HTMLInputElement>(null);

// Custom hook with TypeScript
function useLocalStorage<T>(key: string, initialValue: T) {
  const [storedValue, setStoredValue] = useState<T>(() => {
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      return initialValue;
    }
  });
  
  const setValue = (value: T | ((val: T) => T)) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value;
      setStoredValue(valueToStore);
      window.localStorage.setItem(key, JSON.stringify(valueToStore));
    } catch (error) {
      console.error(error);
    }
  };
  
  return [storedValue, setValue] as const;
}

// Usage
const [user, setUser] = useLocalStorage<User>('user', { name: '', email: '' });
```

### Event Handlers

```tsx
// Form events
const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
  e.preventDefault();
  // Handle submit
};

const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
  setValue(e.target.value);
};

// Mouse events
const handleClick = (e: React.MouseEvent<HTMLButtonElement>) => {
  console.log(e.clientX, e.clientY);
};

// Keyboard events
const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
  if (e.key === 'Enter') {
    // Handle enter
  }
};
```

### Context with TypeScript

```tsx
interface AuthContextType {
  user: User | null;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
  isAuthenticated: boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  
  const login = async (email: string, password: string) => {
    const user = await api.login(email, password);
    setUser(user);
  };
  
  const logout = () => {
    setUser(null);
  };
  
  const value = {
    user,
    login,
    logout,
    isAuthenticated: !!user
  };
  
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within AuthProvider');
  }
  return context;
};
```

---

## 26. Advanced State Management Patterns

### Zustand (Lightweight State Management)

```bash
npm install zustand
```

```tsx
import create from 'zustand';

interface BearState {
  bears: number;
  increase: () => void;
  decrease: () => void;
  reset: () => void;
}

const useBearStore = create<BearState>((set) => ({
  bears: 0,
  increase: () => set((state) => ({ bears: state.bears + 1 })),
  decrease: () => set((state) => ({ bears: state.bears - 1 })),
  reset: () => set({ bears: 0 }),
}));

// Usage
function BearCounter() {
  const bears = useBearStore((state) => state.bears);
  const increase = useBearStore((state) => state.increase);
  
  return (
    <div>
      <h1>{bears} bears</h1>
      <button onClick={increase}>Add bear</button>
    </div>
  );
}
```

### Redux Toolkit (Modern Redux)

```bash
npm install @reduxjs/toolkit react-redux
```

```tsx
// store/userSlice.ts
import { createSlice, PayloadAction } from '@reduxjs/toolkit';

interface UserState {
  user: User | null;
  loading: boolean;
  error: string | null;
}

const initialState: UserState = {
  user: null,
  loading: false,
  error: null,
};

const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    setUser: (state, action: PayloadAction<User>) => {
      state.user = action.payload;
      state.loading = false;
    },
    setLoading: (state, action: PayloadAction<boolean>) => {
      state.loading = action.payload;
    },
    setError: (state, action: PayloadAction<string>) => {
      state.error = action.payload;
      state.loading = false;
    },
  },
});

export const { setUser, setLoading, setError } = userSlice.actions;
export default userSlice.reducer;

// store/index.ts
import { configureStore } from '@reduxjs/toolkit';
import userReducer from './userSlice';

export const store = configureStore({
  reducer: {
    user: userReducer,
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;

// Usage
import { useSelector, useDispatch } from 'react-redux';
import { RootState, AppDispatch } from './store';

function UserProfile() {
  const user = useSelector((state: RootState) => state.user.user);
  const dispatch = useDispatch<AppDispatch>();
  
  return <div>{user?.name}</div>;
}
```

### TanStack Query (React Query)

```bash
npm install @tanstack/react-query
```

```tsx
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';

// Fetch data
function Users() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['users'],
    queryFn: async () => {
      const res = await fetch('/api/users');
      return res.json();
    },
  });
  
  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  
  return (
    <ul>
      {data.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}

// Mutations
function CreateUser() {
  const queryClient = useQueryClient();
  
  const mutation = useMutation({
    mutationFn: (newUser: User) => {
      return fetch('/api/users', {
        method: 'POST',
        body: JSON.stringify(newUser),
      });
    },
    onSuccess: () => {
      // Invalidate and refetch
      queryClient.invalidateQueries({ queryKey: ['users'] });
    },
  });
  
  return (
    <button onClick={() => mutation.mutate({ name: 'John' })}>
      Create User
    </button>
  );
}
```

---

## 27. Real-World Patterns & Architecture

### Feature-Based Folder Structure

```
src/
├── features/
│   ├── auth/
│   │   ├── components/
│   │   │   ├── LoginForm.tsx
│   │   │   └── RegisterForm.tsx
│   │   ├── hooks/
│   │   │   └── useAuth.ts
│   │   ├── api/
│   │   │   └── authApi.ts
│   │   ├── types/
│   │   │   └── auth.types.ts
│   │   └── index.ts
│   ├── posts/
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── api/
│   │   └── types/
│   └── users/
├── shared/
│   ├── components/
│   │   ├── Button/
│   │   ├── Input/
│   │   └── Modal/
│   ├── hooks/
│   │   ├── useDebounce.ts
│   │   └── useLocalStorage.ts
│   ├── utils/
│   │   ├── formatters.ts
│   │   └── validators.ts
│   └── types/
│       └── common.types.ts
├── layouts/
│   ├── MainLayout.tsx
│   └── DashboardLayout.tsx
├── pages/
│   ├── HomePage.tsx
│   ├── LoginPage.tsx
│   └── DashboardPage.tsx
└── App.tsx
```

### Compound Component Pattern

```tsx
// Tabs component using compound pattern
interface TabsContextType {
  activeTab: string;
  setActiveTab: (tab: string) => void;
}

const TabsContext = createContext<TabsContextType | undefined>(undefined);

function Tabs({ children, defaultTab }: { children: React.ReactNode; defaultTab: string }) {
  const [activeTab, setActiveTab] = useState(defaultTab);
  
  return (
    <TabsContext.Provider value={{ activeTab, setActiveTab }}>
      <div className="tabs">{children}</div>
    </TabsContext.Provider>
  );
}

function TabList({ children }: { children: React.ReactNode }) {
  return <div className="tab-list">{children}</div>;
}

function Tab({ id, children }: { id: string; children: React.ReactNode }) {
  const context = useContext(TabsContext);
  if (!context) throw new Error('Tab must be used within Tabs');
  
  const { activeTab, setActiveTab } = context;
  
  return (
    <button
      className={activeTab === id ? 'active' : ''}
      onClick={() => setActiveTab(id)}
    >
      {children}
    </button>
  );
}

function TabPanels({ children }: { children: React.ReactNode }) {
  return <div className="tab-panels">{children}</div>;
}

function TabPanel({ id, children }: { id: string; children: React.ReactNode }) {
  const context = useContext(TabsContext);
  if (!context) throw new Error('TabPanel must be used within Tabs');
  
  const { activeTab } = context;
  
  if (activeTab !== id) return null;
  
  return <div className="tab-panel">{children}</div>;
}

// Attach sub-components
Tabs.List = TabList;
Tabs.Tab = Tab;
Tabs.Panels = TabPanels;
Tabs.Panel = TabPanel;

// Usage
<Tabs defaultTab="home">
  <Tabs.List>
    <Tabs.Tab id="home">Home</Tabs.Tab>
    <Tabs.Tab id="profile">Profile</Tabs.Tab>
    <Tabs.Tab id="settings">Settings</Tabs.Tab>
  </Tabs.List>
  
  <Tabs.Panels>
    <Tabs.Panel id="home">Home content</Tabs.Panel>
    <Tabs.Panel id="profile">Profile content</Tabs.Panel>
    <Tabs.Panel id="settings">Settings content</Tabs.Panel>
  </Tabs.Panels>
</Tabs>
```

### Render Props Pattern

```tsx
interface MousePosition {
  x: number;
  y: number;
}

interface MouseTrackerProps {
  render: (position: MousePosition) => React.ReactNode;
}

function MouseTracker({ render }: MouseTrackerProps) {
  const [position, setPosition] = useState<MousePosition>({ x: 0, y: 0 });
  
  useEffect(() => {
    const handleMouseMove = (e: MouseEvent) => {
      setPosition({ x: e.clientX, y: e.clientY });
    };
    
    window.addEventListener('mousemove', handleMouseMove);
    return () => window.removeEventListener('mousemove', handleMouseMove);
  }, []);
  
  return <>{render(position)}</>;
}

// Usage
<MouseTracker
  render={({ x, y }) => (
    <div>
      Mouse position: {x}, {y}
    </div>
  )}
/>
```

### HOC (Higher-Order Component) Pattern

```tsx
// withAuth HOC
function withAuth<P extends object>(
  Component: React.ComponentType<P>
): React.FC<P> {
  return (props: P) => {
    const { user, isLoading } = useAuth();
    const navigate = useNavigate();
    
    useEffect(() => {
      if (!isLoading && !user) {
        navigate('/login');
      }
    }, [user, isLoading, navigate]);
    
    if (isLoading) return <div>Loading...</div>;
    if (!user) return null;
    
    return <Component {...props} />;
  };
}

// Usage
const ProtectedDashboard = withAuth(Dashboard);
```

---

## 28. Progressive Web Apps (PWA)

### Service Worker Registration

```javascript
// public/service-worker.js
const CACHE_NAME = 'my-app-v1';
const urlsToCache = [
  '/',
  '/static/css/main.css',
  '/static/js/main.js',
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => cache.addAll(urlsToCache))
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request)
      .then((response) => response || fetch(event.request))
  );
});
```

```javascript
// src/serviceWorkerRegistration.js
export function register() {
  if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
      navigator.serviceWorker
        .register('/service-worker.js')
        .then((registration) => {
          console.log('SW registered:', registration);
        })
        .catch((error) => {
          console.log('SW registration failed:', error);
        });
    });
  }
}
```

### Web App Manifest

```json
{
  "name": "My React App",
  "short_name": "MyApp",
  "description": "A progressive web app built with React",
  "start_url": "/",
  "display": "standalone",
  "theme_color": "#000000",
  "background_color": "#ffffff",
  "icons": [
    {
      "src": "/icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "/icon-512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

---

## 29. Accessibility (a11y) Best Practices

### Semantic HTML

```jsx
// ❌ Bad
<div onClick={handleClick}>Click me</div>

// ✅ Good
<button onClick={handleClick}>Click me</button>

// ❌ Bad
<div className="heading">Title</div>

// ✅ Good
<h1>Title</h1>
```

### ARIA Attributes

```jsx
function Modal({ isOpen, onClose, children }) {
  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-labelledby="modal-title"
      aria-describedby="modal-description"
    >
      <h2 id="modal-title">Modal Title</h2>
      <div id="modal-description">{children}</div>
      <button onClick={onClose} aria-label="Close modal">
        ×
      </button>
    </div>
  );
}
```

### Keyboard Navigation

```jsx
function Dropdown() {
  const [isOpen, setIsOpen] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState(0);
  
  const handleKeyDown = (e: React.KeyboardEvent) => {
    switch (e.key) {
      case 'ArrowDown':
        e.preventDefault();
        setSelectedIndex((prev) => Math.min(prev + 1, items.length - 1));
        break;
      case 'ArrowUp':
        e.preventDefault();
        setSelectedIndex((prev) => Math.max(prev - 1, 0));
        break;
      case 'Enter':
        e.preventDefault();
        selectItem(items[selectedIndex]);
        break;
      case 'Escape':
        setIsOpen(false);
        break;
    }
  };
  
  return (
    <div onKeyDown={handleKeyDown} tabIndex={0}>
      {/* Dropdown content */}
    </div>
  );
}
```

### Focus Management

```jsx
function Dialog({ isOpen, onClose }) {
  const closeButtonRef = useRef<HTMLButtonElement>(null);
  
  useEffect(() => {
    if (isOpen) {
      closeButtonRef.current?.focus();
    }
  }, [isOpen]);
  
  return (
    <div role="dialog">
      <button ref={closeButtonRef} onClick={onClose}>
        Close
      </button>
      {/* Dialog content */}
    </div>
  );
}
```

---

## 30. Deployment & Production Optimization

### Build Optimization

```javascript
// vite.config.js
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom'],
          router: ['react-router-dom'],
        },
      },
    },
    chunkSizeWarningLimit: 1000,
  },
});
```

### Code Splitting

```jsx
import { lazy, Suspense } from 'react';

// Lazy load components
const Dashboard = lazy(() => import('./pages/Dashboard'));
const Profile = lazy(() => import('./pages/Profile'));

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <Routes>
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/profile" element={<Profile />} />
      </Routes>
    </Suspense>
  );
}
```

### Environment Variables

```bash
# .env.production
VITE_API_URL=https://api.production.com
VITE_GA_ID=UA-XXXXXXXXX-X
```

```tsx
const apiUrl = import.meta.env.VITE_API_URL;
const isDev = import.meta.env.DEV;
const isProd = import.meta.env.PROD;
```

### Docker Deployment

```dockerfile
# Dockerfile
FROM node:18-alpine as build

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### CI/CD with GitHub Actions

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Run tests
        run: npm test
        
      - name: Build
        run: npm run build
        
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
```

---

## Conclusion & Advanced Resources

### Mastery Checklist

✅ **Fundamentals**
- JSX and component basics
- Props and state management
- Event handling and forms
- Lists and conditional rendering

✅ **Hooks**
- useState, useEffect, useContext
- useReducer, useMemo, useCallback
- useRef, useLayoutEffect
- Custom hooks

✅ **Routing**
- React Router setup
- Dynamic routes and parameters
- Protected routes
- Nested routing

✅ **Advanced Patterns**
- Compound components
- Render props
- Higher-order components
- Context API patterns

✅ **State Management**
- Context + useReducer
- Redux Toolkit
- Zustand
- TanStack Query

✅ **Performance**
- Code splitting
- Lazy loading
- Memoization
- Virtual scrolling

✅ **TypeScript**
- Component typing
- Props interfaces
- Generic components
- Event handlers

✅ **Testing**
- Unit tests with Jest
- Component tests with RTL
- Integration tests
- E2E tests

✅ **Production**
- Build optimization
- Deployment strategies
- Monitoring and analytics
- Error tracking

### Advanced Topics to Explore

1. **React Internals**
   - Fiber reconciliation algorithm
   - Concurrent rendering
   - Suspense and transitions
   - Server components architecture

2. **Frameworks**
   - Next.js (SSR, SSG, ISR)
   - Remix (nested routing, data loading)
   - Gatsby (static site generation)

3. **Mobile Development**
   - React Native
   - Expo
   - Native modules

4. **Advanced State**
   - Jotai (atomic state)
   - Recoil (Facebook's state library)
   - MobX (observable state)
   - XState (state machines)

5. **Animation**
   - Framer Motion
   - React Spring
   - GSAP with React

6. **3D Graphics**
   - React Three Fiber
   - Three.js integration

### Recommended Learning Path

**Month 1-2: Fundamentals**
- Build 5+ small projects
- Master hooks and component patterns
- Learn React Router

**Month 3-4: Advanced Concepts**
- State management (Redux/Zustand)
- TypeScript integration
- Testing strategies
- Performance optimization

**Month 5-6: Production Skills**
- Next.js or Remix
- Deployment and CI/CD
- Monitoring and analytics
- Real-world project architecture

**Ongoing:**
- Contribute to open source
- Stay updated with React RFCs
- Follow React core team on Twitter
- Read React source code

### Essential Resources

**Official Documentation:**
- https://react.dev
- https://nextjs.org/docs
- https://reactrouter.com

**Learning Platforms:**
- Frontend Masters
- Epic React by Kent C. Dodds
- React TypeScript Cheatsheet

**Community:**
- React Discord
- r/reactjs subreddit
- React conferences (React Conf, React Summit)

**Blogs to Follow:**
- Dan Abramov's blog
- Kent C. Dodds
- Josh Comeau
- Robin Wieruch

---

**You've reached the end of this comprehensive React mastery guide!**

Remember: The best way to learn React is by building real projects. Start small, iterate often, and gradually tackle more complex challenges. Happy coding! 🚀

'@

# Remove the old conclusion and add new comprehensive content
$content = Get-Content $targetFile -Raw
$content = $content -replace "(?s)---\s+## 21\. TypeScript with React.*$", $additionalContent
Set-Content -Path $targetFile -Value $content

Write-Host "Successfully expanded React guide with comprehensive additional content!"
Write-Host "Added sections 23-30 covering:"
Write-Host "- Server Components & Next.js"
Write-Host "- React Native"
Write-Host "- Advanced TypeScript"
Write-Host "- Advanced State Management (Zustand, Redux Toolkit, TanStack Query)"
Write-Host "- Real-World Patterns & Architecture"
Write-Host "- Progressive Web Apps"
Write-Host "- Accessibility"
Write-Host "- Deployment & Production"
