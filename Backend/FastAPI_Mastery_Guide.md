# The Complete FastAPI Mastery Guide
## From Zero to Expert: Deep Dive into Modern Python Web APIs

**Version**: 1.0 (Ultra Deep Dive Edition)  
**Last Updated**: 2025  
**Target Audience**: Developers seeking a mastery-level understanding of FastAPI (from fundamentals to production-ready architecture)

---

## Table of Contents

### Part I: Fundamentals & Core Concepts
1. [FastAPI Philosophy & Mental Model](#1-fastapi-philosophy--mental-model)  
2. [Environment Setup & Tooling](#2-environment-setup--tooling)  
3. [Project Structure & Architecture](#3-project-structure--architecture)  
4. [Request–Response Cycle Deep Dive](#4-requestresponse-cycle-deep-dive)  
5. [Routing: The Complete Guide](#5-routing-the-complete-guide)

### Part II: Data Handling & Validation
6. [Pydantic Models & Validation](#6-pydantic-models--validation)  
7. [Path, Query, Body, Headers & Cookies](#7-path-query-body-headers--cookies)  
8. [Response Models, Status Codes & Error Handling](#8-response-models-status-codes--error-handling)  
9. [File Uploads, Form Data & Streaming Responses](#9-file-uploads-form-data--streaming-responses)

### Part III: Dependency Injection & Application Lifecycle
10. [Dependency Injection System (Depends)](#10-dependency-injection-system-depends)  
11. [Lifespan Events, Startup & Shutdown](#11-lifespan-events-startup--shutdown)

### Part IV: Database Integration
12. [SQL Databases with SQLAlchemy](#12-sql-databases-with-sqlalchemy)  
13. [SQLModel & Async Databases](#13-sqlmodel--async-databases)  
14. [Repository & Service Layer Patterns](#14-repository--service-layer-patterns)

### Part V: Authentication, Authorization & Security
15. [Security Primitives (OAuth2, Security Schemes)](#15-security-primitives-oauth2-security-schemes)  
16. [JWT Authentication End-to-End](#16-jwt-authentication-end-to-end)  
17. [Roles, Permissions & Scopes](#17-roles-permissions--scopes)  
18. [Security Best Practices](#18-security-best-practices)

### Part VI: Advanced FastAPI Features
19. [Background Tasks](#19-background-tasks)  
20. [WebSockets & Real-time Features](#20-websockets--real-time-features)  
21. [Settings Management & Configuration](#21-settings-management--configuration)  
22. [Modularization with APIRouter](#22-modularization-with-apirouter)  
23. [Versioning Your API](#23-versioning-your-api)

### Part VII: Testing, Performance & Production
24. [Testing FastAPI with pytest & HTTPX](#24-testing-fastapi-with-pytest--httpx)  
25. [Performance Optimization](#25-performance-optimization)  
26. [Logging, Monitoring & Observability](#26-logging-monitoring--observability)  
27. [Deployment Strategies (Uvicorn, Gunicorn, Docker)](#27-deployment-strategies-uvicorn-gunicorn-docker)  
28. [Common Pitfalls & Best Practices Checklist](#28-common-pitfalls--best-practices-checklist)
29. [Machine Learning with PyTorch Integration](#29-machine-learning-with-pytorch-integration)
30. [Integrating PyTorch Models with Node.js/Express Backends](#30-integrating-pytorch-models-with-node.js-express-backends)

---

## Part I: Fundamentals & Core Concepts

---

## 1. FastAPI Philosophy & Mental Model

### What is FastAPI?

FastAPI is a **modern, high-performance, async-first** Python web framework for building APIs, powered by:

- **Starlette** – for the ASGI web layer (routing, middleware, WebSockets, etc.)
- **Pydantic** – for data validation, parsing and serialization

Key properties:

- **Fast**: Comparable performance to Node.js and Go in many benchmarks.
- **Productive**: Minimal boilerplate, automatic documentation and validation.
- **Type-driven**: Python type hints directly power validation and docs.
- **Async-ready**: Designed around `async` / `await` and non-blocking IO.

### Minimal Example

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def read_root():
    return {"message": "Hello, FastAPI!"}
```

Run with Uvicorn:

```bash
uvicorn app:app --reload --host 0.0.0.0 --port 8000
```

- `app:app` → `module_name:variable_name` (Python import style)
- `--reload` → auto-reload on code changes (dev only)

### How FastAPI Thinks (Mental Model)

FastAPI encourages you to:

1. **Describe inputs and outputs using Python types and Pydantic models**.
2. **Attach those to HTTP paths and methods** using decorators.
3. **Define reusable dependencies** with `Depends(...)` instead of copy-pasting code.
4. Let FastAPI automatically handle:
   - Request parsing (JSON, form data, files)
   - Data validation & coercion
   - OpenAPI schema generation
   - Interactive API docs (Swagger UI / ReDoc)

Rough data flow:

```text
HTTP Request
  ↓
Routing (path + method match)
  ↓
Dependency Resolution & Validation
  ↓
Path Operation (your function)
  ↓
Pydantic Response Model Serialization
  ↓
HTTP Response (JSON by default)
```

### FastAPI vs "Traditional" Frameworks

- **Compared to Django / Flask**:
  - FastAPI is more API-focused, async-friendly, type-driven and automatically documented.
  - Django is batteries-included (ORM, admin, templates). FastAPI is more modular.
- **Compared to Express.js (Node.js)**:
  - FastAPI has built-in validation via types, no need for separate schemas (like Joi) unless needed.
  - Routing and dependency injection are more declarative.

---

## 2. Environment Setup & Tooling

### 2.1 Prerequisites

- Python **3.9+** (3.10+ recommended)
- `pip` or `pipx` (or Poetry / Pipenv)
- A modern editor (VS Code + Python extensions recommended)

### 2.2 Create & Activate Virtual Environment

**Windows (PowerShell):**

```bash
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

**macOS / Linux:**

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### 2.3 Install Core Dependencies

```bash
# Core
pip install fastapi uvicorn

# Optional: extras (templates, forms, etc.)
pip install "fastapi[all]"

# Database (choose based on needs)
pip install sqlalchemy psycopg2-binary  # PostgreSQL (sync)
# or
pip install "sqlmodel[postgresql]"      # SQLModel + async support

# Security & Auth
pip install python-jose[cryptography] passlib[bcrypt]

# Environment & settings
pip install python-dotenv pydantic-settings

# Testing
pip install pytest pytest-asyncio httpx

# Tooling
pip install black isort ruff mypy
```

### 2.4 Basic `requirements.txt` Example

```txt
fastapi
uvicorn[standard]
sqlalchemy
python-jose[cryptography]
passlib[bcrypt]
python-dotenv
pydantic-settings
pytest
pytest-asyncio
httpx
black
isort
ruff
mypy
```

### 2.5 Editor / Tooling Recommendations

- Enable **format-on-save** with Black.
- Configure **isort** for imports.
- Add **mypy** for type checking.
- Use a **Python / FastAPI** extension in VS Code for linting and Intellisense.

---

## 3. Project Structure & Architecture

Like the Express guide, we want a **clean, scalable structure** that works for both small and large apps.

### 3.1 Small-to-Medium Project Structure

```text
fastapi-app/
├── app/
│   ├── main.py              # FastAPI app instance & router wiring
│   ├── api/
│   │   ├── deps.py          # Shared dependencies (DB, auth, etc.)
│   │   ├── v1/
│   │   │   ├── routes/
│   │   │   │   ├── users.py
│   │   │   │   ├── auth.py
│   │   │   │   └── items.py
│   │   │   └── __init__.py
│   │   └── __init__.py
│   ├── core/
│   │   ├── config.py        # Settings via pydantic-settings
│   │   ├── security.py      # JWT, password hashing helpers
│   │   └── logging.py       # Logging configuration
│   ├── db/
│   │   ├── base.py          # Base metadata / model imports
│   │   ├── session.py       # Engine & SessionLocal
│   │   └── init_db.py       # Initial data / migrations bootstrapping
│   ├── models/              # SQLAlchemy / SQLModel models
│   │   └── user.py
│   ├── schemas/             # Pydantic schemas (request/response)
│   │   └── user.py
│   ├── services/            # Business logic layer
│   │   └── user_service.py
│   └── __init__.py
├── tests/
│   ├── test_main.py
│   └── api/
├── .env
├── .env.example
├── pyproject.toml or requirements.txt
└── README.md
```

### 3.2 Large Enterprise-style Structure

```text
fastapi-app/
├── app/
│   ├── main.py
│   ├── api/
│   │   ├── deps.py
│   │   ├── v1/
│   │   │   ├── routes/
│   │   │   │   ├── users.py
│   │   │   │   ├── auth.py
│   │   │   │   ├── orders.py
│   │   │   │   └── products.py
│   │   │   ├── __init__.py
│   │   └── v2/
│   ├── core/
│   │   ├── config.py
│   │   ├── security.py
│   │   ├── logging.py
│   │   └── celery_app.py         # If using Celery or background workers
│   ├── db/
│   │   ├── base.py
│   │   ├── session.py
│   │   └── migrations/           # Alembic migrations
│   ├── models/
│   ├── schemas/
│   ├── services/
│   ├── utils/
│   └── __init__.py
├── tests/
│   ├── integration/
│   └── unit/
├── scripts/
├── docs/
└── docker/
```

### 3.3 Example `main.py`

```python
# app/main.py
from fastapi import FastAPI
from app.api.v1.routes import users, auth
from app.core.config import settings

app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.VERSION,
    docs_url="/docs",
    redoc_url="/redoc",
    openapi_url="/openapi.json",
)

# Routers
app.include_router(auth.router, prefix="/api/v1", tags=["auth"])
app.include_router(users.router, prefix="/api/v1/users", tags=["users"])


@app.get("/health", tags=["health"])
async def health_check():
    return {"status": "OK"}
```

---

## 4. Request–Response Cycle Deep Dive

If you already know `@app.get("/some-path")` but are not sure **what exactly happens after a request comes in**, this section is for you.

### 4.1 High-level Flow (Step-by-step)

Imagine a client (browser / Postman / frontend app) calling your API:

```text
1. Client sends HTTP request (e.g. GET /items?page=2&size=5)
2. Uvicorn (ASGI server) receives the request
3. FastAPI finds the matching path operation (e.g. @app.get("/items"))
4. FastAPI reads all parameter definitions and dependencies
5. FastAPI:
   - Extracts data from the URL (path + query)
   - Converts types (str → int, etc.)
   - Validates with Pydantic models / type hints
6. FastAPI calls your Python function (path operation) with the parsed arguments
7. Your function returns a Python object (dict / list / Pydantic model)
8. FastAPI converts it to JSON, sets status code & headers
9. Uvicorn sends the HTTP response back to the client
```

So: **you only write a normal Python function**; FastAPI takes care of the ugly request parsing and JSON response details.

---

### 4.2 What is Pagination? (Beginner-friendly)

When a database table has thousands of rows (e.g. users, products, posts), you almost never want to send **all** of them in a single response.

**Pagination** means:

- Return results **page by page** instead of everything at once.
- Common parameters:
  - `page` → which page the client wants (1, 2, 3, ...)
  - `size` (or `limit`) → how many items per page (10, 20, 50, ...)
- Example: `GET /items?page=2&size=10`
  - Skip the first 10 results (page 1)
  - Return items 11–20

We usually:

1. **Read** `page` and `size` from the query string.
2. **Validate** them (page ≥ 1, size not too large).
3. **Convert** them into `offset` / `limit` for the database.
4. **Wrap** them in a small helper object so we can reuse this logic.

---

### 4.3 Example with Logging, Dependency & Pagination Helper

Below is a small, self-contained example you can paste into a file like `main.py` and run directly. It shows:

- How requests go through a **middleware** for logging.
- How a **dependency** collects and validates pagination parameters.
- How the final **route** receives a ready-to-use `pagination` object.

```python
from fastapi import FastAPI, Depends, Request, Query
from pydantic import BaseModel, Field

app = FastAPI()


# 1) Define a Pydantic model to hold pagination data
class PaginationParams(BaseModel):
    # "page" is which page the user wants (1, 2, 3, ...)
    page: int = Field(1, ge=1, description="Current page number (starting from 1)")
    # "size" is how many items we return per page
    size: int = Field(10, ge=1, le=100, description="Items per page (1–100)")


# 2) Define a dependency that reads page/size from the query string
#    and returns a PaginationParams object.
async def get_pagination(
    page: int = Query(1, ge=1, description="Page number, must be >= 1"),
    size: int = Query(10, ge=1, le=100, description="Page size, 1–100"),
) -> PaginationParams:
    """Read and validate pagination parameters from the URL query string.

    Example:
    - GET /items?page=2&size=5 → page=2, size=5
    - GET /items               → page=1, size=10 (defaults)
    """
    return PaginationParams(page=page, size=size)


# 3) Optional: a middleware that logs ALL requests
@app.middleware("http")
async def log_requests(request: Request, call_next):
    print(f"Incoming: {request.method} {request.url}")
    response = await call_next(request)  # call the next layer (dependencies + route)
    print(f"Completed: {response.status_code}")
    return response


# 4) A route that uses the pagination dependency
@app.get("/items")
async def list_items(pagination: PaginationParams = Depends(get_pagination)):
    """Return a fake list of items with pagination info.

    In a real app, you would:
    - Compute `offset = (page - 1) * size`
    - Run a DB query like: SELECT * FROM items LIMIT size OFFSET offset
    """

    # Example of how you'd calculate offset/limit for a database
    offset = (pagination.page - 1) * pagination.size
    limit = pagination.size

    # For now, we just pretend and return metadata
    return {
        "pagination": {
            "page": pagination.page,
            "size": pagination.size,
            "offset": offset,
            "limit": limit,
        },
        "items": [],  # here you would put the actual data from the DB
    }
```

#### Step-by-step: `GET /items?page=2&size=5`

1. **Uvicorn** receives the request and hands it to FastAPI.
2. FastAPI passes the request to the `log_requests` **middleware**:
   - It prints: `Incoming: GET http://127.0.0.1:8000/items?page=2&size=5`.
   - It calls `call_next(request)` to continue.
3. FastAPI looks for a matching route: `@app.get("/items")`.
4. FastAPI inspects the parameters of `list_items`:
   - Sees `pagination: PaginationParams = Depends(get_pagination)`.
   - Understands that **before** calling `list_items`, it must call `get_pagination`.
5. FastAPI calls `get_pagination` and:
   - Reads `page` and `size` from the query string.
   - Converts them to integers.
   - Validates them (`page >= 1`, `1 <= size <= 100`).
   - Builds a `PaginationParams(page=2, size=5)` Pydantic object.
6. FastAPI then calls `list_items(pagination=PaginationParams(page=2, size=5))`.
7. Inside `list_items`:
   - We compute `offset = (2 - 1) * 5 = 5`.
   - We compute `limit = 5`.
   - In a **real** app, you would use these in a DB query.
   - We return a dict with pagination info and a fake empty `items` list.
8. FastAPI serializes this dict to JSON and creates the HTTP response.
9. Control goes back to `log_requests` middleware:
   - It prints: `Completed: 200`.
   - It returns the response.
10. The client receives a JSON response like:

```json
{
  "pagination": {
    "page": 2,
    "size": 5,
    "offset": 5,
    "limit": 5
  },
  "items": []
}
```

---

### 4.4 Real Database Pagination Example (SQLAlchemy)

Now let’s plug the same pagination idea into a **real database query**. We’ll use:

- A simple `Item` SQLAlchemy model.
- The `get_db` dependency from the DB section.
- Our `PaginationParams` + `get_pagination` from above.

```python
# models/item.py
from sqlalchemy import Column, Integer, String
from app.db.base import Base


class Item(Base):
    __tablename__ = "items"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
```

```python
# schemas/item.py
from pydantic import BaseModel


class ItemOut(BaseModel):
    id: int
    name: str

    class Config:
        orm_mode = True
```

```python
# api/v1/routes/items.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List

from app.db.session import get_db
from app.models.item import Item
from app.schemas.item import ItemOut
from app.api.v1.deps import get_pagination, PaginationParams

router = APIRouter()


@router.get("/", response_model=List[ItemOut])
async def list_items(
    pagination: PaginationParams = Depends(get_pagination),
    db: Session = Depends(get_db),
):
    # 1) Calculate offset/limit from page + size
    offset = (pagination.page - 1) * pagination.size
    limit = pagination.size

    # 2) Query the database with LIMIT/OFFSET
    items = (
        db.query(Item)
        .order_by(Item.id)            # sort by id for stable paging
        .offset(offset)               # skip "offset" rows
        .limit(limit)                 # take at most "limit" rows
        .all()
    )

    return items
```

**What happens for `GET /api/v1/items?page=3&size=10`:**

1. FastAPI runs `get_pagination` → `PaginationParams(page=3, size=10)`.
2. `offset = (3 - 1) * 10 = 20` → skip first 20 rows.
3. `limit = 10` → take next 10 rows.
4. SQLAlchemy query becomes: roughly "give me items 21–30 when ordered by id".
5. FastAPI converts each `Item` ORM object into `ItemOut` (thanks to `orm_mode = True`).
6. The client receives **only 10 items** for that page.

You can reuse this pattern for **any table**:

- Change `Item` → `User`, `Product`, etc.
- Keep using the **same** `PaginationParams` + `get_pagination` dependency.

---

### 4.5 Async vs Sync in FastAPI (Beginner-friendly)

You’ll see two kinds of route functions in FastAPI:

```python
@app.get("/sync")
def sync_route():
    return {"type": "sync"}


@app.get("/async")
async def async_route():
    return {"type": "async"}
```

Both **work**, but they are different:

- `def` (sync): regular Python function. If it does slow/blocking work, the whole worker is blocked.
- `async def`: asynchronous function. It can **await** other async operations and let FastAPI serve other requests while it waits.

FastAPI can happily mix both, but:

- Use **`async def`** for anything that might wait on IO (DB, HTTP calls, file system) *if* the library you use supports async.
- It’s okay to keep **simple CPU-only work** as plain `def`.

#### What does `await` mean?

Inside an `async def` function you can write:

```python
import asyncio


@app.get("/wait")
async def wait_route():
    # Pretend to do some work for 2 seconds
    await asyncio.sleep(2)
    return {"done": True}
```

`await asyncio.sleep(2)` means:

- “Pause this route’s work for 2 seconds, **but do NOT block the whole server**.”
- During those 2 seconds, FastAPI/Uvicorn can handle **other requests**.

If you did this instead:

```python
import time


@app.get("/bad-wait")
async def bad_wait_route():
    time.sleep(2)  # ❌ blocking inside async
    return {"done": True}
```

`time.sleep(2)` blocks the entire worker process for 2 seconds, even though the function is `async def`. So:

- Inside `async def`, always use **async functions** (`await something_async()`), not blocking ones.

#### Async DB Example (Conceptual)

For async DB libraries (e.g. SQLAlchemy 2 async, asyncpg, databases, SQLModel + async engine), you’ll often see:

```python
@app.get("/users")
async def list_users(db: AsyncSession = Depends(get_async_db)):
    result = await db.execute(select(User))  # await the DB call
    users = result.scalars().all()
    return users
```

Key points:

- The route is `async def`.
- The DB call is `await db.execute(...)`.
- While the DB is working, FastAPI can process other requests.

You don’t need to become an async expert immediately, but remember:

> **If the library gives you an async function (e.g. `await client.get(...)`), your route must be `async def` and you must use `await`.**

We’ll see a complete async DB pagination example later in the SQLModel section.

---

The important takeaway:

- **You don’t manually read `request.query_params` inside every route.**
- Instead, you create a **dependency** (here `get_pagination`) that:
  - Reads data from the request.
  - Validates it.
  - Returns a nicely typed object.
- Any route can then just say `pagination: PaginationParams = Depends(get_pagination)` and reuse this logic.

---

## 5. Routing: The Complete Guide

### 5.1 Basic HTTP Methods

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def read_root():
    return {"message": "GET root"}

@app.post("/")
async def create_root():
    return {"message": "POST root"}

@app.put("/")
async def update_root():
    return {"message": "PUT root"}

@app.delete("/")
async def delete_root():
    return {"message": "DELETE root"}
```

### 5.2 Path Parameters (Typed)

```python
from fastapi import Path

@app.get("/users/{user_id}")
async def get_user(user_id: int = Path(..., gt=0)):
    return {"user_id": user_id}

@app.get("/users/{user_id}/posts/{post_id}")
async def get_user_post(user_id: int, post_id: int):
    return {"user_id": user_id, "post_id": post_id}
```

### 5.3 Query Parameters

```python
from typing import List, Optional
from fastapi import Query

@app.get("/search")
async def search(
    q: Optional[str] = Query(None, min_length=3, max_length=50),
    tags: List[str] = Query(default=[]),
    page: int = Query(1, ge=1),
    size: int = Query(10, ge=1, le=100),
):
    return {
        "q": q,
        "tags": tags,
        "page": page,
        "size": size,
    }
```

Example URL:

```text
/search?q=fastapi&tags=python&tags=backend&page=2
```

→ `tags == ["python", "backend"]`

### 5.4 APIRouter & Modular Routing

```python
# app/api/v1/routes/users.py
from fastapi import APIRouter, Depends, HTTPException, status
from typing import List
from pydantic import BaseModel

router = APIRouter()

class User(BaseModel):
    id: int
    name: str

fake_users = [User(id=1, name="Alice"), User(id=2, name="Bob")]


@router.get("/", response_model=List[User])
async def list_users():
    return fake_users


@router.get("/{user_id}", response_model=User)
async def get_user(user_id: int):
    for user in fake_users:
        if user.id == user_id:
            return user
    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
```

Registering the router in `main.py`:

```python
# app/main.py
from fastapi import FastAPI
from app.api.v1.routes import users

app = FastAPI()

app.include_router(users.router, prefix="/api/v1/users", tags=["users"])
```

---

## Part II: Data Handling & Validation

---

## 6. Pydantic Models & Validation

### 6.1 Basic Models

```python
from pydantic import BaseModel, EmailStr, Field


class UserBase(BaseModel):
    name: str = Field(..., min_length=2, max_length=50)
    email: EmailStr


class UserCreate(UserBase):
    password: str = Field(..., min_length=8)


class UserUpdate(BaseModel):
    name: str | None = Field(None, min_length=2, max_length=50)


class UserOut(UserBase):
    id: int
    is_active: bool = True

    class Config:
        orm_mode = True  # allows returning ORM objects directly
```

### 6.2 Enums, Nested Models & Examples

```python
from enum import Enum
from typing import List


class Role(str, Enum):
    user = "user"
    admin = "admin"


class Profile(BaseModel):
    bio: str | None = None
    website: str | None = None


class UserDetail(UserOut):
    role: Role = Role.user
    profile: Profile | None = None
    tags: List[str] = []

    class Config:
        schema_extra = {
            "example": {
                "id": 1,
                "name": "Alice",
                "email": "alice@example.com",
                "is_active": True,
                "role": "admin",
                "profile": {
                    "bio": "Backend engineer",
                    "website": "https://example.com",
                },
                "tags": ["fastapi", "backend"],
            }
        }
```

### 6.3 Request / Response Validation

```python
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

router = APIRouter()


@router.post("/", response_model=UserOut, status_code=status.HTTP_201_CREATED)
async def create_user(user_in: UserCreate, db: Session = Depends(get_db)):
    existing = db.query(User).filter(User.email == user_in.email).first()
    if existing:
        raise HTTPException(status_code=409, detail="Email already registered")

    user = User(
        name=user_in.name,
        email=user_in.email,
        hashed_password=hash_password(user_in.password),
    )
    db.add(user)
    db.commit()
    db.refresh(user)
    return user
```

---

## 7. Path, Query, Body, Headers & Cookies

### 7.1 Body Parameters

```python
from fastapi import Body


@app.post("/items")
async def create_item(
    name: str = Body(..., min_length=1),
    price: float = Body(..., gt=0),
    is_offer: bool | None = Body(None),
):
    return {"name": name, "price": price, "is_offer": is_offer}
```

Using a Pydantic model:

```python
class Item(BaseModel):
    name: str
    price: float
    tags: list[str] = []


@app.post("/items", response_model=Item)
async def create_item(item: Item):
    return item
```

### 7.2 Headers & Cookies

```python
from fastapi import Header, Cookie


@app.get("/header-demo")
async def header_demo(
    user_agent: str = Header(...),
    x_trace_id: str | None = Header(None, convert_underscores=False),
):
    return {"user_agent": user_agent, "x_trace_id": x_trace_id}


@app.get("/cookie-demo")
async def cookie_demo(session_id: str | None = Cookie(None)):
    return {"session_id": session_id}
```

Setting cookies:

```python
from fastapi import Response


@app.post("/login")
async def login(response: Response):
    # validate credentials...
    response.set_cookie(
        key="session_id",
        value="abc123",
        httponly=True,
        max_age=3600,
        samesite="lax",
        secure=False,  # True in production (HTTPS)
    )
    return {"logged_in": True}
```

---

## 8. Response Models, Status Codes & Error Handling

### 8.1 Response Models & Codes

```python
from typing import List
from fastapi import status


@app.get("/users", response_model=List[UserOut])
async def list_users(db: Session = Depends(get_db)):
    users = db.query(User).all()
    return users


@app.post(
    "/users",
    response_model=UserOut,
    status_code=status.HTTP_201_CREATED,
)
async def create_user(...):
    ...
```

### 8.2 `HTTPException` Usage

```python
from fastapi import HTTPException


@app.get("/users/{user_id}", response_model=UserOut)
async def get_user(user_id: int, db: Session = Depends(get_db)):
    user = db.query(User).get(user_id)
    if not user:
        raise HTTPException(status_code=404, detail=f"User {user_id} not found")
    return user
```

### 8.3 Custom Exception Handler

```python
from fastapi import Request
from fastapi.responses import JSONResponse


class AppError(Exception):
    def __init__(self, message: str, status_code: int = 400):
        self.message = message
        self.status_code = status_code


@app.exception_handler(AppError)
async def app_error_handler(request: Request, exc: AppError):
    return JSONResponse(
        status_code=exc.status_code,
        content={"detail": exc.message},
    )
```

---

## 9. File Uploads, Form Data & Streaming Responses

### 9.1 File Uploads with `UploadFile`

```python
from fastapi import File, UploadFile
from typing import List


@app.post("/uploadfile")
async def upload_file(file: UploadFile = File(...)):
    content = await file.read()
    size = len(content)
    return {"filename": file.filename, "size": size}


@app.post("/upload-multiple")
async def upload_multiple(files: List[UploadFile] = File(...)):
    return [{"filename": f.filename} for f in files]
```

### 9.2 Form Data

```python
from fastapi import Form


@app.post("/login-form")
async def login_form(username: str = Form(...), password: str = Form(...)):
    return {"username": username}
```

### 9.3 Streaming Responses

```python
from fastapi.responses import StreamingResponse
from io import BytesIO


@app.get("/stream")
async def stream():
    data = BytesIO(b"Hello, this is streamed content")
    return StreamingResponse(data, media_type="text/plain")
```

---

## Part III: Dependency Injection & Application Lifecycle

---

## 10. Dependency Injection System (`Depends`)

### 10.1 Basic Dependency

```python
from fastapi import Depends


def get_token(token: str | None = None):
    # In real code, extract from headers or cookies
    return token


@app.get("/secure")
async def secure_route(token: str | None = Depends(get_token)):
    return {"token": token}
```

### 10.2 Database Session Dependency

```python
# app/db/session.py
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session

SQLALCHEMY_DATABASE_URL = "sqlite:///./test.db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False}
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


def get_db() -> Session:
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
```

Usage:

```python
from sqlalchemy.orm import Session


@app.get("/users")
async def list_users(db: Session = Depends(get_db)):
    return db.query(User).all()
```

---

## 11. Lifespan Events, Startup & Shutdown

### 11.1 Classic Event Handlers

```python
@app.on_event("startup")
async def on_startup():
    # Connect to DB, init caches, etc.
    ...


@app.on_event("shutdown")
async def on_shutdown():
    # Close DB connections, cleanup resources
    ...
```

### 11.2 Lifespan Context Manager

```python
from contextlib import asynccontextmanager
from fastapi import FastAPI


@asynccontextmanager
async def lifespan(app: FastAPI):
    print("Starting app")
    # startup
    yield
    # shutdown
    print("Shutting down")


app = FastAPI(lifespan=lifespan)
```

---

## Part IV: Database Integration

---

## 12. SQL Databases with SQLAlchemy

### 12.1 Engine & Session

```python
# app/db/session.py
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

SQLALCHEMY_DATABASE_URL = "postgresql://user:password@localhost:5432/mydb"

engine = create_engine(SQLALCHEMY_DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
```

### 12.2 Base Model & User Model

```python
# app/db/base.py
from sqlalchemy.orm import declarative_base

Base = declarative_base()
```

```python
# app/models/user.py
from sqlalchemy import Column, Integer, String, Boolean
from app.db.base import Base


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(50), nullable=False)
    email = Column(String(255), unique=True, index=True, nullable=False)
    hashed_password = Column(String(255), nullable=False)
    is_active = Column(Boolean, default=True)
```

### 12.3 CRUD with FastAPI

```python
# app/api/v1/routes/users.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.schemas.user import UserCreate, UserOut
from app.models.user import User
from app.db.session import get_db
from app.core.security import hash_password

router = APIRouter()


@router.get("/", response_model=list[UserOut])
async def list_users(db: Session = Depends(get_db)):
    return db.query(User).all()


@router.post("/", response_model=UserOut, status_code=status.HTTP_201_CREATED)
async def create_user(user_in: UserCreate, db: Session = Depends(get_db)):
    existing = db.query(User).filter(User.email == user_in.email).first()
    if existing:
        raise HTTPException(status_code=409, detail="Email already registered")

    user = User(
        name=user_in.name,
        email=user_in.email,
        hashed_password=hash_password(user_in.password),
    )
    db.add(user)
    db.commit()
    db.refresh(user)
    return user
```

---

## 13. SQLModel & Async Databases

*(Conceptually similar to SQLAlchemy, but more Pydantic-friendly and with good async support.)*

### 13.1 Basic SQLModel Setup (Sync)

```python
from sqlmodel import SQLModel, Field, create_engine, Session


class User(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str
    email: str
    is_active: bool = True


engine = create_engine("sqlite:///./sqlmodel.db", echo=True)



def init_db():
    SQLModel.metadata.create_all(engine)



def get_session():
    with Session(engine) as session:
        yield session
```

### 13.2 Async SQLModel + Async Pagination Example

Now, let’s see how this looks with **async**. We’ll:

- Use an **async engine**.
- Define an `AsyncSession` dependency.
- Reuse the same `PaginationParams` + `get_pagination`.

```python
# db/async_session.py
from sqlmodel import SQLModel
from sqlmodel.ext.asyncio.session import AsyncSession
from sqlalchemy.ext.asyncio import create_async_engine
from sqlalchemy.orm import sessionmaker

DATABASE_URL = "postgresql+asyncpg://user:password@localhost:5432/mydb"

engine = create_async_engine(DATABASE_URL, echo=False, future=True)

AsyncSessionLocal = sessionmaker(
    engine, expire_on_commit=False, class_=AsyncSession
)


async def init_async_db() -> None:
    async with engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.create_all)


async def get_async_session() -> AsyncSession:
    async with AsyncSessionLocal() as session:
        yield session
```

Assume we have an `Item` model compatible with SQLModel:

```python
# models/item_sqlmodel.py
from sqlmodel import SQLModel, Field


class Item(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str
```

Async route with pagination:

```python
# api/v1/routes/items_async.py
from typing import List

from fastapi import APIRouter, Depends
from sqlmodel import select
from sqlmodel.ext.asyncio.session import AsyncSession

from app.db.async_session import get_async_session
from app.api.v1.deps import PaginationParams, get_pagination
from app.models.item_sqlmodel import Item

router = APIRouter()


@router.get("/", response_model=List[Item])
async def list_items_async(
    pagination: PaginationParams = Depends(get_pagination),
    session: AsyncSession = Depends(get_async_session),
):
    # 1) Compute offset/limit from page + size
    offset = (pagination.page - 1) * pagination.size
    limit = pagination.size

    # 2) Build a SELECT query
    query = select(Item).order_by(Item.id).offset(offset).limit(limit)

    # 3) Execute query asynchronously
    result = await session.exec(query)

    # 4) Extract list of Item objects
    items = result.all()

    return items
```

What’s new compared to the sync SQLAlchemy example:

- The route is **`async def`**.
- The DB session type is **`AsyncSession`**.
- We `await session.exec(query)` because it’s an async call.
- While the database is processing the query, FastAPI can serve other requests.

This mirrors the earlier **sync** pagination logic, but now everything is async/await-aware.

---

Similar to the Express guide’s service/controller layering, we can:

- Keep **route handlers** thin.
- Move complex logic to **services**.
- Access DB through **repositories**.

```python
# app/services/user_service.py
from sqlalchemy.orm import Session
from app.models.user import User
from app.schemas.user import UserCreate
from app.core.security import hash_password


def create_user(db: Session, user_in: UserCreate) -> User:
    existing = db.query(User).filter(User.email == user_in.email).first()
    if existing:
        raise ValueError("Email already registered")
    user = User(
        name=user_in.name,
        email=user_in.email,
        hashed_password=hash_password(user_in.password),
    )
    db.add(user)
    db.commit()
    db.refresh(user)
    return user
```

```python
# app/api/v1/routes/users.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.session import get_db
from app.schemas.user import UserCreate, UserOut
from app.services.user_service import create_user as create_user_service

router = APIRouter()


@router.post("/", response_model=UserOut)
async def create_user(user_in: UserCreate, db: Session = Depends(get_db)):
    try:
        user = create_user_service(db, user_in)
    except ValueError as exc:
        raise HTTPException(status_code=409, detail=str(exc))
    return user
```

---

## Part V: Authentication, Authorization & Security

---

## 15. Security Primitives (OAuth2, Security Schemes)

FastAPI provides security helpers via `fastapi.security`.

```python
from fastapi.security import OAuth2PasswordBearer
from fastapi import Depends, HTTPException, status
from jose import jwt, JWTError


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/v1/auth/token")

SECRET_KEY = "CHANGE_ME"
ALGORITHM = "HS256"


async def get_current_user(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
    except JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid authentication credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    # load user from DB using payload["sub"]
    ...
```

---

## 16. JWT Authentication End-to-End

### 16.1 Password Hashing & Token Generation

```python
from datetime import datetime, timedelta
from passlib.context import CryptContext
from jose import jwt

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
SECRET_KEY = "CHANGE_ME"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30


def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)


def hash_password(password: str) -> str:
    return pwd_context.hash(password)


def create_access_token(data: dict, expires_delta: timedelta | None = None) -> str:
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=15))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
```

### 16.2 Login Route

```python
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from datetime import timedelta

router = APIRouter()


@router.post("/token")
async def login_for_access_token(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db),
):
    user = authenticate_user(db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect username or password")

    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": str(user.id)}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}
```

---

## 17. Roles, Permissions & Scopes

```python
from fastapi import Depends, HTTPException, status


def require_admin(current_user = Depends(get_current_user)):
    if current_user.role != "admin":
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Forbidden")
    return current_user


@app.delete("/admin/users/{user_id}")
async def admin_delete_user(
    user_id: int,
    current_admin = Depends(require_admin),
):
    # only admins can access this route
    ...
```

---

## 18. Security Best Practices

- Always hash passwords (never store plain text).
- Use HTTPS in production.
- Rotate secrets and use environment variables.
- Limit exposure of internal fields via response models.
- Validate all input with Pydantic.
- Configure CORS properly when serving from multiple domains.

---

## Part VI: Advanced FastAPI Features

---

## 19. Background Tasks

```python
from fastapi import BackgroundTasks


def send_email(email: str, content: str):
    # Heavy IO - send email, write file, etc.
    ...


@app.post("/send-email")
async def send_email_endpoint(
    email: str,
    background_tasks: BackgroundTasks,
):
    background_tasks.add_task(send_email, email, "Welcome!")
    return {"message": "Email scheduled"}
```

---

## 20. WebSockets & Real-time Features

```python
from fastapi import WebSocket, WebSocketDisconnect


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        while True:
            data = await websocket.receive_text()
            await websocket.send_text(f"Echo: {data}")
    except WebSocketDisconnect:
        pass
```

---

## 21. Settings Management & Configuration

```python
# app/core/config.py
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    PROJECT_NAME: str = "FastAPI App"
    VERSION: str = "1.0.0"
    ENVIRONMENT: str = "development"
    DATABASE_URL: str
    SECRET_KEY: str

    class Config:
        env_file = ".env"


settings = Settings()
```

Example `.env`:

```env
PROJECT_NAME="FastAPI Mastery Service"
VERSION="1.0.0"
ENVIRONMENT="development"
DATABASE_URL="postgresql://user:password@localhost:5432/mydb"
SECRET_KEY="CHANGE_ME"
```

---

## 22. Modularization with APIRouter

- Organize features by **domain** (users, auth, orders, etc.).
- Group routes with `APIRouter`, then mount under prefixes.

```python
# app/api/v1/routes/orders.py
from fastapi import APIRouter

router = APIRouter()


@router.get("/")
async def list_orders():
    return []
```

```python
# app/main.py
from app.api.v1.routes import users, auth, orders

app.include_router(users.router, prefix="/api/v1/users", tags=["users"])
app.include_router(auth.router, prefix="/api/v1", tags=["auth"])
app.include_router(orders.router, prefix="/api/v1/orders", tags=["orders"])
```

---

## 23. Versioning Your API

- Use different prefixes: `/api/v1`, `/api/v2`.
- Optionally separate routers into `api/v1`, `api/v2` packages.

```text
app/
  api/
    v1/
      routes/
    v2/
      routes/
```

---

## Part VII: Testing, Performance & Production

---

## 24. Testing FastAPI with pytest & HTTPX

### 24.1 Basic Test with `TestClient`

```python
# tests/test_main.py
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)


def test_health_check():
    resp = client.get("/health")
    assert resp.status_code == 200
    assert resp.json()["status"] == "OK"
```

Run:

```bash
pytest
```

### 24.2 Async Tests with HTTPX

```python
import pytest
from httpx import AsyncClient
from app.main import app


@pytest.mark.asyncio
async def test_health_async():
    async with AsyncClient(app=app, base_url="http://test") as ac:
        resp = await ac.get("/health")
    assert resp.status_code == 200
```

---

## 25. Performance Optimization

- Use **async** DB drivers where possible.
- Avoid blocking IO in async endpoints.
- Enable **keep-alive** & proper connection pooling.
- Add caching (Redis, in-memory) for expensive queries.
- Profile endpoints with tools like `locust`, `k6`, or `wrk`.

---

## 26. Logging, Monitoring & Observability

### 26.1 Basic Logging Middleware

```python
from fastapi import Request


@app.middleware("http")
async def logging_middleware(request: Request, call_next):
    print(f"Request: {request.method} {request.url}")
    response = await call_next(request)
    print(f"Response status: {response.status_code}")
    return response
```

### 26.2 External Monitoring

- Integrate with tools like **Prometheus**, **Grafana**, **Sentry**, **New Relic**.
- Use OpenTelemetry for distributed tracing.

---

## 27. Deployment Strategies (Uvicorn, Gunicorn, Docker)

### 27.1 Local Development

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### 27.2 Production with Gunicorn + Uvicorn Workers

```bash
gunicorn app.main:app \
  --workers 4 \
  --worker-class uvicorn.workers.UvicornWorker \
  --bind 0.0.0.0:8000
```

### 27.3 Dockerfile Example

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

ENV PORT=8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

Build & run:

```bash
docker build -t fastapi-app .
docker run -p 8000:8000 --env-file .env fastapi-app
```

---

## 28. Common Pitfalls & Best Practices Checklist

### 28.1 Common Pitfalls

- Mixing blocking IO in async endpoints (e.g. `time.sleep` instead of `asyncio.sleep`).
- Returning ORM models directly without `orm_mode` Pydantic schemas.
- Forgetting to close DB sessions when using custom session management.
- Hardcoding secrets instead of using environment variables.
- Overloading path operations with too much business logic (no service layer).

### 28.2 Best Practices Checklist

- [ ] Use Pydantic models for all request/response bodies.  
- [ ] Separate schemas (`schemas/`), models (`models/`), and services (`services/`).  
- [ ] Use `Depends` for DB sessions, auth, and common logic.  
- [ ] Handle errors with `HTTPException` and custom exception handlers.  
- [ ] Secure JWTs with strong `SECRET_KEY` and short expirations.  
- [ ] Document environment variables and use `pydantic-settings`.  
- [ ] Add tests for critical endpoints (auth, payments, etc.).  
- [ ] Monitor performance and errors in production.

---

## 29. Machine Learning with PyTorch Integration

### Overview

FastAPI's async capabilities and automatic validation make it perfect for serving machine learning models. This section covers integrating PyTorch models with FastAPI for production deployment.

### Project Structure for ML APIs

```
ml_api/
├── app/
│   ├── __init__.py
│   ├── main.py
│   ├── models/
│   │   ├── __init__.py
│   │   ├── pytorch_model.py
│   │   └── schemas.py
│   ├── api/
│   │   ├── __init__.py
│   │   ├── routes/
│   │   │   ├── __init__.py
│   │   │   ├── prediction.py
│   │   │   └── health.py
│   │   └── dependencies.py
│   └── core/
│       ├── __init__.py
│       ├── config.py
│       └── preprocessing.py
├── models/
│   └── saved_models/
│       └── model_v1.pth
├── requirements.txt
└── Dockerfile
```

### Basic PyTorch Model Integration

#### 1. Model Definition and Loading

```python
# app/models/pytorch_model.py
import torch
import torch.nn as nn
from pathlib import Path
import logging

logger = logging.getLogger(__name__)

class SimpleClassifier(nn.Module):
    def __init__(self, input_size: int, hidden_size: int, num_classes: int):
        super(SimpleClassifier, self).__init__()
        self.layers = nn.Sequential(
            nn.Linear(input_size, hidden_size),
            nn.ReLU(),
            nn.Dropout(0.2),
            nn.Linear(hidden_size, hidden_size // 2),
            nn.ReLU(),
            nn.Dropout(0.2),
            nn.Linear(hidden_size // 2, num_classes)
        )
    
    def forward(self, x):
        return self.layers(x)

class ModelManager:
    def __init__(self, model_path: str, device: str = None):
        self.device = device or ('cuda' if torch.cuda.is_available() else 'cpu')
        self.model = None
        self.model_path = Path(model_path)
        self.load_model()
    
    def load_model(self):
        """Load PyTorch model with error handling"""
        try:
            # Define model architecture (must match training)
            self.model = SimpleClassifier(
                input_size=784,  # Example: 28x28 images flattened
                hidden_size=128,
                num_classes=10
            )
            
            # Load state dict
            state_dict = torch.load(self.model_path, map_location=self.device)
            self.model.load_state_dict(state_dict)
            self.model.to(self.device)
            self.model.eval()
            
            logger.info(f"Model loaded successfully on {self.device}")
            
        except Exception as e:
            logger.error(f"Failed to load model: {e}")
            raise
    
    def predict(self, input_data: torch.Tensor) -> torch.Tensor:
        """Make prediction with the model"""
        with torch.no_grad():
            input_data = input_data.to(self.device)
            outputs = self.model(input_data)
            probabilities = torch.softmax(outputs, dim=1)
            return probabilities
    
    def predict_classes(self, input_data: torch.Tensor) -> torch.Tensor:
        """Return predicted classes"""
        probabilities = self.predict(input_data)
        return torch.argmax(probabilities, dim=1)

# Global model instance
model_manager = None

def get_model_manager() -> ModelManager:
    """Dependency injection for model manager"""
    global model_manager
    if model_manager is None:
        model_manager = ModelManager("models/saved_models/model_v1.pth")
    return model_manager
```

#### 2. Pydantic Schemas for ML

```python
# app/models/schemas.py
from pydantic import BaseModel, Field, validator
from typing import List, Union
import numpy as np

class PredictionRequest(BaseModel):
    """Schema for single prediction request"""
    features: List[float] = Field(..., description="Input features as flat array")
    
    @validator('features')
    def validate_features(cls, v):
        if len(v) != 784:  # Example: 28x28 image
            raise ValueError('Features must be 784 elements (28x28 flattened)')
        return v

class BatchPredictionRequest(BaseModel):
    """Schema for batch prediction request"""
    instances: List[List[float]] = Field(..., description="List of feature arrays")
    
    @validator('instances')
    def validate_batch(cls, v):
        if not v:
            raise ValueError('At least one instance required')
        if len(v) > 100:  # Limit batch size
            raise ValueError('Maximum 100 instances per batch')
        for instance in v:
            if len(instance) != 784:
                raise ValueError('Each instance must have 784 features')
        return v

class PredictionResponse(BaseModel):
    """Schema for prediction response"""
    prediction: int = Field(..., description="Predicted class")
    confidence: float = Field(..., description="Prediction confidence")
    probabilities: List[float] = Field(..., description="Class probabilities")

class BatchPredictionResponse(BaseModel):
    """Schema for batch prediction response"""
    predictions: List[PredictionResponse]

class ModelInfo(BaseModel):
    """Model metadata"""
    model_name: str
    version: str
    input_shape: List[int]
    output_shape: List[int]
    device: str
    pytorch_version: str
```

#### 3. API Routes for ML Predictions

```python
# app/api/routes/prediction.py
from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
from fastapi.responses import JSONResponse
import torch
import time
import logging
from typing import List

from app.models.pytorch_model import get_model_manager, ModelManager
from app.models.schemas import (
    PredictionRequest, 
    BatchPredictionRequest, 
    PredictionResponse, 
    BatchPredictionResponse,
    ModelInfo
)

router = APIRouter()
logger = logging.getLogger(__name__)

@router.post("/predict", response_model=PredictionResponse)
async def predict(
    request: PredictionRequest,
    model_manager: ModelManager = Depends(get_model_manager)
):
    """
    Single prediction endpoint
    """
    start_time = time.time()
    
    try:
        # Convert input to tensor
        input_tensor = torch.tensor(request.features, dtype=torch.float32).unsqueeze(0)
        
        # Get predictions
        probabilities = model_manager.predict(input_tensor)
        predicted_class = model_manager.predict_classes(input_tensor)
        
        # Prepare response
        response = PredictionResponse(
            prediction=int(predicted_class.item()),
            confidence=float(probabilities[0][predicted_class].item()),
            probabilities=probabilities[0].tolist()
        )
        
        processing_time = time.time() - start_time
        logger.info(f"Prediction completed in {processing_time:.3f}s")
        
        return response
        
    except Exception as e:
        logger.error(f"Prediction failed: {e}")
        raise HTTPException(status_code=500, detail=f"Prediction failed: {str(e)}")

@router.post("/predict/batch", response_model=BatchPredictionResponse)
async def predict_batch(
    request: BatchPredictionRequest,
    background_tasks: BackgroundTasks,
    model_manager: ModelManager = Depends(get_model_manager)
):
    """
    Batch prediction endpoint with background processing for large batches
    """
    start_time = time.time()
    
    try:
        # Convert batch to tensor
        batch_tensor = torch.tensor(request.instances, dtype=torch.float32)
        
        # Get predictions
        probabilities = model_manager.predict(batch_tensor)
        predicted_classes = model_manager.predict_classes(batch_tensor)
        
        # Prepare response
        predictions = []
        for i in range(len(request.instances)):
            pred_response = PredictionResponse(
                prediction=int(predicted_classes[i].item()),
                confidence=float(probabilities[i][predicted_classes[i]].item()),
                probabilities=probabilities[i].tolist()
            )
            predictions.append(pred_response)
        
        response = BatchPredictionResponse(predictions=predictions)
        
        processing_time = time.time() - start_time
        logger.info(f"Batch prediction completed in {processing_time:.3f}s for {len(request.instances)} instances")
        
        return response
        
    except Exception as e:
        logger.error(f"Batch prediction failed: {e}")
        raise HTTPException(status_code=500, detail=f"Batch prediction failed: {str(e)}")

@router.get("/model/info", response_model=ModelInfo)
async def get_model_info(
    model_manager: ModelManager = Depends(get_model_manager)
):
    """
    Get model information and metadata
    """
    try:
        # Get model details
        model = model_manager.model
        
        # Calculate parameter count
        total_params = sum(p.numel() for p in model.parameters())
        
        info = ModelInfo(
            model_name="SimpleClassifier",
            version="1.0.0",
            input_shape=[784],  # Example
            output_shape=[10],  # Example: 10 classes
            device=str(model_manager.device),
            pytorch_version=torch.__version__
        )
        
        return info
        
    except Exception as e:
        logger.error(f"Failed to get model info: {e}")
        raise HTTPException(status_code=500, detail=f"Failed to get model info: {str(e)}")
```

#### 4. Health Check and Monitoring

```python
# app/api/routes/health.py
from fastapi import APIRouter, Depends
import torch
import psutil
import time
from app.models.pytorch_model import get_model_manager, ModelManager

router = APIRouter()

@router.get("/health")
async def health_check():
    """Basic health check"""
    return {
        "status": "healthy",
        "timestamp": time.time(),
        "service": "ml-api"
    }

@router.get("/health/detailed")
async def detailed_health_check(
    model_manager: ModelManager = Depends(get_model_manager)
):
    """Detailed health check with model and system info"""
    
    # Check GPU memory if available
    gpu_memory = {}
    if torch.cuda.is_available():
        gpu_memory = {
            "allocated": torch.cuda.memory_allocated() / 1024**2,  # MB
            "reserved": torch.cuda.memory_reserved() / 1024**2,    # MB
            "total": torch.cuda.get_device_properties(0).total_memory / 1024**2  # MB
        }
    
    # System memory
    memory = psutil.virtual_memory()
    
    return {
        "status": "healthy",
        "timestamp": time.time(),
        "model": {
            "loaded": model_manager.model is not None,
            "device": str(model_manager.device),
            "pytorch_version": torch.__version__
        },
        "system": {
            "cpu_percent": psutil.cpu_percent(interval=1),
            "memory_percent": memory.percent,
            "memory_used_mb": memory.used / 1024**2,
            "memory_total_mb": memory.total / 1024**2
        },
        "gpu": gpu_memory if gpu_memory else None
    }
```

#### 5. Main Application Setup

```python
# app/main.py
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
import logging
import time

from app.api.routes.prediction import router as prediction_router
from app.api.routes.health import router as health_router

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Create FastAPI app
app = FastAPI(
    title="ML API with PyTorch",
    description="Machine Learning API powered by FastAPI and PyTorch",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure appropriately for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Add routers
app.include_router(
    prediction_router,
    prefix="/api/v1",
    tags=["predictions"]
)
app.include_router(
    health_router,
    prefix="/api/v1",
    tags=["health"]
)

# Global exception handler
@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    logger.error(f"Global exception: {exc}")
    return JSONResponse(
        status_code=500,
        content={"detail": "Internal server error"}
    )

# Startup event
@app.on_event("startup")
async def startup_event():
    logger.info("Starting ML API server...")
    # Pre-load model or perform initialization
    pass

# Shutdown event
@app.on_event("shutdown")
async def shutdown_event():
    logger.info("Shutting down ML API server...")
    # Cleanup resources
    pass

@app.get("/")
async def root():
    return {
        "message": "ML API with PyTorch",
        "docs": "/docs",
        "health": "/api/v1/health"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
        log_level="info"
    )
```

### Advanced PyTorch Integration Patterns

#### 1. Model Versioning and A/B Testing

```python
# app/models/model_versioning.py
from typing import Dict, Optional
import torch
from pathlib import Path

class ModelVersionManager:
    def __init__(self):
        self.models: Dict[str, ModelManager] = {}
        self.active_versions: Dict[str, str] = {}
    
    def load_version(self, model_name: str, version: str, model_path: str):
        """Load a specific model version"""
        key = f"{model_name}:{version}"
        if key not in self.models:
            self.models[key] = ModelManager(model_path)
        return self.models[key]
    
    def set_active_version(self, model_name: str, version: str):
        """Set active version for A/B testing"""
        self.active_versions[model_name] = version
    
    def get_model(self, model_name: str, version: Optional[str] = None) -> ModelManager:
        """Get model by name and optional version"""
        if version is None:
            version = self.active_versions.get(model_name, "v1")
        
        key = f"{model_name}:{version}"
        if key not in self.models:
            raise ValueError(f"Model {key} not loaded")
        
        return self.models[key]

# Global instance
version_manager = ModelVersionManager()

def get_model_manager(model_name: str = "classifier", version: Optional[str] = None) -> ModelManager:
    return version_manager.get_model(model_name, version)
```

#### 2. Async Model Inference

```python
# app/api/routes/async_prediction.py
from fastapi import APIRouter, BackgroundTasks
import asyncio
import torch
from concurrent.futures import ThreadPoolExecutor
import logging

from app.models.schemas import PredictionRequest, PredictionResponse
from app.models.pytorch_model import get_model_manager

router = APIRouter()
logger = logging.getLogger(__name__)

# Thread pool for CPU-bound tasks
executor = ThreadPoolExecutor(max_workers=4)

async def run_inference(input_tensor: torch.Tensor):
    """Run model inference in thread pool"""
    loop = asyncio.get_event_loop()
    model_manager = get_model_manager()
    
    # Run in thread pool to avoid blocking
    result = await loop.run_in_executor(
        executor, 
        model_manager.predict, 
        input_tensor
    )
    return result

@router.post("/predict/async", response_model=PredictionResponse)
async def predict_async(request: PredictionRequest):
    """
    Asynchronous prediction using thread pool
    """
    start_time = time.time()
    
    try:
        # Convert input to tensor
        input_tensor = torch.tensor(request.features, dtype=torch.float32).unsqueeze(0)
        
        # Run inference asynchronously
        probabilities = await run_inference(input_tensor)
        predicted_class = torch.argmax(probabilities, dim=1)
        
        response = PredictionResponse(
            prediction=int(predicted_class.item()),
            confidence=float(probabilities[0][predicted_class].item()),
            probabilities=probabilities[0].tolist()
        )
        
        processing_time = time.time() - start_time
        logger.info(f"Async prediction completed in {processing_time:.3f}s")
        
        return response
        
    except Exception as e:
        logger.error(f"Async prediction failed: {e}")
        raise HTTPException(status_code=500, detail=f"Prediction failed: {str(e)}")
```

#### 3. Model Caching and Warm-up

```python
# app/core/model_cache.py
from functools import lru_cache
import torch
import time
import logging

logger = logging.getLogger(__name__)

class ModelCache:
    def __init__(self, max_cache_size: int = 100):
        self.cache = {}
        self.max_cache_size = max_cache_size
    
    @lru_cache(maxsize=1000)
    def get_cached_prediction(self, input_hash: str, model_version: str):
        """Cache predictions for identical inputs"""
        # This would be implemented with actual caching logic
        pass
    
    def warmup_model(self, model_manager, sample_inputs):
        """Warm up model with sample inputs"""
        logger.info("Warming up model...")
        start_time = time.time()
        
        with torch.no_grad():
            for sample in sample_inputs:
                _ = model_manager.predict(sample)
        
        warmup_time = time.time() - start_time
        logger.info(f"Model warmup completed in {warmup_time:.2f}s")

def create_warmup_samples(num_samples: int = 10, input_size: int = 784):
    """Create random samples for model warm-up"""
    samples = []
    for _ in range(num_samples):
        sample = torch.randn(1, input_size)
        samples.append(sample)
    return samples
```

### Production Considerations

#### 1. Model Serialization and Loading

```python
# Save model during training
def save_model(model, path, metadata=None):
    """Save PyTorch model with metadata"""
    torch.save({
        'model_state_dict': model.state_dict(),
        'metadata': metadata or {},
        'timestamp': time.time(),
        'pytorch_version': torch.__version__
    }, path)

# Load model in production
def load_model_checkpoint(path):
    """Load model with metadata validation"""
    checkpoint = torch.load(path, map_location='cpu')
    
    # Validate PyTorch version compatibility
    if checkpoint.get('pytorch_version') != torch.__version__:
        logger.warning(f"Model trained with PyTorch {checkpoint.get('pytorch_version')}, "
                      f"loading with {torch.__version__}")
    
    return checkpoint
```

#### 2. GPU Memory Management

```python
# app/core/gpu_utils.py
import torch
import gc

def clear_gpu_cache():
    """Clear GPU cache if available"""
    if torch.cuda.is_available():
        torch.cuda.empty_cache()
        gc.collect()

def get_optimal_device():
    """Get optimal device with memory check"""
    if torch.cuda.is_available():
        # Check available memory
        total_memory = torch.cuda.get_device_properties(0).total_memory
        allocated_memory = torch.cuda.memory_allocated()
        free_memory = total_memory - allocated_memory
        
        # Require at least 1GB free
        if free_memory > 1 * 1024**3:
            return torch.device('cuda')
    
    return torch.device('cpu')

class GPUMemoryTracker:
    def __init__(self):
        self.initial_memory = torch.cuda.memory_allocated() if torch.cuda.is_available() else 0
    
    def get_memory_usage(self):
        if not torch.cuda.is_available():
            return 0
        current = torch.cuda.memory_allocated()
        return current - self.initial_memory
```

#### 3. Error Handling and Logging

```python
# app/core/error_handling.py
from fastapi import HTTPException
import logging

logger = logging.getLogger(__name__)

class ModelInferenceError(Exception):
    pass

def handle_model_errors(func):
    """Decorator for model error handling"""
    def wrapper(*args, **kwargs):
        try:
            return func(*args, **kwargs)
        except torch.cuda.OutOfMemoryError:
            logger.error("GPU out of memory")
            clear_gpu_cache()
            raise HTTPException(status_code=507, detail="GPU memory exhausted")
        except ModelInferenceError as e:
            logger.error(f"Model inference error: {e}")
            raise HTTPException(status_code=500, detail="Model inference failed")
        except Exception as e:
            logger.error(f"Unexpected error: {e}")
            raise HTTPException(status_code=500, detail="Internal server error")
    return wrapper
```

### Requirements and Dockerfile

```txt
# requirements.txt
fastapi==0.104.1
uvicorn[standard]==0.24.0
torch==2.1.0
torchvision==0.16.0
pydantic==2.5.0
python-multipart==0.0.6
psutil==5.9.6
```

```dockerfile
# Dockerfile
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create non-root user
RUN useradd --create-home --shell /bin/bash app \
    && chown -R app:app /app
USER app

# Expose port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/api/v1/health || exit 1

# Run application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### Testing ML APIs

```python
# tests/test_prediction.py
import pytest
from fastapi.testclient import TestClient
import torch
import numpy as np

from app.main import app

client = TestClient(app)

def test_single_prediction():
    """Test single prediction endpoint"""
    # Create test input (random features)
    features = np.random.rand(784).tolist()
    
    response = client.post("/api/v1/predict", json={"features": features})
    
    assert response.status_code == 200
    data = response.json()
    assert "prediction" in data
    assert "confidence" in data
    assert "probabilities" in data
    assert len(data["probabilities"]) == 10  # Assuming 10 classes

def test_batch_prediction():
    """Test batch prediction endpoint"""
    # Create batch of test inputs
    batch_size = 3
    instances = [np.random.rand(784).tolist() for _ in range(batch_size)]
    
    response = client.post("/api/v1/predict/batch", json={"instances": instances})
    
    assert response.status_code == 200
    data = response.json()
    assert len(data["predictions"]) == batch_size

def test_invalid_input():
    """Test error handling for invalid input"""
    # Too few features
    features = [1.0] * 100  # Only 100 instead of 784
    
    response = client.post("/api/v1/predict", json={"features": features})
    assert response.status_code == 422  # Validation error

def test_model_info():
    """Test model info endpoint"""
    response = client.get("/api/v1/model/info")
    
    assert response.status_code == 200
    data = response.json()
    assert "model_name" in data
    assert "version" in data
    assert "device" in data
```

### Performance Optimization Tips

1. **Use GPU if available**: Check `torch.cuda.is_available()`
2. **Batch predictions**: Process multiple inputs together
3. **Model quantization**: Reduce model size for faster inference
4. **Caching**: Cache predictions for repeated inputs
5. **Async processing**: Use background tasks for heavy computations
6. **Memory management**: Clear GPU cache periodically
7. **Model versioning**: Support multiple model versions for A/B testing

### Security Considerations

1. **Input validation**: Always validate input dimensions and types
2. **Rate limiting**: Implement rate limiting for prediction endpoints
3. **Model access control**: Restrict access to model endpoints
4. **Logging**: Log all predictions for monitoring and debugging
5. **Error handling**: Don't expose internal model details in errors

This comprehensive guide covers everything from basic PyTorch model loading to advanced production patterns for serving ML models with FastAPI.

---

## 30. Integrating PyTorch Models with Node.js/Express Backends

While FastAPI is Python-based, you can serve PyTorch models and consume them from Node.js/Express applications. This section covers various integration patterns.

### Architecture Options

#### Option 1: FastAPI as ML Microservice (Recommended)

**Architecture**: Node.js Express API ↔ FastAPI ML Service ↔ PyTorch Model

**Pros**: 
- Clean separation of concerns
- Scalable and maintainable
- Can use different technologies for different services
- Easy to deploy and monitor separately

**Cons**: 
- Additional network overhead
- More complex deployment

#### Option 2: Python Child Process in Node.js

**Architecture**: Node.js Express → Python Child Process → PyTorch Model

**Pros**: 
- Single deployment
- No network calls

**Cons**: 
- Blocking operations
- Harder to scale
- Resource management issues

#### Option 3: ONNX Runtime in Node.js

**Architecture**: Node.js Express → ONNX Runtime → Converted Model

**Pros**: 
- Single runtime
- No Python dependency

**Cons**: 
- Model conversion required
- Limited PyTorch feature support

### Option 1: FastAPI ML Microservice (Recommended)

#### 1. FastAPI ML Service (Python)

Use the PyTorch integration code from Section 29 as your ML service.

```python
# ml_service/main.py (FastAPI service)
from fastapi import FastAPI
from app.api.routes.prediction import router as prediction_router

app = FastAPI(title="ML Service", version="1.0.0")

app.include_router(prediction_router, prefix="/api/v1")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8001)
```

#### 2. Node.js Express Client

```javascript
// express_app/mlClient.js
const axios = require('axios');

class MLClient {
    constructor(baseURL = 'http://localhost:8001') {
        this.client = axios.create({
            baseURL,
            timeout: 30000, // 30 seconds for ML inference
        });
    }

    async predict(features) {
        try {
            const response = await this.client.post('/api/v1/predict', {
                features: features
            });
            return response.data;
        } catch (error) {
            console.error('ML prediction failed:', error.message);
            throw new Error('ML service unavailable');
        }
    }

    async predictBatch(instances) {
        try {
            const response = await this.client.post('/api/v1/predict/batch', {
                instances: instances
            });
            return response.data;
        } catch (error) {
            console.error('ML batch prediction failed:', error.message);
            throw new Error('ML service unavailable');
        }
    }

    async getModelInfo() {
        try {
            const response = await this.client.get('/api/v1/model/info');
            return response.data;
        } catch (error) {
            console.error('Failed to get model info:', error.message);
            return null;
        }
    }
}

module.exports = MLClient;
```

#### 3. Express.js Integration

```javascript
// express_app/app.js
const express = require('express');
const MLClient = require('./mlClient');

const app = express();
const mlClient = new MLClient(process.env.ML_SERVICE_URL || 'http://localhost:8001');

app.use(express.json());

// Middleware to handle ML service errors
app.use('/api/ml/*', async (req, res, next) => {
    try {
        // Check ML service health
        const health = await mlClient.client.get('/api/v1/health');
        if (health.status !== 200) {
            return res.status(503).json({ error: 'ML service unavailable' });
        }
        next();
    } catch (error) {
        return res.status(503).json({ error: 'ML service unavailable' });
    }
});

// ML prediction endpoint
app.post('/api/ml/predict', async (req, res) => {
    try {
        const { features } = req.body;
        
        if (!features || !Array.isArray(features)) {
            return res.status(400).json({ error: 'Features array required' });
        }

        const result = await mlClient.predict(features);
        res.json(result);
    } catch (error) {
        console.error('Prediction error:', error);
        res.status(500).json({ error: 'Prediction failed' });
    }
});

// Batch prediction endpoint
app.post('/api/ml/predict/batch', async (req, res) => {
    try {
        const { instances } = req.body;
        
        if (!instances || !Array.isArray(instances)) {
            return res.status(400).json({ error: 'Instances array required' });
        }

        const result = await mlClient.predictBatch(instances);
        res.json(result);
    } catch (error) {
        console.error('Batch prediction error:', error);
        res.status(500).json({ error: 'Batch prediction failed' });
    }
});

// Model info endpoint
app.get('/api/ml/model/info', async (req, res) => {
    try {
        const info = await mlClient.getModelInfo();
        if (info) {
            res.json(info);
        } else {
            res.status(503).json({ error: 'Model info unavailable' });
        }
    } catch (error) {
        res.status(503).json({ error: 'Model info unavailable' });
    }
});

// Example: Image classification endpoint
app.post('/api/ml/classify-image', async (req, res) => {
    try {
        const { imageData } = req.body; // Base64 encoded image
        
        // Preprocess image (convert to features)
        const features = await preprocessImage(imageData);
        
        // Get prediction
        const result = await mlClient.predict(features);
        
        // Add class names
        const classNames = ['airplane', 'automobile', 'bird', 'cat', 'deer', 
                           'dog', 'frog', 'horse', 'ship', 'truck'];
        result.class_name = classNames[result.prediction];
        
        res.json(result);
    } catch (error) {
        console.error('Image classification error:', error);
        res.status(500).json({ error: 'Classification failed' });
    }
});

async function preprocessImage(imageData) {
    // Implement image preprocessing
    // Convert base64 to tensor-like array
    // Resize, normalize, flatten
    // Return 784-element array for MNIST-like models
    return new Array(784).fill(0).map(() => Math.random());
}

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Express server running on port ${PORT}`);
    console.log(`ML service at: ${process.env.ML_SERVICE_URL || 'http://localhost:8001'}`);
});
```

#### 4. Docker Compose for Multi-Service Setup

```yaml
# docker-compose.yml
version: '3.8'

services:
  ml-service:
    build: ./ml_service
    ports:
      - "8001:8001"
    environment:
      - CUDA_VISIBLE_DEVICES=0  # GPU support
    volumes:
      - ./models:/app/models:ro
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8001/api/v1/health"]
      interval: 30s
      timeout: 10s
      retries: 3

  express-api:
    build: ./express_app
    ports:
      - "3000:3000"
    environment:
      - ML_SERVICE_URL=http://ml-service:8001
    depends_on:
      ml-service:
        condition: service_healthy
    volumes:
      - ./express_app:/app

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - express-api
```

### Option 2: Python Child Process in Node.js

#### Using python-shell

```javascript
// express_app/mlProcessor.js
const { PythonShell } = require('python-shell');

class MLProcessor {
    constructor(modelPath) {
        this.modelPath = modelPath;
        this.pythonOptions = {
            mode: 'json',
            pythonPath: process.env.PYTHON_PATH || 'python3',
            scriptPath: __dirname + '/python_scripts',
        };
    }

    async predict(features) {
        return new Promise((resolve, reject) => {
            const pyshell = new PythonShell('predict.py', {
                ...this.pythonOptions,
                args: [JSON.stringify({ features, model_path: this.modelPath })]
            });

            pyshell.on('message', (message) => {
                resolve(message);
            });

            pyshell.on('error', (error) => {
                reject(error);
            });

            pyshell.end((err) => {
                if (err) reject(err);
            });
        });
    }

    async predictBatch(instances) {
        return new Promise((resolve, reject) => {
            const pyshell = new PythonShell('batch_predict.py', {
                ...this.pythonOptions,
                args: [JSON.stringify({ instances, model_path: this.modelPath })]
            });

            pyshell.on('message', (message) => {
                resolve(message);
            });

            pyshell.on('error', (error) => {
                reject(error);
            });

            pyshell.end((err) => {
                if (err) reject(err);
            });
        });
    }
}

module.exports = MLProcessor;
```

#### Python Script for Inference

```python
# express_app/python_scripts/predict.py
import sys
import json
import torch
import torch.nn as nn
from pathlib import Path

class SimpleClassifier(nn.Module):
    def __init__(self, input_size=784, hidden_size=128, num_classes=10):
        super().__init__()
        self.layers = nn.Sequential(
            nn.Linear(input_size, hidden_size),
            nn.ReLU(),
            nn.Linear(hidden_size, num_classes)
        )

def load_model(model_path):
    model = SimpleClassifier()
    model.load_state_dict(torch.load(model_path, map_location='cpu'))
    model.eval()
    return model

def main():
    # Read arguments
    args = sys.argv[1]
    data = json.loads(args)
    
    features = data['features']
    model_path = data['model_path']
    
    # Load model
    model = load_model(model_path)
    
    # Prepare input
    input_tensor = torch.tensor(features, dtype=torch.float32).unsqueeze(0)
    
    # Predict
    with torch.no_grad():
        outputs = model(input_tensor)
        probabilities = torch.softmax(outputs, dim=1)
        prediction = torch.argmax(probabilities, dim=1)
    
    # Return result
    result = {
        'prediction': int(prediction.item()),
        'confidence': float(probabilities[0][prediction].item()),
        'probabilities': probabilities[0].tolist()
    }
    
    print(json.dumps(result))

if __name__ == '__main__':
    main()
```

#### Express.js Usage

```javascript
// express_app/app.js
const express = require('express');
const MLProcessor = require('./mlProcessor');

const app = express();
const mlProcessor = new MLProcessor('./models/model.pth');

app.use(express.json());

// Prediction endpoint using child process
app.post('/api/ml/predict', async (req, res) => {
    try {
        const { features } = req.body;
        const result = await mlProcessor.predict(features);
        res.json(result);
    } catch (error) {
        console.error('Prediction error:', error);
        res.status(500).json({ error: 'Prediction failed' });
    }
});

app.listen(3000, () => {
    console.log('Express server with Python child process running on port 3000');
});
```

### Option 3: ONNX Runtime in Node.js

#### Convert PyTorch Model to ONNX

```python
# convert_to_onnx.py
import torch
import torch.onnx
from your_model import SimpleClassifier  # Your model class

# Load your trained PyTorch model
model = SimpleClassifier()
model.load_state_dict(torch.load('model.pth'))
model.eval()

# Create dummy input
dummy_input = torch.randn(1, 784)  # Adjust shape for your model

# Export to ONNX
torch.onnx.export(
    model,
    dummy_input,
    "model.onnx",
    export_params=True,
    opset_version=11,
    do_constant_folding=True,
    input_names=['input'],
    output_names=['output'],
    dynamic_axes={'input': {0: 'batch_size'}, 'output': {0: 'batch_size'}}
)
```

#### Node.js ONNX Integration

```javascript
// express_app/onnxPredictor.js
const ort = require('onnxruntime-node');

class ONNXPredictor {
    constructor(modelPath) {
        this.modelPath = modelPath;
        this.session = null;
    }

    async loadModel() {
        if (!this.session) {
            this.session = await ort.InferenceSession.create(this.modelPath);
        }
        return this.session;
    }

    async predict(features) {
        await this.loadModel();
        
        // Convert features to tensor
        const inputTensor = new ort.Tensor('float32', 
            new Float32Array(features), 
            [1, features.length]
        );
        
        // Run inference
        const feeds = { input: inputTensor };
        const results = await this.session.run(feeds);
        
        // Process results
        const output = results.output.data;
        const probabilities = softmax(Array.from(output));
        const prediction = argmax(probabilities);
        
        return {
            prediction: prediction,
            confidence: probabilities[prediction],
            probabilities: probabilities
        };
    }
}

function softmax(arr) {
    const max = Math.max(...arr);
    const exps = arr.map(x => Math.exp(x - max));
    const sum = exps.reduce((a, b) => a + b);
    return exps.map(x => x / sum);
}

function argmax(arr) {
    return arr.indexOf(Math.max(...arr));
}

module.exports = ONNXPredictor;
```

#### Express.js with ONNX

```javascript
// express_app/app.js
const express = require('express');
const ONNXPredictor = require('./onnxPredictor');

const app = express();
const predictor = new ONNXPredictor('./models/model.onnx');

app.use(express.json());

// ONNX prediction endpoint
app.post('/api/ml/predict', async (req, res) => {
    try {
        const { features } = req.body;
        const result = await predictor.predict(features);
        res.json(result);
    } catch (error) {
        console.error('ONNX prediction error:', error);
        res.status(500).json({ error: 'Prediction failed' });
    }
});

app.listen(3000, () => {
    console.log('Express server with ONNX runtime running on port 3000');
});
```

### Performance Comparison

| Method | Latency | Throughput | Complexity | Scalability |
|--------|---------|------------|------------|-------------|
| FastAPI Microservice | Medium | High | Medium | High |
| Python Child Process | High | Low | Low | Low |
| ONNX Runtime | Low | High | High | High |

### Recommended Setup

For most production scenarios, **Option 1 (FastAPI Microservice)** is recommended because:

1. **Separation of Concerns**: ML logic is isolated from business logic
2. **Scalability**: Can scale ML service independently
3. **Technology Choice**: Use best tool for each job
4. **Monitoring**: Separate monitoring and logging
5. **Deployment**: Easier to update ML models without touching main API

### Production Deployment

```yaml
# docker-compose.prod.yml
version: '3.8'

services:
  ml-service:
    image: your-registry/ml-service:latest
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
    environment:
      - CUDA_VISIBLE_DEVICES=0
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8001/api/v1/health/detailed"]
      interval: 30s
      timeout: 10s
      retries: 3

  express-api:
    image: your-registry/express-api:latest
    environment:
      - ML_SERVICE_URL=http://ml-service:8001
    depends_on:
      ml-service:
        condition: service_healthy

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
```

This section provides comprehensive guidance for integrating PyTorch models with Node.js/Express backends using various architectural approaches.
