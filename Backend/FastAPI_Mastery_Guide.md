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

*(Conceptually similar to SQLAlchemy, but more Pydantic-friendly and async-ready.)*

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

---

## 14. Repository & Service Layer Patterns

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
