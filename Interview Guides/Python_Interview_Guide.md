# Python Interview Guide

## Table of Contents

1. [Introduction](#introduction)
2. [Python Basics](#python-basics)
3. [Data Structures](#data-structures)
4. [Algorithms](#algorithms)
5. [Object-Oriented Programming](#object-oriented-programming)
6. [Common Libraries](#common-libraries)
7. [Advanced Python Topics](#advanced-python-topics)
8. [Concurrency and Parallelism](#concurrency-and-parallelism)
9. [Testing](#testing)
10. [Performance Optimization](#performance-optimization)
11. [Security](#security)
12. [Coding Problems](#coding-problems)
13. [System Design](#system-design)
14. [Behavioral Interview](#behavioral-interview)
15. [Interview Tips and Best Practices](#interview-tips-and-best-practices)
16. [Resources](#resources)

## Introduction

Python interviews typically consist of multiple rounds:
- Phone screen with basic questions
- Coding interviews (LeetCode-style problems)
- System design interviews
- Behavioral interviews

Preparation tips:
- Practice coding daily
- Understand time/space complexities
- Review core concepts
- Mock interviews
- Study company-specific patterns

## Python Basics

### Syntax and Data Types

Python is a dynamically typed, interpreted, high-level programming language. It emphasizes code readability with its clean syntax.

```python
# Variables (no declaration needed)
x = 5              # int
y = "hello"        # str
z = 3.14           # float
a = True           # bool
b = None           # NoneType

# Type checking
print(type(x))     # <class 'int'>
print(isinstance(x, int))  # True

# Type conversion
str_num = str(123)  # "123"
int_str = int("456")  # 456
float_num = float("3.14")  # 3.14
```

#### Mutable vs Immutable Types

- **Immutable**: int, float, str, tuple, frozenset
- **Mutable**: list, dict, set

```python
# Immutable example
x = 5
y = x
x = 10
print(y)  # 5 (unchanged)

# Mutable example
lst1 = [1, 2, 3]
lst2 = lst1
lst1.append(4)
print(lst2)  # [1, 2, 3, 4] (changed!)
```

### Control Structures

#### Conditional Statements

```python
# If-elif-else
age = 25
if age < 18:
    print("Minor")
elif age < 65:
    print("Adult")
else:
    print("Senior")

# Ternary operator
status = "Adult" if age >= 18 else "Minor"

# Match statement (Python 3.10+)
def http_status(status_code):
    match status_code:
        case 200:
            return "OK"
        case 404:
            return "Not Found"
        case 500:
            return "Internal Server Error"
        case _:
            return "Unknown"
```

#### Loops

```python
# For loop
for i in range(5):  # 0 to 4
    print(i)

# For loop with enumerate
fruits = ['apple', 'banana', 'cherry']
for index, fruit in enumerate(fruits):
    print(f"{index}: {fruit}")

# While loop
count = 0
while count < 5:
    print(count)
    count += 1

# Break and continue
for i in range(10):
    if i == 3:
        continue  # Skip 3
    if i == 7:
        break     # Stop at 7
    print(i)

# Else clause in loops
for i in range(5):
    print(i)
else:
    print("Loop completed")  # Executes if no break
```

### Functions

#### Function Definition and Calling

```python
def greet(name, greeting="Hello"):
    """Function with docstring"""
    return f"{greeting}, {name}!"

print(greet("Alice"))                    # Hello, Alice!
print(greet("Bob", "Hi"))                # Hi, Bob!
print(greet.__doc__)                     # Function with docstring
```

#### Lambda Functions

```python
# Anonymous functions
square = lambda x: x ** 2
add = lambda x, y: x + y

print(square(5))        # 25
print(add(3, 4))        # 7

# Lambda in sorting
points = [(1, 2), (3, 1), (5, 0)]
points.sort(key=lambda p: p[1])  # Sort by y-coordinate
print(points)  # [(5, 0), (3, 1), (1, 2)]
```

#### *args and **kwargs

```python
def flexible_func(*args, **kwargs):
    print(f"Args: {args}")       # Tuple
    print(f"Kwargs: {kwargs}")   # Dict

flexible_func(1, 2, 3, name="Alice", age=30)
# Args: (1, 2, 3)
# Kwargs: {'name': 'Alice', 'age': 30}

# Unpacking
def add(x, y, z):
    return x + y + z

nums = [1, 2, 3]
print(add(*nums))  # 6

def person_info(name, age, city):
    return f"{name} is {age} years old from {city}"

info = {"name": "Alice", "age": 30, "city": "NYC"}
print(person_info(**info))  # Alice is 30 years old from NYC
```

### Comprehensions

#### List Comprehensions

```python
# Basic
squares = [x**2 for x in range(10)]
print(squares)  # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]

# With condition
even_squares = [x**2 for x in range(10) if x % 2 == 0]
print(even_squares)  # [0, 4, 16, 36, 64]

# Nested
matrix = [[i*j for j in range(3)] for i in range(3)]
print(matrix)  # [[0, 0, 0], [0, 1, 2], [0, 2, 4]]
```

#### Dictionary Comprehensions

```python
# Basic
squares_dict = {x: x**2 for x in range(5)}
print(squares_dict)  # {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}

# Conditional
even_squares = {x: x**2 for x in range(10) if x % 2 == 0}
print(even_squares)  # {0: 0, 2: 4, 4: 16, 6: 36, 8: 64}
```

#### Set Comprehensions

```python
squares_set = {x**2 for x in range(10)}
print(squares_set)  # {0, 1, 4, 9, 16, 25, 36, 49, 64, 81}
```

### Generators

Generators are iterators that yield values one at a time, saving memory.

```python
# Generator function
def fibonacci(n):
    a, b = 0, 1
    for _ in range(n):
        yield a
        a, b = b, a + b

for num in fibonacci(10):
    print(num, end=" ")  # 0 1 1 2 3 5 8 13 21 34

# Generator expression
squares_gen = (x**2 for x in range(10))
print(list(squares_gen))  # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]

# Memory comparison
import sys
list_comp = [x**2 for x in range(100000)]  # Creates full list
gen_expr = (x**2 for x in range(100000))   # Creates generator
print(sys.getsizeof(list_comp))  # Large memory usage
print(sys.getsizeof(gen_expr))   # Small memory usage
```

### Decorators

Decorators modify the behavior of functions or classes.

```python
# Simple decorator
def timer(func):
    def wrapper(*args, **kwargs):
        import time
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"{func.__name__} took {end - start:.2f} seconds")
        return result
    return wrapper

@timer
def slow_function():
    import time
    time.sleep(1)
    return "Done"

print(slow_function())  # slow_function took 1.00 seconds \n Done

# Decorator with parameters
def repeat(times):
    def decorator(func):
        def wrapper(*args, **kwargs):
            for _ in range(times):
                func(*args, **kwargs)
        return wrapper
    return decorator

@repeat(3)
def greet(name):
    print(f"Hello, {name}!")

greet("Alice")  # Prints 3 times
```

### Context Managers

Context managers handle resource management (files, locks, etc.).

```python
# Using with statement
with open('file.txt', 'w') as f:
    f.write('Hello, World!')

# Custom context manager
class Timer:
    def __enter__(self):
        import time
        self.start = time.time()
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        import time
        end = time.time()
        print(f"Elapsed: {end - self.start:.2f} seconds")

with Timer():
    import time
    time.sleep(1)  # Elapsed: 1.00 seconds

# Context manager decorator
from contextlib import contextmanager

@contextmanager
def timer():
    import time
    start = time.time()
    try:
        yield
    finally:
        end = time.time()
        print(f"Time: {end - start:.2f} seconds")

with timer():
    time.sleep(0.5)  # Time: 0.50 seconds
```

### Exception Handling

```python
try:
    x = 1 / 0
except ZeroDivisionError as e:
    print(f"Error: {e}")
except Exception as e:
    print(f"General error: {e}")
else:
    print("No errors")
finally:
    print("Always executes")

# Raising exceptions
def validate_age(age):
    if age < 0:
        raise ValueError("Age cannot be negative")
    if age > 150:
        raise ValueError("Age seems too high")

try:
    validate_age(-5)
except ValueError as e:
    print(e)  # Age cannot be negative
```

### Modules and Packages

#### Importing

```python
# Different import styles
import math
from math import sqrt, pi
from math import *  # Avoid in production
import math as m

print(math.sqrt(16))  # 4.0
print(sqrt(25))       # 5.0
print(m.pi)           # 3.141592653589793
```

#### Creating Modules

```python
# mymodule.py
def hello():
    return "Hello from mymodule"

# main.py
import mymodule
print(mymodule.hello())
```

#### Packages

```
mypackage/
    __init__.py
    module1.py
    module2.py
    subpackage/
        __init__.py
        module3.py
```

```python
# __init__.py can be empty or contain initialization code
from .module1 import *
from .module2 import some_function
```

### Advanced Topics

#### Global and Local Variables

```python
x = "global"

def func():
    global x
    x = "modified global"
    local_var = "local"

func()
print(x)  # modified global
# print(local_var)  # NameError
```

#### Closures

```python
def outer(x):
    def inner(y):
        return x + y  # x is captured from outer scope
    return inner

add_five = outer(5)
print(add_five(3))  # 8
```

#### Iterators and Iterables

```python
# Iterable: can be looped over
# Iterator: object with __next__ method

class MyIterator:
    def __init__(self, max_num):
        self.max_num = max_num
        self.current = 0
    
    def __iter__(self):
        return self
    
    def __next__(self):
        if self.current < self.max_num:
            self.current += 1
            return self.current
        else:
            raise StopIteration

for num in MyIterator(5):
    print(num, end=" ")  # 1 2 3 4 5
```

```python
import math
from collections import defaultdict
```

## Data Structures

Python provides built-in data structures and additional ones in the `collections` module. Understanding time complexities is crucial for interviews.

### Lists

Lists are dynamic arrays that can store heterogeneous data.

```python
# Creation and basic operations
lst = [1, 2, 3, 4, 5]

# Common methods
lst.append(6)           # Add to end: [1, 2, 3, 4, 5, 6]
lst.insert(0, 0)        # Insert at index: [0, 1, 2, 3, 4, 5, 6]
lst.extend([7, 8])      # Extend with another iterable: [0, 1, 2, 3, 4, 5, 6, 7, 8]
lst.remove(3)           # Remove first occurrence of 3: [0, 1, 2, 4, 5, 6, 7, 8]
popped = lst.pop()      # Remove and return last element: 8
popped_idx = lst.pop(2) # Remove and return element at index 2: 2

# Slicing
sub_list = lst[1:4]     # [1, 4, 5]
reversed_list = lst[::-1]  # Reverse list

# List comprehensions (already covered)
squares = [x**2 for x in range(10)]

# Time Complexities:
# Access by index: O(1)
# Append: O(1) amortized
# Insert/Delete at beginning: O(n)
# Search (in/not in): O(n)
# Sort: O(n log n)
```

#### List Interview Questions

```python
# Remove duplicates from list
def remove_duplicates(nums):
    return list(set(nums))  # O(n) time, O(n) space

# Or preserve order
def remove_duplicates_preserve_order(nums):
    seen = set()
    result = []
    for num in nums:
        if num not in seen:
            seen.add(num)
            result.append(num)
    return result

# Rotate list by k positions
def rotate_list(nums, k):
    k = k % len(nums)
    return nums[-k:] + nums[:-k]
```

### Tuples

Tuples are immutable sequences, often used for fixed data.

```python
# Creation
tup = (1, 2, 3)
single_tup = (1,)      # Note the comma
empty_tup = ()

# Tuple unpacking
a, b, c = (1, 2, 3)
first, *rest = (1, 2, 3, 4)  # first=1, rest=[2, 3, 4]

# Named tuples (from collections)
from collections import namedtuple
Point = namedtuple('Point', ['x', 'y'])
p = Point(1, 2)
print(p.x, p.y)  # 1 2

# Time Complexities:
# Access: O(1)
# Search: O(n)
# Immutable: Cannot modify
```

### Dictionaries

Dictionaries are hash tables mapping keys to values.

```python
# Creation
d = {'a': 1, 'b': 2, 'c': 3}
d = dict(a=1, b=2, c=3)  # Alternative

# Operations
d['d'] = 4              # Add/update
del d['a']              # Delete
value = d.get('b', 0)   # Get with default
keys = d.keys()         # dict_keys object
values = d.values()     # dict_values object
items = d.items()       # dict_items object

# Dictionary comprehensions
squares = {x: x**2 for x in range(5)}

# OrderedDict (preserves insertion order)
from collections import OrderedDict
od = OrderedDict()
od['a'] = 1
od['b'] = 2

# defaultdict (provides default values)
from collections import defaultdict
dd = defaultdict(int)   # Default value is 0
dd['a'] += 1            # No KeyError

# Counter (counts hashable objects)
from collections import Counter
counter = Counter(['a', 'b', 'a', 'c'])
print(counter)  # Counter({'a': 2, 'b': 1, 'c': 1})

# Time Complexities:
# Access/Update/Delete: O(1) average
# Worst case: O(n) (hash collisions)
```

#### Dictionary Interview Questions

```python
# Two Sum (already shown)
# Group anagrams
from collections import defaultdict

def group_anagrams(strs):
    anagrams = defaultdict(list)
    for s in strs:
        key = ''.join(sorted(s))
        anagrams[key].append(s)
    return list(anagrams.values())

# Most frequent element
def most_frequent(nums):
    from collections import Counter
    counter = Counter(nums)
    return counter.most_common(1)[0][0]
```

### Sets

Sets are unordered collections of unique elements.

```python
# Creation
s = {1, 2, 3}
s = set([1, 2, 3])  # From iterable

# Operations
s.add(4)              # Add element
s.remove(2)           # Remove (raises KeyError if not found)
s.discard(5)          # Remove (no error if not found)
s.pop()               # Remove and return arbitrary element

# Set operations
s1 = {1, 2, 3}
s2 = {3, 4, 5}
print(s1 | s2)        # Union: {1, 2, 3, 4, 5}
print(s1 & s2)        # Intersection: {3}
print(s1 - s2)        # Difference: {1, 2}
print(s1 ^ s2)        # Symmetric difference: {1, 2, 4, 5}

# Frozenset (immutable set)
fs = frozenset([1, 2, 3])

# Time Complexities:
# Add/Remove/Check membership: O(1) average
```

### Advanced Data Structures

#### Deque (Double-ended Queue)

```python
from collections import deque

# Creation
dq = deque([1, 2, 3])

# Operations
dq.append(4)          # Add to right: deque([1, 2, 3, 4])
dq.appendleft(0)      # Add to left: deque([0, 1, 2, 3, 4])
dq.pop()              # Remove from right: 4
dq.popleft()          # Remove from left: 0

# Rotate
dq.rotate(1)          # Rotate right: deque([4, 1, 2, 3])
dq.rotate(-1)         # Rotate left: deque([1, 2, 3, 4])

# Time Complexities:
# Append/Pop from ends: O(1)
# Access by index: O(n)
```

#### Heap (Priority Queue)

```python
import heapq

# Min-heap operations
heap = []
heapq.heappush(heap, 3)
heapq.heappush(heap, 1)
heapq.heappush(heap, 4)
heapq.heappush(heap, 2)

print(heapq.heappop(heap))  # 1 (smallest)
print(heapq.heappop(heap))  # 2

# Max-heap (negate values)
max_heap = []
heapq.heappush(max_heap, -3)
heapq.heappush(max_heap, -1)
print(-heapq.heappop(max_heap))  # 3 (largest)

# Heapify existing list
nums = [3, 1, 4, 2]
heapq.heapify(nums)
print(nums)  # [1, 2, 3, 4] (heap property)

# nlargest/nsmallest
print(heapq.nlargest(2, [3, 1, 4, 2]))  # [4, 3]
print(heapq.nsmallest(2, [3, 1, 4, 2]))  # [1, 2]
```

#### Linked List Implementation

```python
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class LinkedList:
    def __init__(self):
        self.head = None
    
    def append(self, val):
        if not self.head:
            self.head = ListNode(val)
            return
        current = self.head
        while current.next:
            current = current.next
        current.next = ListNode(val)
    
    def print_list(self):
        current = self.head
        while current:
            print(current.val, end=" -> ")
            current = current.next
        print("None")

# Usage
ll = LinkedList()
ll.append(1)
ll.append(2)
ll.append(3)
ll.print_list()  # 1 -> 2 -> 3 -> None
```

### String Operations

Strings are immutable sequences of characters.

```python
s = "Hello, World!"

# Common operations
print(len(s))           # 13
print(s[0])             # 'H'
print(s[7:12])          # 'World'
print(s.upper())        # 'HELLO, WORLD!'
print(s.lower())        # 'hello, world!'
print(s.split(','))     # ['Hello', ' World!']
print(','.join(['a', 'b', 'c']))  # 'a,b,c'

# String formatting
name = "Alice"
age = 30
print(f"{name} is {age} years old")  # Alice is 30 years old
print("Name: {}, Age: {}".format(name, age))
print("Name: %s, Age: %d" % (name, age))

# Check methods
print(s.startswith("Hello"))  # True
print(s.endswith("!"))        # True
print("World" in s)           # True
print(s.isalpha())            # False (contains comma and space)
print("hello".isalpha())      # True

# Find and replace
print(s.find("World"))        # 7
print(s.replace("World", "Python"))  # 'Hello, Python!'
```

### Array Module

For typed arrays (more memory efficient than lists).

```python
import array

# Create typed array
arr = array.array('i', [1, 2, 3, 4, 5])  # 'i' for signed int
arr.append(6)
print(arr[0])  # 1
```

### Common Data Structure Patterns

#### Stack (using list)

```python
class Stack:
    def __init__(self):
        self.items = []
    
    def push(self, item):
        self.items.append(item)
    
    def pop(self):
        return self.items.pop()
    
    def peek(self):
        return self.items[-1] if self.items else None
    
    def is_empty(self):
        return len(self.items) == 0
```

#### Queue (using deque)

```python
from collections import deque

class Queue:
    def __init__(self):
        self.items = deque()
    
    def enqueue(self, item):
        self.items.append(item)
    
    def dequeue(self):
        return self.items.popleft()
    
    def is_empty(self):
        return len(self.items) == 0
```

#### Hash Table Implementation

```python
class HashTable:
    def __init__(self, size=10):
        self.size = size
        self.table = [[] for _ in range(size)]
    
    def _hash(self, key):
        return hash(key) % self.size
    
    def set(self, key, value):
        index = self._hash(key)
        for pair in self.table[index]:
            if pair[0] == key:
                pair[1] = value
                return
        self.table[index].append([key, value])
    
    def get(self, key):
        index = self._hash(key)
        for pair in self.table[index]:
            if pair[0] == key:
                return pair[1]
        raise KeyError(key)
```

### Time Complexity Cheat Sheet

| Operation | List | Dict | Set | Deque |
|-----------|------|------|-----|-------|
| Access by index | O(1) | O(1) | - | O(1) |
| Search | O(n) | O(1) | O(1) | O(n) |
| Insert end | O(1) | O(1) | O(1) | O(1) |
| Insert beginning | O(n) | - | - | O(1) |
| Delete end | O(1) | O(1) | O(1) | O(1) |
| Delete beginning | O(n) | - | - | O(1) |

## Algorithms

Algorithms are step-by-step procedures for solving problems. Understanding time/space complexity is crucial.

### Sorting Algorithms

#### Built-in Sorting

```python
# Python's Timsort: O(n log n) worst case
lst = [3, 1, 4, 1, 5, 9, 2, 6]
lst.sort()                    # In-place sort
sorted_lst = sorted(lst)      # Returns new sorted list

# Sort with key function
words = ['apple', 'Banana', 'cherry']
words.sort(key=str.lower)     # Case-insensitive sort

# Sort by multiple criteria
students = [('Alice', 85), ('Bob', 92), ('Charlie', 78)]
students.sort(key=lambda x: (-x[1], x[0]))  # Descending score, ascending name
```

#### Bubble Sort

```python
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        swapped = False
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
                swapped = True
        if not swapped:
            break
    return arr

# Time: O(n^2) worst/average, O(n) best
```

#### Quick Sort

```python
def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quick_sort(left) + middle + quick_sort(right)

# Time: O(n log n) average, O(n^2) worst
```

#### Merge Sort

```python
def merge_sort(arr):
    if len(arr) <= 1:
        return arr
    
    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    
    return merge(left, right)

def merge(left, right):
    result = []
    i = j = 0
    
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    
    result.extend(left[i:])
    result.extend(right[j:])
    return result

# Time: O(n log n) worst/average/best
```

### Searching Algorithms

#### Linear Search

```python
def linear_search(arr, target):
    for i, num in enumerate(arr):
        if num == target:
            return i
    return -1

# Time: O(n)
```

#### Binary Search (Iterative and Recursive)

```python
def binary_search_iterative(arr, target):
    left, right = 0, len(arr) - 1
    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return -1

def binary_search_recursive(arr, target, left=0, right=None):
    if right is None:
        right = len(arr) - 1
    
    if left > right:
        return -1
    
    mid = (left + right) // 2
    if arr[mid] == target:
        return mid
    elif arr[mid] < target:
        return binary_search_recursive(arr, target, mid + 1, right)
    else:
        return binary_search_recursive(arr, target, left, mid - 1)

# Time: O(log n)
```

#### Interpolation Search

```python
def interpolation_search(arr, target):
    low, high = 0, len(arr) - 1
    
    while low <= high and arr[low] <= target <= arr[high]:
        if low == high:
            if arr[low] == target:
                return low
            return -1
        
        # Interpolation formula
        pos = low + ((target - arr[low]) * (high - low)) // (arr[high] - arr[low])
        
        if arr[pos] == target:
            return pos
        elif arr[pos] < target:
            low = pos + 1
        else:
            high = pos - 1
    
    return -1

# Time: O(log log n) for uniformly distributed data
```

### Recursion

#### Tower of Hanoi

```python
def tower_of_hanoi(n, source, target, auxiliary):
    if n == 1:
        print(f"Move disk 1 from {source} to {target}")
        return
    tower_of_hanoi(n-1, source, auxiliary, target)
    print(f"Move disk {n} from {source} to {target}")
    tower_of_hanoi(n-1, auxiliary, target, source)

# tower_of_hanoi(3, 'A', 'C', 'B')
```

#### Permutations

```python
def permutations(arr):
    if len(arr) <= 1:
        return [arr]
    
    result = []
    for i, num in enumerate(arr):
        remaining = arr[:i] + arr[i+1:]
        for perm in permutations(remaining):
            result.append([num] + perm)
    return result

# Time: O(n!)
```

#### Subsets/Power Set

```python
def subsets(nums):
    result = [[]]
    for num in nums:
        result += [subset + [num] for subset in result]
    return result

# Or using bit manipulation
def subsets_bit(nums):
    n = len(nums)
    result = []
    for i in range(1 << n):  # 2^n subsets
        subset = []
        for j in range(n):
            if i & (1 << j):
                subset.append(nums[j])
        result.append(subset)
    return result
```

### Dynamic Programming

#### 0/1 Knapsack

```python
def knapsack(weights, values, capacity):
    n = len(weights)
    dp = [[0] * (capacity + 1) for _ in range(n + 1)]
    
    for i in range(1, n + 1):
        for w in range(1, capacity + 1):
            if weights[i-1] <= w:
                dp[i][w] = max(dp[i-1][w], dp[i-1][w - weights[i-1]] + values[i-1])
            else:
                dp[i][w] = dp[i-1][w]
    
    return dp[n][capacity]

# Space optimized
def knapsack_optimized(weights, values, capacity):
    n = len(weights)
    dp = [0] * (capacity + 1)
    
    for i in range(n):
        for w in range(capacity, weights[i] - 1, -1):
            dp[w] = max(dp[w], dp[w - weights[i]] + values[i])
    
    return dp[capacity]
```

#### Longest Common Subsequence

```python
def lcs(X, Y):
    m, n = len(X), len(Y)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if X[i-1] == Y[j-1]:
                dp[i][j] = dp[i-1][j-1] + 1
            else:
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
    
    return dp[m][n]

# Reconstruct LCS
def lcs_string(X, Y):
    m, n = len(X), len(Y)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    # Fill dp table
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if X[i-1] == Y[j-1]:
                dp[i][j] = dp[i-1][j-1] + 1
            else:
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
    
    # Reconstruct
    lcs_str = []
    i, j = m, n
    while i > 0 and j > 0:
        if X[i-1] == Y[j-1]:
            lcs_str.append(X[i-1])
            i -= 1
            j -= 1
        elif dp[i-1][j] > dp[i][j-1]:
            i -= 1
        else:
            j -= 1
    
    return ''.join(reversed(lcs_str))
```

#### Edit Distance

```python
def edit_distance(word1, word2):
    m, n = len(word1), len(word2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    # Initialize base cases
    for i in range(m + 1):
        dp[i][0] = i
    for j in range(n + 1):
        dp[0][j] = j
    
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if word1[i-1] == word2[j-1]:
                dp[i][j] = dp[i-1][j-1]
            else:
                dp[i][j] = 1 + min(dp[i-1][j],      # Delete
                                   dp[i][j-1],      # Insert
                                   dp[i-1][j-1])    # Replace
    
    return dp[m][n]
```

### Greedy Algorithms

#### Activity Selection

```python
def activity_selection(activities):
    # activities: list of (start, end) tuples
    activities.sort(key=lambda x: x[1])  # Sort by end time
    
    selected = [activities[0]]
    for activity in activities[1:]:
        if activity[0] >= selected[-1][1]:
            selected.append(activity)
    
    return selected
```

#### Huffman Coding

```python
import heapq
from collections import defaultdict

class HuffmanNode:
    def __init__(self, char, freq):
        self.char = char
        self.freq = freq
        self.left = None
        self.right = None
    
    def __lt__(self, other):
        return self.freq < other.freq

def build_huffman_tree(text):
    freq = defaultdict(int)
    for char in text:
        freq[char] += 1
    
    heap = [HuffmanNode(char, f) for char, f in freq.items()]
    heapq.heapify(heap)
    
    while len(heap) > 1:
        left = heapq.heappop(heap)
        right = heapq.heappop(heap)
        merged = HuffmanNode(None, left.freq + right.freq)
        merged.left = left
        merged.right = right
        heapq.heappush(heap, merged)
    
    return heap[0]

def generate_codes(node, code="", codes={}):
    if node is None:
        return
    
    if node.char is not None:
        codes[node.char] = code
        return
    
    generate_codes(node.left, code + "0", codes)
    generate_codes(node.right, code + "1", codes)
    
    return codes
```

### Graph Algorithms

#### Graph Representations

```python
# Adjacency List
graph = {
    'A': ['B', 'C'],
    'B': ['A', 'D', 'E'],
    'C': ['A', 'F'],
    'D': ['B'],
    'E': ['B', 'F'],
    'F': ['C', 'E']
}

# Adjacency Matrix
n = 6  # Number of nodes
adj_matrix = [[0] * n for _ in range(n)]
# Add edges...
```

#### Depth-First Search (DFS)

```python
def dfs(graph, start, visited=None):
    if visited is None:
        visited = set()
    
    visited.add(start)
    print(start, end=" ")
    
    for neighbor in graph[start]:
        if neighbor not in visited:
            dfs(graph, neighbor, visited)

# Iterative DFS
def dfs_iterative(graph, start):
    visited = set()
    stack = [start]
    
    while stack:
        node = stack.pop()
        if node not in visited:
            visited.add(node)
            print(node, end=" ")
            # Add neighbors in reverse order to maintain order
            for neighbor in reversed(graph[node]):
                if neighbor not in visited:
                    stack.append(neighbor)
```

#### Breadth-First Search (BFS)

```python
from collections import deque

def bfs(graph, start):
    visited = set()
    queue = deque([start])
    visited.add(start)
    
    while queue:
        node = queue.popleft()
        print(node, end=" ")
        
        for neighbor in graph[node]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)
```

#### Dijkstra's Algorithm

```python
import heapq

def dijkstra(graph, start):
    # graph: dict of dicts {node: {neighbor: weight}}
    distances = {node: float('inf') for node in graph}
    distances[start] = 0
    pq = [(0, start)]  # (distance, node)
    
    while pq:
        current_distance, current_node = heapq.heappop(pq)
        
        if current_distance > distances[current_node]:
            continue
        
        for neighbor, weight in graph[current_node].items():
            distance = current_distance + weight
            if distance < distances[neighbor]:
                distances[neighbor] = distance
                heapq.heappush(pq, (distance, neighbor))
    
    return distances
```

#### Topological Sort

```python
def topological_sort(graph):
    # graph: adjacency list
    visited = set()
    stack = []
    
    def dfs(node):
        visited.add(node)
        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                dfs(neighbor)
        stack.append(node)
    
    for node in graph:
        if node not in visited:
            dfs(node)
    
    return stack[::-1]  # Reverse for topological order
```

#### Union-Find (Disjoint Set)

```python
class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))
        self.rank = [0] * size
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])  # Path compression
        return self.parent[x]
    
    def union(self, x, y):
        px, py = self.find(x), self.find(y)
        if px != py:
            if self.rank[px] < self.rank[py]:
                self.parent[px] = py
            elif self.rank[px] > self.rank[py]:
                self.parent[py] = px
            else:
                self.parent[py] = px
                self.rank[px] += 1
```

### Backtracking

#### N-Queens Problem

```python
def solve_n_queens(n):
    def is_safe(board, row, col):
        # Check column
        for i in range(row):
            if board[i][col] == 'Q':
                return False
        
        # Check upper diagonal
        for i, j in zip(range(row-1, -1, -1), range(col-1, -1, -1)):
            if board[i][j] == 'Q':
                return False
        
        # Check lower diagonal
        for i, j in zip(range(row-1, -1, -1), range(col+1, n)):
            if board[i][j] == 'Q':
                return False
        
        return True
    
    def backtrack(board, row):
        if row == n:
            result.append([''.join(r) for r in board])
            return
        
        for col in range(n):
            if is_safe(board, row, col):
                board[row][col] = 'Q'
                backtrack(board, row + 1)
                board[row][col] = '.'
    
    result = []
    board = [['.'] * n for _ in range(n)]
    backtrack(board, 0)
    return result
```

#### Sudoku Solver

```python
def solve_sudoku(board):
    def is_valid(num, pos):
        # Check row
        for j in range(9):
            if board[pos[0]][j] == str(num) and j != pos[1]:
                return False
        
        # Check column
        for i in range(9):
            if board[i][pos[1]] == str(num) and i != pos[0]:
                return False
        
        # Check 3x3 box
        box_x = pos[0] // 3
        box_y = pos[1] // 3
        for i in range(box_x * 3, box_x * 3 + 3):
            for j in range(box_y * 3, box_y * 3 + 3):
                if board[i][j] == str(num) and (i, j) != pos:
                    return False
        
        return True
    
    def find_empty():
        for i in range(9):
            for j in range(9):
                if board[i][j] == '.':
                    return (i, j)
        return None
    
    def solve():
        empty = find_empty()
        if not empty:
            return True
        
        row, col = empty
        for num in range(1, 10):
            if is_valid(num, (row, col)):
                board[row][col] = str(num)
                if solve():
                    return True
                board[row][col] = '.'
        
        return False
    
    solve()
    return board
```

### Bit Manipulation

#### Common Operations

```python
# Check if ith bit is set
def is_set(num, i):
    return (num & (1 << i)) != 0

# Set ith bit
def set_bit(num, i):
    return num | (1 << i)

# Clear ith bit
def clear_bit(num, i):
    return num & ~(1 << i)

# Toggle ith bit
def toggle_bit(num, i):
    return num ^ (1 << i)

# Count set bits
def count_bits(num):
    count = 0
    while num:
        count += num & 1
        num >>= 1
    return count

# Or using built-in
def count_bits_builtin(num):
    return bin(num).count('1')
```

#### Bit Manipulation Problems

```python
# Single Number (all appear twice except one)
def single_number(nums):
    result = 0
    for num in nums:
        result ^= num
    return result

# Power of Two
def is_power_of_two(n):
    return n > 0 and (n & (n - 1)) == 0

# Reverse bits
def reverse_bits(n):
    result = 0
    for _ in range(32):
        result = (result << 1) | (n & 1)
        n >>= 1
    return result
```

### Time Complexity Analysis

| Algorithm | Time Complexity | Space Complexity |
|-----------|----------------|------------------|
| Linear Search | O(n) | O(1) |
| Binary Search | O(log n) | O(1) |
| Bubble Sort | O(n²) | O(1) |
| Quick Sort | O(n log n) avg | O(log n) |
| Merge Sort | O(n log n) | O(n) |
| DFS/BFS | O(V + E) | O(V) |
| Dijkstra | O((V + E) log V) | O(V) |
| Bellman-Ford | O(V * E) | O(V) |
| Floyd-Warshall | O(V³) | O(V²) |
| Knapsack DP | O(n * W) | O(n * W) |

Where:
- V = vertices/nodes
- E = edges
- n = array size
- W = knapsack capacity

## Object-Oriented Programming

Object-Oriented Programming (OOP) is a paradigm that uses objects and classes to structure code. Python supports OOP with full features including inheritance, polymorphism, encapsulation, and abstraction.

### Core Principles

#### 1. Encapsulation
Encapsulation is the bundling of data and methods that operate on that data within a single unit (class). It restricts direct access to some of an object's components.

```python
class BankAccount:
    def __init__(self, balance=0):
        self.__balance = balance  # Private attribute
    
    def deposit(self, amount):
        if amount > 0:
            self.__balance += amount
    
    def withdraw(self, amount):
        if 0 < amount <= self.__balance:
            self.__balance -= amount
            return True
        return False
    
    def get_balance(self):
        return self.__balance

account = BankAccount(1000)
account.deposit(500)
print(account.get_balance())  # 1500
# print(account.__balance)  # AttributeError: 'BankAccount' has no attribute '__balance'
```

#### 2. Abstraction
Abstraction is the concept of hiding complex implementation details and showing only the necessary features of an object.

```python
from abc import ABC, abstractmethod

class Shape(ABC):
    @abstractmethod
    def area(self):
        pass
    
    @abstractmethod
    def perimeter(self):
        pass

class Rectangle(Shape):
    def __init__(self, width, height):
        self.width = width
        self.height = height
    
    def area(self):
        return self.width * self.height
    
    def perimeter(self):
        return 2 * (self.width + self.height)

rect = Rectangle(10, 5)
print(f"Area: {rect.area()}")  # Area: 50
```

#### 3. Inheritance
Inheritance allows a class to inherit attributes and methods from another class.

```python
class Animal:
    def __init__(self, name):
        self.name = name
    
    def speak(self):
        return "Some sound"

class Dog(Animal):
    def speak(self):
        return "Woof!"

class Cat(Animal):
    def speak(self):
        return "Meow!"

dog = Dog("Buddy")
cat = Cat("Whiskers")
print(dog.speak())  # Woof!
print(cat.speak())  # Meow!
```

#### 4. Polymorphism
Polymorphism allows objects of different classes to be treated as objects of a common superclass.

```python
def animal_sound(animal):
    return animal.speak()

animals = [Dog("Buddy"), Cat("Whiskers")]
for animal in animals:
    print(animal_sound(animal))
```

### Classes and Objects

#### Class Variables vs Instance Variables

```python
class Car:
    wheels = 4  # Class variable
    
    def __init__(self, make, model):
        self.make = make  # Instance variable
        self.model = model

car1 = Car("Toyota", "Camry")
car2 = Car("Honda", "Civic")

print(car1.wheels)  # 4
print(car2.wheels)  # 4
Car.wheels = 6
print(car1.wheels)  # 6 (changed for all instances)
```

#### Methods

- **Instance Methods**: Operate on instance data
- **Class Methods**: Operate on class data, use `@classmethod` decorator
- **Static Methods**: Don't operate on instance or class data, use `@staticmethod` decorator

```python
class MathUtils:
    @staticmethod
    def add(x, y):
        return x + y
    
    @classmethod
    def create_zero_vector(cls, dimensions):
        return [0] * dimensions
    
    def __init__(self, value):
        self.value = value
    
    def multiply(self, factor):
        return self.value * factor

print(MathUtils.add(5, 3))  # 8
print(MathUtils.create_zero_vector(3))  # [0, 0, 0]
```

#### Property Decorators

```python
class Temperature:
    def __init__(self, celsius):
        self._celsius = celsius
    
    @property
    def celsius(self):
        return self._celsius
    
    @celsius.setter
    def celsius(self, value):
        if value < -273.15:
            raise ValueError("Temperature can't be below absolute zero")
        self._celsius = value
    
    @property
    def fahrenheit(self):
        return (self._celsius * 9/5) + 32

temp = Temperature(25)
print(temp.fahrenheit)  # 77.0
temp.celsius = 30
print(temp.fahrenheit)  # 86.0
```

### Advanced Inheritance

#### Multiple Inheritance

```python
class Flyable:
    def fly(self):
        return "Flying"

class Swimmable:
    def swim(self):
        return "Swimming"

class Duck(Flyable, Swimmable):
    def quack(self):
        return "Quack!"

duck = Duck()
print(duck.fly())    # Flying
print(duck.swim())   # Swimming
print(duck.quack())  # Quack!
```

#### Method Resolution Order (MRO)

```python
class A:
    def method(self):
        return "A"

class B(A):
    def method(self):
        return "B"

class C(A):
    def method(self):
        return "C"

class D(B, C):
    pass

d = D()
print(d.method())  # B (follows MRO: D -> B -> C -> A)
print(D.__mro__)   # (<class '__main__.D'>, <class '__main__.B'>, <class '__main__.C'>, <class '__main__.A'>, <class 'object'>)
```

### Magic Methods (Dunder Methods)

Magic methods allow customization of object behavior.

```python
class Vector:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    
    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y)
    
    def __sub__(self, other):
        return Vector(self.x - other.x, self.y - other.y)
    
    def __mul__(self, scalar):
        return Vector(self.x * scalar, self.y * scalar)
    
    def __eq__(self, other):
        return self.x == other.x and self.y == other.y
    
    def __str__(self):
        return f"Vector({self.x}, {self.y})"
    
    def __repr__(self):
        return f"Vector({self.x}, {self.y})"
    
    def __len__(self):
        return 2  # Number of components
    
    def __getitem__(self, index):
        if index == 0:
            return self.x
        elif index == 1:
            return self.y
        else:
            raise IndexError("Vector index out of range")

v1 = Vector(1, 2)
v2 = Vector(3, 4)
print(v1 + v2)  # Vector(4, 6)
print(v1 * 3)    # Vector(3, 6)
print(v1 == v2)  # False
print(len(v1))   # 2
print(v1[0])     # 1
```

### Composition vs Inheritance

Composition is often preferred over inheritance for flexibility.

```python
class Engine:
    def start(self):
        return "Engine started"

class Car:
    def __init__(self):
        self.engine = Engine()  # Composition
    
    def start(self):
        return self.engine.start()

car = Car()
print(car.start())  # Engine started
```

### Design Patterns (Brief Overview)

#### Singleton Pattern

```python
class Singleton:
    _instance = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

s1 = Singleton()
s2 = Singleton()
print(s1 is s2)  # True
```

#### Factory Pattern

```python
class AnimalFactory:
    @staticmethod
    def create_animal(animal_type):
        if animal_type == "dog":
            return Dog("Buddy")
        elif animal_type == "cat":
            return Cat("Whiskers")
        else:
            raise ValueError("Unknown animal type")

animal = AnimalFactory.create_animal("dog")
print(animal.speak())  # Woof!
```

### Common OOP Interview Questions

1. **What is the difference between `is` and `==`?**
   - `==` compares values
   - `is` compares object identity

2. **What are metaclasses?**
   - Classes that create classes
   - Used for advanced customization

3. **What is monkey patching?**
   - Dynamically modifying classes or modules at runtime

4. **Explain `__slots__`**
   - Restricts attribute creation to save memory
   - `class MyClass: __slots__ = ['x', 'y']`

5. **What is the difference between `@staticmethod` and `@classmethod`?**
   - `@staticmethod`: No access to class or instance
   - `@classmethod`: Access to class, can modify class state

## Common Libraries

### Standard Library

#### os Module

```python
import os

# File operations
print(os.getcwd())                    # Current working directory
os.chdir('/path/to/dir')              # Change directory
os.mkdir('new_dir')                   # Create directory
os.makedirs('path/to/nested/dir')     # Create nested directories
os.remove('file.txt')                 # Remove file
os.rmdir('dir')                       # Remove directory
os.rename('old.txt', 'new.txt')       # Rename file

# Path operations
print(os.path.exists('file.txt'))     # Check if path exists
print(os.path.isfile('file.txt'))     # Check if file
print(os.path.isdir('dir'))           # Check if directory
print(os.path.join('path', 'to', 'file.txt'))  # Join paths
print(os.path.basename('/path/to/file.txt'))   # Get filename
print(os.path.dirname('/path/to/file.txt'))    # Get directory
print(os.path.splitext('file.txt'))            # Split extension
```

#### sys Module

```python
import sys

print(sys.version)                    # Python version
print(sys.platform)                   # Platform
print(sys.path)                       # Module search path
sys.exit(0)                           # Exit program

# Command line arguments
print(sys.argv)                       # List of command line args
# python script.py arg1 arg2 -> ['script.py', 'arg1', 'arg2']

# Standard streams
sys.stdout.write('Hello\n')           # Write to stdout
sys.stderr.write('Error\n')           # Write to stderr
```

#### datetime Module

```python
from datetime import datetime, date, time, timedelta

# Current date and time
now = datetime.now()
print(now)                            # 2023-12-07 14:30:45.123456
print(now.date())                     # 2023-12-07
print(now.time())                     # 14:30:45.123456

# Create specific datetime
dt = datetime(2023, 12, 7, 14, 30, 45)
print(dt)                             # 2023-12-07 14:30:45

# Formatting
print(dt.strftime('%Y-%m-%d %H:%M:%S'))  # 2023-12-07 14:30:45
print(dt.strftime('%A, %B %d, %Y'))      # Thursday, December 07, 2023

# Parsing
date_str = '2023-12-07'
parsed = datetime.strptime(date_str, '%Y-%m-%d')
print(parsed)                         # 2023-12-07 00:00:00

# Time arithmetic
tomorrow = now + timedelta(days=1)
next_week = now + timedelta(weeks=1)
print(tomorrow.date())                # Tomorrow's date
```

#### json Module

```python
import json

# Python to JSON
data = {'name': 'Alice', 'age': 30, 'city': 'NYC'}
json_str = json.dumps(data)
print(json_str)                       # {"name": "Alice", "age": 30, "city": "NYC"}

# JSON to Python
parsed = json.loads(json_str)
print(parsed['name'])                 # Alice

# File operations
with open('data.json', 'w') as f:
    json.dump(data, f, indent=2)

with open('data.json', 'r') as f:
    loaded = json.load(f)
```

#### collections Module

```python
from collections import Counter, defaultdict, OrderedDict, deque, namedtuple

# Counter
counter = Counter(['a', 'b', 'a', 'c', 'a', 'b'])
print(counter)                        # Counter({'a': 3, 'b': 2, 'c': 1})
print(counter.most_common(2))         # [('a', 3), ('b', 2)]

# defaultdict
dd = defaultdict(int)
dd['a'] += 1                          # No KeyError
print(dd['a'])                        # 1
print(dd['b'])                        # 0 (default value)

# OrderedDict (Python 3.7+ dicts maintain order)
od = OrderedDict()
od['a'] = 1
od['b'] = 2
od['c'] = 3

# deque
dq = deque([1, 2, 3])
dq.append(4)                          # Add to right
dq.appendleft(0)                      # Add to left
print(dq)                             # deque([0, 1, 2, 3, 4])

# namedtuple
Point = namedtuple('Point', ['x', 'y'])
p = Point(1, 2)
print(p.x, p.y)                       # 1 2
print(p[0], p[1])                     # 1 2
```

#### itertools Module

```python
import itertools

# Infinite iterators
counter = itertools.count(start=10, step=2)
print(list(itertools.islice(counter, 5)))  # [10, 12, 14, 16, 18]

cycle = itertools.cycle('ABC')
print(list(itertools.islice(cycle, 7)))    # ['A', 'B', 'C', 'A', 'B', 'C', 'A']

repeat = itertools.repeat('Hello', 3)
print(list(repeat))                          # ['Hello', 'Hello', 'Hello']

# Combinatorics
print(list(itertools.permutations('ABC', 2)))  # All permutations of length 2
print(list(itertools.combinations('ABC', 2)))  # All combinations of length 2
print(list(itertools.product('AB', 'CD')))     # Cartesian product

# Grouping and filtering
data = [1, 2, 3, 4, 5, 6]
grouped = itertools.groupby(data, lambda x: x % 2)
for key, group in grouped:
    print(key, list(group))
# 1 [1, 3, 5]
# 0 [2, 4, 6]
```

#### functools Module

```python
import functools

# partial
def multiply(x, y):
    return x * y

double = functools.partial(multiply, 2)
print(double(5))                       # 10

# reduce
numbers = [1, 2, 3, 4, 5]
product = functools.reduce(lambda x, y: x * y, numbers)
print(product)                         # 120

# lru_cache
@functools.lru_cache(maxsize=None)
def fibonacci(n):
    if n < 2:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

print(fibonacci(10))                   # 55 (cached)

# cmp_to_key (for Python 3)
def compare_items(a, b):
    if a < b:
        return -1
    elif a > b:
        return 1
    else:
        return 0

# sorted_list = sorted(items, key=functools.cmp_to_key(compare_items))
```

### Third-party Libraries

#### NumPy

```python
import numpy as np

# Arrays
arr = np.array([1, 2, 3, 4, 5])
print(arr.dtype)                       # int64
print(arr.shape)                       # (5,)

# 2D arrays
matrix = np.array([[1, 2, 3], [4, 5, 6]])
print(matrix.shape)                    # (2, 3)

# Operations
print(arr + 10)                        # [11, 12, 13, 14, 15]
print(arr * 2)                         # [2, 4, 6, 8, 10]
print(np.sum(arr))                     # 15
print(np.mean(arr))                    # 3.0
print(np.max(arr))                     # 5

# Indexing and slicing
print(arr[1:4])                        # [2, 3, 4]
print(matrix[0, :])                    # [1, 2, 3]
print(matrix[:, 1])                    # [2, 5]

# Broadcasting
a = np.array([1, 2, 3])
b = np.array([[1], [2], [3]])
print(a + b)                           # Broadcasting
```

#### Pandas

```python
import pandas as pd

# Series
s = pd.Series([1, 3, 5, 6, 8])
print(s.mean())                        # 4.6

# DataFrame
data = {
    'Name': ['Alice', 'Bob', 'Charlie'],
    'Age': [25, 30, 35],
    'City': ['NYC', 'LA', 'Chicago']
}
df = pd.DataFrame(data)

print(df.head())                       # First 5 rows
print(df.describe())                   # Statistics
print(df['Age'].mean())                # 30.0

# Filtering
adults = df[df['Age'] > 25]
print(adults)

# Grouping
grouped = df.groupby('City').mean()
print(grouped)
```

#### Requests

```python
import requests

# GET request
response = requests.get('https://api.github.com/user', auth=('user', 'pass'))
print(response.status_code)            # 200
print(response.json())                 # JSON response

# POST request
data = {'key': 'value'}
response = requests.post('https://httpbin.org/post', json=data)
print(response.json())

# Headers and params
headers = {'User-Agent': 'MyApp/1.0'}
params = {'key': 'value', 'page': 1}
response = requests.get('https://api.example.com/data', 
                       headers=headers, params=params)

# File upload
files = {'file': open('example.txt', 'rb')}
response = requests.post('https://httpbin.org/post', files=files)
```

#### Flask (Web Framework)

```python
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'

@app.route('/api/data', methods=['GET', 'POST'])
def handle_data():
    if request.method == 'POST':
        data = request.get_json()
        return jsonify({'received': data})
    return jsonify({'message': 'GET request'})

if __name__ == '__main__':
    app.run(debug=True)
```

#### pytest (Testing)

```python
# test_example.py
def add(x, y):
    return x + y

def test_add():
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
    assert add(0, 0) == 0

def test_add_types():
    import pytest
    with pytest.raises(TypeError):
        add("a", 1)

# Run with: pytest test_example.py
```

## Advanced Python Topics

### Metaclasses

```python
class SingletonMeta(type):
    _instances = {}
    
    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super().__call__(*args, **kwargs)
        return cls._instances[cls]

class Singleton(metaclass=SingletonMeta):
    def __init__(self, value):
        self.value = value

s1 = Singleton(1)
s2 = Singleton(2)
print(s1 is s2)  # True
print(s1.value)  # 1 (first instance)
```

### Descriptors

```python
class LazyProperty:
    def __init__(self, func):
        self.func = func
        self.name = func.__name__
    
    def __get__(self, instance, owner):
        if instance is None:
            return self
        value = self.func(instance)
        setattr(instance, self.name, value)
        return value

class Circle:
    def __init__(self, radius):
        self.radius = radius
    
    @LazyProperty
    def area(self):
        print("Computing area...")
        return 3.14159 * self.radius ** 2
    
    @LazyProperty
    def circumference(self):
        print("Computing circumference...")
        return 2 * 3.14159 * self.radius

c = Circle(5)
print(c.area)        # Computing area... 78.53975
print(c.area)        # 78.53975 (cached)
```

### Generators and Coroutines

```python
# Generator with send()
def counter():
    count = 0
    while True:
        received = (yield count)
        if received is not None:
            count = received
        else:
            count += 1

gen = counter()
print(next(gen))     # 0
print(next(gen))     # 1
print(gen.send(10))  # 10
print(next(gen))     # 11
```

### asyncio (Asynchronous Programming)

```python
import asyncio

async def say_hello(name, delay):
    await asyncio.sleep(delay)
    print(f"Hello, {name}!")

async def main():
    # Concurrent execution
    await asyncio.gather(
        say_hello("Alice", 1),
        say_hello("Bob", 2),
        say_hello("Charlie", 1.5)
    )

# Run the event loop
asyncio.run(main())
```

### Multiprocessing

```python
import multiprocessing as mp
import time

def worker(num):
    print(f"Worker {num} starting")
    time.sleep(2)
    print(f"Worker {num} finished")

if __name__ == '__main__':
    processes = []
    for i in range(4):
        p = mp.Process(target=worker, args=(i,))
        processes.append(p)
        p.start()
    
    for p in processes:
        p.join()
```

### Memory Management

```python
import gc
import sys

# Reference counting
a = [1, 2, 3]
print(sys.getrefcount(a))  # Reference count

# Garbage collection
gc.collect()  # Force garbage collection

# Weak references
import weakref

class MyClass:
    def __init__(self, value):
        self.value = value

obj = MyClass(42)
weak_ref = weakref.ref(obj)
print(weak_ref().value)  # 42

del obj
print(weak_ref())  # None (object garbage collected)
```

### Type Hints and Annotations

```python
from typing import List, Dict, Optional, Union, Callable

def greet(name: str) -> str:
    return f"Hello, {name}!"

def process_items(items: List[int]) -> Dict[str, int]:
    return {
        'count': len(items),
        'sum': sum(items)
    }

def find_item(items: List[str], predicate: Callable[[str], bool]) -> Optional[str]:
    for item in items:
        if predicate(item):
            return item
    return None

# Union types
def add(x: Union[int, float], y: Union[int, float]) -> Union[int, float]:
    return x + y

# Generic types
from typing import TypeVar, Generic

T = TypeVar('T')

class Stack(Generic[T]):
    def __init__(self):
        self.items: List[T] = []
    
    def push(self, item: T) -> None:
        self.items.append(item)
    
    def pop(self) -> T:
        return self.items.pop()
```

## Concurrency and Parallelism

### Threading

```python
import threading
import time

def worker(name, delay):
    print(f"Thread {name} starting")
    time.sleep(delay)
    print(f"Thread {name} finished")

# Create threads
threads = []
for i in range(3):
    t = threading.Thread(target=worker, args=(f"T{i}", i+1))
    threads.append(t)
    t.start()

# Wait for all threads
for t in threads:
    t.join()

print("All threads completed")
```

### Thread Synchronization

```python
import threading

class Counter:
    def __init__(self):
        self.value = 0
        self.lock = threading.Lock()
    
    def increment(self):
        with self.lock:
            self.value += 1

counter = Counter()
threads = []

def increment_counter():
    for _ in range(1000):
        counter.increment()

for _ in range(10):
    t = threading.Thread(target=increment_counter)
    threads.append(t)
    t.start()

for t in threads:
    t.join()

print(f"Final count: {counter.value}")  # 10000
```

### Queue for Thread Communication

```python
import threading
import queue
import time

def producer(q):
    for i in range(5):
        q.put(i)
        print(f"Produced: {i}")
        time.sleep(0.1)

def consumer(q):
    while True:
        item = q.get()
        if item is None:
            break
        print(f"Consumed: {item}")
        q.task_done()

q = queue.Queue()
producer_thread = threading.Thread(target=producer, args=(q,))
consumer_thread = threading.Thread(target=consumer, args=(q,))

producer_thread.start()
consumer_thread.start()

producer_thread.join()
q.put(None)  # Signal consumer to stop
consumer_thread.join()
```

### Concurrent.futures

```python
import concurrent.futures
import time

def task(n):
    time.sleep(1)
    return n * n

# ThreadPoolExecutor
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as executor:
    futures = [executor.submit(task, i) for i in range(10)]
    for future in concurrent.futures.as_completed(futures):
        print(f"Result: {future.result()}")

# ProcessPoolExecutor
with concurrent.futures.ProcessPoolExecutor(max_workers=4) as executor:
    results = executor.map(task, range(10))
    print(list(results))
```

## Testing

### unittest

```python
import unittest

class TestMath(unittest.TestCase):
    def setUp(self):
        self.calc = Calculator()
    
    def test_add(self):
        self.assertEqual(self.calc.add(2, 3), 5)
        self.assertEqual(self.calc.add(-1, 1), 0)
    
    def test_divide(self):
        self.assertEqual(self.calc.divide(6, 2), 3)
        with self.assertRaises(ZeroDivisionError):
            self.calc.divide(1, 0)
    
    def tearDown(self):
        pass

if __name__ == '__main__':
    unittest.main()
```

### pytest Fixtures

```python
import pytest

@pytest.fixture
def sample_data():
    return [1, 2, 3, 4, 5]

@pytest.fixture(scope="module")
def db_connection():
    # Setup
    conn = create_database_connection()
    yield conn
    # Teardown
    conn.close()

def test_sum(sample_data):
    assert sum(sample_data) == 15

def test_average(sample_data):
    assert average(sample_data) == 3.0

def test_database_query(db_connection):
    result = db_connection.query("SELECT * FROM users")
    assert len(result) > 0
```

### Mocking

```python
from unittest.mock import Mock, patch

# Mock object
mock_obj = Mock()
mock_obj.method.return_value = 42
print(mock_obj.method())  # 42

# Patching
@patch('module.external_api_call')
def test_api_call(mock_api):
    mock_api.return_value = {'status': 'success'}
    result = my_function()
    assert result['status'] == 'success'
    mock_api.assert_called_once()
```

### Coverage

```bash
# Install coverage
pip install coverage

# Run tests with coverage
coverage run -m pytest
coverage report
coverage html  # Generate HTML report
```

## Performance Optimization

### Profiling

```python
import cProfile
import pstats

def slow_function():
    return sum(i**2 for i in range(100000))

# Profile function
cProfile.run('slow_function()')

# Or use as decorator
def profile(func):
    def wrapper(*args, **kwargs):
        import cProfile
        pr = cProfile.Profile()
        pr.enable()
        result = func(*args, **kwargs)
        pr.disable()
        pr.print_stats()
        return result
    return wrapper

@profile
def my_function():
    # Code to profile
    pass
```

### Memory Profiling

```python
from memory_profiler import profile

@profile
def memory_intensive():
    big_list = [i for i in range(100000)]
    return sum(big_list)

memory_intensive()
```

### Optimization Techniques

```python
# Use list comprehensions instead of loops
# Bad
squares = []
for i in range(1000):
    squares.append(i**2)

# Good
squares = [i**2 for i in range(1000)]

# Use generators for large datasets
def large_generator():
    for i in range(1000000):
        yield i**2

# Use appropriate data structures
# Use set for membership testing instead of list
# Use deque for frequent appends/pops from both ends

# String concatenation
# Bad
result = ""
for s in strings:
    result += s

# Good
result = "".join(strings)

# Cache expensive operations
from functools import lru_cache

@lru_cache(maxsize=128)
def expensive_function(n):
    # Expensive computation
    return n ** n
```

## Security

### Common Vulnerabilities

```python
# SQL Injection (BAD)
import sqlite3

def get_user_bad(username):
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    query = f"SELECT * FROM users WHERE username = '{username}'"
    cursor.execute(query)  # Vulnerable to injection
    return cursor.fetchall()

# SQL Injection (GOOD)
def get_user_good(username):
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users WHERE username = ?", (username,))
    return cursor.fetchall()

# Command Injection (BAD)
import os

def run_command_bad(cmd):
    os.system(cmd)  # Dangerous!

# Command Injection (GOOD)
def run_command_good(cmd):
    import subprocess
    allowed_commands = ['ls', 'pwd', 'echo']
    if cmd.split()[0] in allowed_commands:
        result = subprocess.run(cmd.split(), capture_output=True, text=True)
        return result.stdout
    else:
        raise ValueError("Command not allowed")
```

### Secure Practices

```python
# Use secrets module for random values
import secrets

# Generate secure token
token = secrets.token_hex(32)

# Use hashlib for passwords (with salt)
import hashlib
import os

def hash_password(password):
    salt = os.urandom(32)
    key = hashlib.pbkdf2_hmac('sha256', password.encode(), salt, 100000)
    return salt + key

# Input validation
def validate_email(email):
    import re
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None

# Use requests with timeout
import requests

response = requests.get('https://api.example.com', timeout=5)

# Environment variables for secrets
import os
api_key = os.getenv('API_KEY')
if not api_key:
    raise ValueError("API_KEY environment variable not set")
```

## Coding Problems

### Two Sum

Given array of integers and target, find indices that sum to target.

```python
def two_sum(nums, target):
    seen = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]
        seen[num] = i
    return []
```

### Reverse Linked List

```python
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

def reverse_list(head):
    prev = None
    curr = head
    while curr:
        next_temp = curr.next
        curr.next = prev
        prev = curr
        curr = next_temp
    return prev
```

### Valid Parentheses

```python
def is_valid(s):
    stack = []
    mapping = {")": "(", "}": "{", "]": "["}
    for char in s:
        if char in mapping:
            top = stack.pop() if stack else '#'
            if mapping[char] != top:
                return False
        else:
            stack.append(char)
    return not stack
```

## System Design

### Basic Concepts

- Scalability: Vertical vs Horizontal
- Load balancing
- Caching
- Database design
- API design

### Example: Design a URL Shortener

Components:
- Frontend: Web interface
- Backend: API server
- Database: Store URL mappings
- Cache: Redis for frequently accessed URLs

Considerations:
- Collision handling
- Expiration
- Analytics

## Interview Tips and Best Practices

### Preparation Strategy

1. **Master the Fundamentals**
   - Understand Python's data model deeply
   - Know time/space complexities of operations
   - Practice writing clean, readable code

2. **Algorithm Practice**
   - Focus on LeetCode Medium problems
   - Understand multiple solutions for each problem
   - Practice explaining your thought process

3. **System Design Practice**
   - Study common design patterns
   - Practice designing scalable systems
   - Learn trade-offs between different approaches

4. **Mock Interviews**
   - Practice with peers or mentors
   - Record yourself explaining solutions
   - Time yourself on problems

### Common Interview Patterns

#### Array/String Problems
- Two pointers
- Sliding window
- Prefix sums
- Hash maps for frequency counting

#### Tree Problems
- DFS (recursive/iterative)
- BFS with queues
- Binary search trees
- Tree traversals

#### Graph Problems
- DFS/BFS
- Topological sort
- Union-Find
- Shortest paths

#### Dynamic Programming
- Identify optimal substructure
- Overlapping subproblems
- Bottom-up vs top-down approaches

### Communication Tips

1. **Think Aloud**
   - Explain your thought process
   - Ask clarifying questions
   - Discuss trade-offs

2. **Write Clean Code**
   - Use descriptive variable names
   - Handle edge cases
   - Add comments for complex logic

3. **Test Your Code**
   - Consider edge cases
   - Test with sample inputs
   - Explain time/space complexity

### Red Flags to Avoid

- Jumping into code without understanding the problem
- Not handling edge cases
- Poor variable naming
- Not explaining your approach
- Giving up too quickly

### Post-Interview

- Send thank-you notes
- Follow up on timeline
- Reflect on what you learned
- Continue practicing

### Salary Negotiation

- Research market rates
- Know your worth
- Consider total compensation
- Practice negotiation scenarios

## Resources

- Books: "Cracking the Coding Interview", "Python Cookbook"
- Websites: LeetCode, HackerRank, CodeSignal
- YouTube: freeCodeCamp, CS Dojo
- Practice: Daily coding problems

Good luck with your interview!