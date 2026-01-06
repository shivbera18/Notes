# 🐍 DSA Solutions: Complete Python Guide for Data Structures and Algorithms

This comprehensive solutions guide covers everything you need to solve DSA problems in Python, including built-in functions, data structures, algorithms, and best practices with example problems.

## Index
1. [Basics](#basics)
2. [Built-in Data Structures](#built-in-data-structures)
3. [String Operations](#string-operations)
4. [Array/List Operations](#arraylist-operations)
5. [Linked Lists](#linked-lists)
6. [Stacks and Queues](#stacks-and-queues)
7. [Trees](#trees)
8. [Graphs](#graphs)
9. [Common Algorithms](#common-algorithms)
10. [Dynamic Programming](#dynamic-programming)
11. [Essential Libraries](#essential-libraries)
12. [Time and Space Complexity](#time-and-space-complexity)
13. [Input/Output Handling](#inputoutput-handling)
14. [Tips for Competitive Programming](#tips-for-competitive-programming)
15. [Example Problems](#example-problems)

---

## 1. Basics

<details>
<summary>Questions</summary>

- Factorial Calculation
- Fibonacci Sequence
- Prime Number Check
- GCD and LCM
- Basic Input/Output

</details>

### Variables and Data Types
```python
# Basic types
int_var = 42
float_var = 3.14
str_var = "hello"
bool_var = True
list_var = [1, 2, 3]
tuple_var = (1, 2, 3)
set_var = {1, 2, 3}
dict_var = {"key": "value"}
```

### Control Structures
```python
# If-else
if condition:
    pass
elif another_condition:
    pass
else:
    pass

# Loops
for i in range(10):
    print(i)

while condition:
    pass

# List comprehensions
squares = [x**2 for x in range(10)]
even_squares = [x**2 for x in range(10) if x % 2 == 0]
```

### Functions and Recursion
```python
def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n-1)

# Lambda functions
add = lambda x, y: x + y
```

---

## 2. Built-in Data Structures and Functions

<details>
<summary>Questions</summary>

- List Operations (Insert, Delete, Search)
- Dictionary Key-Value Operations
- Set Operations (Union, Intersection)
- Tuple Immutability
- Counter for Frequency Counting

</details>

### Lists (Dynamic Arrays)
```python
# Creation
arr = [1, 2, 3, 4, 5]

# Common operations
arr.append(6)        # Add to end
arr.insert(0, 0)     # Insert at index
arr.pop()           # Remove last
arr.pop(0)          # Remove at index
arr.remove(3)       # Remove first occurrence of value
arr.reverse()       # Reverse in place
arr.sort()          # Sort in place
arr.sort(reverse=True)  # Sort descending

# Slicing
sub = arr[1:4]      # [2, 3, 4]
sub = arr[::2]      # Every other element
sub = arr[::-1]     # Reverse

# Other methods
len(arr)            # Length
max(arr), min(arr)  # Max/min values
sum(arr)            # Sum of elements
arr.index(3)        # Find index of value
arr.count(2)        # Count occurrences
```

### Tuples (Immutable)
```python
tup = (1, 2, 3)
# Similar to lists but immutable
tup[0]  # Access
len(tup)
tup.index(2)
tup.count(1)
```

### Sets (Unique Elements)
```python
s = {1, 2, 3, 4}
s.add(5)
s.remove(1)
s.discard(6)  # No error if not present

# Set operations
s1 = {1, 2, 3}
s2 = {3, 4, 5}
s1.union(s2)        # {1, 2, 3, 4, 5}
s1.intersection(s2) # {3}
s1.difference(s2)   # {1, 2}
s1.symmetric_difference(s2)  # {1, 2, 4, 5}
```

### Dictionaries (Hash Maps)
```python
d = {"key": "value", "num": 42}
d["new_key"] = "new_value"
d.get("key")        # Safe access
d.pop("key")        # Remove and return
d.keys()            # View of keys
d.values()          # View of values
d.items()           # View of key-value pairs

# Dict comprehension
squares = {x: x**2 for x in range(5)}
```

---

## 3. String Operations

<details>
<summary>Questions</summary>

- Valid Palindrome
- Longest Palindromic Substring
- String to Integer (atoi)
- Longest Common Prefix
- Group Anagrams
- Valid Parentheses

</details>

```python
s = "Hello, World!"

# Basic operations
len(s)              # Length
s[0]                # First character
s[-1]               # Last character
s[1:5]              # Slice

# String methods
s.upper()           # 'HELLO, WORLD!'
s.lower()           # 'hello, world!'
s.title()           # 'Hello, World!'
s.capitalize()      # 'Hello, world!'

s.strip()           # Remove whitespace
s.lstrip()          # Left strip
s.rstrip()          # Right strip

s.split()           # Split by whitespace
s.split(',')        # Split by comma
','.join(['a', 'b', 'c'])  # 'a,b,c'

s.find('World')     # Index of substring
s.replace('World', 'Python')  # Replace
s.startswith('Hello')  # True
s.endswith('!')     # True

# Check methods
s.isalpha()         # All alphabetic
s.isdigit()         # All digits
s.isalnum()         # Alphanumeric
s.isspace()         # All whitespace
s.isupper()         # All uppercase
s.islower()         # All lowercase

# Formatting
name = "Alice"
age = 30
f"My name is {name} and I'm {age} years old."
"My name is {} and I'm {} years old.".format(name, age)
```

---

## 4. Array/List Operations

<details>
<summary>Questions</summary>

- Two Sum
- Maximum Subarray
- Contains Duplicate
- Product of Array Except Self
- Find Minimum in Rotated Sorted Array
- Search in Rotated Sorted Array
- Merge Intervals
- 3Sum

</details>

```python
# All list methods above apply
# Additional array-like operations

# 2D Arrays
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
matrix[0][1]  # 2

# Initialize 2D array
rows, cols = 3, 4
arr_2d = [[0 for _ in range(cols)] for _ in range(rows)]

# Flatten 2D array
flat = [item for sublist in matrix for item in sublist]

# Transpose
transpose = list(map(list, zip(*matrix)))

# Rotate 90 degrees clockwise
rotated = list(map(list, zip(*matrix[::-1])))

# Common array algorithms
def rotate_left(arr, k):
    return arr[k:] + arr[:k]

def rotate_right(arr, k):
    return arr[-k:] + arr[:-k]

# Binary search (requires sorted array)
import bisect
arr = [1, 3, 5, 7, 9]
bisect.bisect_left(arr, 4)   # Insertion point for 4
bisect.bisect_right(arr, 5)  # Right insertion point
```

---

## 5. Linked Lists

<details>
<summary>Questions</summary>

- Reverse Linked List
- Merge Two Sorted Lists
- Linked List Cycle
- Remove Nth Node From End of List
- Add Two Numbers
- Intersection of Two Linked Lists
- Palindrome Linked List

</details>

### Singly Linked List Implementation
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
        curr = self.head
        while curr.next:
            curr = curr.next
        curr.next = ListNode(val)
    
    def prepend(self, val):
        self.head = ListNode(val, self.head)
    
    def delete(self, val):
        if not self.head:
            return
        if self.head.val == val:
            self.head = self.head.next
            return
        curr = self.head
        while curr.next and curr.next.val != val:
            curr = curr.next
        if curr.next:
            curr.next = curr.next.next
    
    def print_list(self):
        curr = self.head
        while curr:
            print(curr.val, end=" -> ")
            curr = curr.next
        print("None")

# Usage
ll = LinkedList()
ll.append(1)
ll.append(2)
ll.append(3)
ll.print_list()  # 1 -> 2 -> 3 -> None
```

### Doubly Linked List
```python
class DoublyListNode:
    def __init__(self, val=0, prev=None, next=None):
        self.val = val
        self.prev = prev
        self.next = next

# Similar implementation with prev pointers
```

### Common Linked List Problems
- Reverse linked list
- Detect cycle (Floyd's algorithm)
- Find middle node
- Remove nth node from end
- Merge two sorted lists

---

## 6. Stacks and Queues

<details>
<summary>Questions</summary>

- Valid Parentheses
- Min Stack
- Implement Queue using Stacks
- Largest Rectangle in Histogram
- Next Greater Element
- Daily Temperatures

</details>

### Stack (LIFO)
```python
# Using list
stack = []
stack.append(1)  # Push
stack.append(2)
stack.pop()      # Pop (removes 2)
stack[-1]        # Peek (1)

# Using collections.deque
from collections import deque
stack = deque()
stack.append(1)
stack.append(2)
stack.pop()      # Removes 2
```

### Queue (FIFO)
```python
# Using collections.deque (efficient)
from collections import deque
queue = deque()
queue.append(1)  # Enqueue
queue.append(2)
queue.popleft()  # Dequeue (removes 1)

# Using list (inefficient for large queues)
queue = []
queue.append(1)
queue.pop(0)     # Inefficient
```

### Priority Queue
```python
import heapq
pq = []
heapq.heappush(pq, 3)
heapq.heappush(pq, 1)
heapq.heappush(pq, 2)
heapq.heappop(pq)  # Returns 1 (smallest)
```

---

## 7. Trees

<details>
<summary>Questions</summary>

- Maximum Depth of Binary Tree
- Same Tree
- Invert Binary Tree
- Binary Tree Level Order Traversal
- Validate Binary Search Tree
- Lowest Common Ancestor
- Binary Tree Maximum Path Sum

</details>

### Binary Tree Implementation
```python
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

# Tree traversals
def inorder(root):
    if root:
        inorder(root.left)
        print(root.val, end=" ")
        inorder(root.right)

def preorder(root):
    if root:
        print(root.val, end=" ")
        preorder(root.left)
        preorder(root.right)

def postorder(root):
    if root:
        postorder(root.left)
        postorder(root.right)
        print(root.val, end=" ")

def level_order(root):
    if not root:
        return
    from collections import deque
    queue = deque([root])
    while queue:
        node = queue.popleft()
        print(node.val, end=" ")
        if node.left:
            queue.append(node.left)
        if node.right:
            queue.append(node.right)

# Build sample tree
root = TreeNode(1)
root.left = TreeNode(2)
root.right = TreeNode(3)
root.left.left = TreeNode(4)
root.left.right = TreeNode(5)
```

### Binary Search Tree (BST)
```python
class BST:
    def __init__(self):
        self.root = None
    
    def insert(self, val):
        if not self.root:
            self.root = TreeNode(val)
            return
        curr = self.root
        while True:
            if val < curr.val:
                if curr.left:
                    curr = curr.left
                else:
                    curr.left = TreeNode(val)
                    break
            else:
                if curr.right:
                    curr = curr.right
                else:
                    curr.right = TreeNode(val)
                    break
    
    def search(self, val):
        curr = self.root
        while curr:
            if val == curr.val:
                return True
            elif val < curr.val:
                curr = curr.left
            else:
                curr = curr.right
        return False
```

### Common Tree Problems
- Height of tree
- Check if balanced
- Lowest common ancestor
- Path sum
- Serialize/deserialize tree
- Diameter of tree

---

## 8. Graphs

<details>
<summary>Questions</summary>

- Number of Islands
- Clone Graph
- Course Schedule
- Pacific Atlantic Water Flow
- Word Ladder
- Network Delay Time
- Graph Valid Tree

</details>

### Graph Representations

#### Adjacency List
```python
# Using dictionary
graph = {
    0: [1, 2],
    1: [0, 3, 4],
    2: [0, 4],
    3: [1, 5],
    4: [1, 2, 5],
    5: [3, 4]
}

# Using list of lists
graph = [
    [1, 2],     # 0
    [0, 3, 4],  # 1
    [0, 4],     # 2
    [1, 5],     # 3
    [1, 2, 5],  # 4
    [3, 4]      # 5
]
```

#### Adjacency Matrix
```python
# For dense graphs
n = 6
adj_matrix = [[0] * n for _ in range(n)]
# Add edges
adj_matrix[0][1] = 1
adj_matrix[0][2] = 1
# etc.
```

### Graph Traversal

#### DFS (Depth-First Search)
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
            # Add unvisited neighbors
            for neighbor in reversed(graph[node]):
                if neighbor not in visited:
                    stack.append(neighbor)
```

#### BFS (Breadth-First Search)
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

### Common Graph Algorithms

#### Shortest Path - Dijkstra's Algorithm
```python
import heapq

def dijkstra(graph, start):
    # graph: dict of {node: [(neighbor, weight), ...]}
    distances = {node: float('inf') for node in graph}
    distances[start] = 0
    pq = [(0, start)]  # (distance, node)
    
    while pq:
        current_distance, current_node = heapq.heappop(pq)
        
        if current_distance > distances[current_node]:
            continue
            
        for neighbor, weight in graph[current_node]:
            distance = current_distance + weight
            if distance < distances[neighbor]:
                distances[neighbor] = distance
                heapq.heappush(pq, (distance, neighbor))
    
    return distances
```

#### Topological Sort
```python
from collections import deque

def topological_sort(graph):
    # graph: adjacency list
    in_degree = {node: 0 for node in graph}
    for node in graph:
        for neighbor in graph[node]:
            in_degree[neighbor] += 1
    
    queue = deque([node for node in in_degree if in_degree[node] == 0])
    result = []
    
    while queue:
        node = queue.popleft()
        result.append(node)
        
        for neighbor in graph[node]:
            in_degree[neighbor] -= 1
            if in_degree[neighbor] == 0:
                queue.append(neighbor)
    
    return result if len(result) == len(graph) else []  # Empty if cycle
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

### Common Graph Problems
- Connected components
- Cycle detection
- Minimum spanning tree (Kruskal's/Prim's)
- Shortest path in unweighted graph
- Bipartite graph check
- Strongly connected components

---

## 9. Common Algorithms

<details>
<summary>Questions</summary>

- Merge Sort Implementation
- Quick Sort Implementation
- Binary Search
- GCD and LCM
- Sieve of Eratosthenes
- Two Pointers Technique
- Sliding Window Maximum

</details>

### Sorting Algorithms
```python
# Built-in sort
arr.sort()  # In-place
sorted_arr = sorted(arr)  # Returns new list

# Bubble sort
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]

# Quick sort
def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr)//2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quick_sort(left) + middle + quick_sort(right)

# Merge sort (as in your main.py)
# ... (same as before)
```

### Searching Algorithms
```python
# Linear search
def linear_search(arr, target):
    for i, val in enumerate(arr):
        if val == target:
            return i
    return -1

# Binary search (iterative)
def binary_search(arr, target):
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

# Binary search (recursive)
def binary_search_recursive(arr, target, left, right):
    if left > right:
        return -1
    mid = (left + right) // 2
    if arr[mid] == target:
        return mid
    elif arr[mid] < target:
        return binary_search_recursive(arr, target, mid + 1, right)
    else:
        return binary_search_recursive(arr, target, left, mid - 1)
```

### Other Algorithms
```python
# GCD (Euclidean algorithm)
def gcd(a, b):
    while b:
        a, b = b, a % b
    return a

# LCM
def lcm(a, b):
    return abs(a * b) // gcd(a, b)

# Factorial
def factorial(n):
    return 1 if n <= 1 else n * factorial(n-1)

# Fibonacci
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

# Memoized Fibonacci
from functools import lru_cache
@lru_cache(maxsize=None)
def fib_memo(n):
    if n <= 1:
        return n
    return fib_memo(n-1) + fib_memo(n-2)
```

---

## 10. Dynamic Programming

<details>
<summary>Questions</summary>

- Climbing Stairs
- House Robber
- Longest Increasing Subsequence
- Coin Change
- Edit Distance
- Longest Common Subsequence
- Knapsack Problem

</details>

### Common DP Patterns
```python
# 1D DP - Climbing Stairs
def climb_stairs(n):
    if n <= 2:
        return n
    dp = [0] * (n + 1)
    dp[1] = 1
    dp[2] = 2
    for i in range(3, n + 1):
        dp[i] = dp[i-1] + dp[i-2]
    return dp[n]

# Space optimized
def climb_stairs_optimized(n):
    if n <= 2:
        return n
    a, b = 1, 2
    for _ in range(3, n + 1):
        a, b = b, a + b
    return b

# 2D DP - Knapsack
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

# Longest Common Subsequence
def lcs(s1, s2):
    m, n = len(s1), len(s2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if s1[i-1] == s2[j-1]:
                dp[i][j] = dp[i-1][j-1] + 1
            else:
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
    
    return dp[m][n]
```

---

## 11. Essential Libraries

<details>
<summary>Questions</summary>

- Frequency Counting with Counter
- Default Dictionary Usage
- Deque for Efficient Queues
- Heap Operations with heapq
- Memoization with lru_cache
- Permutations and Combinations

</details>

```python
# Collections
from collections import Counter, defaultdict, deque, OrderedDict

# Counter - frequency counting
counter = Counter([1, 2, 2, 3, 3, 3])
print(counter)  # Counter({3: 3, 2: 2, 1: 1})

# defaultdict - default values for missing keys
dd = defaultdict(int)
dd['a'] += 1  # No KeyError

# deque - double-ended queue
dq = deque([1, 2, 3])
dq.appendleft(0)
dq.pop()

# Heapq
import heapq
heap = []
heapq.heappush(heap, 3)
heapq.heappush(heap, 1)
heapq.heappop(heap)  # 1

# Functools
from functools import lru_cache, reduce

@lru_cache(maxsize=None)
def fib(n):
    return n if n <= 1 else fib(n-1) + fib(n-2)

reduce(lambda x, y: x + y, [1, 2, 3, 4])  # 10

# Itertools
import itertools

# Permutations
list(itertools.permutations([1, 2, 3], 2))

# Combinations
list(itertools.combinations([1, 2, 3], 2))

# Product (Cartesian product)
list(itertools.product([1, 2], ['a', 'b']))

# Math
import math
math.gcd(12, 18)  # 6
math.lcm(12, 18)  # 36
math.factorial(5)  # 120
math.sqrt(16)     # 4.0

# Sys
import sys
sys.maxsize       # Maximum integer
sys.stdin.read()  # Read all input
sys.stdout.write("Hello")

# Time
import time
start = time.time()
# code here
end = time.time()
print(f"Time: {end - start} seconds")
```

---

## 12. Time and Space Complexity

<details>
<summary>Questions</summary>

- Analyze Time Complexity of Algorithms
- Space Complexity Trade-offs
- Big O Notation Problems
- Optimizing Code for Better Complexity

</details>

### Big O Notation
- **O(1)**: Constant time - array access, hash map operations
- **O(log n)**: Logarithmic - binary search, balanced tree operations
- **O(n)**: Linear - single loop through array
- **O(n log n)**: Linearithmic - sorting algorithms (merge, quick, heap sort)
- **O(n²)**: Quadratic - nested loops, bubble sort
- **O(2^n)**: Exponential - recursive fibonacci without memoization
- **O(n!)**: Factorial - generating all permutations

### Common Complexities by Data Structure
- **Array/List**: Access O(1), Search O(n), Insert/Delete O(n)
- **Linked List**: Access O(n), Search O(n), Insert/Delete O(1) at known position
- **Stack/Queue**: Push/Pop O(1)
- **Hash Table**: Insert/Search/Delete O(1) average
- **Binary Search Tree**: Insert/Search/Delete O(log n) average
- **Heap**: Insert/Delete O(log n)
- **Graph Traversal**: DFS/BFS O(V + E)

---

## 13. Input/Output Handling

<details>
<summary>Questions</summary>

- Reading Multiple Test Cases
- Fast Input for Large Data
- File I/O Operations
- String Input Processing

</details>

### Standard Input/Output
```python
# Single line input
n = int(input())
arr = list(map(int, input().split()))

# Multiple lines
t = int(input())
for _ in range(t):
    # process each test case

# Fast input for large data
import sys
input = sys.stdin.read
data = input().split()

# Fast output
import sys
sys.stdout.write(" ".join(map(str, result)) + "\n")
```

### File I/O
```python
# Reading file
with open("input.txt", "r") as f:
    data = f.read().splitlines()

# Writing file
with open("output.txt", "w") as f:
    f.write("Result: " + str(result))
```

---

## 14. Tips for Competitive Programming

<details>
<summary>Questions</summary>

- Common Pitfalls in Coding Problems
- Debugging Techniques
- Code Optimization Strategies
- Handling Time Limits

</details>

1. **Read the problem carefully** - understand constraints and edge cases
2. **Choose the right data structure** - affects time/space complexity
3. **Handle edge cases** - empty inputs, single elements, maximum constraints
4. **Use appropriate I/O methods** - sys.stdin for large inputs
5. **Optimize code** - avoid unnecessary operations, use built-in functions
6. **Test thoroughly** - multiple test cases, boundary conditions
7. **Time your code** - ensure it runs within time limits
8. **Learn common patterns** - sliding window, two pointers, etc.
9. **Practice regularly** - solve problems on LeetCode, CodeChef, etc.
10. **Debug systematically** - use print statements, check variable values

### Common Patterns
```python
# Two pointers
def two_sum_sorted(arr, target):
    left, right = 0, len(arr) - 1
    while left < right:
        current_sum = arr[left] + arr[right]
        if current_sum == target:
            return [left, right]
        elif current_sum < target:
            left += 1
        else:
            right -= 1

# Sliding window
def max_subarray_sum(arr, k):
    max_sum = float('-inf')
    current_sum = 0
    for i in range(len(arr)):
        current_sum += arr[i]
        if i >= k - 1:
            max_sum = max(max_sum, current_sum)
            current_sum -= arr[i - (k - 1)]
    return max_sum

# Prefix sum
def prefix_sum(arr):
    prefix = [0] * (len(arr) + 1)
    for i in range(1, len(arr) + 1):
        prefix[i] = prefix[i-1] + arr[i-1]
    return prefix

# Range sum query
def range_sum(prefix, left, right):
    return prefix[right+1] - prefix[left]
```

---

## 15. Example Problems

<details>
<summary>Questions</summary>

- Two Sum
- Valid Parentheses
- Merge Two Sorted Lists
- Maximum Depth of Binary Tree
- Graph Valid Tree
- Climbing Stairs
- Longest Palindromic Substring

</details>

### 1. Two Sum (Hash Map)
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

### 2. Valid Parentheses (Stack)
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

### 3. Merge Two Sorted Lists (Linked List)
```python
def merge_two_lists(list1, list2):
    dummy = ListNode()
    curr = dummy
    
    while list1 and list2:
        if list1.val < list2.val:
            curr.next = list1
            list1 = list1.next
        else:
            curr.next = list2
            list2 = list2.next
        curr = curr.next
    
    curr.next = list1 or list2
    return dummy.next
```

### 4. Maximum Subarray (DP)
```python
def max_subarray(nums):
    max_current = max_global = nums[0]
    for num in nums[1:]:
        max_current = max(num, max_current + num)
        max_global = max(max_global, max_current)
    return max_global
```

### 5. Binary Tree Inorder Traversal
```python
def inorder_traversal(root):
    result = []
    def dfs(node):
        if node:
            dfs(node.left)
            result.append(node.val)
            dfs(node.right)
    dfs(root)
    return result
```

### 6. Graph Valid Tree (Union-Find)
```python
def valid_tree(n, edges):
    if len(edges) != n - 1:
        return False
    
    uf = UnionFind(n)
    for u, v in edges:
        if uf.find(u) == uf.find(v):
            return False  # Cycle detected
        uf.union(u, v)
    return True
```

### 7. Climbing Stairs (DP)
```python
def climb_stairs(n):
    if n <= 2:
        return n
    a, b = 1, 2
    for _ in range(3, n + 1):
        a, b = b, a + b
    return b
```

### 8. Longest Palindromic Substring
```python
def longest_palindrome(s):
    if not s:
        return ""
    
    def expand_around_center(left, right):
        while left >= 0 and right < len(s) and s[left] == s[right]:
            left -= 1
            right += 1
        return s[left+1:right]
    
    longest = ""
    for i in range(len(s)):
        # Odd length
        pal1 = expand_around_center(i, i)
        # Even length
        pal2 = expand_around_center(i, i+1)
        longest = max(longest, pal1, pal2, key=len)
    
    return longest
```

---

## Additional Resources

- **LeetCode**: Practice problems with solutions
- **GeeksforGeeks**: Comprehensive algorithm explanations
- **CLRS Book**: Introduction to Algorithms
- **Python Documentation**: https://docs.python.org/3/
- **Time Complexity Cheat Sheet**: Big O reference

---

**Happy Coding! 🚀**

*Last Updated: January 6, 2026*