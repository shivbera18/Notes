# The Complete Next.js Mastery Guide
## From Zero to Expert: App Router, Server Components, and Production-Ready Applications

**Version**: 4.0 (Next.js 15+ Deep Dive Edition)  
**Last Updated**: December 2025  
**Target Audience**: Developers seeking mastery-level understanding of Next.js

---

## Table of Contents

### Part I: Fundamentals & Core Concepts
1. [Next.js Philosophy & Mental Model](#1-nextjs-philosophy--mental-model)
2. [Environment Setup & Project Structure](#2-environment-setup--project-structure)
3. [Routing Deep Dive](#3-routing-deep-dive)
4. [Pages & Layouts](#4-pages--layouts)
5. [Navigation & Links](#5-navigation--links)

### Part II: Data Fetching & Rendering
6. [Server Components vs Client Components](#6-server-components-vs-client-components)
7. [Data Fetching Patterns](#7-data-fetching-patterns)
8. [Caching & Revalidation](#8-caching--revalidation)
9. [Streaming & Suspense](#9-streaming--suspense)
10. [Server Actions](#10-server-actions)

### Part III: Advanced Features
11. [Metadata & SEO](#11-metadata--seo)
12. [Image Optimization](#12-image-optimization)
13. [Font Optimization](#13-font-optimization)
14. [Route Handlers (API Routes)](#14-route-handlers-api-routes)
15. [Middleware](#15-middleware)

### Part IV: Styling & UI
16. [CSS Modules & Global Styles](#16-css-modules--global-styles)
17. [Tailwind CSS Integration](#17-tailwind-css-integration)
18. [CSS-in-JS Solutions](#18-css-in-js-solutions)

### Part V: State Management & Forms
19. [Client State Management](#19-client-state-management)
20. [Server State with React Query](#20-server-state-with-react-query)
21. [Forms & Validation](#21-forms--validation)

### Part VI: Authentication & Security
22. [Authentication Patterns](#22-authentication-patterns)
23. [Authorization & Protected Routes](#23-authorization--protected-routes)
24. [Security Best Practices](#24-security-best-practices)

### Part VII: Database & Backend
25. [Database Integration](#25-database-integration)
26. [Prisma with Next.js](#26-prisma-with-nextjs)
27. [API Design Patterns](#27-api-design-patterns)

### Part VIII: Performance & Optimization
28. [Performance Optimization](#28-performance-optimization)
29. [Bundle Analysis & Code Splitting](#29-bundle-analysis--code-splitting)
30. [Monitoring & Analytics](#30-monitoring--analytics)

### Part IX: Testing & Quality
31. [Testing Strategies](#31-testing-strategies)
32. [Error Handling](#32-error-handling)
33. [TypeScript Best Practices](#33-typescript-best-practices)

### Part X: Deployment & Production
34. [Deployment Options](#34-deployment-options)
35. [Environment Variables](#35-environment-variables)
36. [CI/CD Pipelines](#36-cicd-pipelines)
37. [Production Best Practices](#37-production-best-practices)

---

## Part I: Fundamentals & Core Concepts

---

## 1. Next.js Philosophy & Mental Model

### What is Next.js?

Next.js is a **React meta-framework** that provides a complete solution for building production-ready web applications. It extends React with:

- **File-based routing** - No need for react-router
- **Server-side rendering (SSR)** - Better SEO and initial load performance
- **Static site generation (SSG)** - Pre-render pages at build time
- **API routes** - Build backend endpoints in the same codebase
- **Automatic code splitting** - Only load what's needed
- **Image optimization** - Automatic image resizing and optimization
- **Built-in CSS support** - CSS Modules, Sass, CSS-in-JS

### The Evolution: Pages Router vs App Router

Next.js has two routing systems:

**Pages Router (Legacy - Next.js 12 and earlier)**
```
pages/
├── index.js          → /
├── about.js          → /about
└── blog/
    └── [slug].js     → /blog/:slug
```

**App Router (Modern - Next.js 13+)**
```
app/
├── page.js           → /
├── about/
│   └── page.js       → /about
└── blog/
    └── [slug]/
        └── page.js   → /blog/:slug
```

**This guide focuses on the App Router**, which is the future of Next.js.

### Key Paradigm Shifts in App Router

#### 1. Server Components by Default

In the App Router, **all components are Server Components by default**.

```jsx
// app/page.js - This is a Server Component
export default async function HomePage() {
  // You can directly fetch data here!
  const data = await fetch('https://api.example.com/data');
  const json = await data.json();
  
  return <div>{json.title}</div>;
}
```

**Benefits:**
- Zero JavaScript sent to client for these components
- Direct database access without API routes
- Better security (API keys never exposed)
- Improved performance

#### 2. Client Components are Opt-in

Use the `'use client'` directive for interactivity.

```jsx
// app/components/Counter.js
'use client';

import { useState } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <button onClick={() => setCount(count + 1)}>
      Count: {count}
    </button>
  );
}
```

#### 3. Colocation of Files

You can colocate components, styles, and tests with routes.

```
app/
└── dashboard/
    ├── page.js           # Route file
    ├── layout.js         # Layout for this route
    ├── loading.js        # Loading UI
    ├── error.js          # Error UI
    ├── components/       # Components used only here
    │   └── Chart.js
    └── utils/            # Utilities used only here
        └── formatData.js
```

### Rendering Strategies

Next.js offers multiple rendering strategies:

#### 1. Static Rendering (Default)

Pages are rendered at **build time** and cached.

```jsx
// app/blog/[slug]/page.js
export default async function BlogPost({ params }) {
  const post = await getPost(params.slug);
  return <article>{post.content}</article>;
}

// Generate static params at build time
export async function generateStaticParams() {
  const posts = await getAllPosts();
  return posts.map(post => ({ slug: post.slug }));
}
```

**Use when:**
- Content doesn't change often
- Same content for all users
- SEO is critical

#### 2. Dynamic Rendering

Pages are rendered at **request time**.

```jsx
// app/dashboard/page.js
export const dynamic = 'force-dynamic';

export default async function Dashboard() {
  const user = await getCurrentUser();
  return <div>Welcome, {user.name}</div>;
}
```

**Use when:**
- Content is personalized
- Data changes frequently
- Need request-time information (cookies, headers)

#### 3. Streaming

Render parts of the page progressively.

```jsx
// app/dashboard/page.js
import { Suspense } from 'react';

export default function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>
      <Suspense fallback={<p>Loading stats...</p>}>
        <Stats />
      </Suspense>
      <Suspense fallback={<p>Loading chart...</p>}>
        <Chart />
      </Suspense>
    </div>
  );
}
```

**Use when:**
- Some parts of the page are slow to load
- Want to show content progressively

---

## 2. Environment Setup & Project Structure

### Creating a New Next.js Project

```bash
# Using create-next-app (recommended)
npx create-next-app@latest my-app

# Interactive prompts will ask:
# ✔ Would you like to use TypeScript? Yes
# ✔ Would you like to use ESLint? Yes
# ✔ Would you like to use Tailwind CSS? Yes
# ✔ Would you like to use `src/` directory? No
# ✔ Would you like to use App Router? Yes
# ✔ Would you like to customize the default import alias? No

cd my-app
npm run dev
```

### Project Structure (Recommended)

```
my-app/
├── app/                      # App Router directory
│   ├── (auth)/              # Route group (doesn't affect URL)
│   │   ├── login/
│   │   │   └── page.js
│   │   └── register/
│   │       └── page.js
│   ├── (marketing)/
│   │   ├── about/
│   │   │   └── page.js
│   │   └── pricing/
│   │       └── page.js
│   ├── api/                 # API routes
│   │   └── users/
│   │       └── route.js
│   ├── dashboard/
│   │   ├── layout.js
│   │   ├── page.js
│   │   └── settings/
│   │       └── page.js
│   ├── layout.js            # Root layout
│   ├── page.js              # Home page
│   ├── loading.js           # Global loading UI
│   ├── error.js             # Global error UI
│   └── not-found.js         # 404 page
├── components/              # Shared components
│   ├── ui/                  # UI components
│   │   ├── Button.js
│   │   └── Input.js
│   └── layout/              # Layout components
│       ├── Header.js
│       └── Footer.js
├── lib/                     # Utility functions
│   ├── db.js               # Database client
│   ├── auth.js             # Auth utilities
│   └── utils.js            # General utilities
├── hooks/                   # Custom React hooks
│   └── useUser.js
├── types/                   # TypeScript types
│   └── index.ts
├── public/                  # Static assets
│   ├── images/
│   └── fonts/
├── styles/                  # Global styles
│   └── globals.css
├── middleware.js            # Middleware
├── next.config.js           # Next.js configuration
├── .env.local              # Environment variables
├── .eslintrc.json          # ESLint config
├── tailwind.config.js      # Tailwind config
├── tsconfig.json           # TypeScript config
└── package.json
```

### Configuration Files

#### next.config.js

```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  // Enable React strict mode
  reactStrictMode: true,
  
  // Image domains for next/image
  images: {
    domains: ['example.com', 'cdn.example.com'],
    formats: ['image/avif', 'image/webp'],
  },
  
  // Environment variables exposed to browser
  env: {
    CUSTOM_KEY: process.env.CUSTOM_KEY,
  },
  
  // Redirects
  async redirects() {
    return [
      {
        source: '/old-blog/:slug',
        destination: '/blog/:slug',
        permanent: true,
      },
    ];
  },
  
  // Rewrites (proxy)
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: 'https://api.example.com/:path*',
      },
    ];
  },
  
  // Headers
  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'X-DNS-Prefetch-Control',
            value: 'on',
          },
        ],
      },
    ];
  },
  
  // Webpack customization
  webpack: (config, { isServer }) => {
    // Custom webpack config
    return config;
  },
};

module.exports = nextConfig;
```

#### Environment Variables

```bash
# .env.local (never commit this!)
DATABASE_URL="postgresql://user:password@localhost:5432/mydb"
NEXTAUTH_SECRET="your-secret-key"
NEXTAUTH_URL="http://localhost:3000"

# .env (can be committed - default values)
NEXT_PUBLIC_API_URL="https://api.example.com"
```

**Important Rules:**
- Variables prefixed with `NEXT_PUBLIC_` are exposed to the browser
- Other variables are only available server-side
- Never commit `.env.local`

### Essential Dependencies

```bash
# State Management
npm install zustand                    # Lightweight state
npm install @tanstack/react-query      # Server state

# Forms
npm install react-hook-form zod @hookform/resolvers

# UI Libraries
npm install @radix-ui/react-dialog @radix-ui/react-dropdown-menu
npm install class-variance-authority clsx tailwind-merge

# Authentication
npm install next-auth@beta             # NextAuth v5

# Database
npm install @prisma/client
npm install -D prisma

# Utilities
npm install date-fns                   # Date utilities
npm install nanoid                     # ID generation

# Development
npm install -D @types/node @types/react @types/react-dom
npm install -D eslint-config-next
npm install -D prettier prettier-plugin-tailwindcss
```

---

## 3. Routing Deep Dive

### File-based Routing

The App Router uses the file system to define routes.

#### Special Files

| File | Purpose |
|------|---------|
| `layout.js` | Shared UI for a segment and its children |
| `page.js` | Unique UI of a route (makes route publicly accessible) |
| `loading.js` | Loading UI for a segment and its children |
| `error.js` | Error UI for a segment and its children |
| `not-found.js` | 404 UI for a segment |
| `route.js` | API endpoint |
| `template.js` | Re-rendered layout |
| `default.js` | Fallback UI for Parallel Routes |

#### Route Examples

```
app/
├── page.js                    → /
├── about/
│   └── page.js               → /about
├── blog/
│   ├── page.js               → /blog
│   └── [slug]/
│       └── page.js           → /blog/:slug
├── shop/
│   └── [...categories]/
│       └── page.js           → /shop/* (catch-all)
└── docs/
    └── [[...slug]]/
        └── page.js           → /docs/* (optional catch-all)
```

### Dynamic Routes

#### Single Dynamic Segment

```jsx
// app/blog/[slug]/page.js
export default function BlogPost({ params }) {
  return <h1>Post: {params.slug}</h1>;
}

// /blog/hello-world → params.slug = "hello-world"
```

#### Multiple Dynamic Segments

```jsx
// app/shop/[category]/[product]/page.js
export default function Product({ params }) {
  return (
    <div>
      <p>Category: {params.category}</p>
      <p>Product: {params.product}</p>
    </div>
  );
}

// /shop/electronics/laptop → 
// params.category = "electronics"
// params.product = "laptop"
```

#### Catch-all Segments

```jsx
// app/docs/[...slug]/page.js
export default function Docs({ params }) {
  return <div>Segments: {params.slug.join('/')}</div>;
}

// /docs/getting-started → params.slug = ["getting-started"]
// /docs/api/reference → params.slug = ["api", "reference"]
```

#### Optional Catch-all Segments

```jsx
// app/shop/[[...categories]]/page.js
export default function Shop({ params }) {
  const categories = params.categories || [];
  return <div>Categories: {categories.join('/')}</div>;
}

// /shop → params.categories = undefined
// /shop/electronics → params.categories = ["electronics"]
// /shop/electronics/laptops → params.categories = ["electronics", "laptops"]
```

### Route Groups

Route groups allow you to organize routes without affecting the URL structure.

```
app/
├── (marketing)/
│   ├── layout.js        # Marketing layout
│   ├── page.js          → /
│   ├── about/
│   │   └── page.js      → /about
│   └── pricing/
│       └── page.js      → /pricing
├── (shop)/
│   ├── layout.js        # Shop layout
│   ├── products/
│   │   └── page.js      → /products
│   └── cart/
│       └── page.js      → /cart
└── (dashboard)/
    ├── layout.js        # Dashboard layout
    ├── dashboard/
    │   └── page.js      → /dashboard
    └── settings/
        └── page.js      → /settings
```

**Benefits:**
- Different layouts for different sections
- Organize code logically
- Multiple root layouts

### Parallel Routes

Render multiple pages in the same layout simultaneously.

```
app/
├── layout.js
├── page.js
├── @team/
│   └── page.js
└── @analytics/
    └── page.js
```

```jsx
// app/layout.js
export default function Layout({ children, team, analytics }) {
  return (
    <div>
      <div>{children}</div>
      <div className="grid grid-cols-2">
        <div>{team}</div>
        <div>{analytics}</div>
      </div>
    </div>
  );
}
```

### Intercepting Routes

Intercept a route and show it in a modal while keeping the URL.

```
app/
├── feed/
│   └── page.js
├── photo/
│   └── [id]/
│       └── page.js
└── @modal/
    └── (..)photo/
        └── [id]/
            └── page.js
```

**Conventions:**
- `(.)` - same level
- `(..)` - one level up
- `(..)(..)` - two levels up
- `(...)` - from root

---

## 4. Pages & Layouts

### Pages

A page is UI that is **unique** to a route. Pages are defined by exporting a component from a `page.js` file.

```jsx
// app/dashboard/page.js
export default function DashboardPage() {
  return <h1>Dashboard</h1>;
}
```

#### Page Props

Pages receive two props: `params` and `searchParams`.

```jsx
// app/shop/[category]/page.js
export default function CategoryPage({ params, searchParams }) {
  // params: { category: "electronics" }
  // searchParams: { sort: "price", order: "asc" }
  // URL: /shop/electronics?sort=price&order=asc
  
  return (
    <div>
      <h1>Category: {params.category}</h1>
      <p>Sort: {searchParams.sort}</p>
      <p>Order: {searchParams.order}</p>
    </div>
  );
}
```

**Important:** `searchParams` is only available in **Server Components** (pages are Server Components by default).

### Layouts

Layouts are UI that is **shared** between multiple pages. Layouts preserve state, remain interactive, and don't re-render.

#### Root Layout (Required)

```jsx
// app/layout.js
export const metadata = {
  title: 'My App',
  description: 'Welcome to my app',
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        <header>
          <nav>Navigation</nav>
        </header>
        <main>{children}</main>
        <footer>Footer</footer>
      </body>
    </html>
  );
}
```

**Rules:**
- Must be present in the `app` directory
- Must contain `<html>` and `<body>` tags
- Can fetch data
- Cannot use `searchParams`

#### Nested Layouts

```jsx
// app/dashboard/layout.js
export default function DashboardLayout({ children }) {
  return (
    <div className="dashboard">
      <aside>
        <nav>
          <a href="/dashboard">Overview</a>
          <a href="/dashboard/analytics">Analytics</a>
          <a href="/dashboard/settings">Settings</a>
        </nav>
      </aside>
      <div className="content">{children}</div>
    </div>
  );
}
```

**Layout Nesting:**
```
app/layout.js (Root)
  └── app/dashboard/layout.js (Dashboard)
      └── app/dashboard/settings/page.js (Settings Page)
```

The Settings page will be wrapped by both layouts:
```jsx
<RootLayout>
  <DashboardLayout>
    <SettingsPage />
  </DashboardLayout>
</RootLayout>
```

### Templates

Templates are similar to layouts but create a new instance on navigation (don't preserve state).

```jsx
// app/template.js
export default function Template({ children }) {
  return <div className="animate-fade-in">{children}</div>;
}
```

**Use templates when:**
- You want to re-run animations on navigation
- You need to reset state on navigation
- You want to track page views in analytics

### Loading UI

Show instant loading states while content loads.

```jsx
// app/dashboard/loading.js
export default function Loading() {
  return <div className="spinner">Loading...</div>;
}
```

This automatically wraps the page in a Suspense boundary:

```jsx
<Suspense fallback={<Loading />}>
  <Page />
</Suspense>
```

### Error Handling

Handle errors gracefully with error boundaries.

```jsx
// app/dashboard/error.js
'use client'; // Error components must be Client Components

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

#### Global Error Handler

```jsx
// app/global-error.js
'use client';

export default function GlobalError({ error, reset }) {
  return (
    <html>
      <body>
        <h2>Something went wrong!</h2>
        <button onClick={() => reset()}>Try again</button>
      </body>
    </html>
  );
}
```

### Not Found

Custom 404 pages.

```jsx
// app/not-found.js
export default function NotFound() {
  return (
    <div>
      <h2>Not Found</h2>
      <p>Could not find requested resource</p>
    </div>
  );
}
```

Trigger programmatically:

```jsx
// app/blog/[slug]/page.js
import { notFound } from 'next/navigation';

export default async function BlogPost({ params }) {
  const post = await getPost(params.slug);
  
  if (!post) {
    notFound(); // Shows app/blog/not-found.js or app/not-found.js
  }
  
  return <article>{post.content}</article>;
}
```

---

## 5. Navigation & Links

### The Link Component

Use `<Link>` for client-side navigation (no full page reload).

```jsx
import Link from 'next/link';

export default function Nav() {
  return (
    <nav>
      <Link href="/">Home</Link>
      <Link href="/about">About</Link>
      <Link href="/blog/hello-world">Blog Post</Link>
    </nav>
  );
}
```

#### Dynamic Links

```jsx
const posts = ['hello', 'world', 'nextjs'];

<ul>
  {posts.map(slug => (
    <li key={slug}>
      <Link href={`/blog/${slug}`}>{slug}</Link>
    </li>
  ))}
</ul>
```

#### Link with Query Parameters

```jsx
<Link href={{
  pathname: '/shop/products',
  query: { category: 'electronics', sort: 'price' }
}}>
  Electronics
</Link>

// URL: /shop/products?category=electronics&sort=price
```

#### Active Link Styling

```jsx
'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';

export default function NavLink({ href, children }) {
  const pathname = usePathname();
  const isActive = pathname === href;
  
  return (
    <Link 
      href={href}
      className={isActive ? 'active' : ''}
    >
      {children}
    </Link>
  );
}
```

### Programmatic Navigation

#### useRouter Hook

```jsx
'use client';

import { useRouter } from 'next/navigation';

export default function LoginForm() {
  const router = useRouter();
  
  const handleSubmit = async (e) => {
    e.preventDefault();
    // ... login logic
    router.push('/dashboard');
  };
  
  return <form onSubmit={handleSubmit}>...</form>;
}
```

**Router Methods:**

```jsx
const router = useRouter();

// Navigate to a new route
router.push('/dashboard');

// Replace current route (no back button)
router.replace('/login');

// Go back
router.back();

// Go forward
router.forward();

// Refresh current route (re-fetch data)
router.refresh();

// Prefetch a route
router.prefetch('/dashboard');
```

### Prefetching

Next.js automatically prefetches routes in the viewport.

```jsx
// Automatic prefetching (default)
<Link href="/dashboard">Dashboard</Link>

// Disable prefetching
<Link href="/dashboard" prefetch={false}>Dashboard</Link>

// Manual prefetching
const router = useRouter();
useEffect(() => {
  router.prefetch('/dashboard');
}, []);
```

### Scroll Behavior

```jsx
// Disable scroll to top on navigation
<Link href="/about" scroll={false}>About</Link>

// Programmatic scroll control
router.push('/about', { scroll: false });
```

### Redirects

#### Server-side Redirect

```jsx
// app/old-page/page.js
import { redirect } from 'next/navigation';

export default function OldPage() {
  redirect('/new-page');
}
```

#### Conditional Redirect

```jsx
// app/dashboard/page.js
import { redirect } from 'next/navigation';
import { getUser } from '@/lib/auth';

export default async function Dashboard() {
  const user = await getUser();
  
  if (!user) {
    redirect('/login');
  }
  
  return <div>Welcome, {user.name}</div>;
}
```

---

## 6. Server Components vs Client Components

### Understanding the Boundary

This is the **most important concept** in modern Next.js.

#### Server Components (Default)

**All components in the App Router are Server Components by default.**

```jsx
// app/page.js - Server Component
export default async function HomePage() {
  const data = await fetch('https://api.example.com/data');
  const json = await data.json();
  
  return <div>{json.title}</div>;
}
```

**What you CAN do:**
- ✅ Fetch data directly
- ✅ Access backend resources (databases, file system)
- ✅ Keep sensitive information on server (API keys, tokens)
- ✅ Use async/await
- ✅ Reduce client-side JavaScript

**What you CANNOT do:**
- ❌ Use hooks (`useState`, `useEffect`, etc.)
- ❌ Use browser APIs (`window`, `localStorage`, etc.)
- ❌ Use event listeners (`onClick`, `onChange`, etc.)
- ❌ Use Context API

#### Client Components

Add `'use client'` at the top of the file.

```jsx
// app/components/Counter.js
'use client';

import { useState } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <button onClick={() => setCount(count + 1)}>
      Count: {count}
    </button>
  );
}
```

**What you CAN do:**
- ✅ Use hooks
- ✅ Use browser APIs
- ✅ Use event listeners
- ✅ Use Context API
- ✅ Use third-party libraries that depend on browser APIs

**What you CANNOT do:**
- ❌ Use async/await in the component body (use `useEffect` instead)
- ❌ Access backend resources directly

### The Client Boundary

Once you add `'use client'`, **all components imported into it become Client Components**.

```jsx
// app/components/Counter.js
'use client';

import { useState } from 'react';
import Display from './Display'; // This becomes a Client Component

export default function Counter() {
  const [count, setCount] = useState(0);
  return <Display count={count} />;
}
```

### Composition Patterns

#### Pattern 1: Server Component with Client Component Children

```jsx
// app/page.js - Server Component
import ClientCounter from './ClientCounter';

export default async function Page() {
  const data = await fetchData(); // Server-side data fetching
  
  return (
    <div>
      <h1>{data.title}</h1>
      <ClientCounter /> {/* Client Component */}
    </div>
  );
}
```

#### Pattern 2: Passing Server Components as Props to Client Components

```jsx
// app/components/ClientWrapper.js
'use client';

export default function ClientWrapper({ children }) {
  const [isOpen, setIsOpen] = useState(false);
  
  return (
    <div>
      <button onClick={() => setIsOpen(!isOpen)}>Toggle</button>
      {isOpen && children}
    </div>
  );
}

// app/page.js - Server Component
import ClientWrapper from './components/ClientWrapper';
import ServerComponent from './components/ServerComponent';

export default function Page() {
  return (
    <ClientWrapper>
      <ServerComponent /> {/* Stays a Server Component! */}
    </ClientWrapper>
  );
}
```

#### Pattern 3: Sharing Data Between Server and Client Components

```jsx
// app/page.js - Server Component
import ClientDisplay from './ClientDisplay';

export default async function Page() {
  const data = await fetchData();
  
  // Pass data as props to Client Component
  return <ClientDisplay data={data} />;
}

// app/ClientDisplay.js
'use client';

export default function ClientDisplay({ data }) {
  const [selected, setSelected] = useState(data[0]);
  
  return (
    <div>
      {data.map(item => (
        <button key={item.id} onClick={() => setSelected(item)}>
          {item.name}
        </button>
      ))}
      <p>Selected: {selected.name}</p>
    </div>
  );
}
```

### When to Use Each

**Use Server Components when:**
- Fetching data
- Accessing backend resources
- Keeping sensitive information on server
- Reducing client-side JavaScript
- No interactivity needed

**Use Client Components when:**
- Using interactivity (event listeners)
- Using state or lifecycle effects
- Using browser-only APIs
- Using custom hooks
- Using React Context

### Best Practices

#### 1. Keep Client Components Small

```jsx
// ❌ Bad - Entire page is a Client Component
'use client';

export default function Page() {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <Header />
      <Sidebar />
      <Content />
      <button onClick={() => setCount(count + 1)}>
        {count}
      </button>
    </div>
  );
}

// ✅ Good - Only the interactive part is a Client Component
export default function Page() {
  return (
    <div>
      <Header />
      <Sidebar />
      <Content />
      <Counter /> {/* Only this is 'use client' */}
    </div>
  );
}
```

#### 2. Move Client Components Down the Tree

```jsx
// ❌ Bad
'use client';

export default function Page() {
  const [search, setSearch] = useState('');
  
  return (
    <div>
      <StaticHeader />
      <input value={search} onChange={e => setSearch(e.target.value)} />
      <StaticFooter />
    </div>
  );
}

// ✅ Good
export default function Page() {
  return (
    <div>
      <StaticHeader />
      <SearchInput /> {/* Only this is 'use client' */}
      <StaticFooter />
    </div>
  );
}
```

#### 3. Pass Server Components as Children

```jsx
// ✅ Good pattern
'use client';

export default function ClientLayout({ children }) {
  return <div className="interactive">{children}</div>;
}

// Usage
<ClientLayout>
  <ServerComponent /> {/* Stays on server */}
</ClientLayout>
```

---

## 7. Data Fetching Patterns

### Server Component Data Fetching

The most powerful feature of Next.js App Router.

#### Basic Fetch

```jsx
// app/posts/page.js
export default async function PostsPage() {
  const res = await fetch('https://api.example.com/posts');
  const posts = await res.json();
  
  return (
    <ul>
      {posts.map(post => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  );
}
```

#### Parallel Data Fetching

```jsx
export default async function Page() {
  // These run in parallel!
  const [posts, users] = await Promise.all([
    fetch('https://api.example.com/posts').then(r => r.json()),
    fetch('https://api.example.com/users').then(r => r.json()),
  ]);
  
  return (
    <div>
      <Posts data={posts} />
      <Users data={users} />
    </div>
  );
}
```

#### Sequential Data Fetching

```jsx
export default async function Page({ params }) {
  // Wait for user first
  const user = await fetch(`https://api.example.com/users/${params.id}`)
    .then(r => r.json());
  
  // Then fetch user's posts
  const posts = await fetch(`https://api.example.com/users/${user.id}/posts`)
    .then(r => r.json());
  
  return (
    <div>
      <h1>{user.name}</h1>
      <Posts data={posts} />
    </div>
  );
}
```

### Database Queries

You can query databases directly in Server Components!

```jsx
// app/posts/page.js
import { prisma } from '@/lib/prisma';

export default async function PostsPage() {
  const posts = await prisma.post.findMany({
    include: { author: true },
    orderBy: { createdAt: 'desc' },
  });
  
  return (
    <ul>
      {posts.map(post => (
        <li key={post.id}>
          {post.title} by {post.author.name}
        </li>
      ))}
    </ul>
  );
}
```

### Fetch Options

#### Caching Behavior

```jsx
// Default: cache forever (static)
fetch('https://api.example.com/data');

// Revalidate every 60 seconds
fetch('https://api.example.com/data', {
  next: { revalidate: 60 }
});

// Never cache (dynamic)
fetch('https://api.example.com/data', {
  cache: 'no-store'
});

// Force cache
fetch('https://api.example.com/data', {
  cache: 'force-cache'
});
```

#### Request Deduplication

Next.js automatically deduplicates identical requests.

```jsx
// These are deduplicated - only one request is made!
export default async function Page() {
  const data1 = await fetch('https://api.example.com/data');
  const data2 = await fetch('https://api.example.com/data');
  const data3 = await fetch('https://api.example.com/data');
  
  // All three get the same data from a single request
}
```

### Client Component Data Fetching

Use `useEffect` or libraries like React Query.

#### With useEffect

```jsx
'use client';

import { useState, useEffect } from 'react';

export default function Posts() {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    fetch('https://api.example.com/posts')
      .then(r => r.json())
      .then(data => {
        setPosts(data);
        setLoading(false);
      });
  }, []);
  
  if (loading) return <div>Loading...</div>;
  
  return (
    <ul>
      {posts.map(post => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  );
}
```

#### With React Query (Recommended)

```jsx
'use client';

import { useQuery } from '@tanstack/react-query';

export default function Posts() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['posts'],
    queryFn: () => fetch('https://api.example.com/posts').then(r => r.json()),
  });
  
  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  
  return (
    <ul>
      {data.map(post => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  );
}
```

### Error Handling

```jsx
export default async function Page() {
  let data;
  
  try {
    const res = await fetch('https://api.example.com/data');
    
    if (!res.ok) {
      throw new Error('Failed to fetch data');
    }
    
    data = await res.json();
  } catch (error) {
    console.error('Error:', error);
    return <div>Error loading data</div>;
  }
  
  return <div>{data.title}</div>;
}
```

### Loading States with Suspense

```jsx
// app/posts/page.js
import { Suspense } from 'react';

async function Posts() {
  const posts = await fetch('https://api.example.com/posts')
    .then(r => r.json());
  
  return (
    <ul>
      {posts.map(post => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  );
}

export default function Page() {
  return (
    <div>
      <h1>Posts</h1>
      <Suspense fallback={<div>Loading posts...</div>}>
        <Posts />
      </Suspense>
    </div>
  );
}
```

---

## 8. Caching & Revalidation

Next.js has a sophisticated caching system with multiple layers.

### Caching Layers

1. **Request Memoization** - Deduplicates identical requests during render
2. **Data Cache** - Persists data across requests and deployments
3. **Full Route Cache** - Caches rendered HTML and RSC payload
4. **Router Cache** - Client-side cache of visited routes

### Data Cache

#### Static Data (Cached Forever)

```jsx
// Cached by default
const data = await fetch('https://api.example.com/data');
```

#### Revalidate After Time

```jsx
// Revalidate every 60 seconds
const data = await fetch('https://api.example.com/data', {
  next: { revalidate: 60 }
});
```

#### Dynamic Data (No Cache)

```jsx
// Never cached
const data = await fetch('https://api.example.com/data', {
  cache: 'no-store'
});
```

### Route Segment Config

Configure caching behavior for entire routes.

```jsx
// app/posts/page.js

// Revalidate this page every 60 seconds
export const revalidate = 60;

// Or force dynamic rendering
export const dynamic = 'force-dynamic';

// Or force static rendering
export const dynamic = 'force-static';

export default async function PostsPage() {
  const posts = await fetch('https://api.example.com/posts')
    .then(r => r.json());
  
  return <div>{/* ... */}</div>;
}
```

**Options:**

```jsx
// Revalidation
export const revalidate = 60; // Revalidate every 60 seconds
export const revalidate = false; // Cache forever (default)
export const revalidate = 0; // Never cache

// Dynamic rendering
export const dynamic = 'auto'; // Default
export const dynamic = 'force-dynamic'; // Always dynamic
export const dynamic = 'force-static'; // Always static
export const dynamic = 'error'; // Error if dynamic

// Fetch cache
export const fetchCache = 'auto'; // Default
export const fetchCache = 'default-cache'; // Force cache
export const fetchCache = 'only-cache'; // Error if not cached
export const fetchCache = 'force-cache'; // Force cache
export const fetchCache = 'default-no-store'; // Force no-store
export const fetchCache = 'only-no-store'; // Error if cached
export const fetchCache = 'force-no-store'; // Force no-store

// Runtime
export const runtime = 'nodejs'; // Default
export const runtime = 'edge'; // Edge runtime
```

### On-Demand Revalidation

#### Revalidate by Path

```jsx
// app/api/revalidate/route.js
import { revalidatePath } from 'next/cache';
import { NextResponse } from 'next/server';

export async function POST(request) {
  const path = request.nextUrl.searchParams.get('path');
  
  if (path) {
    revalidatePath(path);
    return NextResponse.json({ revalidated: true, now: Date.now() });
  }
  
  return NextResponse.json({
    revalidated: false,
    now: Date.now(),
    message: 'Missing path to revalidate',
  });
}
```

Usage:
```bash
curl -X POST 'http://localhost:3000/api/revalidate?path=/posts'
```

#### Revalidate by Tag

```jsx
// Fetch with tags
const data = await fetch('https://api.example.com/posts', {
  next: { tags: ['posts'] }
});

// Revalidate by tag
// app/api/revalidate/route.js
import { revalidateTag } from 'next/cache';

export async function POST(request) {
  const tag = request.nextUrl.searchParams.get('tag');
  
  if (tag) {
    revalidateTag(tag);
    return NextResponse.json({ revalidated: true });
  }
  
  return NextResponse.json({ revalidated: false });
}
```

### Opting Out of Caching

```jsx
// Entire route
export const dynamic = 'force-dynamic';

// Individual fetch
fetch('https://api.example.com/data', { cache: 'no-store' });

// Using dynamic functions (automatically opts out)
import { cookies, headers } from 'next/headers';

export default async function Page() {
  const cookieStore = cookies(); // Makes route dynamic
  const headersList = headers(); // Makes route dynamic
  
  // This route is now dynamic
}
```

---

## 9. Streaming & Suspense

Streaming allows you to progressively render UI from the server.

### Why Streaming?

Traditional SSR:
```
1. Fetch all data on server
2. Generate HTML on server
3. Send HTML to client
4. Load JavaScript on client
5. Hydrate on client
```

With Streaming:
```
1. Send initial HTML immediately
2. Stream remaining HTML as it's ready
3. Hydrate progressively
```

### Basic Streaming with Suspense

```jsx
// app/page.js
import { Suspense } from 'react';

async function SlowComponent() {
  await new Promise(resolve => setTimeout(resolve, 3000));
  return <div>Slow content loaded!</div>;
}

export default function Page() {
  return (
    <div>
      <h1>My Page</h1>
      <p>This loads instantly</p>
      
      <Suspense fallback={<div>Loading slow content...</div>}>
        <SlowComponent />
      </Suspense>
    </div>
  );
}
```

### Multiple Suspense Boundaries

```jsx
export default function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>
      
      {/* These load independently */}
      <div className="grid grid-cols-2 gap-4">
        <Suspense fallback={<Skeleton />}>
          <RevenueChart />
        </Suspense>
        
        <Suspense fallback={<Skeleton />}>
          <UserStats />
        </Suspense>
        
        <Suspense fallback={<Skeleton />}>
          <RecentOrders />
        </Suspense>
        
        <Suspense fallback={<Skeleton />}>
          <TopProducts />
        </Suspense>
      </div>
    </div>
  );
}
```

### Loading.js (Automatic Suspense)

```jsx
// app/dashboard/loading.js
export default function Loading() {
  return <div className="spinner">Loading dashboard...</div>;
}

// app/dashboard/page.js
export default async function Dashboard() {
  const data = await fetchDashboardData();
  return <div>{/* ... */}</div>;
}
```

This is equivalent to:

```jsx
<Suspense fallback={<Loading />}>
  <Dashboard />
</Suspense>
```

### Streaming with Parallel Data Fetching

```jsx
// app/dashboard/page.js
import { Suspense } from 'react';

async function Revenue() {
  const data = await fetchRevenue();
  return <div>Revenue: ${data.total}</div>;
}

async function Users() {
  const data = await fetchUsers();
  return <div>Users: {data.count}</div>;
}

async function Orders() {
  const data = await fetchOrders();
  return <div>Orders: {data.length}</div>;
}

export default function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>
      
      {/* All three fetch in parallel and stream independently */}
      <Suspense fallback={<div>Loading revenue...</div>}>
        <Revenue />
      </Suspense>
      
      <Suspense fallback={<div>Loading users...</div>}>
        <Users />
      </Suspense>
      
      <Suspense fallback={<div>Loading orders...</div>}>
        <Orders />
      </Suspense>
    </div>
  );
}
```

### Preloading Data

```jsx
// lib/data.js
const cache = new Map();

export function preloadRevenue() {
  void fetchRevenue(); // Starts fetching
}

export async function fetchRevenue() {
  if (cache.has('revenue')) {
    return cache.get('revenue');
  }
  
  const data = await fetch('https://api.example.com/revenue')
    .then(r => r.json());
  
  cache.set('revenue', data);
  return data;
}

// app/dashboard/page.js
import { preloadRevenue, fetchRevenue } from '@/lib/data';

export default function Dashboard() {
  preloadRevenue(); // Start fetching immediately
  
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <Revenue />
    </Suspense>
  );
}

async function Revenue() {
  const data = await fetchRevenue(); // Uses cached data
  return <div>Revenue: ${data.total}</div>;
}
```

---

## 10. Server Actions

Server Actions allow you to run server-side code directly from Client Components.

### Basic Server Action

```jsx
// app/actions.js
'use server';

export async function createPost(formData) {
  const title = formData.get('title');
  const content = formData.get('content');
  
  // Save to database
  await db.post.create({
    data: { title, content }
  });
  
  // Revalidate cache
  revalidatePath('/posts');
}
```

```jsx
// app/posts/new/page.js
import { createPost } from '@/app/actions';

export default function NewPost() {
  return (
    <form action={createPost}>
      <input name="title" required />
      <textarea name="content" required />
      <button type="submit">Create Post</button>
    </form>
  );
}
```

### Server Actions in Client Components

```jsx
// app/actions.js
'use server';

export async function incrementLikes(postId) {
  await db.post.update({
    where: { id: postId },
    data: { likes: { increment: 1 } }
  });
  
  revalidatePath('/posts');
  return { success: true };
}
```

```jsx
// app/components/LikeButton.js
'use client';

import { incrementLikes } from '@/app/actions';
import { useState } from 'react';

export default function LikeButton({ postId }) {
  const [isPending, setIsPending] = useState(false);
  
  const handleLike = async () => {
    setIsPending(true);
    await incrementLikes(postId);
    setIsPending(false);
  };
  
  return (
    <button onClick={handleLike} disabled={isPending}>
      {isPending ? 'Liking...' : 'Like'}
    </button>
  );
}
```

### Using useFormState

```jsx
// app/actions.js
'use server';

export async function createPost(prevState, formData) {
  const title = formData.get('title');
  const content = formData.get('content');
  
  // Validation
  if (!title || title.length < 3) {
    return { error: 'Title must be at least 3 characters' };
  }
  
  try {
    await db.post.create({
      data: { title, content }
    });
    
    revalidatePath('/posts');
    return { success: true };
  } catch (error) {
    return { error: 'Failed to create post' };
  }
}
```

```jsx
// app/posts/new/page.js
'use client';

import { useFormState } from 'react-dom';
import { createPost } from '@/app/actions';

export default function NewPost() {
  const [state, formAction] = useFormState(createPost, { error: null });
  
  return (
    <form action={formAction}>
      {state.error && <div className="error">{state.error}</div>}
      {state.success && <div className="success">Post created!</div>}
      
      <input name="title" required />
      <textarea name="content" required />
      <button type="submit">Create Post</button>
    </form>
  );
}
```

### Using useFormStatus

```jsx
// app/components/SubmitButton.js
'use client';

import { useFormStatus } from 'react-dom';

export default function SubmitButton() {
  const { pending } = useFormStatus();
  
  return (
    <button type="submit" disabled={pending}>
      {pending ? 'Submitting...' : 'Submit'}
    </button>
  );
}
```

```jsx
// app/posts/new/page.js
import { createPost } from '@/app/actions';
import SubmitButton from '@/app/components/SubmitButton';

export default function NewPost() {
  return (
    <form action={createPost}>
      <input name="title" required />
      <textarea name="content" required />
      <SubmitButton />
    </form>
  );
}
```

### Progressive Enhancement

Server Actions work even without JavaScript!

```jsx
// This form works without JavaScript
<form action={createPost}>
  <input name="title" required />
  <button type="submit">Create</button>
</form>
```

### Optimistic Updates

```jsx
'use client';

import { useOptimistic } from 'react';
import { incrementLikes } from '@/app/actions';

export default function Post({ post }) {
  const [optimisticLikes, addOptimisticLike] = useOptimistic(
    post.likes,
    (state, amount) => state + amount
  );
  
  const handleLike = async () => {
    addOptimisticLike(1); // Update UI immediately
    await incrementLikes(post.id); // Update server
  };
  
  return (
    <div>
      <p>{post.title}</p>
      <button onClick={handleLike}>
        Likes: {optimisticLikes}
      </button>
    </div>
  );
}
```

### Validation with Zod

```jsx
// app/actions.js
'use server';

import { z } from 'zod';

const PostSchema = z.object({
  title: z.string().min(3).max(100),
  content: z.string().min(10),
  published: z.boolean().optional(),
});

export async function createPost(formData) {
  const validatedFields = PostSchema.safeParse({
    title: formData.get('title'),
    content: formData.get('content'),
    published: formData.get('published') === 'on',
  });
  
  if (!validatedFields.success) {
    return {
      errors: validatedFields.error.flatten().fieldErrors,
    };
  }
  
  const { title, content, published } = validatedFields.data;
  
  await db.post.create({
    data: { title, content, published }
  });
  
  revalidatePath('/posts');
  redirect('/posts');
}
```

---

## 11. Metadata & SEO

Next.js provides powerful APIs for managing metadata and improving SEO.

### Static Metadata

```jsx
// app/layout.js
export const metadata = {
  title: 'My App',
  description: 'Welcome to my app',
  keywords: ['Next.js', 'React', 'JavaScript'],
  authors: [{ name: 'John Doe' }],
  creator: 'John Doe',
  publisher: 'My Company',
  openGraph: {
    title: 'My App',
    description: 'Welcome to my app',
    url: 'https://example.com',
    siteName: 'My App',
    images: [
      {
        url: 'https://example.com/og.png',
        width: 1200,
        height: 630,
      },
    ],
    locale: 'en_US',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'My App',
    description: 'Welcome to my app',
    creator: '@johndoe',
    images: ['https://example.com/twitter.png'],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
  icons: {
    icon: '/favicon.ico',
    shortcut: '/shortcut-icon.png',
    apple: '/apple-icon.png',
    other: {
      rel: 'apple-touch-icon-precomposed',
      url: '/apple-touch-icon-precomposed.png',
    },
  },
  manifest: '/manifest.json',
  verification: {
    google: 'google-site-verification-code',
    yandex: 'yandex-verification-code',
  },
};
```

### Dynamic Metadata

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
      images: [post.coverImage],
    },
  };
}

export default async function BlogPost({ params }) {
  const post = await getPost(params.slug);
  return <article>{post.content}</article>;
}
```

### Metadata with Parent Data

```jsx
export async function generateMetadata({ params }, parent) {
  const post = await getPost(params.slug);
  const previousImages = (await parent).openGraph?.images || [];
  
  return {
    title: post.title,
    openGraph: {
      images: [post.coverImage, ...previousImages],
    },
  };
}
```

### JSON-LD Structured Data

```jsx
// app/blog/[slug]/page.js
export default async function BlogPost({ params }) {
  const post = await getPost(params.slug);
  
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BlogPosting',
    headline: post.title,
    image: post.coverImage,
    datePublished: post.publishedAt,
    dateModified: post.updatedAt,
    author: {
      '@type': 'Person',
      name: post.author.name,
    },
  };
  
  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />
      <article>{post.content}</article>
    </>
  );
}
```

### Sitemap Generation

```jsx
// app/sitemap.js
export default async function sitemap() {
  const posts = await getAllPosts();
  
  const postUrls = posts.map(post => ({
    url: `https://example.com/blog/${post.slug}`,
    lastModified: post.updatedAt,
    changeFrequency: 'weekly',
    priority: 0.8,
  }));
  
  return [
    {
      url: 'https://example.com',
      lastModified: new Date(),
      changeFrequency: 'yearly',
      priority: 1,
    },
    {
      url: 'https://example.com/about',
      lastModified: new Date(),
      changeFrequency: 'monthly',
      priority: 0.8,
    },
    ...postUrls,
  ];
}
```

### Robots.txt

```jsx
// app/robots.js
export default function robots() {
  return {
    rules: {
      userAgent: '*',
      allow: '/',
      disallow: '/private/',
    },
    sitemap: 'https://example.com/sitemap.xml',
  };
}
```

### Canonical URLs

```jsx
export const metadata = {
  alternates: {
    canonical: 'https://example.com/blog/post',
    languages: {
      'en-US': 'https://example.com/en-US/blog/post',
      'de-DE': 'https://example.com/de-DE/blog/post',
    },
  },
};
```

---

## 12. Image Optimization

Next.js automatically optimizes images with the `Image` component.

### Basic Usage

```jsx
import Image from 'next/image';

export default function Page() {
  return (
    <Image
      src="/profile.jpg"
      alt="Profile picture"
      width={500}
      height={500}
    />
  );
}
```

### Remote Images

```jsx
// next.config.js
module.exports = {
  images: {
    domains: ['example.com', 'cdn.example.com'],
    // Or use remotePatterns for more control
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**.example.com',
        port: '',
        pathname: '/images/**',
      },
    ],
  },
};
```

```jsx
<Image
  src="https://example.com/profile.jpg"
  alt="Profile"
  width={500}
  height={500}
/>
```

### Fill Container

```jsx
<div style={{ position: 'relative', width: '100%', height: '400px' }}>
  <Image
    src="/hero.jpg"
    alt="Hero"
    fill
    style={{ objectFit: 'cover' }}
  />
</div>
```

### Priority Loading

```jsx
// Load image with high priority (above the fold)
<Image
  src="/hero.jpg"
  alt="Hero"
  width={1200}
  height={600}
  priority
/>
```

### Responsive Images

```jsx
<Image
  src="/hero.jpg"
  alt="Hero"
  width={1200}
  height={600}
  sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
/>
```

### Placeholder Blur

```jsx
import Image from 'next/image';
import profilePic from '../public/profile.jpg'; // Import generates blur data

export default function Page() {
  return (
    <Image
      src={profilePic}
      alt="Profile"
      placeholder="blur" // Automatic blur-up while loading
    />
  );
}
```

### Custom Blur Data URL

```jsx
<Image
  src="/profile.jpg"
  alt="Profile"
  width={500}
  height={500}
  placeholder="blur"
  blurDataURL="data:image/jpeg;base64,/9j/4AAQSkZJRg..."
/>
```

### Image Loader

```jsx
// next.config.js
module.exports = {
  images: {
    loader: 'custom',
    loaderFile: './lib/imageLoader.js',
  },
};
```

```jsx
// lib/imageLoader.js
export default function cloudinaryLoader({ src, width, quality }) {
  const params = ['f_auto', 'c_limit', `w_${width}`, `q_${quality || 'auto'}`];
  return `https://res.cloudinary.com/demo/image/upload/${params.join(',')}${src}`;
}
```

### Image Formats

```jsx
// next.config.js
module.exports = {
  images: {
    formats: ['image/avif', 'image/webp'],
  },
};
```

### Quality

```jsx
<Image
  src="/profile.jpg"
  alt="Profile"
  width={500}
  height={500}
  quality={75} // Default is 75
/>
```

---

## 13. Font Optimization

Next.js automatically optimizes fonts with `next/font`.

### Google Fonts

```jsx
// app/layout.js
import { Inter, Roboto_Mono } from 'next/font/google';

const inter = Inter({
  subsets: ['latin'],
  display: 'swap',
});

const robotoMono = Roboto_Mono({
  subsets: ['latin'],
  display: 'swap',
});

export default function RootLayout({ children }) {
  return (
    <html lang="en" className={inter.className}>
      <body>{children}</body>
    </html>
  );
}
```

### Multiple Weights

```jsx
import { Inter } from 'next/font/google';

const inter = Inter({
  subsets: ['latin'],
  weight: ['400', '700'],
  style: ['normal', 'italic'],
  display: 'swap',
});
```

### Variable Fonts

```jsx
import { Inter } from 'next/font/google';

const inter = Inter({
  subsets: ['latin'],
  variable: '--font-inter',
});

export default function RootLayout({ children }) {
  return (
    <html lang="en" className={inter.variable}>
      <body>{children}</body>
    </html>
  );
}
```

```css
/* globals.css */
body {
  font-family: var(--font-inter);
}
```

### Local Fonts

```jsx
import localFont from 'next/font/local';

const myFont = localFont({
  src: './my-font.woff2',
  display: 'swap',
});

export default function RootLayout({ children }) {
  return (
    <html lang="en" className={myFont.className}>
      <body>{children}</body>
    </html>
  );
}
```

### Multiple Local Fonts

```jsx
const myFont = localFont({
  src: [
    {
      path: './my-font-regular.woff2',
      weight: '400',
      style: 'normal',
    },
    {
      path: './my-font-bold.woff2',
      weight: '700',
      style: 'normal',
    },
  ],
  variable: '--font-my-font',
});
```

### Preloading Fonts

```jsx
// Fonts are automatically preloaded
const inter = Inter({ subsets: ['latin'], preload: true });
```

### Font Display Strategies

```jsx
const inter = Inter({
  subsets: ['latin'],
  display: 'swap', // 'auto' | 'block' | 'swap' | 'fallback' | 'optional'
});
```

---

## 14. Route Handlers (API Routes)

Route Handlers allow you to create API endpoints.

### Basic Route Handler

```jsx
// app/api/hello/route.js
export async function GET(request) {
  return Response.json({ message: 'Hello World' });
}
```

### HTTP Methods

```jsx
// app/api/posts/route.js
export async function GET(request) {
  const posts = await db.post.findMany();
  return Response.json(posts);
}

export async function POST(request) {
  const body = await request.json();
  const post = await db.post.create({ data: body });
  return Response.json(post, { status: 201 });
}

export async function PUT(request) {
  const body = await request.json();
  const post = await db.post.update({
    where: { id: body.id },
    data: body,
  });
  return Response.json(post);
}

export async function DELETE(request) {
  const { searchParams } = new URL(request.url);
  const id = searchParams.get('id');
  await db.post.delete({ where: { id } });
  return new Response(null, { status: 204 });
}
```

### Dynamic Route Handlers

```jsx
// app/api/posts/[id]/route.js
export async function GET(request, { params }) {
  const post = await db.post.findUnique({
    where: { id: params.id },
  });
  
  if (!post) {
    return Response.json({ error: 'Not found' }, { status: 404 });
  }
  
  return Response.json(post);
}

export async function PATCH(request, { params }) {
  const body = await request.json();
  const post = await db.post.update({
    where: { id: params.id },
    data: body,
  });
  return Response.json(post);
}

export async function DELETE(request, { params }) {
  await db.post.delete({ where: { id: params.id } });
  return new Response(null, { status: 204 });
}
```

### Request Object

```jsx
export async function POST(request) {
  // URL and search params
  const { searchParams } = new URL(request.url);
  const query = searchParams.get('query');
  
  // Headers
  const contentType = request.headers.get('content-type');
  
  // Cookies
  const token = request.cookies.get('token');
  
  // Body
  const body = await request.json();
  // or
  const formData = await request.formData();
  // or
  const text = await request.text();
  
  return Response.json({ success: true });
}
```

### Response Helpers

```jsx
import { NextResponse } from 'next/server';

export async function GET(request) {
  // JSON response
  return NextResponse.json({ message: 'Hello' });
  
  // Redirect
  return NextResponse.redirect(new URL('/home', request.url));
  
  // Rewrite
  return NextResponse.rewrite(new URL('/api/v2/posts', request.url));
  
  // Set cookies
  const response = NextResponse.json({ success: true });
  response.cookies.set('token', 'abc123', {
    httpOnly: true,
    secure: true,
    sameSite: 'strict',
    maxAge: 60 * 60 * 24 * 7, // 1 week
  });
  return response;
  
  // Set headers
  const response2 = NextResponse.json({ data: [] });
  response2.headers.set('X-Custom-Header', 'value');
  return response2;
}
```

### Error Handling

```jsx
export async function GET(request, { params }) {
  try {
    const post = await db.post.findUnique({
      where: { id: params.id },
    });
    
    if (!post) {
      return NextResponse.json(
        { error: 'Post not found' },
        { status: 404 }
      );
    }
    
    return NextResponse.json(post);
  } catch (error) {
    console.error('Error fetching post:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

### CORS

```jsx
export async function GET(request) {
  const data = { message: 'Hello' };
  
  return NextResponse.json(data, {
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    },
  });
}

export async function OPTIONS(request) {
  return new Response(null, {
    status: 200,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    },
  });
}
```

### Streaming Responses

```jsx
export async function GET() {
  const encoder = new TextEncoder();
  
  const stream = new ReadableStream({
    async start(controller) {
      for (let i = 0; i < 10; i++) {
        await new Promise(resolve => setTimeout(resolve, 1000));
        controller.enqueue(encoder.encode(`data: ${i}\n\n`));
      }
      controller.close();
    },
  });
  
  return new Response(stream, {
    headers: {
      'Content-Type': 'text/event-stream',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
    },
  });
}
```

### Edge Runtime

```jsx
export const runtime = 'edge';

export async function GET(request) {
  return Response.json({ message: 'Running on Edge' });
}
```

---

## 15. Middleware

Middleware runs before a request is completed, allowing you to modify the response.

### Basic Middleware

```jsx
// middleware.js
import { NextResponse } from 'next/server';

export function middleware(request) {
  console.log('Middleware running for:', request.url);
  return NextResponse.next();
}
```

### Matching Paths

```jsx
// middleware.js
export function middleware(request) {
  // Your middleware logic
}

export const config = {
  matcher: [
    '/dashboard/:path*',
    '/api/:path*',
  ],
};
```

**Matcher patterns:**

```jsx
export const config = {
  matcher: [
    // Match all paths except static files
    '/((?!_next/static|_next/image|favicon.ico).*)',
    
    // Match specific paths
    '/dashboard/:path*',
    '/api/:path*',
    
    // Match with regex
    '/(api|trpc)(.*)',
  ],
};
```

### Authentication Middleware

```jsx
// middleware.js
import { NextResponse } from 'next/server';

export function middleware(request) {
  const token = request.cookies.get('token');
  
  if (!token) {
    return NextResponse.redirect(new URL('/login', request.url));
  }
  
  return NextResponse.next();
}

export const config = {
  matcher: ['/dashboard/:path*', '/profile/:path*'],
};
```

### Conditional Redirects

```jsx
export function middleware(request) {
  const { pathname } = request.nextUrl;
  
  // Redirect old blog URLs
  if (pathname.startsWith('/old-blog')) {
    const slug = pathname.replace('/old-blog/', '');
    return NextResponse.redirect(new URL(`/blog/${slug}`, request.url));
  }
  
  // Redirect based on cookie
  const country = request.cookies.get('country');
  if (country === 'US' && !pathname.startsWith('/en-us')) {
    return NextResponse.redirect(new URL('/en-us', request.url));
  }
  
  return NextResponse.next();
}
```

### Setting Headers

```jsx
export function middleware(request) {
  const response = NextResponse.next();
  
  response.headers.set('X-Custom-Header', 'value');
  response.headers.set('X-Frame-Options', 'DENY');
  response.headers.set('X-Content-Type-Options', 'nosniff');
  
  return response;
}
```

### Setting Cookies

```jsx
export function middleware(request) {
  const response = NextResponse.next();
  
  response.cookies.set('visited', 'true', {
    maxAge: 60 * 60 * 24 * 365, // 1 year
  });
  
  return response;
}
```

### Rewriting

```jsx
export function middleware(request) {
  const { pathname } = request.nextUrl;
  
  // Rewrite /docs to /documentation
  if (pathname.startsWith('/docs')) {
    return NextResponse.rewrite(
      new URL(pathname.replace('/docs', '/documentation'), request.url)
    );
  }
  
  return NextResponse.next();
}
```

### Geolocation

```jsx
export function middleware(request) {
  const country = request.geo?.country || 'US';
  const response = NextResponse.next();
  
  response.cookies.set('country', country);
  
  return response;
}
```

### A/B Testing

```jsx
export function middleware(request) {
  const bucket = Math.random() < 0.5 ? 'a' : 'b';
  const response = NextResponse.next();
  
  response.cookies.set('bucket', bucket);
  
  if (bucket === 'b') {
    return NextResponse.rewrite(new URL('/variant-b', request.url));
  }
  
  return response;
}
```

### Rate Limiting

```jsx
import { Ratelimit } from '@upstash/ratelimit';
import { Redis } from '@upstash/redis';

const ratelimit = new Ratelimit({
  redis: Redis.fromEnv(),
  limiter: Ratelimit.slidingWindow(10, '10 s'),
});

export async function middleware(request) {
  const ip = request.ip ?? '127.0.0.1';
  const { success } = await ratelimit.limit(ip);
  
  if (!success) {
    return new Response('Too many requests', { status: 429 });
  }
  
  return NextResponse.next();
}
```

---

## 16. CSS Modules & Global Styles

### CSS Modules

CSS Modules automatically scope CSS to components.

```css
/* app/components/Button.module.css */
.button {
  background-color: blue;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
}

.button:hover {
  background-color: darkblue;
}

.primary {
  background-color: green;
}

.secondary {
  background-color: gray;
}
```

```jsx
// app/components/Button.js
import styles from './Button.module.css';

export default function Button({ variant = 'primary', children }) {
  return (
    <button className={`${styles.button} ${styles[variant]}`}>
      {children}
    </button>
  );
}
```

### Global Styles

```css
/* app/globals.css */
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen,
    Ubuntu, Cantarell, 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
  line-height: 1.6;
  color: #333;
}

a {
  color: inherit;
  text-decoration: none;
}
```

```jsx
// app/layout.js
import './globals.css';

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
```

### Sass Support

```bash
npm install sass
```

```scss
// app/components/Button.module.scss
$primary-color: blue;
$secondary-color: gray;

.button {
  background-color: $primary-color;
  color: white;
  padding: 10px 20px;
  
  &:hover {
    background-color: darken($primary-color, 10%);
  }
  
  &.secondary {
    background-color: $secondary-color;
  }
}
```

### CSS Variables

```css
/* app/globals.css */
:root {
  --primary-color: #0070f3;
  --secondary-color: #666;
  --background: #fff;
  --foreground: #000;
  --border-radius: 8px;
  --spacing-sm: 8px;
  --spacing-md: 16px;
  --spacing-lg: 24px;
}

[data-theme='dark'] {
  --background: #000;
  --foreground: #fff;
}
```

```jsx
// app/components/Card.js
export default function Card({ children }) {
  return (
    <div style={{
      backgroundColor: 'var(--background)',
      color: 'var(--foreground)',
      padding: 'var(--spacing-md)',
      borderRadius: 'var(--border-radius)',
    }}>
      {children}
    </div>
  );
}
```

---

## 17. Tailwind CSS Integration

### Setup

Tailwind is included by default when creating a new Next.js app.

```bash
npx create-next-app@latest my-app
# Select "Yes" for Tailwind CSS
```

Manual setup:

```bash
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

```javascript
// tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#0070f3',
        secondary: '#666',
      },
    },
  },
  plugins: [],
};
```

```css
/* app/globals.css */
@tailwind base;
@tailwind components;
@tailwind utilities;
```

### Basic Usage

```jsx
export default function Button({ children }) {
  return (
    <button className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
      {children}
    </button>
  );
}
```

### Conditional Classes

```jsx
'use client';

import { useState } from 'react';

export default function Button({ variant = 'primary' }) {
  const [isActive, setIsActive] = useState(false);
  
  const baseClasses = 'font-bold py-2 px-4 rounded';
  const variantClasses = {
    primary: 'bg-blue-500 hover:bg-blue-700 text-white',
    secondary: 'bg-gray-500 hover:bg-gray-700 text-white',
    danger: 'bg-red-500 hover:bg-red-700 text-white',
  };
  const activeClasses = isActive ? 'ring-2 ring-offset-2' : '';
  
  return (
    <button
      className={`${baseClasses} ${variantClasses[variant]} ${activeClasses}`}
      onClick={() => setIsActive(!isActive)}
    >
      Click me
    </button>
  );
}
```

### Using clsx/classnames

```bash
npm install clsx
```

```jsx
import clsx from 'clsx';

export default function Button({ variant, isActive, disabled }) {
  return (
    <button
      className={clsx(
        'font-bold py-2 px-4 rounded',
        {
          'bg-blue-500 hover:bg-blue-700': variant === 'primary',
          'bg-gray-500 hover:bg-gray-700': variant === 'secondary',
          'ring-2 ring-offset-2': isActive,
          'opacity-50 cursor-not-allowed': disabled,
        }
      )}
    >
      Click me
    </button>
  );
}
```

### Custom Utilities

```css
/* app/globals.css */
@layer utilities {
  .text-balance {
    text-wrap: balance;
  }
  
  .scrollbar-hide {
    -ms-overflow-style: none;
    scrollbar-width: none;
  }
  
  .scrollbar-hide::-webkit-scrollbar {
    display: none;
  }
}
```

### Custom Components

```css
@layer components {
  .btn {
    @apply font-bold py-2 px-4 rounded;
  }
  
  .btn-primary {
    @apply bg-blue-500 hover:bg-blue-700 text-white;
  }
  
  .btn-secondary {
    @apply bg-gray-500 hover:bg-gray-700 text-white;
  }
}
```

### Dark Mode

```javascript
// tailwind.config.js
module.exports = {
  darkMode: 'class', // or 'media'
  // ...
};
```

```jsx
export default function Card() {
  return (
    <div className="bg-white dark:bg-gray-800 text-black dark:text-white">
      <h2 className="text-2xl font-bold">Title</h2>
      <p className="text-gray-600 dark:text-gray-300">Content</p>
    </div>
  );
}
```

### Responsive Design

```jsx
export default function Grid() {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
      <div>Item 1</div>
      <div>Item 2</div>
      <div>Item 3</div>
    </div>
  );
}
```

---

## 18. CSS-in-JS Solutions

### Styled JSX (Built-in)

```jsx
export default function Button() {
  return (
    <>
      <button className="button">Click me</button>
      
      <style jsx>{`
        .button {
          background-color: blue;
          color: white;
          padding: 10px 20px;
          border: none;
          border-radius: 4px;
        }
        
        .button:hover {
          background-color: darkblue;
        }
      `}</style>
    </>
  );
}
```

### Global Styles with Styled JSX

```jsx
export default function Layout({ children }) {
  return (
    <>
      <div>{children}</div>
      
      <style jsx global>{`
        body {
          margin: 0;
          font-family: sans-serif;
        }
      `}</style>
    </>
  );
}
```

### Styled Components

```bash
npm install styled-components
```

```jsx
// app/lib/registry.js
'use client';

import React, { useState } from 'react';
import { useServerInsertedHTML } from 'next/navigation';
import { ServerStyleSheet, StyleSheetManager } from 'styled-components';

export default function StyledComponentsRegistry({ children }) {
  const [styledComponentsStyleSheet] = useState(() => new ServerStyleSheet());

  useServerInsertedHTML(() => {
    const styles = styledComponentsStyleSheet.getStyleElement();
    styledComponentsStyleSheet.instance.clearTag();
    return <>{styles}</>;
  });

  if (typeof window !== 'undefined') return <>{children}</>;

  return (
    <StyleSheetManager sheet={styledComponentsStyleSheet.instance}>
      {children}
    </StyleSheetManager>
  );
}
```

```jsx
// app/layout.js
import StyledComponentsRegistry from './lib/registry';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        <StyledComponentsRegistry>{children}</StyledComponentsRegistry>
      </body>
    </html>
  );
}
```

```jsx
// app/components/Button.js
'use client';

import styled from 'styled-components';

const StyledButton = styled.button`
  background-color: ${props => props.primary ? 'blue' : 'gray'};
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  
  &:hover {
    background-color: ${props => props.primary ? 'darkblue' : 'darkgray'};
  }
`;

export default function Button({ primary, children }) {
  return <StyledButton primary={primary}>{children}</StyledButton>;
}
```

---

## 19. Client State Management

### useState (Built-in)

```jsx
'use client';

import { useState } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

### useReducer (Built-in)

```jsx
'use client';

import { useReducer } from 'react';

const initialState = { count: 0 };

function reducer(state, action) {
  switch (action.type) {
    case 'increment':
      return { count: state.count + 1 };
    case 'decrement':
      return { count: state.count - 1 };
    case 'reset':
      return initialState;
    default:
      throw new Error();
  }
}

export default function Counter() {
  const [state, dispatch] = useReducer(reducer, initialState);
  
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

### Context API (Built-in)

```jsx
// app/contexts/ThemeContext.js
'use client';

import { createContext, useContext, useState } from 'react';

const ThemeContext = createContext();

export function ThemeProvider({ children }) {
  const [theme, setTheme] = useState('light');
  
  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light');
  };
  
  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error('useTheme must be used within ThemeProvider');
  }
  return context;
}
```

```jsx
// app/layout.js
import { ThemeProvider } from './contexts/ThemeContext';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        <ThemeProvider>{children}</ThemeProvider>
      </body>
    </html>
  );
}
```

```jsx
// app/components/ThemeToggle.js
'use client';

import { useTheme } from '../contexts/ThemeContext';

export default function ThemeToggle() {
  const { theme, toggleTheme } = useTheme();
  
  return (
    <button onClick={toggleTheme}>
      Current theme: {theme}
    </button>
  );
}
```

### Zustand (Recommended)

```bash
npm install zustand
```

```jsx
// app/stores/useStore.js
import { create } from 'zustand';

export const useStore = create((set) => ({
  count: 0,
  increment: () => set((state) => ({ count: state.count + 1 })),
  decrement: () => set((state) => ({ count: state.count - 1 })),
  reset: () => set({ count: 0 }),
}));
```

```jsx
// app/components/Counter.js
'use client';

import { useStore } from '../stores/useStore';

export default function Counter() {
  const { count, increment, decrement, reset } = useStore();
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={increment}>+</button>
      <button onClick={decrement}>-</button>
      <button onClick={reset}>Reset</button>
    </div>
  );
}
```

### Zustand with Persist

```jsx
import { create } from 'zustand';
import { persist } from 'zustand/middleware';

export const useStore = create(
  persist(
    (set) => ({
      count: 0,
      increment: () => set((state) => ({ count: state.count + 1 })),
    }),
    {
      name: 'counter-storage',
    }
  )
);
```

### Redux Toolkit

```bash
npm install @reduxjs/toolkit react-redux
```

```jsx
// app/store/store.js
import { configureStore } from '@reduxjs/toolkit';
import counterReducer from './counterSlice';

export const store = configureStore({
  reducer: {
    counter: counterReducer,
  },
});
```

```jsx
// app/store/counterSlice.js
import { createSlice } from '@reduxjs/toolkit';

const counterSlice = createSlice({
  name: 'counter',
  initialState: { value: 0 },
  reducers: {
    increment: (state) => {
      state.value += 1;
    },
    decrement: (state) => {
      state.value -= 1;
    },
  },
});

export const { increment, decrement } = counterSlice.actions;
export default counterSlice.reducer;
```

```jsx
// app/components/Providers.js
'use client';

import { Provider } from 'react-redux';
import { store } from '../store/store';

export function Providers({ children }) {
  return <Provider store={store}>{children}</Provider>;
}
```

```jsx
// app/layout.js
import { Providers } from './components/Providers';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
```

```jsx
// app/components/Counter.js
'use client';

import { useSelector, useDispatch } from 'react-redux';
import { increment, decrement } from '../store/counterSlice';

export default function Counter() {
  const count = useSelector((state) => state.counter.value);
  const dispatch = useDispatch();
  
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => dispatch(increment())}>+</button>
      <button onClick={() => dispatch(decrement())}>-</button>
    </div>
  );
}
```

---

## 20. Server State with React Query

React Query (TanStack Query) is the best solution for server state management.

### Setup

```bash
npm install @tanstack/react-query
```

```jsx
// app/components/Providers.js
'use client';

import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { useState } from 'react';

export function Providers({ children }) {
  const [queryClient] = useState(() => new QueryClient());
  
  return (
    <QueryClientProvider client={queryClient}>
      {children}
    </QueryClientProvider>
  );
}
```

```jsx
// app/layout.js
import { Providers } from './components/Providers';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
```

### Basic Query

```jsx
'use client';

import { useQuery } from '@tanstack/react-query';

async function fetchPosts() {
  const res = await fetch('https://api.example.com/posts');
  if (!res.ok) throw new Error('Failed to fetch');
  return res.json();
}

export default function Posts() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['posts'],
    queryFn: fetchPosts,
  });
  
  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  
  return (
    <ul>
      {data.map(post => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  );
}
```

### Query with Parameters

```jsx
function fetchPost(id) {
  return fetch(`https://api.example.com/posts/${id}`).then(r => r.json());
}

export default function Post({ id }) {
  const { data, isLoading } = useQuery({
    queryKey: ['post', id],
    queryFn: () => fetchPost(id),
  });
  
  if (isLoading) return <div>Loading...</div>;
  
  return <div>{data.title}</div>;
}
```

### Mutations

```jsx
'use client';

import { useMutation, useQueryClient } from '@tanstack/react-query';

async function createPost(newPost) {
  const res = await fetch('https://api.example.com/posts', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(newPost),
  });
  return res.json();
}

export default function CreatePost() {
  const queryClient = useQueryClient();
  
  const mutation = useMutation({
    mutationFn: createPost,
    onSuccess: () => {
      // Invalidate and refetch
      queryClient.invalidateQueries({ queryKey: ['posts'] });
    },
  });
  
  const handleSubmit = (e) => {
    e.preventDefault();
    const formData = new FormData(e.target);
    mutation.mutate({
      title: formData.get('title'),
      content: formData.get('content'),
    });
  };
  
  return (
    <form onSubmit={handleSubmit}>
      <input name="title" required />
      <textarea name="content" required />
      <button type="submit" disabled={mutation.isPending}>
        {mutation.isPending ? 'Creating...' : 'Create Post'}
      </button>
      {mutation.isError && <div>Error: {mutation.error.message}</div>}
      {mutation.isSuccess && <div>Post created!</div>}
    </form>
  );
}
```

### Optimistic Updates

```jsx
const mutation = useMutation({
  mutationFn: updatePost,
  onMutate: async (newPost) => {
    // Cancel outgoing refetches
    await queryClient.cancelQueries({ queryKey: ['posts'] });
    
    // Snapshot previous value
    const previousPosts = queryClient.getQueryData(['posts']);
    
    // Optimistically update
    queryClient.setQueryData(['posts'], (old) => [...old, newPost]);
    
    // Return context with snapshot
    return { previousPosts };
  },
  onError: (err, newPost, context) => {
    // Rollback on error
    queryClient.setQueryData(['posts'], context.previousPosts);
  },
  onSettled: () => {
    // Refetch after error or success
    queryClient.invalidateQueries({ queryKey: ['posts'] });
  },
});
```

### Pagination

```jsx
'use client';

import { useQuery } from '@tanstack/react-query';
import { useState } from 'react';

function fetchPosts(page) {
  return fetch(`https://api.example.com/posts?page=${page}`)
    .then(r => r.json());
}

export default function Posts() {
  const [page, setPage] = useState(1);
  
  const { data, isLoading, isPreviousData } = useQuery({
    queryKey: ['posts', page],
    queryFn: () => fetchPosts(page),
    keepPreviousData: true,
  });
  
  return (
    <div>
      {isLoading ? (
        <div>Loading...</div>
      ) : (
        <ul>
          {data.posts.map(post => (
            <li key={post.id}>{post.title}</li>
          ))}
        </ul>
      )}
      
      <div>
        <button
          onClick={() => setPage(old => Math.max(old - 1, 1))}
          disabled={page === 1}
        >
          Previous
        </button>
        <span>Page {page}</span>
        <button
          onClick={() => setPage(old => old + 1)}
          disabled={isPreviousData || !data?.hasMore}
        >
          Next
        </button>
      </div>
    </div>
  );
}
```

### Infinite Queries

```jsx
import { useInfiniteQuery } from '@tanstack/react-query';

function fetchPosts({ pageParam = 1 }) {
  return fetch(`https://api.example.com/posts?page=${pageParam}`)
    .then(r => r.json());
}

export default function Posts() {
  const {
    data,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage,
  } = useInfiniteQuery({
    queryKey: ['posts'],
    queryFn: fetchPosts,
    getNextPageParam: (lastPage, pages) => lastPage.nextPage,
  });
  
  return (
    <div>
      {data?.pages.map((page, i) => (
        <div key={i}>
          {page.posts.map(post => (
            <div key={post.id}>{post.title}</div>
          ))}
        </div>
      ))}
      
      <button
        onClick={() => fetchNextPage()}
        disabled={!hasNextPage || isFetchingNextPage}
      >
        {isFetchingNextPage
          ? 'Loading more...'
          : hasNextPage
          ? 'Load More'
          : 'Nothing more to load'}
      </button>
    </div>
  );
}
```

---

## 21. Forms & Validation

### Basic Form with Server Actions

```jsx
// app/actions.js
'use server';

export async function createUser(formData) {
  const name = formData.get('name');
  const email = formData.get('email');
  
  // Save to database
  await db.user.create({
    data: { name, email }
  });
  
  revalidatePath('/users');
}
```

```jsx
// app/users/new/page.js
import { createUser } from '@/app/actions';

export default function NewUser() {
  return (
    <form action={createUser}>
      <input name="name" required />
      <input name="email" type="email" required />
      <button type="submit">Create User</button>
    </form>
  );
}
```

### React Hook Form

```bash
npm install react-hook-form
```

```jsx
'use client';

import { useForm } from 'react-hook-form';

export default function Form() {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm();
  
  const onSubmit = async (data) => {
    await fetch('/api/users', {
      method: 'POST',
      body: JSON.stringify(data),
    });
  };
  
  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input
        {...register('name', {
          required: 'Name is required',
          minLength: {
            value: 3,
            message: 'Name must be at least 3 characters',
          },
        })}
      />
      {errors.name && <span>{errors.name.message}</span>}
      
      <input
        {...register('email', {
          required: 'Email is required',
          pattern: {
            value: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i,
            message: 'Invalid email address',
          },
        })}
      />
      {errors.email && <span>{errors.email.message}</span>}
      
      <button type="submit" disabled={isSubmitting}>
        {isSubmitting ? 'Submitting...' : 'Submit'}
      </button>
    </form>
  );
}
```

### Zod Validation

```bash
npm install zod @hookform/resolvers
```

```jsx
'use client';

import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';

const schema = z.object({
  name: z.string().min(3, 'Name must be at least 3 characters'),
  email: z.string().email('Invalid email address'),
  age: z.number().min(18, 'Must be at least 18 years old'),
  password: z.string().min(8, 'Password must be at least 8 characters'),
  confirmPassword: z.string(),
}).refine((data) => data.password === data.confirmPassword, {
  message: "Passwords don't match",
  path: ['confirmPassword'],
});

export default function Form() {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm({
    resolver: zodResolver(schema),
  });
  
  const onSubmit = (data) => {
    console.log(data);
  };
  
  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('name')} />
      {errors.name && <span>{errors.name.message}</span>}
      
      <input {...register('email')} />
      {errors.email && <span>{errors.email.message}</span>}
      
      <input {...register('age', { valueAsNumber: true })} type="number" />
      {errors.age && <span>{errors.age.message}</span>}
      
      <input {...register('password')} type="password" />
      {errors.password && <span>{errors.password.message}</span>}
      
      <input {...register('confirmPassword')} type="password" />
      {errors.confirmPassword && <span>{errors.confirmPassword.message}</span>}
      
      <button type="submit">Submit</button>
    </form>
  );
}
```

### Server-side Validation with Zod

```jsx
// app/actions.js
'use server';

import { z } from 'zod';

const UserSchema = z.object({
  name: z.string().min(3),
  email: z.string().email(),
});

export async function createUser(prevState, formData) {
  const validatedFields = UserSchema.safeParse({
    name: formData.get('name'),
    email: formData.get('email'),
  });
  
  if (!validatedFields.success) {
    return {
      errors: validatedFields.error.flatten().fieldErrors,
    };
  }
  
  const { name, email } = validatedFields.data;
  
  await db.user.create({
    data: { name, email }
  });
  
  return { success: true };
}
```

```jsx
'use client';

import { useFormState } from 'react-dom';
import { createUser } from '@/app/actions';

export default function Form() {
  const [state, formAction] = useFormState(createUser, {});
  
  return (
    <form action={formAction}>
      <input name="name" />
      {state.errors?.name && <span>{state.errors.name[0]}</span>}
      
      <input name="email" />
      {state.errors?.email && <span>{state.errors.email[0]}</span>}
      
      <button type="submit">Submit</button>
      
      {state.success && <div>User created successfully!</div>}
    </form>
  );
}
```

---

*This completes sections 11-21. The guide continues with Authentication, Database Integration, Performance, Testing, and Deployment sections. Would you like me to continue with the remaining sections (22-37)?*
