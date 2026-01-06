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
- Surrounded Regions
- Course Schedule II
- Redundant Connection
- Accounts Merge
- Number of Connected Components
- Alien Dictionary
- Reconstruct Itinerary
- Minimum Height Trees
- Critical Connections in a Network
- Cheapest Flights Within K Stops
- Path with Maximum Probability
- Find the City With the Smallest Number of Neighbors
- Evaluate Division
- Optimize Water Distribution
- Bus Routes
- All Paths from Source to Target
- Shortest Path in Binary Matrix
- As Far from Land as Possible
- Making A Large Island
- Detonate the Maximum Bombs
- Find All People With Secret
- Throne Inheritance

</details>

### 8.1 Number of Islands

**Problem Statement:** Given an m x n 2D binary grid which represents a map of '1's (land) and '0's (water), return the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically.

**Input Format:** First line contains two integers m n (rows and columns). Next m lines contain n space-separated integers each.

**Intuition:** Use DFS or BFS to traverse each island, marking visited cells. Count each connected component of '1's.

**Algorithm:**
1. Initialize count = 0
2. For each cell in grid:
   - If cell == '1' and not visited, count += 1
   - DFS/BFS from this cell to mark all connected '1's as visited
3. Return count

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    void dfs(vector<vector<char>>& grid, int i, int j) {
        if (i < 0 || i >= grid.size() || j < 0 || j >= grid[0].size() || grid[i][j] == '0') return;
        grid[i][j] = '0'; // Mark as visited
        dfs(grid, i+1, j);
        dfs(grid, i-1, j);
        dfs(grid, i, j+1);
        dfs(grid, i, j-1);
    }
    
    int numIslands(vector<vector<char>>& grid) {
        int count = 0;
        for (int i = 0; i < grid.size(); ++i) {
            for (int j = 0; j < grid[0].size(); ++j) {
                if (grid[i][j] == '1') {
                    count++;
                    dfs(grid, i, j);
                }
            }
        }
        return count;
    }
};

int main() {
    int m, n;
    cin >> m >> n;
    vector<vector<char>> grid(m, vector<char>(n));
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            cin >> grid[i][j];
        }
    }
    Solution sol;
    cout << sol.numIslands(grid) << endl;
    return 0;
}
```

**Python Code:**
```python
def num_islands(grid):
    if not grid:
        return 0
    
    def dfs(i, j):
        if i < 0 or i >= len(grid) or j < 0 or j >= len(grid[0]) or grid[i][j] == '0':
            return
        grid[i][j] = '0'  # Mark as visited
        dfs(i+1, j)
        dfs(i-1, j)
        dfs(i, j+1)
        dfs(i, j-1)
    
    count = 0
    for i in range(len(grid)):
        for j in range(len(grid[0])):
            if grid[i][j] == '1':
                count += 1
                dfs(i, j)
    
    return count

if __name__ == "__main__":
    import sys
    input = sys.stdin.read
    data = input().split()
    m = int(data[0])
    n = int(data[1])
    grid = []
    idx = 2
    for i in range(m):
        row = []
        for j in range(n):
            row.append(data[idx])
            idx += 1
        grid.append(row)
    print(num_islands(grid))
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n) worst case (recursion stack)

### 8.2 Clone Graph

**Problem Statement:** Given a reference of a node in a connected undirected graph, return a deep copy (clone) of the graph.

**Intuition:** Use DFS or BFS with a hash map to track cloned nodes. When visiting a node, create its clone and recursively clone its neighbors.

**Algorithm:**
1. If node is None, return None
2. Use hash map to store original -> clone mapping
3. DFS function:
   - If node in visited, return visited[node]
   - Create clone of current node
   - Add to visited
   - For each neighbor, recursively clone and add to clone's neighbors
4. Return clone of original node

**C++ Code:**
```cpp
class Node {
public:
    int val;
    vector<Node*> neighbors;
    Node() {
        val = 0;
        neighbors = vector<Node*>();
    }
    Node(int _val) {
        val = _val;
        neighbors = vector<Node*>();
    }
    Node(int _val, vector<Node*> _neighbors) {
        val = _val;
        neighbors = _neighbors;
    }
};

class Solution {
public:
    unordered_map<Node*, Node*> visited;
    
    Node* cloneGraph(Node* node) {
        if (!node) return nullptr;
        if (visited.count(node)) return visited[node];
        
        Node* clone = new Node(node->val);
        visited[node] = clone;
        
        for (Node* neighbor : node->neighbors) {
            clone->neighbors.push_back(cloneGraph(neighbor));
        }
        
        return clone;
    }
};
```

**Python Code:**
```python
class Node:
    def __init__(self, val=0, neighbors=None):
        self.val = val
        self.neighbors = neighbors if neighbors is not None else []

def clone_graph(node):
    if not node:
        return None
    
    visited = {}
    
    def dfs(original):
        if original in visited:
            return visited[original]
        
        clone = Node(original.val)
        visited[original] = clone
        
        for neighbor in original.neighbors:
            clone.neighbors.append(dfs(neighbor))
        
        return clone
    
    return dfs(node)
```

**Complexity Analysis:**
- Time: O(V + E)
- Space: O(V)

### 8.3 Course Schedule

**Problem Statement:** There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai. Return true if you can finish all courses.

**Input Format:** First line contains two integers numCourses p (number of courses and number of prerequisites). Next p lines contain two integers ai bi (prerequisites).

**Intuition:** This is a cycle detection problem in directed graph. Use topological sort - if we can complete topological sort, no cycle exists.

**Algorithm:**
1. Build adjacency list and in-degree array
2. Use queue for nodes with in-degree 0
3. While queue not empty:
   - Dequeue node, count completed courses
   - For each neighbor, decrease in-degree
   - If in-degree becomes 0, enqueue
4. Return count == numCourses

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    bool canFinish(int numCourses, vector<vector<int>>& prerequisites) {
        vector<vector<int>> graph(numCourses);
        vector<int> inDegree(numCourses, 0);
        
        for (auto& prereq : prerequisites) {
            graph[prereq[1]].push_back(prereq[0]);
            inDegree[prereq[0]]++;
        }
        
        queue<int> q;
        for (int i = 0; i < numCourses; ++i) {
            if (inDegree[i] == 0) q.push(i);
        }
        
        int count = 0;
        while (!q.empty()) {
            int course = q.front(); q.pop();
            count++;
            
            for (int next : graph[course]) {
                inDegree[next]--;
                if (inDegree[next] == 0) q.push(next);
            }
        }
        
        return count == numCourses;
    }
};

int main() {
    int numCourses, p;
    cin >> numCourses >> p;
    vector<vector<int>> prerequisites(p, vector<int>(2));
    for (int i = 0; i < p; ++i) {
        cin >> prerequisites[i][0] >> prerequisites[i][1];
    }
    Solution sol;
    cout << (sol.canFinish(numCourses, prerequisites) ? "true" : "false") << endl;
    return 0;
}
```

**Python Code:**
```python
from collections import deque

def can_finish(num_courses, prerequisites):
    graph = [[] for _ in range(num_courses)]
    in_degree = [0] * num_courses
    
    for course, prereq in prerequisites:
        graph[prereq].append(course)
        in_degree[course] += 1
    
    queue = deque([i for i in range(num_courses) if in_degree[i] == 0])
    count = 0
    
    while queue:
        course = queue.popleft()
        count += 1
        
        for next_course in graph[course]:
            in_degree[next_course] -= 1
            if in_degree[next_course] == 0:
                queue.append(next_course)
    
    return count == num_courses

if __name__ == "__main__":
    import sys
    input = sys.stdin.read
    data = input().split()
    num_courses = int(data[0])
    p = int(data[1])
    prerequisites = []
    for i in range(p):
        prerequisites.append([int(data[2 + 2*i]), int(data[3 + 2*i])])
    print(can_finish(num_courses, prerequisites))
```

**Complexity Analysis:**
- Time: O(V + E)
- Space: O(V + E)

### 8.4 Pacific Atlantic Water Flow

**Problem Statement:** Given an m x n matrix of non-negative integers representing the height of each unit cell in a continent, the "Pacific ocean" touches the left and top edges of the matrix and the "Atlantic ocean" touches the right and bottom edges. Water can only flow in four directions (up, down, left, or right) from a cell to another one with height equal or lower. Find the list of grid coordinates where water can flow to both the Pacific and Atlantic ocean.

**Intuition:** Start from Pacific and Atlantic borders, use DFS/BFS to find cells that can reach each ocean. Intersection gives cells that can reach both.

**Algorithm:**
1. Create two visited matrices for Pacific and Atlantic
2. DFS from Pacific borders (left, top) marking reachable cells
3. DFS from Atlantic borders (right, bottom) marking reachable cells
4. Find intersection of both visited matrices
5. Return coordinates where both are true

**C++ Code:**
```cpp
class Solution {
public:
    void dfs(vector<vector<int>>& heights, vector<vector<bool>>& visited, int i, int j) {
        visited[i][j] = true;
        vector<pair<int, int>> dirs = {{0,1}, {1,0}, {0,-1}, {-1,0}};
        
        for (auto& dir : dirs) {
            int ni = i + dir.first, nj = j + dir.second;
            if (ni >= 0 && ni < heights.size() && nj >= 0 && nj < heights[0].size() 
                && !visited[ni][nj] && heights[ni][nj] >= heights[i][j]) {
                dfs(heights, visited, ni, nj);
            }
        }
    }
    
    vector<vector<int>> pacificAtlantic(vector<vector<int>>& heights) {
        int m = heights.size(), n = heights[0].size();
        vector<vector<bool>> pacific(m, vector<bool>(n, false));
        vector<vector<bool>> atlantic(m, vector<bool>(n, false));
        
        // Pacific borders
        for (int i = 0; i < m; ++i) dfs(heights, pacific, i, 0);
        for (int j = 0; j < n; ++j) dfs(heights, pacific, 0, j);
        
        // Atlantic borders
        for (int i = 0; i < m; ++i) dfs(heights, atlantic, i, n-1);
        for (int j = 0; j < n; ++j) dfs(heights, atlantic, m-1, j);
        
        vector<vector<int>> result;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (pacific[i][j] && atlantic[i][j]) {
                    result.push_back({i, j});
                }
            }
        }
        
        return result;
    }
};
```

**Python Code:**
```python
def pacific_atlantic(heights):
    if not heights:
        return []
    
    m, n = len(heights), len(heights[0])
    pacific = [[False] * n for _ in range(m)]
    atlantic = [[False] * n for _ in range(m)]
    
    def dfs(i, j, visited):
        visited[i][j] = True
        for di, dj in [(0,1), (1,0), (0,-1), (-1,0)]:
            ni, nj = i + di, j + dj
            if (0 <= ni < m and 0 <= nj < n and 
                not visited[ni][nj] and heights[ni][nj] >= heights[i][j]):
                dfs(ni, nj, visited)
    
    # Pacific
    for i in range(m):
        dfs(i, 0, pacific)
    for j in range(n):
        dfs(0, j, pacific)
    
    # Atlantic
    for i in range(m):
        dfs(i, n-1, atlantic)
    for j in range(n):
        dfs(m-1, j, atlantic)
    
    result = []
    for i in range(m):
        for j in range(n):
            if pacific[i][j] and atlantic[i][j]:
                result.append([i, j])
    
    return result
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n)

### 8.5 Word Ladder

**Problem Statement:** A transformation sequence from word beginWord to word endWord using a dictionary wordList is a sequence of words beginWord -> s1 -> s2 -> ... -> sk such that every adjacent pair of words differs by a single letter, and every si is in wordList. Return the number of words in the shortest transformation sequence, or 0 if no such sequence exists.

**Intuition:** BFS where each level represents one letter change. Use queue to explore all possible transformations at each step.

**Algorithm:**
1. If endWord not in wordList, return 0
2. Use set for wordList for O(1) lookup
3. BFS: queue contains (word, steps)
4. For each word, generate all possible transformations by changing one letter
5. If transformation in wordList and not visited, add to queue with steps+1
6. Return steps when reach endWord

**C++ Code:**
```cpp
class Solution {
public:
    int ladderLength(string beginWord, string endWord, vector<string>& wordList) {
        unordered_set<string> wordSet(wordList.begin(), wordList.end());
        if (wordSet.find(endWord) == wordSet.end()) return 0;
        
        queue<pair<string, int>> q;
        q.push({beginWord, 1});
        unordered_set<string> visited;
        visited.insert(beginWord);
        
        while (!q.empty()) {
            auto [word, steps] = q.front(); q.pop();
            
            if (word == endWord) return steps;
            
            for (int i = 0; i < word.size(); ++i) {
                string temp = word;
                for (char c = 'a'; c <= 'z'; ++c) {
                    temp[i] = c;
                    if (wordSet.count(temp) && visited.find(temp) == visited.end()) {
                        visited.insert(temp);
                        q.push({temp, steps + 1});
                    }
                }
            }
        }
        
        return 0;
    }
};
```

**Python Code:**
```python
from collections import deque

def ladder_length(begin_word, end_word, word_list):
    word_set = set(word_list)
    if end_word not in word_set:
        return 0
    
    queue = deque([(begin_word, 1)])
    visited = set([begin_word])
    
    while queue:
        word, steps = queue.popleft()
        
        if word == end_word:
            return steps
        
        for i in range(len(word)):
            for c in 'abcdefghijklmnopqrstuvwxyz':
                temp = word[:i] + c + word[i+1:]
                if temp in word_set and temp not in visited:
                    visited.add(temp)
                    queue.append((temp, steps + 1))
    
    return 0
```

**Complexity Analysis:**
- Time: O(N * 26 * L) where N = wordList size, L = word length
- Space: O(N)

### 8.6 Network Delay Time

**Problem Statement:** You are given a network of n nodes, labeled from 1 to n. You are also given times, a list of travel times as directed edges times[i] = (ui, vi, wi), where ui is the source node, vi is the target node, and wi is the time it takes for a signal to travel from source to target. We will send a signal from a given node k. Return the time it takes for all the n nodes to receive the signal. If it is impossible for all the n nodes to receive the signal, return -1.

**Input Format:** First line contains three integers n k e (nodes, source, edges). Next e lines contain three integers ui vi wi (edges with weights).

**Intuition:** Use Dijkstra's algorithm to find shortest path from source k to all nodes. The maximum distance is the answer.

**Algorithm:**
1. Build graph as adjacency list: {node: [(neighbor, time), ...]}
2. Initialize distances array with INF, distances[k-1] = 0
3. Use priority queue for Dijkstra: (time, node)
4. While queue not empty:
   - Pop smallest time node
   - For each neighbor, update distance if shorter
5. Find maximum in distances array, return -1 if any INF

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int networkDelayTime(vector<vector<int>>& times, int n, int k) {
        vector<vector<pair<int, int>>> graph(n + 1);
        for (auto& time : times) {
            graph[time[0]].push_back({time[1], time[2]});
        }
        
        vector<int> dist(n + 1, INT_MAX);
        dist[k] = 0;
        
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.push({0, k});
        
        while (!pq.empty()) {
            auto [time, node] = pq.top(); pq.pop();
            
            if (time > dist[node]) continue;
            
            for (auto& [neighbor, weight] : graph[node]) {
                int newTime = time + weight;
                if (newTime < dist[neighbor]) {
                    dist[neighbor] = newTime;
                    pq.push({newTime, neighbor});
                }
            }
        }
        
        int maxTime = 0;
        for (int i = 1; i <= n; ++i) {
            if (dist[i] == INT_MAX) return -1;
            maxTime = max(maxTime, dist[i]);
        }
        
        return maxTime;
    }
};

int main() {
    int n, k, e;
    cin >> n >> k >> e;
    vector<vector<int>> times(e, vector<int>(3));
    for (int i = 0; i < e; ++i) {
        cin >> times[i][0] >> times[i][1] >> times[i][2];
    }
    Solution sol;
    cout << sol.networkDelayTime(times, n, k) << endl;
    return 0;
}
```

**Python Code:**
```python
import heapq

def network_delay_time(times, n, k):
    graph = [[] for _ in range(n + 1)]
    for u, v, w in times:
        graph[u].append((v, w))
    
    dist = [float('inf')] * (n + 1)
    dist[k] = 0
    
    pq = [(0, k)]  # (time, node)
    
    while pq:
        time, node = heapq.heappop(pq)
        
        if time > dist[node]:
            continue
        
        for neighbor, weight in graph[node]:
            new_time = time + weight
            if new_time < dist[neighbor]:
                dist[neighbor] = new_time
                heapq.heappush(pq, (new_time, neighbor))
    
    max_time = max(dist[1:])
    return max_time if max_time != float('inf') else -1

if __name__ == "__main__":
    import sys
    input = sys.stdin.read
    data = input().split()
    n = int(data[0])
    k = int(data[1])
    e = int(data[2])
    times = []
    for i in range(e):
        times.append([int(data[3 + 3*i]), int(data[4 + 3*i]), int(data[5 + 3*i])])
    print(network_delay_time(times, n, k))
```

**Complexity Analysis:**
- Time: O((V + E) log V)
- Space: O(V + E)

### 8.7 Graph Valid Tree

**Problem Statement:** Given n nodes labeled from 0 to n-1 and a list of undirected edges, check whether these edges make up a valid tree.

**Intuition:** A graph is a tree if it's connected and has no cycles. Use Union-Find to check for cycles and ensure all nodes are connected.

**Algorithm:**
1. If edges.size() != n-1, return false (tree property)
2. Initialize Union-Find with n nodes
3. For each edge [u,v]:
   - If find(u) == find(v), cycle exists, return false
   - Union(u, v)
4. Check if all nodes have same parent (connected)
5. Return true

**C++ Code:**
```cpp
class UnionFind {
public:
    vector<int> parent, rank;
    UnionFind(int size) {
        parent.resize(size);
        rank.resize(size, 0);
        for (int i = 0; i < size; ++i) parent[i] = i;
    }
    
    int find(int x) {
        if (parent[x] != x) parent[x] = find(parent[x]);
        return parent[x];
    }
    
    bool unite(int x, int y) {
        int px = find(x), py = find(y);
        if (px == py) return false;
        if (rank[px] < rank[py]) parent[px] = py;
        else if (rank[px] > rank[py]) parent[py] = px;
        else {
            parent[py] = px;
            rank[px]++;
        }
        return true;
    }
};

class Solution {
public:
    bool validTree(int n, vector<vector<int>>& edges) {
        if (edges.size() != n - 1) return false;
        
        UnionFind uf(n);
        for (auto& edge : edges) {
            if (!uf.unite(edge[0], edge[1])) return false;
        }
        
        return true;
    }
};
```

**Python Code:**
```python
class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))
        self.rank = [0] * size
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]
    
    def unite(self, x, y):
        px, py = self.find(x), self.find(y)
        if px == py:
            return False
        if self.rank[px] < self.rank[py]:
            self.parent[px] = py
        elif self.rank[px] > self.rank[py]:
            self.parent[py] = px
        else:
            self.parent[py] = px
            self.rank[px] += 1
        return True

def valid_tree(n, edges):
    if len(edges) != n - 1:
        return False
    
    uf = UnionFind(n)
    for u, v in edges:
        if not uf.unite(u, v):
            return False
    
    return True
```

**Complexity Analysis:**
- Time: O(V + E α(V)) where α is inverse Ackermann function
- Space: O(V)

### 8.8 Surrounded Regions

**Problem Statement:** Given an m x n matrix board containing 'X' and 'O', capture all regions that are 4-directionally surrounded by 'X'. A region is captured by flipping all 'O's into 'X's in that surrounded region.

**Intuition:** Any 'O' connected to boundary cannot be surrounded. Use DFS/BFS from boundary 'O's to mark safe regions, then flip unmarked 'O's to 'X'.

**Algorithm:**
1. For each boundary cell:
   - If 'O', DFS/BFS to mark all connected 'O's as safe (use 'S')
2. Iterate through board:
   - 'O' -> 'X' (surrounded)
   - 'S' -> 'O' (safe)
3. Return modified board

**C++ Code:**
```cpp
class Solution {
public:
    void dfs(vector<vector<char>>& board, int i, int j) {
        if (i < 0 || i >= board.size() || j < 0 || j >= board[0].size() || board[i][j] != 'O') return;
        board[i][j] = 'S'; // Safe
        dfs(board, i+1, j);
        dfs(board, i-1, j);
        dfs(board, i, j+1);
        dfs(board, i, j-1);
    }
    
    void solve(vector<vector<char>>& board) {
        if (board.empty()) return;
        int m = board.size(), n = board[0].size();
        
        // Mark boundary 'O's as safe
        for (int i = 0; i < m; ++i) {
            dfs(board, i, 0);
            dfs(board, i, n-1);
        }
        for (int j = 0; j < n; ++j) {
            dfs(board, 0, j);
            dfs(board, m-1, j);
        }
        
        // Flip regions
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (board[i][j] == 'O') board[i][j] = 'X';
                else if (board[i][j] == 'S') board[i][j] = 'O';
            }
        }
    }
};
```

**Python Code:**
```python
def solve(board):
    if not board:
        return
    
    m, n = len(board), len(board[0])
    
    def dfs(i, j):
        if i < 0 or i >= m or j < 0 or j >= n or board[i][j] != 'O':
            return
        board[i][j] = 'S'  # Safe
        dfs(i+1, j)
        dfs(i-1, j)
        dfs(i, j+1)
        dfs(i, j-1)
    
    # Mark boundary 'O's as safe
    for i in range(m):
        dfs(i, 0)
        dfs(i, n-1)
    for j in range(n):
        dfs(0, j)
        dfs(m-1, j)
    
    # Flip regions
    for i in range(m):
        for j in range(n):
            if board[i][j] == 'O':
                board[i][j] = 'X'
            elif board[i][j] == 'S':
                board[i][j] = 'O'
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n) worst case (recursion stack)

### 8.9 Course Schedule II

**Problem Statement:** There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai. Return the ordering of courses you should take to finish all courses. If there are many valid answers, return any of them. If it is impossible to finish all courses, return an empty array.

**Intuition:** Use topological sort with Kahn's algorithm. Build graph and in-degree array, then process nodes with in-degree 0.

**Algorithm:**
1. Build adjacency list and in-degree array
2. Initialize queue with nodes having in-degree 0
3. While queue not empty:
   - Dequeue node, add to result
   - For each neighbor, decrease in-degree
   - If in-degree becomes 0, enqueue
4. If result size == numCourses, return result, else []

**C++ Code:**
```cpp
class Solution {
public:
    vector<int> findOrder(int numCourses, vector<vector<int>>& prerequisites) {
        vector<vector<int>> graph(numCourses);
        vector<int> inDegree(numCourses, 0);
        
        for (auto& prereq : prerequisites) {
            graph[prereq[1]].push_back(prereq[0]);
            inDegree[prereq[0]]++;
        }
        
        queue<int> q;
        for (int i = 0; i < numCourses; ++i) {
            if (inDegree[i] == 0) q.push(i);
        }
        
        vector<int> result;
        while (!q.empty()) {
            int course = q.front(); q.pop();
            result.push_back(course);
            
            for (int next : graph[course]) {
                inDegree[next]--;
                if (inDegree[next] == 0) q.push(next);
            }
        }
        
        return result.size() == numCourses ? result : vector<int>();
    }
};
```

**Python Code:**
```python
from collections import deque

def find_order(num_courses, prerequisites):
    graph = [[] for _ in range(num_courses)]
    in_degree = [0] * num_courses
    
    for course, prereq in prerequisites:
        graph[prereq].append(course)
        in_degree[course] += 1
    
    queue = deque([i for i in range(num_courses) if in_degree[i] == 0])
    result = []
    
    while queue:
        course = queue.popleft()
        result.append(course)
        
        for next_course in graph[course]:
            in_degree[next_course] -= 1
            if in_degree[next_course] == 0:
                queue.append(next_course)
    
    return result if len(result) == num_courses else []
```

**Complexity Analysis:**
- Time: O(V + E)
- Space: O(V + E)

### 8.10 Redundant Connection

**Problem Statement:** In this problem, a tree is an undirected graph that is connected and has no cycles. You are given a graph that started as a tree with n nodes labeled from 1 to n, with one additional edge added. The added edge has two different vertices chosen from 1 to n, and was not an edge that already existed. The graph is represented as an array edges of length n where edges[i] = [ai, bi] indicates that there is an edge between nodes ai and bi in the graph. Return an edge that can be removed so that the resulting graph is a tree of n nodes.

**Intuition:** Use Union-Find. The redundant edge is the first edge that connects two nodes already in the same component.

**Algorithm:**
1. Initialize Union-Find with n+1 nodes
2. For each edge [u,v]:
   - If find(u) == find(v), this is redundant edge, return it
   - Else, union(u, v)
3. Return last edge (shouldn't reach here for valid input)

**C++ Code:**
```cpp
class UnionFind {
public:
    vector<int> parent;
    UnionFind(int size) {
        parent.resize(size);
        for (int i = 0; i < size; ++i) parent[i] = i;
    }
    
    int find(int x) {
        if (parent[x] != x) parent[x] = find(parent[x]);
        return parent[x];
    }
    
    bool unite(int x, int y) {
        int px = find(x), py = find(y);
        if (px == py) return false;
        parent[px] = py;
        return true;
    }
};

class Solution {
public:
    vector<int> findRedundantConnection(vector<vector<int>>& edges) {
        UnionFind uf(edges.size() + 1);
        
        for (auto& edge : edges) {
            if (!uf.unite(edge[0], edge[1])) {
                return edge;
            }
        }
        
        return {};
    }
};
```

**Python Code:**
```python
class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]
    
    def unite(self, x, y):
        px, py = self.find(x), self.find(y)
        if px == py:
            return False
        self.parent[px] = py
        return True

def find_redundant_connection(edges):
    uf = UnionFind(len(edges) + 1)
    
    for u, v in edges:
        if not uf.unite(u, v):
            return [u, v]
    
    return []
```

**Complexity Analysis:**
- Time: O(V + E α(V))
- Space: O(V)

### 8.11 Accounts Merge

**Problem Statement:** Given a list of accounts where each element accounts[i] is a list of strings, where the first element accounts[i][0] is a name, and the rest of the elements are emails representing emails of the account. Now, we would like to merge these accounts. Two accounts definitely belong to the same person if there is some common email to both accounts. Note that even if two accounts have the same name, they may belong to different people as people could have the same name. A person can have any number of accounts initially, but all of them have the same name. After merging the accounts, return the accounts in the following format: the first element of each account is the name, and the rest of the elements are emails in sorted order.

**Intuition:** Use Union-Find where each email is a node. Group emails that belong to same account, then merge accounts with common emails.

**Algorithm:**
1. Create email -> name mapping and email -> index mapping
2. Initialize Union-Find with number of unique emails
3. For each account, union all emails in the account
4. Group emails by their root parent
5. For each group, create account with name and sorted emails
6. Return merged accounts

**C++ Code:**
```cpp
class UnionFind {
public:
    vector<int> parent;
    UnionFind(int size) {
        parent.resize(size);
        for (int i = 0; i < size; ++i) parent[i] = i;
    }
    
    int find(int x) {
        if (parent[x] != x) parent[x] = find(parent[x]);
        return parent[x];
    }
    
    void unite(int x, int y) {
        int px = find(x), py = find(y);
        if (px != py) parent[px] = py;
    }
};

class Solution {
public:
    vector<vector<string>> accountsMerge(vector<vector<string>>& accounts) {
        unordered_map<string, string> emailToName;
        unordered_map<string, int> emailToId;
        int id = 0;
        
        for (auto& account : accounts) {
            string name = account[0];
            for (int i = 1; i < account.size(); ++i) {
                string email = account[i];
                emailToName[email] = name;
                if (emailToId.find(email) == emailToId.end()) {
                    emailToId[email] = id++;
                }
            }
        }
        
        UnionFind uf(id);
        
        for (auto& account : accounts) {
            int firstId = emailToId[account[1]];
            for (int i = 2; i < account.size(); ++i) {
                uf.unite(firstId, emailToId[account[i]]);
            }
        }
        
        unordered_map<int, vector<string>> groups;
        for (auto& p : emailToId) {
            int root = uf.find(p.second);
            groups[root].push_back(p.first);
        }
        
        vector<vector<string>> result;
        for (auto& p : groups) {
            vector<string> account = {emailToName[p.second[0]]};
            sort(p.second.begin(), p.second.end());
            account.insert(account.end(), p.second.begin(), p.second.end());
            result.push_back(account);
        }
        
        return result;
    }
};
```

**Python Code:**
```python
class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]
    
    def unite(self, x, y):
        px, py = self.find(x), self.find(y)
        if px != py:
            self.parent[px] = py

def accounts_merge(accounts):
    email_to_name = {}
    email_to_id = {}
    id_counter = 0
    
    for account in accounts:
        name = account[0]
        for email in account[1:]:
            email_to_name[email] = name
            if email not in email_to_id:
                email_to_id[email] = id_counter
                id_counter += 1
    
    uf = UnionFind(id_counter)
    
    for account in accounts:
        first_id = email_to_id[account[1]]
        for email in account[2:]:
            uf.unite(first_id, email_to_id[email])
    
    groups = {}
    for email, id_val in email_to_id.items():
        root = uf.find(id_val)
        if root not in groups:
            groups[root] = []
        groups[root].append(email)
    
    result = []
    for emails in groups.values():
        name = email_to_name[emails[0]]
        result.append([name] + sorted(emails))
    
    return result
```

**Complexity Analysis:**
- Time: O(N log N) where N is total emails
- Space: O(N)

### 8.12 Number of Connected Components

**Problem Statement:** Given n nodes labeled from 0 to n-1 and a list of undirected edges, write a function to find the number of connected components in an undirected graph.

**Intuition:** Use Union-Find or DFS/BFS to count connected components. Each time we start a new traversal from unvisited node, increment count.

**Algorithm:**
1. Build adjacency list
2. Initialize visited array and count = 0
3. For each node:
   - If not visited, count += 1, DFS/BFS from this node
4. Return count

**C++ Code:**
```cpp
class Solution {
public:
    void dfs(vector<vector<int>>& graph, vector<bool>& visited, int node) {
        visited[node] = true;
        for (int neighbor : graph[node]) {
            if (!visited[neighbor]) {
                dfs(graph, visited, neighbor);
            }
        }
    }
    
    int countComponents(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }
        
        vector<bool> visited(n, false);
        int count = 0;
        
        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                count++;
                dfs(graph, visited, i);
            }
        }
        
        return count;
    }
};
```

**Python Code:**
```python
def count_components(n, edges):
    graph = [[] for _ in range(n)]
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)
    
    visited = [False] * n
    count = 0
    
    def dfs(node):
        visited[node] = True
        for neighbor in graph[node]:
            if not visited[neighbor]:
                dfs(neighbor)
    
    for i in range(n):
        if not visited[i]:
            count += 1
            dfs(i)
    
    return count
```

**Complexity Analysis:**
- Time: O(V + E)
- Space: O(V + E)

### 8.13 Alien Dictionary

**Problem Statement:** There is a new alien language that uses the English alphabet. However, the order among the letters is unknown to you. You are given a list of strings words from the alien language's dictionary, where the strings in words are sorted lexicographically by the rules of this new language. Derive the order of letters in this language, and return it as a string. If there is no valid ordering, return "".

**Intuition:** Build graph where edge A->B means A comes before B. Use topological sort to find the order.

**Algorithm:**
1. Build graph and in-degree for each character
2. For consecutive words, find first differing character, add edge
3. Use Kahn's algorithm for topological sort
4. If result length == unique characters, return order, else ""

**C++ Code:**
```cpp
class Solution {
public:
    string alienOrder(vector<string>& words) {
        unordered_map<char, vector<char>> graph;
        unordered_map<char, int> inDegree;
        
        // Initialize all characters
        for (auto& word : words) {
            for (char c : word) {
                if (graph.find(c) == graph.end()) {
                    graph[c] = {};
                    inDegree[c] = 0;
                }
            }
        }
        
        // Build graph
        for (int i = 0; i < words.size() - 1; ++i) {
            string w1 = words[i], w2 = words[i+1];
            int len = min(w1.size(), w2.size());
            bool found = false;
            
            for (int j = 0; j < len; ++j) {
                if (w1[j] != w2[j]) {
                    graph[w1[j]].push_back(w2[j]);
                    inDegree[w2[j]]++;
                    found = true;
                    break;
                }
            }
            
            if (!found && w1.size() > w2.size()) return "";
        }
        
        // Topological sort
        queue<char> q;
        for (auto& p : inDegree) {
            if (p.second == 0) q.push(p.first);
        }
        
        string result;
        while (!q.empty()) {
            char c = q.front(); q.pop();
            result += c;
            
            for (char next : graph[c]) {
                inDegree[next]--;
                if (inDegree[next] == 0) q.push(next);
            }
        }
        
        return result.size() == graph.size() ? result : "";
    }
};
```

**Python Code:**
```python
from collections import deque, defaultdict

def alien_order(words):
    graph = defaultdict(list)
    in_degree = {}
    
    # Initialize all characters
    for word in words:
        for c in word:
            if c not in in_degree:
                in_degree[c] = 0
    
    # Build graph
    for i in range(len(words) - 1):
        w1, w2 = words[i], words[i+1]
        min_len = min(len(w1), len(w2))
        found = False
        
        for j in range(min_len):
            if w1[j] != w2[j]:
                if w2[j] not in graph[w1[j]]:
                    graph[w1[j]].append(w2[j])
                    in_degree[w2[j]] += 1
                found = True
                break
        
        if not found and len(w1) > len(w2):
            return ""
    
    # Topological sort
    queue = deque([c for c in in_degree if in_degree[c] == 0])
    result = []
    
    while queue:
        c = queue.popleft()
        result.append(c)
        
        for next_c in graph[c]:
            in_degree[next_c] -= 1
            if in_degree[next_c] == 0:
                queue.append(next_c)
    
    return ''.join(result) if len(result) == len(in_degree) else ""
```

**Complexity Analysis:**
- Time: O(C + E) where C is total characters
- Space: O(C)

### 8.14 Reconstruct Itinerary

**Problem Statement:** You are given a list of airline tickets where tickets[i] = [fromi, toi] represent the departure and the arrival airports of one flight. Reconstruct the itinerary in order and return it. All of the tickets belong to a man who departs from "JFK", so the itinerary must begin with "JFK". If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string.

**Intuition:** Use Eulerian path in directed graph. Use DFS with backtracking, choosing smallest lexical destination first.

**Algorithm:**
1. Build graph as adjacency list with multiset for destinations
2. DFS from "JFK", adding destinations to result in reverse order
3. Sort destinations for lexical order
4. Return reversed result

**C++ Code:**
```cpp
class Solution {
public:
    void dfs(string airport, unordered_map<string, multiset<string>>& graph, vector<string>& result) {
        while (!graph[airport].empty()) {
            string next = *graph[airport].begin();
            graph[airport].erase(graph[airport].begin());
            dfs(next, graph, result);
        }
        result.push_back(airport);
    }
    
    vector<string> findItinerary(vector<vector<string>>& tickets) {
        unordered_map<string, multiset<string>> graph;
        for (auto& ticket : tickets) {
            graph[ticket[0]].insert(ticket[1]);
        }
        
        vector<string> result;
        dfs("JFK", graph, result);
        reverse(result.begin(), result.end());
        
        return result;
    }
};
```

**Python Code:**
```python
from collections import defaultdict

def find_itinerary(tickets):
    graph = defaultdict(list)
    for src, dst in tickets:
        graph[src].append(dst)
    
    # Sort destinations for lexical order
    for src in graph:
        graph[src].sort(reverse=True)
    
    result = []
    
    def dfs(airport):
        while graph[airport]:
            dfs(graph[airport].pop())
        result.append(airport)
    
    dfs("JFK")
    return result[::-1]
```

**Complexity Analysis:**
- Time: O(E log E) for sorting
- Space: O(V + E)

### 8.15 Minimum Height Trees

**Problem Statement:** A tree is an undirected graph in which any two vertices are connected by exactly one path. In other words, any connected graph without simple cycles is a tree. Given a tree of n nodes labelled from 0 to n-1, and an array of n-1 edges where edges[i] = [ai, bi] indicates that there is an undirected edge between the two nodes ai and bi in the tree, you can choose any node of the tree as the root. When you select a node x as the root, the result tree has height h. Among all possible rooted trees, those with minimum height (i.e. min h) are called minimum height trees (MHTs). Return a list of all MHTs' root labels. You can return the answer in any order.

**Intuition:** The root of MHT is the center of the tree. Use topological sort to peel leaves layer by layer until 1 or 2 nodes remain.

**Algorithm:**
1. Build adjacency list
2. Find all leaves (nodes with degree 1)
3. While more than 2 nodes remain:
   - Remove current leaves
   - Update degrees of neighbors
   - Add new leaves to queue
4. Return remaining nodes

**C++ Code:**
```cpp
class Solution {
public:
    vector<int> findMinHeightTrees(int n, vector<vector<int>>& edges) {
        if (n == 1) return {0};
        
        vector<vector<int>> graph(n);
        vector<int> degree(n, 0);
        
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
            degree[edge[0]]++;
            degree[edge[1]]++;
        }
        
        queue<int> leaves;
        for (int i = 0; i < n; ++i) {
            if (degree[i] == 1) leaves.push(i);
        }
        
        int remaining = n;
        while (remaining > 2) {
            int size = leaves.size();
            remaining -= size;
            
            for (int i = 0; i < size; ++i) {
                int leaf = leaves.front(); leaves.pop();
                
                for (int neighbor : graph[leaf]) {
                    degree[neighbor]--;
                    if (degree[neighbor] == 1) {
                        leaves.push(neighbor);
                    }
                }
            }
        }
        
        vector<int> result;
        while (!leaves.empty()) {
            result.push_back(leaves.front());
            leaves.pop();
        }
        
        return result;
    }
};
```

**Python Code:**
```python
from collections import deque

def find_min_height_trees(n, edges):
    if n == 1:
        return [0]
    
    graph = [[] for _ in range(n)]
    degree = [0] * n
    
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)
        degree[u] += 1
        degree[v] += 1
    
    leaves = deque([i for i in range(n) if degree[i] == 1])
    remaining = n
    
    while remaining > 2:
        size = len(leaves)
        remaining -= size
        
        for _ in range(size):
            leaf = leaves.popleft()
            for neighbor in graph[leaf]:
                degree[neighbor] -= 1
                if degree[neighbor] == 1:
                    leaves.append(neighbor)
    
    return list(leaves)
```

**Complexity Analysis:**
- Time: O(V + E)
- Space: O(V + E)

### 8.16 Critical Connections in a Network

**Problem Statement:** There are n servers numbered from 0 to n-1 connected by undirected server-to-server connections forming a network where connections[i] = [ai, bi] represents a connection between servers ai and bi. Any server can reach any other server directly or indirectly through the network. A critical connection is a connection that, if removed, will make some server unable to reach some other server. Return all critical connections in the network in any order.

**Intuition:** Use Tarjan's algorithm to find bridges. Keep track of discovery time and low time for each node.

**Algorithm:**
1. Build adjacency list
2. DFS with discovery time and low time
3. For each edge u-v:
   - If low[v] > disc[u], it's a bridge
4. Return all bridges

**C++ Code:**
```cpp
class Solution {
public:
    int time = 0;
    vector<vector<int>> bridges;
    
    void dfs(int u, int parent, vector<vector<int>>& graph, vector<int>& disc, vector<int>& low, vector<bool>& visited) {
        visited[u] = true;
        disc[u] = low[u] = time++;
        
        for (int v : graph[u]) {
            if (v == parent) continue;
            
            if (!visited[v]) {
                dfs(v, u, graph, disc, low, visited);
                low[u] = min(low[u], low[v]);
                
                if (low[v] > disc[u]) {
                    bridges.push_back({u, v});
                }
            } else {
                low[u] = min(low[u], disc[v]);
            }
        }
    }
    
    vector<vector<int>> criticalConnections(int n, vector<vector<int>>& connections) {
        vector<vector<int>> graph(n);
        for (auto& conn : connections) {
            graph[conn[0]].push_back(conn[1]);
            graph[conn[1]].push_back(conn[0]);
        }
        
        vector<int> disc(n, -1), low(n, -1);
        vector<bool> visited(n, false);
        
        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                dfs(i, -1, graph, disc, low, visited);
            }
        }
        
        return bridges;
    }
};
```

**Python Code:**
```python
def critical_connections(n, connections):
    graph = [[] for _ in range(n)]
    for u, v in connections:
        graph[u].append(v)
        graph[v].append(u)
    
    disc = [-1] * n
    low = [-1] * n
    visited = [False] * n
    time = 0
    bridges = []
    
    def dfs(u, parent):
        nonlocal time
        visited[u] = True
        disc[u] = low[u] = time
        time += 1
        
        for v in graph[u]:
            if v == parent:
                continue
            
            if not visited[v]:
                dfs(v, u)
                low[u] = min(low[u], low[v])
                
                if low[v] > disc[u]:
                    bridges.append([u, v])
            else:
                low[u] = min(low[u], disc[v])
    
    for i in range(n):
        if not visited[i]:
            dfs(i, -1)
    
    return bridges
```

**Complexity Analysis:**
- Time: O(V + E)
- Space: O(V + E)

### 8.17 Cheapest Flights Within K Stops

**Problem Statement:** There are n cities connected by some number of flights. You are given an array flights where flights[i] = [fromi, toi, pricei] indicates that there is a flight from city fromi to city toi with cost pricei. You are also given three integers src, dst, and k, return the cheapest price from src to dst with at most k stops. If there is no such route, return -1.

**Intuition:** Modified Dijkstra with stops constraint. Use priority queue with (cost, city, stops).

**Algorithm:**
1. Build graph as adjacency list
2. Priority queue: (cost, city, stops)
3. dist[city] tracks minimum cost to reach city
4. If stops <= k and cost < dist[city], update and continue
5. Return dist[dst] or -1

**C++ Code:**
```cpp
class Solution {
public:
    int findCheapestPrice(int n, vector<vector<int>>& flights, int src, int dst, int k) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& flight : flights) {
            graph[flight[0]].push_back({flight[1], flight[2]});
        }
        
        vector<int> dist(n, INT_MAX);
        dist[src] = 0;
        
        // priority queue: (cost, city, stops)
        using T = tuple<int, int, int>;
        priority_queue<T, vector<T>, greater<T>> pq;
        pq.push({0, src, 0});
        
        while (!pq.empty()) {
            auto [cost, city, stops] = pq.top(); pq.pop();
            
            if (city == dst) return cost;
            if (stops > k) continue;
            
            for (auto& [next, price] : graph[city]) {
                int newCost = cost + price;
                if (newCost < dist[next]) {
                    dist[next] = newCost;
                    pq.push({newCost, next, stops + 1});
                }
            }
        }
        
        return -1;
    }
};
```

**Python Code:**
```python
import heapq

def find_cheapest_price(n, flights, src, dst, k):
    graph = [[] for _ in range(n)]
    for u, v, price in flights:
        graph[u].append((v, price))
    
    dist = [float('inf')] * n
    dist[src] = 0
    
    # (cost, city, stops)
    pq = [(0, src, 0)]
    
    while pq:
        cost, city, stops = heapq.heappop(pq)
        
        if city == dst:
            return cost
        if stops > k:
            continue
        
        for next_city, price in graph[city]:
            new_cost = cost + price
            if new_cost < dist[next_city]:
                dist[next_city] = new_cost
                heapq.heappush(pq, (new_cost, next_city, stops + 1))
    
    return -1
```

**Complexity Analysis:**
- Time: O((V + E) log V)
- Space: O(V + E)

### 8.18 Path with Maximum Probability

**Problem Statement:** You are given an undirected graph with n nodes (0-indexed) and m edges, where each edge has a probability of success. You start at node 0 and need to reach node n-1, and you want to find the path with the maximum probability of success. Return the probability of the path with the maximum probability, or 0 if no path exists.

**Intuition:** Use Dijkstra with maximum probability instead of minimum distance. Use priority queue with probability.

**Algorithm:**
1. Build graph with probabilities
2. Priority queue: (probability, node)
3. prob[node] tracks maximum probability to reach node
4. Update if higher probability found
5. Return prob[n-1]

**C++ Code:**
```cpp
class Solution {
public:
    double maxProbability(int n, vector<vector<int>>& edges, vector<double>& succProb, int start, int end) {
        vector<vector<pair<int, double>>> graph(n);
        for (int i = 0; i < edges.size(); ++i) {
            int u = edges[i][0], v = edges[i][1];
            double p = succProb[i];
            graph[u].push_back({v, p});
            graph[v].push_back({u, p});
        }
        
        vector<double> prob(n, 0.0);
        prob[start] = 1.0;
        
        // priority queue: (probability, node)
        using T = pair<double, int>;
        priority_queue<T> pq;
        pq.push({1.0, start});
        
        while (!pq.empty()) {
            auto [currProb, node] = pq.top(); pq.pop();
            
            if (currProb < prob[node]) continue;
            
            for (auto& [next, edgeProb] : graph[node]) {
                double newProb = currProb * edgeProb;
                if (newProb > prob[next]) {
                    prob[next] = newProb;
                    pq.push({newProb, next});
                }
            }
        }
        
        return prob[end];
    }
};
```

**Python Code:**
```python
import heapq

def max_probability(n, edges, succ_prob, start, end):
    graph = [[] for _ in range(n)]
    for i, (u, v) in enumerate(edges):
        p = succ_prob[i]
        graph[u].append((v, p))
        graph[v].append((u, p))
    
    prob = [0.0] * n
    prob[start] = 1.0
    
    # (probability, node) - max heap
    pq = [(-1.0, start)]
    
    while pq:
        curr_prob, node = heapq.heappop(pq)
        curr_prob = -curr_prob
        
        if curr_prob < prob[node]:
            continue
        
        for next_node, edge_prob in graph[node]:
            new_prob = curr_prob * edge_prob
            if new_prob > prob[next_node]:
                prob[next_node] = new_prob
                heapq.heappush(pq, (-new_prob, next_node))
    
    return prob[end]
```

**Complexity Analysis:**
- Time: O((V + E) log V)
- Space: O(V + E)

### 8.19 Find the City With the Smallest Number of Neighbors

**Problem Statement:** There are n cities numbered from 0 to n-1. Given the array edges where edges[i] = [fromi, toi, weighti] represents a bidirectional and weighted edge between cities fromi and toi, and given the integer distanceThreshold. A city is reachable from another city if the total distance of the path between them is at most distanceThreshold. Return the city with the smallest number of cities that are reachable through some path and whose distance is at most distanceThreshold, If there are multiple answers, return the city with the greatest number.

**Intuition:** For each city, run Dijkstra to count cities within distance threshold. Track city with minimum count.

**Algorithm:**
1. Build graph
2. For each city as source:
   - Run Dijkstra to find distances
   - Count cities with distance <= threshold
3. Track city with minimum count (break ties by largest city number)
4. Return that city

**C++ Code:**
```cpp
class Solution {
public:
    int findTheCity(int n, vector<vector<int>>& edges, int distanceThreshold) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back({edge[1], edge[2]});
            graph[edge[1]].push_back({edge[0], edge[2]});
        }
        
        auto dijkstra = [&](int start) {
            vector<int> dist(n, INT_MAX);
            dist[start] = 0;
            priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
            pq.push({0, start});
            
            while (!pq.empty()) {
                auto [cost, node] = pq.top(); pq.pop();
                if (cost > dist[node]) continue;
                
                for (auto& [next, weight] : graph[node]) {
                    int newCost = cost + weight;
                    if (newCost < dist[next]) {
                        dist[next] = newCost;
                        pq.push({newCost, next});
                    }
                }
            }
            
            int count = 0;
            for (int d : dist) {
                if (d <= distanceThreshold) count++;
            }
            return count;
        };
        
        int minCount = INT_MAX, result = -1;
        for (int i = 0; i < n; ++i) {
            int count = dijkstra(i);
            if (count <= minCount) {
                minCount = count;
                result = i;
            }
        }
        
        return result;
    }
};
```

**Python Code:**
```python
import heapq

def find_the_city(n, edges, distance_threshold):
    graph = [[] for _ in range(n)]
    for u, v, w in edges:
        graph[u].append((v, w))
        graph[v].append((u, w))
    
    def dijkstra(start):
        dist = [float('inf')] * n
        dist[start] = 0
        pq = [(0, start)]
        
        while pq:
            cost, node = heapq.heappop(pq)
            if cost > dist[node]:
                continue
            
            for next_node, weight in graph[node]:
                new_cost = cost + weight
                if new_cost < dist[next_node]:
                    dist[next_node] = new_cost
                    heapq.heappush(pq, (new_cost, next_node))
        
        count = sum(1 for d in dist if d <= distance_threshold)
        return count
    
    min_count = float('inf')
    result = -1
    
    for i in range(n):
        count = dijkstra(i)
        if count <= min_count:
            min_count = count
            result = i
    
    return result
```

**Complexity Analysis:**
- Time: O(n * (V + E) log V)
- Space: O(V + E)

### 8.20 Evaluate Division

**Problem Statement:** You are given an array of variable pairs equations and an array of real numbers values, where equations[i] = [Ai, Bi] and values[i] represent the equation Ai / Bi = values[i]. You are also given some queries, where queries[j] = [Cj, Dj] represents the jth query to find the answer for Cj / Dj = ?. Return the answers to all queries. If a single answer cannot be determined, return -1.0.

**Intuition:** Build graph where variables are nodes and division relationships are weighted edges. Use DFS/BFS to find paths between query variables.

**Algorithm:**
1. Build graph with bidirectional edges (A->B: val, B->A: 1/val)
2. For each query [C,D]:
   - If C or D not in graph, return -1
   - DFS from C to D, multiplying edge weights
3. Return results

**C++ Code:**
```cpp
class Solution {
public:
    double dfs(string start, string end, unordered_map<string, vector<pair<string, double>>>& graph, unordered_set<string>& visited) {
        if (start == end) return 1.0;
        visited.insert(start);
        
        for (auto& [next, val] : graph[start]) {
            if (visited.find(next) == visited.end()) {
                double res = dfs(next, end, graph, visited);
                if (res != -1.0) return res * val;
            }
        }
        
        return -1.0;
    }
    
    vector<double> calcEquation(vector<vector<string>>& equations, vector<double>& values, vector<vector<string>>& queries) {
        unordered_map<string, vector<pair<string, double>>> graph;
        
        for (int i = 0; i < equations.size(); ++i) {
            string a = equations[i][0], b = equations[i][1];
            double val = values[i];
            graph[a].push_back({b, val});
            graph[b].push_back({a, 1.0 / val});
        }
        
        vector<double> result;
        for (auto& query : queries) {
            string start = query[0], end = query[1];
            if (graph.find(start) == graph.end() || graph.find(end) == graph.end()) {
                result.push_back(-1.0);
            } else {
                unordered_set<string> visited;
                result.push_back(dfs(start, end, graph, visited));
            }
        }
        
        return result;
    }
};
```

**Python Code:**
```python
def calc_equation(equations, values, queries):
    graph = {}
    
    for (a, b), val in zip(equations, values):
        if a not in graph:
            graph[a] = []
        if b not in graph:
            graph[b] = []
        graph[a].append((b, val))
        graph[b].append((a, 1.0 / val))
    
    def dfs(start, end, visited):
        if start == end:
            return 1.0
        visited.add(start)
        
        for next_node, val in graph.get(start, []):
            if next_node not in visited:
                res = dfs(next_node, end, visited)
                if res != -1.0:
                    return res * val
        
        return -1.0
    
    result = []
    for start, end in queries:
        if start not in graph or end not in graph:
            result.append(-1.0)
        else:
            visited = set()
            result.append(dfs(start, end, visited))
    
    return result
```

**Complexity Analysis:**
- Time: O(Q * (V + E))
- Space: O(V + E)

### 8.21 Optimize Water Distribution

**Problem Statement:** There are n houses in a village. We want to supply water for all the houses by building wells and laying pipes between the houses. For each house i, we can either build a well inside it directly with cost wells[i-1], or pipe in water from another house with the cost of the pipe between them. Return the minimum total cost to supply water to all houses.

**Intuition:** This is a minimum spanning tree problem. Treat wells as edges from a virtual node to each house.

**Algorithm:**
1. Create virtual node 0, add edges from 0 to each house with cost wells[i-1]
2. Add all pipe edges
3. Run Kruskal's algorithm to find MST
4. Return total cost of MST

**C++ Code:**
```cpp
class UnionFind {
public:
    vector<int> parent, rank;
    UnionFind(int size) {
        parent.resize(size);
        rank.resize(size, 0);
        for (int i = 0; i < size; ++i) parent[i] = i;
    }
    
    int find(int x) {
        if (parent[x] != x) parent[x] = find(parent[x]);
        return parent[x];
    }
    
    bool unite(int x, int y) {
        int px = find(x), py = find(y);
        if (px == py) return false;
        if (rank[px] < rank[py]) parent[px] = py;
        else if (rank[px] > rank[py]) parent[py] = px;
        else {
            parent[py] = px;
            rank[px]++;
        }
        return true;
    }
};

class Solution {
public:
    int minCostToSupplyWater(int n, vector<int>& wells, vector<vector<int>>& pipes) {
        vector<vector<int>> edges;
        
        // Add well edges from virtual node 0
        for (int i = 1; i <= n; ++i) {
            edges.push_back({0, i, wells[i-1]});
        }
        
        // Add pipe edges
        for (auto& pipe : pipes) {
            edges.push_back({pipe[0], pipe[1], pipe[2]});
        }
        
        // Sort edges by cost
        sort(edges.begin(), edges.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });
        
        UnionFind uf(n + 1);
        int totalCost = 0;
        
        for (auto& edge : edges) {
            if (uf.unite(edge[0], edge[1])) {
                totalCost += edge[2];
            }
        }
        
        return totalCost;
    }
};
```

**Python Code:**
```python
class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))
        self.rank = [0] * size
    
    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]
    
    def unite(self, x, y):
        px, py = self.find(x), self.find(y)
        if px == py:
            return False
        if self.rank[px] < self.rank[py]:
            self.parent[px] = py
        elif self.rank[px] > self.rank[py]:
            self.parent[py] = px
        else:
            self.parent[py] = px
            self.rank[px] += 1
        return True

def min_cost_to_supply_water(n, wells, pipes):
    edges = []
    
    # Add well edges from virtual node 0
    for i in range(1, n + 1):
        edges.append((0, i, wells[i-1]))
    
    # Add pipe edges
    for u, v, cost in pipes:
        edges.append((u, v, cost))
    
    # Sort by cost
    edges.sort(key=lambda x: x[2])
    
    uf = UnionFind(n + 1)
    total_cost = 0
    
    for u, v, cost in edges:
        if uf.unite(u, v):
            total_cost += cost
    
    return total_cost
```

**Complexity Analysis:**
- Time: O(E log E)
- Space: O(V + E)

### 8.22 Bus Routes

**Problem Statement:** You are given an array routes representing bus routes where routes[i] is a bus route that the i-th bus repeats forever. For example, if routes[0] = [1, 5, 7], this means that the 0-th bus travels in the sequence 1 -> 5 -> 7 -> 1 -> 5 -> 7 -> ... forever. You will start at the bus stop source (You are not on any bus initially), and you want to go to the bus stop target. You can get on and off the buses at any time. You also cannot travel between bus stops on foot. Return the least number of buses you must take to travel from source to target. Return -1 if it is impossible.

**Intuition:** Model as graph where bus routes are nodes, stops are connections. BFS where each level represents one bus change.

**Algorithm:**
1. Build stop -> routes mapping
2. BFS: queue contains (current stop, buses taken)
3. For each stop, try all routes that pass through it
4. Mark visited routes to avoid cycles
5. Return buses when reach target

**C++ Code:**
```cpp
class Solution {
public:
    int numBusesToDestination(vector<vector<int>>& routes, int source, int target) {
        if (source == target) return 0;
        
        unordered_map<int, vector<int>> stopToRoutes;
        for (int i = 0; i < routes.size(); ++i) {
            for (int stop : routes[i]) {
                stopToRoutes[stop].push_back(i);
            }
        }
        
        queue<pair<int, int>> q; // (current stop, buses taken)
        q.push({source, 0});
        unordered_set<int> visitedStops;
        unordered_set<int> visitedRoutes;
        visitedStops.insert(source);
        
        while (!q.empty()) {
            auto [stop, buses] = q.front(); q.pop();
            
            for (int route : stopToRoutes[stop]) {
                if (visitedRoutes.count(route)) continue;
                visitedRoutes.insert(route);
                
                for (int nextStop : routes[route]) {
                    if (nextStop == target) return buses + 1;
                    if (visitedStops.count(nextStop) == 0) {
                        visitedStops.insert(nextStop);
                        q.push({nextStop, buses + 1});
                    }
                }
            }
        }
        
        return -1;
    }
};
```

**Python Code:**
```python
from collections import deque, defaultdict

def num_buses_to_destination(routes, source, target):
    if source == target:
        return 0
    
    stop_to_routes = defaultdict(list)
    for i, route in enumerate(routes):
        for stop in route:
            stop_to_routes[stop].append(i)
    
    queue = deque([(source, 0)])  # (stop, buses)
    visited_stops = set([source])
    visited_routes = set()
    
    while queue:
        stop, buses = queue.popleft()
        
        for route_idx in stop_to_routes[stop]:
            if route_idx in visited_routes:
                continue
            visited_routes.add(route_idx)
            
            for next_stop in routes[route_idx]:
                if next_stop == target:
                    return buses + 1
                if next_stop not in visited_stops:
                    visited_stops.add(next_stop)
                    queue.append((next_stop, buses + 1))
    
    return -1
```

**Complexity Analysis:**
- Time: O(R * S) where R = routes, S = stops per route
- Space: O(R * S)

### 8.23 All Paths from Source to Target

**Problem Statement:** Given a directed acyclic graph (DAG) of n nodes labeled from 0 to n - 1, find all possible paths from node 0 to node n - 1, and return them in any order. The graph is given as follows: graph[i] is a list of all nodes you can visit from node i (i.e., there is a directed edge from node i to node graph[i][j]).

**Intuition:** DFS with backtracking to explore all paths from source to target.

**Algorithm:**
1. DFS function with current path
2. When reach target, add path to result
3. For each neighbor, recurse with updated path
4. Backtrack by removing last node

**C++ Code:**
```cpp
class Solution {
public:
    void dfs(int node, int target, vector<vector<int>>& graph, vector<int>& path, vector<vector<int>>& result) {
        path.push_back(node);
        
        if (node == target) {
            result.push_back(path);
        } else {
            for (int next : graph[node]) {
                dfs(next, target, graph, path, result);
            }
        }
        
        path.pop_back();
    }
    
    vector<vector<int>> allPathsSourceTarget(vector<vector<int>>& graph) {
        vector<vector<int>> result;
        vector<int> path;
        dfs(0, graph.size() - 1, graph, path, result);
        return result;
    }
};
```

**Python Code:**
```python
def all_paths_source_target(graph):
    def dfs(node, target, path, result):
        path.append(node)
        
        if node == target:
            result.append(path[:])
        else:
            for next_node in graph[node]:
                dfs(next_node, target, path, result)
        
        path.pop()
    
    result = []
    dfs(0, len(graph) - 1, [], result)
    return result
```

**Complexity Analysis:**
- Time: O(2^V) worst case
- Space: O(V)

### 8.24 Shortest Path in Binary Matrix

**Problem Statement:** Given an n x n binary matrix grid, return the length of the shortest clear path in the matrix. If there is no clear path, return -1. A clear path in a binary matrix is a path from the top-left cell (i.e., (0, 0)) to the bottom-right cell (i.e., (n-1, n-1)) such that all the visited cells are 0 and all adjacent cells are 8-directionally connected.

**Intuition:** BFS from (0,0) to (n-1,n-1), exploring all 8 directions. Each step increases path length by 1.

**Algorithm:**
1. If grid[0][0] == 1 or grid[n-1][n-1] == 1, return -1
2. BFS queue: (i, j, steps)
3. Mark visited cells
4. Explore 8 directions
5. Return steps when reach (n-1, n-1)

**C++ Code:**
```cpp
class Solution {
public:
    int shortestPathBinaryMatrix(vector<vector<int>>& grid) {
        int n = grid.size();
        if (grid[0][0] == 1 || grid[n-1][n-1] == 1) return -1;
        
        vector<vector<int>> directions = {{-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,1}, {1,-1}, {1,0}, {1,1}};
        queue<vector<int>> q; // {i, j, steps}
        q.push({0, 0, 1});
        grid[0][0] = 1; // mark visited
        
        while (!q.empty()) {
            auto curr = q.front(); q.pop();
            int i = curr[0], j = curr[1], steps = curr[2];
            
            if (i == n-1 && j == n-1) return steps;
            
            for (auto& dir : directions) {
                int ni = i + dir[0], nj = j + dir[1];
                if (ni >= 0 && ni < n && nj >= 0 && nj < n && grid[ni][nj] == 0) {
                    grid[ni][nj] = 1; // mark visited
                    q.push({ni, nj, steps + 1});
                }
            }
        }
        
        return -1;
    }
};
```

**Python Code:**
```python
from collections import deque

def shortest_path_binary_matrix(grid):
    n = len(grid)
    if grid[0][0] == 1 or grid[n-1][n-1] == 1:
        return -1
    
    directions = [(-1,-1), (-1,0), (-1,1), (0,-1), (0,1), (1,-1), (1,0), (1,1)]
    queue = deque([(0, 0, 1)])  # (i, j, steps)
    grid[0][0] = 1  # mark visited
    
    while queue:
        i, j, steps = queue.popleft()
        
        if i == n-1 and j == n-1:
            return steps
        
        for di, dj in directions:
            ni, nj = i + di, j + dj
            if 0 <= ni < n and 0 <= nj < n and grid[ni][nj] == 0:
                grid[ni][nj] = 1  # mark visited
                queue.append((ni, nj, steps + 1))
    
    return -1
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n²)

### 8.25 As Far from Land as Possible

**Problem Statement:** Given an n x n grid containing only values 0 and 1, where 0 represents water and 1 represents land, find a water cell such that its distance to the nearest land cell is maximized, and return the distance. If no land or no water exists in the grid, return -1.

**Intuition:** Multi-source BFS from all land cells. The last cell visited will have maximum distance.

**Algorithm:**
1. BFS queue with all land cells (distance 0)
2. Mark visited land cells
3. BFS to find maximum distance to water cells
4. Return maximum distance

**C++ Code:**
```cpp
class Solution {
public:
    int maxDistance(vector<vector<int>>& grid) {
        int n = grid.size();
        queue<pair<int, int>> q;
        vector<vector<bool>> visited(n, vector<bool>(n, false));
        
        // Add all land cells to queue
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    q.push({i, j});
                    visited[i][j] = true;
                }
            }
        }
        
        if (q.size() == 0 || q.size() == n * n) return -1;
        
        vector<pair<int, int>> directions = {{-1,0}, {1,0}, {0,-1}, {0,1}};
        int distance = -1;
        
        while (!q.empty()) {
            int size = q.size();
            distance++;
            
            for (int k = 0; k < size; ++k) {
                auto [i, j] = q.front(); q.pop();
                
                for (auto& dir : directions) {
                    int ni = i + dir.first, nj = j + dir.second;
                    if (ni >= 0 && ni < n && nj >= 0 && nj < n && !visited[ni][nj]) {
                        visited[ni][nj] = true;
                        q.push({ni, nj});
                    }
                }
            }
        }
        
        return distance;
    }
};
```

**Python Code:**
```python
from collections import deque

def max_distance(grid):
    n = len(grid)
    queue = deque()
    visited = [[False] * n for _ in range(n)]
    
    # Add all land cells
    for i in range(n):
        for j in range(n):
            if grid[i][j] == 1:
                queue.append((i, j))
                visited[i][j] = True
    
    if not queue or len(queue) == n * n:
        return -1
    
    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    distance = -1
    
    while queue:
        size = len(queue)
        distance += 1
        
        for _ in range(size):
            i, j = queue.popleft()
            
            for di, dj in directions:
                ni, nj = i + di, j + dj
                if 0 <= ni < n and 0 <= nj < n and not visited[ni][nj]:
                    visited[ni][nj] = True
                    queue.append((ni, nj))
    
    return distance
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n²)

### 8.26 Making A Large Island

**Problem Statement:** You are given an n x n binary matrix grid. You are allowed to change at most one 0 to be 1. Return the size of the largest island in grid after applying this operation. An island is a 4-directionally connected group of 1's.

**Intuition:** Find all islands and their sizes. For each 0, check adjacent islands and calculate potential size.

**Algorithm:**
1. DFS to find all islands and their sizes
2. For each 0, check 4 directions for adjacent islands
3. Calculate total size if we flip this 0
4. Return maximum size

**C++ Code:**
```cpp
class Solution {
public:
    int dfs(int i, int j, vector<vector<int>>& grid, int id) {
        if (i < 0 || i >= grid.size() || j < 0 || j >= grid[0].size() || grid[i][j] != 1) return 0;
        grid[i][j] = id;
        return 1 + dfs(i+1, j, grid, id) + dfs(i-1, j, grid, id) + dfs(i, j+1, grid, id) + dfs(i, j-1, grid, id);
    }
    
    int largestIsland(vector<vector<int>>& grid) {
        int n = grid.size();
        unordered_map<int, int> islandSize;
        int id = 2;
        
        // Find all islands
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    islandSize[id] = dfs(i, j, grid, id);
                    id++;
                }
            }
        }
        
        if (islandSize.empty()) return 1;
        
        int maxSize = 0;
        for (auto& p : islandSize) maxSize = max(maxSize, p.second);
        
        // Check each 0
        vector<pair<int, int>> directions = {{-1,0}, {1,0}, {0,-1}, {0,1}};
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    unordered_set<int> adjacentIslands;
                    for (auto& dir : directions) {
                        int ni = i + dir.first, nj = j + dir.second;
                        if (ni >= 0 && ni < n && nj >= 0 && nj < n && grid[ni][nj] > 1) {
                            adjacentIslands.insert(grid[ni][nj]);
                        }
                    }
                    
                    int total = 1; // the flipped 0
                    for (int islandId : adjacentIslands) {
                        total += islandSize[islandId];
                    }
                    maxSize = max(maxSize, total);
                }
            }
        }
        
        return maxSize;
    }
};
```

**Python Code:**
```python
def largest_island(grid):
    n = len(grid)
    island_size = {}
    island_id = 2
    
    def dfs(i, j, id_val):
        if i < 0 or i >= n or j < 0 or j >= n or grid[i][j] != 1:
            return 0
        grid[i][j] = id_val
        return 1 + dfs(i+1, j, id_val) + dfs(i-1, j, id_val) + dfs(i, j+1, id_val) + dfs(i, j-1, id_val)
    
    # Find all islands
    for i in range(n):
        for j in range(n):
            if grid[i][j] == 1:
                island_size[island_id] = dfs(i, j, island_id)
                island_id += 1
    
    if not island_size:
        return 1
    
    max_size = max(island_size.values())
    
    # Check each 0
    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
    for i in range(n):
        for j in range(n):
            if grid[i][j] == 0:
                adjacent = set()
                for di, dj in directions:
                    ni, nj = i + di, j + dj
                    if 0 <= ni < n and 0 <= nj < n and grid[ni][nj] > 1:
                        adjacent.add(grid[ni][nj])
                
                total = 1  # flipped 0
                for island_id in adjacent:
                    total += island_size[island_id]
                max_size = max(max_size, total)
    
    return max_size
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n²)

### 8.27 Detonate the Maximum Bombs

**Problem Statement:** You are given a list of bombs. The range of a bomb is defined as the area where its effect can be felt. This area is in the shape of a circle with the center as the location of the bomb. The bombs are represented by a 0-indexed 2D integer array bombs where bombs[i] = [x_i, y_i, r_i]. x_i and y_i denote the X-coordinate and Y-coordinate of the center of the i-th bomb, and r_i denotes the radius of its range. You may choose to detonate a single bomb. When a bomb is detonated, it will detonate all bombs that lie in its range. These bombs will further detonate the bombs that lie in their ranges. Return the maximum number of bombs that can be detonated in the explosion.

**Intuition:** Build graph where edge exists if one bomb can detonate another. DFS/BFS from each bomb to find maximum connected component.

**Algorithm:**
1. Build directed graph: i -> j if bomb i can reach bomb j
2. For each bomb, DFS to count reachable bombs
3. Return maximum count

**C++ Code:**
```cpp
class Solution {
public:
    void dfs(int node, vector<vector<int>>& graph, vector<bool>& visited, int& count) {
        visited[node] = true;
        count++;
        
        for (int next : graph[node]) {
            if (!visited[next]) {
                dfs(next, graph, visited, count);
            }
        }
    }
    
    int maximumDetonation(vector<vector<int>>& bombs) {
        int n = bombs.size();
        vector<vector<int>> graph(n);
        
        // Build graph
        for (int i = 0; i < n; ++i) {
            long long x1 = bombs[i][0], y1 = bombs[i][1], r1 = bombs[i][2];
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                long long x2 = bombs[j][0], y2 = bombs[j][1];
                long long dist = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
                if (dist <= r1 * r1) {
                    graph[i].push_back(j);
                }
            }
        }
        
        int maxDetonated = 0;
        for (int i = 0; i < n; ++i) {
            vector<bool> visited(n, false);
            int count = 0;
            dfs(i, graph, visited, count);
            maxDetonated = max(maxDetonated, count);
        }
        
        return maxDetonated;
    }
};
```

**Python Code:**
```python
def maximum_detonation(bombs):
    n = len(bombs)
    graph = [[] for _ in range(n)]
    
    # Build graph
    for i in range(n):
        x1, y1, r1 = bombs[i]
        for j in range(n):
            if i == j:
                continue
            x2, y2, _ = bombs[j]
            dist = (x1 - x2) ** 2 + (y1 - y2) ** 2
            if dist <= r1 ** 2:
                graph[i].append(j)
    
    def dfs(node, visited):
        visited.add(node)
        count = 1
        
        for next_node in graph[node]:
            if next_node not in visited:
                count += dfs(next_node, visited)
        
        return count
    
    max_detonated = 0
    for i in range(n):
        visited = set()
        count = dfs(i, visited)
        max_detonated = max(max_detonated, count)
    
    return max_detonated
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n²)

### 8.28 Find All People With Secret

**Problem Statement:** You are given an integer n indicating there are n people numbered from 0 to n-1. You are also given a 0-indexed 2D integer array meetings where meetings[i] = [xi, yi, time_i] denotes a meeting at time_i between person xi and person yi. All the meetings are sorted in ascending order of time_i. A person may attend multiple meetings at the same time. When a person attends a meeting, they share the secret with everyone else who attends the same meeting. The secret is shared transitively, so if person A shares with person B, and person B shares with person C, then person A also shares with person C through person B. You are given an integer firstPerson, and you want to find all the people who have the secret after all the meetings have happened. Note that person 0 always has the secret initially.

**Intuition:** Process meetings in time order. For each time slot, build graph of meetings and find connected components with secret.

**Algorithm:**
1. Sort meetings by time
2. Group meetings by time
3. For each time group:
   - Build graph of people meeting
   - Find connected components
   - If component contains person with secret, all get secret
4. Return all people with secret

**C++ Code:**
```cpp
class Solution {
public:
    vector<int> findAllPeople(int n, vector<vector<int>>& meetings, int firstPerson) {
        sort(meetings.begin(), meetings.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });
        
        vector<bool> hasSecret(n, false);
        hasSecret[0] = true;
        hasSecret[firstPerson] = true;
        
        int i = 0;
        while (i < meetings.size()) {
            int time = meetings[i][2];
            unordered_map<int, vector<int>> graph;
            unordered_set<int> people;
            
            // Collect all meetings at this time
            while (i < meetings.size() && meetings[i][2] == time) {
                int p1 = meetings[i][0], p2 = meetings[i][1];
                graph[p1].push_back(p2);
                graph[p2].push_back(p1);
                people.insert(p1);
                people.insert(p2);
                i++;
            }
            
            // Find connected components
            vector<bool> visited(n, false);
            for (int person : people) {
                if (visited[person]) continue;
                
                // DFS to find component
                vector<int> component;
                queue<int> q;
                q.push(person);
                visited[person] = true;
                bool hasSecretPerson = hasSecret[person];
                
                while (!q.empty()) {
                    int p = q.front(); q.pop();
                    component.push_back(p);
                    
                    for (int next : graph[p]) {
                        if (!visited[next]) {
                            visited[next] = true;
                            q.push(next);
                            if (hasSecret[next]) hasSecretPerson = true;
                        }
                    }
                }
                
                // If component has secret, all get it
                if (hasSecretPerson) {
                    for (int p : component) {
                        hasSecret[p] = true;
                    }
                }
            }
        }
        
        vector<int> result;
        for (int i = 0; i < n; ++i) {
            if (hasSecret[i]) result.push_back(i);
        }
        
        return result;
    }
};
```

**Python Code:**
```python
from collections import defaultdict, deque

def find_all_people(n, meetings, first_person):
    meetings.sort(key=lambda x: x[2])
    
    has_secret = [False] * n
    has_secret[0] = True
    has_secret[first_person] = True
    
    i = 0
    while i < len(meetings):
        time = meetings[i][2]
        graph = defaultdict(list)
        people = set()
        
        # Collect meetings at this time
        while i < len(meetings) and meetings[i][2] == time:
            p1, p2, _ = meetings[i]
            graph[p1].append(p2)
            graph[p2].append(p1)
            people.add(p1)
            people.add(p2)
            i += 1
        
        # Find connected components
        visited = [False] * n
        for person in people:
            if visited[person]:
                continue
            
            # BFS to find component
            component = []
            queue = deque([person])
            visited[person] = True
            has_secret_person = has_secret[person]
            
            while queue:
                p = queue.popleft()
                component.append(p)
                
                for next_p in graph[p]:
                    if not visited[next_p]:
                        visited[next_p] = True
                        queue.append(next_p)
                        if has_secret[next_p]:
                            has_secret_person = True
            
            # Share secret
            if has_secret_person:
                for p in component:
                    has_secret[p] = True
    
    return [i for i in range(n) if has_secret[i]]
```

**Complexity Analysis:**
- Time: O(M log M + M * α(N)) where M = meetings
- Space: O(N + M)

### 8.29 Throne Inheritance

**Problem Statement:** A kingdom consists of a king, his children, his grandchildren, and so on. Every once in a while, someone in the family dies. The kingdom decides who the next king will be based on the following rules: The current king dies. Among the king's children, the eldest son becomes the next king. If the king had no children, the next eldest sibling of the king becomes the next king. If the king had no siblings, the next eldest child of the king's parent becomes the next king. And so on. For example, if the king has an eldest son who has an eldest son, that grandson becomes the next king. Given a king's name, the structure of the kingdom, and the people who have died, please find the name of the next king.

**Intuition:** Build tree structure. When king dies, find next in line using DFS preorder traversal, skipping dead people.

**Algorithm:**
1. Build tree: parent -> children
2. Mark dead people
3. DFS from king to find next alive person in succession order
4. Return first alive person found

**C++ Code:**
```cpp
class ThroneInheritance {
public:
    unordered_map<string, vector<string>> children;
    unordered_set<string> dead;
    string king;
    
    ThroneInheritance(string kingName) {
        king = kingName;
    }
    
    void birth(string parentName, string childName) {
        children[parentName].push_back(childName);
    }
    
    void death(string name) {
        dead.insert(name);
    }
    
    vector<string> getInheritanceOrder() {
        vector<string> order;
        function<void(string)> dfs = [&](string person) {
            if (dead.find(person) == dead.end()) {
                order.push_back(person);
            }
            for (string child : children[person]) {
                dfs(child);
            }
        };
        dfs(king);
        return order;
    }
    
    string getNextKing() {
        function<string(string)> findNext = [&](string person) -> string {
            if (dead.find(person) == dead.end()) {
                return person;
            }
            for (string child : children[person]) {
                string next = findNext(child);
                if (!next.empty()) return next;
            }
            return "";
        };
        
        // Start from king's children
        for (string child : children[king]) {
            string next = findNext(child);
            if (!next.empty()) return next;
        }
        
        return ""; // Should not happen
    }
};
```

**Python Code:**
```python
class ThroneInheritance:
    def __init__(self, kingName):
        self.king = kingName
        self.children = defaultdict(list)
        self.dead = set()
    
    def birth(self, parentName, childName):
        self.children[parentName].append(childName)
    
    def death(self, name):
        self.dead.add(name)
    
    def get_inheritance_order(self):
        order = []
        
        def dfs(person):
            if person not in self.dead:
                order.append(person)
            for child in self.children[person]:
                dfs(child)
        
        dfs(self.king)
        return order
    
    def get_next_king(self):
        def find_next(person):
            if person not in self.dead:
                return person
            for child in self.children[person]:
                next_king = find_next(child)
                if next_king:
                    return next_king
            return None
        
        # Check king's children
        for child in self.children[self.king]:
            next_king = find_next(child)
            if next_king:
                return next_king
        
        return None
```

**Complexity Analysis:**
- Time: O(N) for inheritance order
- Space: O(N)

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
- Fibonacci Number
- Minimum Path Sum
- Unique Paths
- Unique Paths II
- Triangle
- Maximum Subarray
- Jump Game
- Jump Game II
- Palindromic Substrings
- Longest Palindromic Substring
- Word Break
- Decode Ways
- Partition Equal Subset Sum
- Frog Jump(DP-3)
- Frog Jump with k distances(DP-4)
- Ninja's Training (DP 7)
- Minimum/Maximum Falling Path Sum (DP-12)
- 3-d DP : Ninja and his friends (DP-13)
- Subset sum equal to target (DP- 14)
- Partition Set Into 2 Subsets With Min Absolute Sum Diff (DP- 16)
- Count Subsets with Sum K (DP - 17)
- Count Partitions with Given Difference (DP - 18)
- Target Sum (DP - 21)
- Coin Change 2 (DP - 22)
- Unbounded Knapsack (DP - 23)
- Rod Cutting Problem | (DP - 24)
- Print Longest Common Subsequence | (DP - 26)
- Longest Common Substring | (DP - 27)
- Longest Palindromic Subsequence | (DP-28)
- Minimum insertions to make string palindrome | DP-29
- Shortest Common Supersequence | (DP - 31)
- Distinct Subsequences| (DP-32)
- Wildcard Matching | (DP-34)
- Best Time to Buy and Sell Stock |(DP-35)
- Buy and Sell Stock - II|(DP-36)
- Buy and Sell Stocks III|(DP-37)
- Buy and Stock Sell IV |(DP-38)
- Buy and Sell Stocks With Cooldown|(DP-39)
- Buy and Sell Stocks With Transaction Fee|(DP-40)
- Printing Longest Increasing Subsequence|(DP-42)
- Largest Divisible Subset|(DP-44)
- Longest String Chain|(DP-45)
- Longest Bitonic Subsequence |(DP-46)
- Number of Longest Increasing Subsequences|(DP-47)

</details>

### 10.1 Climbing Stairs

**Problem Statement:** You are climbing a staircase. It takes n steps to reach the top. Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

**Input Format:** A single integer n representing the number of steps.

**Intuition:** This is a classic DP problem where each step depends on the previous steps. The number of ways to reach step n is the sum of ways to reach step n-1 and n-2.

**Algorithm:**
1. If n <= 2, return n
2. Initialize dp array of size n+1
3. Set dp[1] = 1, dp[2] = 2
4. For i from 3 to n: dp[i] = dp[i-1] + dp[i-2]
5. Return dp[n]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int climbStairs(int n) {
        if (n <= 2) return n;
        vector<int> dp(n + 1, 0);
        dp[1] = 1;
        dp[2] = 2;
        for (int i = 3; i <= n; ++i) {
            dp[i] = dp[i-1] + dp[i-2];
        }
        return dp[n];
    }
};

int main() {
    int n;
    cin >> n;
    Solution sol;
    cout << sol.climbStairs(n) << endl;
    return 0;
}
```

**Python Code:**
```python
def climb_stairs(n):
    if n <= 2:
        return n
    dp = [0] * (n + 1)
    dp[1] = 1
    dp[2] = 2
    for i in range(3, n + 1):
        dp[i] = dp[i-1] + dp[i-2]
    return dp[n]

if __name__ == "__main__":
    n = int(input().strip())
    print(climb_stairs(n))
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(n)

### 10.2 House Robber

**Problem Statement:** You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

**Input Format:** First line contains an integer n (size of array). Second line contains n space-separated integers.

**Intuition:** For each house, we have two choices: rob it or skip it. If we rob it, we cannot rob the previous house. Use DP to track maximum amount at each house.

**Algorithm:**
1. If no houses, return 0
2. If one house, return its value
3. Initialize dp array where dp[i] represents max money up to house i
4. dp[0] = nums[0], dp[1] = max(nums[0], nums[1])
5. For i from 2 to n-1: dp[i] = max(dp[i-1], dp[i-2] + nums[i])
6. Return dp[n-1]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int rob(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;
        if (n == 1) return nums[0];
        
        vector<int> dp(n);
        dp[0] = nums[0];
        dp[1] = max(nums[0], nums[1]);
        
        for (int i = 2; i < n; ++i) {
            dp[i] = max(dp[i-1], dp[i-2] + nums[i]);
        }
        
        return dp[n-1];
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> nums(n);
    for (int i = 0; i < n; ++i) {
        cin >> nums[i];
    }
    Solution sol;
    cout << sol.rob(nums) << endl;
    return 0;
}
```

**Python Code:**
```python
def rob(nums):
    n = len(nums)
    if n == 0:
        return 0
    if n == 1:
        return nums[0]
    
    dp = [0] * n
    dp[0] = nums[0]
    dp[1] = max(nums[0], nums[1])
    
    for i in range(2, n):
        dp[i] = max(dp[i-1], dp[i-2] + nums[i])
    
    return dp[n-1]

if __name__ == "__main__":
    nums = list(map(int, input().strip().split()))
    print(rob(nums))
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(n)

### 10.3 Longest Increasing Subsequence

**Problem Statement:** Given an integer array nums, return the length of the longest strictly increasing subsequence.

**Input Format:** First line contains an integer n (size of array). Second line contains n space-separated integers.

**Intuition:** For each element, find the longest increasing subsequence ending at that element. Use DP where dp[i] represents the LIS ending at index i.

**Algorithm:**
1. Initialize dp array with all 1s (each element is a subsequence of length 1)
2. For each i from 1 to n-1:
   - For each j from 0 to i-1:
     - If nums[i] > nums[j], dp[i] = max(dp[i], dp[j] + 1)
3. Return maximum value in dp array

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int lengthOfLIS(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n, 1);
        
        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] > nums[j]) {
                    dp[i] = max(dp[i], dp[j] + 1);
                }
            }
        }
        
        return *max_element(dp.begin(), dp.end());
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> nums(n);
    for (int i = 0; i < n; ++i) {
        cin >> nums[i];
    }
    Solution sol;
    cout << sol.lengthOfLIS(nums) << endl;
    return 0;
}
```

**Python Code:**
```python
def length_of_lis(nums):
    n = len(nums)
    if n == 0:
        return 0
    
    dp = [1] * n
    
    for i in range(1, n):
        for j in range(i):
            if nums[i] > nums[j]:
                dp[i] = max(dp[i], dp[j] + 1)
    
    return max(dp)

if __name__ == "__main__":
    nums = list(map(int, input().strip().split()))
    print(length_of_lis(nums))
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n)

### 10.4 Coin Change

**Problem Statement:** You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money. Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

**Input Format:** First line contains two integers n amount (number of coin types and target amount). Second line contains n space-separated integers (coin denominations).

**Intuition:** Use DP where dp[i] represents the minimum number of coins needed to make amount i. For each coin, update dp[i] if using that coin reduces the coin count.

**Algorithm:**
1. Initialize dp array of size amount+1 with INF, dp[0] = 0
2. For each coin in coins:
   - For i from coin to amount:
     - If dp[i - coin] != INF, dp[i] = min(dp[i], dp[i - coin] + 1)
3. Return dp[amount] if not INF, else -1

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int coinChange(vector<int>& coins, int amount) {
        const int INF = 1e9;
        vector<int> dp(amount + 1, INF);
        dp[0] = 0;
        
        for (int coin : coins) {
            for (int i = coin; i <= amount; ++i) {
                if (dp[i - coin] != INF) {
                    dp[i] = min(dp[i], dp[i - coin] + 1);
                }
            }
        }
        
        return dp[amount] == INF ? -1 : dp[amount];
    }
};

int main() {
    int n, amount;
    cin >> n >> amount;
    vector<int> coins(n);
    for (int i = 0; i < n; ++i) {
        cin >> coins[i];
    }
    Solution sol;
    cout << sol.coinChange(coins, amount) << endl;
    return 0;
}
```

**Python Code:**
```python
def coin_change(coins, amount):
    INF = float('inf')
    dp = [INF] * (amount + 1)
    dp[0] = 0
    
    for coin in coins:
        for i in range(coin, amount + 1):
            if dp[i - coin] != INF:
                dp[i] = min(dp[i], dp[i - coin] + 1)
    
    return dp[amount] if dp[amount] != INF else -1

if __name__ == "__main__":
    import sys
    input = sys.stdin.read
    data = input().split()
    n = int(data[0])
    amount = int(data[1])
    coins = list(map(int, data[2:2+n]))
    print(coin_change(coins, amount))
```

**Complexity Analysis:**
- Time: O(amount * len(coins))
- Space: O(amount)

### 10.5 Edit Distance

**Problem Statement:** Given two strings word1 and word2, return the minimum number of operations required to convert word1 to word2. Operations allowed: insert, delete, replace.

**Input Format:** Two strings separated by space.

**Intuition:** Use 2D DP where dp[i][j] represents minimum operations to convert first i chars of word1 to first j chars of word2.

**Algorithm:**
1. Initialize dp[m+1][n+1], m = len(word1), n = len(word2)
2. For i from 0 to m: dp[i][0] = i (deletions)
3. For j from 0 to n: dp[0][j] = j (insertions)
4. For i from 1 to m:
   - For j from 1 to n:
     - If word1[i-1] == word2[j-1], dp[i][j] = dp[i-1][j-1]
     - Else, dp[i][j] = 1 + min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1])
5. Return dp[m][n]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int minDistance(string word1, string word2) {
        int m = word1.size(), n = word2.size();
        vector<vector<int>> dp(m + 1, vector<int>(n + 1, 0));
        
        for (int i = 0; i <= m; ++i) dp[i][0] = i;
        for (int j = 0; j <= n; ++j) dp[0][j] = j;
        
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (word1[i-1] == word2[j-1]) {
                    dp[i][j] = dp[i-1][j-1];
                } else {
                    dp[i][j] = 1 + min({dp[i-1][j], dp[i][j-1], dp[i-1][j-1]});
                }
            }
        }
        
        return dp[m][n];
    }
};

int main() {
    string word1, word2;
    cin >> word1 >> word2;
    Solution sol;
    cout << sol.minDistance(word1, word2) << endl;
    return 0;
}
```

**Python Code:**
```python
def min_distance(word1, word2):
    m, n = len(word1), len(word2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    for i in range(m + 1):
        dp[i][0] = i
    for j in range(n + 1):
        dp[0][j] = j
    
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if word1[i-1] == word2[j-1]:
                dp[i][j] = dp[i-1][j-1]
            else:
                dp[i][j] = 1 + min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1])
    
    return dp[m][n]

if __name__ == "__main__":
    word1, word2 = input().strip().split()
    print(min_distance(word1, word2))
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n)

### 10.6 Longest Common Subsequence

**Problem Statement:** Given two strings text1 and text2, return the length of their longest common subsequence. A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.

**Input Format:** Two strings separated by space.

**Intuition:** Use 2D DP where dp[i][j] represents LCS length of first i chars of text1 and first j chars of text2.

**Algorithm:**
1. Initialize dp[m+1][n+1] with 0s
2. For i from 1 to m:
   - For j from 1 to n:
     - If text1[i-1] == text2[j-1], dp[i][j] = dp[i-1][j-1] + 1
     - Else, dp[i][j] = max(dp[i-1][j], dp[i][j-1])
3. Return dp[m][n]

**C++ Code:**
```cpp
class Solution {
public:
    int longestCommonSubsequence(string text1, string text2) {
        int m = text1.size(), n = text2.size();
        vector<vector<int>> dp(m + 1, vector<int>(n + 1, 0));
        
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (text1[i-1] == text2[j-1]) {
                    dp[i][j] = dp[i-1][j-1] + 1;
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
                }
            }
        }
        
        return dp[m][n];
    }
};

int main() {
    string text1, text2;
    cin >> text1 >> text2;
    Solution sol;
    cout << sol.longestCommonSubsequence(text1, text2) << endl;
    return 0;
}
```

**Python Code:**
```python
def longest_common_subsequence(text1, text2):
    m, n = len(text1), len(text2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if text1[i-1] == text2[j-1]:
                dp[i][j] = dp[i-1][j-1] + 1
            else:
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
    
    return dp[m][n]

if __name__ == "__main__":
    text1, text2 = input().strip().split()
    print(longest_common_subsequence(text1, text2))
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n)

### 10.7 Knapsack Problem

**Problem Statement:** Given weights and values of n items, put these items in a knapsack of capacity W to get the maximum total value in the knapsack.

**Input Format:** First line contains two integers n W (number of items and knapsack capacity). Next n lines contain two integers wi vi (weight and value of each item).

**Intuition:** Use 2D DP where dp[i][w] represents maximum value using first i items with capacity w.

**Algorithm:**
1. Initialize dp[n+1][W+1] with 0s
2. For i from 1 to n:
   - For w from 1 to W:
     - If weights[i-1] <= w, dp[i][w] = max(dp[i-1][w], dp[i-1][w - weights[i-1]] + values[i-1])
     - Else, dp[i][w] = dp[i-1][w]
3. Return dp[n][W]

**C++ Code:**
```cpp
class Solution {
public:
    int knapsack(vector<int>& weights, vector<int>& values, int W) {
        int n = weights.size();
        vector<vector<int>> dp(n + 1, vector<int>(W + 1, 0));
        
        for (int i = 1; i <= n; ++i) {
            for (int w = 1; w <= W; ++w) {
                if (weights[i-1] <= w) {
                    dp[i][w] = max(dp[i-1][w], dp[i-1][w - weights[i-1]] + values[i-1]);
                } else {
                    dp[i][w] = dp[i-1][w];
                }
            }
        }
        
        return dp[n][W];
    }
};

int main() {
    int n, W;
    cin >> n >> W;
    vector<int> weights(n), values(n);
    for (int i = 0; i < n; ++i) {
        cin >> weights[i] >> values[i];
    }
    Solution sol;
    cout << sol.knapsack(weights, values, W) << endl;
    return 0;
}
```

**Python Code:**
```python
def knapsack(weights, values, W):
    n = len(weights)
    dp = [[0] * (W + 1) for _ in range(n + 1)]
    
    for i in range(1, n + 1):
        for w in range(1, W + 1):
            if weights[i-1] <= w:
                dp[i][w] = max(dp[i-1][w], dp[i-1][w - weights[i-1]] + values[i-1])
            else:
                dp[i][w] = dp[i-1][w]
    
    return dp[n][W]

if __name__ == "__main__":
    n, W = map(int, input().split())
    weights = []
    values = []
    for _ in range(n):
        w, v = map(int, input().split())
        weights.append(w)
        values.append(v)
    print(knapsack(weights, values, W))
```

**Complexity Analysis:**
- Time: O(n*W)
- Space: O(n*W)

### 10.8 Fibonacci Number

**Problem Statement:** The Fibonacci numbers, commonly denoted F(n) form a sequence, called the Fibonacci sequence, such that each number is the sum of the two preceding ones, starting from 0 and 1.

**Intuition:** Simple DP where each number depends on the previous two. Can be optimized to O(1) space.

**Algorithm:**
1. If n <= 1, return n
2. Initialize a = 0, b = 1
3. For i from 2 to n: a, b = b, a + b
4. Return b

**C++ Code:**
```cpp
class Solution {
public:
    int fib(int n) {
        if (n <= 1) return n;
        int a = 0, b = 1;
        for (int i = 2; i <= n; ++i) {
            int temp = a + b;
            a = b;
            b = temp;
        }
        return b;
    }
};
```

**Python Code:**
```python
def fib(n):
    if n <= 1:
        return n
    a, b = 0, 1
    for _ in range(2, n + 1):
        a, b = b, a + b
    return b
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(1)

### 10.9 Minimum Path Sum

**Problem Statement:** Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right, which minimizes the sum of all numbers along its path. You can only move either down or right at any point in time.

**Intuition:** DP where dp[i][j] represents minimum path sum to reach grid[i][j].

**Algorithm:**
1. Initialize dp[m][n], dp[0][0] = grid[0][0]
2. Fill first row: dp[0][j] = dp[0][j-1] + grid[0][j]
3. Fill first column: dp[i][0] = dp[i-1][0] + grid[i][0]
4. For i from 1 to m-1:
   - For j from 1 to n-1:
     - dp[i][j] = grid[i][j] + min(dp[i-1][j], dp[i][j-1])
5. Return dp[m-1][n-1]

**C++ Code:**
```cpp
class Solution {
public:
    int minPathSum(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));
        dp[0][0] = grid[0][0];
        
        for (int j = 1; j < n; ++j) dp[0][j] = dp[0][j-1] + grid[0][j];
        for (int i = 1; i < m; ++i) dp[i][0] = dp[i-1][0] + grid[i][0];
        
        for (int i = 1; i < m; ++i) {
            for (int j = 1; j < n; ++j) {
                dp[i][j] = grid[i][j] + min(dp[i-1][j], dp[i][j-1]);
            }
        }
        
        return dp[m-1][n-1];
    }
};
```

**Python Code:**
```python
def min_path_sum(grid):
    m, n = len(grid), len(grid[0])
    dp = [[0] * n for _ in range(m)]
    dp[0][0] = grid[0][0]
    
    for j in range(1, n):
        dp[0][j] = dp[0][j-1] + grid[0][j]
    for i in range(1, m):
        dp[i][0] = dp[i-1][0] + grid[i][0]
    
    for i in range(1, m):
        for j in range(1, n):
            dp[i][j] = grid[i][j] + min(dp[i-1][j], dp[i][j-1])
    
    return dp[m-1][n-1]
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n)

### 10.10 Unique Paths

**Problem Statement:** A robot is located at the top-left corner of a m x n grid. The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid. How many possible unique paths are there?

**Intuition:** Combinatorics problem. Total moves: m-1 down + n-1 right. Choose positions for down moves: C((m-1)+(n-1), m-1)

**Algorithm:**
1. Return C(m+n-2, m-1) where C(n,k) = n! / (k! * (n-k)!)

**C++ Code:**
```cpp
class Solution {
public:
    int uniquePaths(int m, int n) {
        long long res = 1;
        int N = m + n - 2;
        int K = min(m-1, n-1);
        
        for (int i = 1; i <= K; ++i) {
            res *= (N - K + i);
            res /= i;
        }
        
        return res;
    }
};
```

**Python Code:**
```python
def unique_paths(m, n):
    import math
    return math.comb(m + n - 2, m - 1)
```

**Complexity Analysis:**
- Time: O(min(m,n))
- Space: O(1)

### 10.11 Unique Paths II

**Problem Statement:** A robot is located at the top-left corner of a m x n grid with obstacles. The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid. Now consider if some obstacles are added to the grids. How many unique paths would there be?

**Intuition:** DP with obstacle handling. If obstacle at position, set dp[i][j] = 0.

**Algorithm:**
1. If grid[0][0] == 1 or grid[m-1][n-1] == 1, return 0
2. Initialize dp[m][n], dp[0][0] = 1
3. Fill first row and column, stopping at obstacles
4. For other cells: if no obstacle, dp[i][j] = dp[i-1][j] + dp[i][j-1]
5. Return dp[m-1][n-1]

**C++ Code:**
```cpp
class Solution {
public:
    int uniquePathsWithObstacles(vector<vector<int>>& obstacleGrid) {
        int m = obstacleGrid.size(), n = obstacleGrid[0].size();
        if (obstacleGrid[0][0] == 1 || obstacleGrid[m-1][n-1] == 1) return 0;
        
        vector<vector<int>> dp(m, vector<int>(n, 0));
        dp[0][0] = 1;
        
        for (int j = 1; j < n; ++j) {
            if (obstacleGrid[0][j] == 0) dp[0][j] = dp[0][j-1];
        }
        for (int i = 1; i < m; ++i) {
            if (obstacleGrid[i][0] == 0) dp[i][0] = dp[i-1][0];
        }
        
        for (int i = 1; i < m; ++i) {
            for (int j = 1; j < n; ++j) {
                if (obstacleGrid[i][j] == 0) {
                    dp[i][j] = dp[i-1][j] + dp[i][j-1];
                }
            }
        }
        
        return dp[m-1][n-1];
    }
};
```

**Python Code:**
```python
def unique_paths_with_obstacles(obstacle_grid):
    m, n = len(obstacle_grid), len(obstacle_grid[0])
    if obstacle_grid[0][0] == 1 or obstacle_grid[m-1][n-1] == 1:
        return 0
    
    dp = [[0] * n for _ in range(m)]
    dp[0][0] = 1
    
    for j in range(1, n):
        if obstacle_grid[0][j] == 0:
            dp[0][j] = dp[0][j-1]
    for i in range(1, m):
        if obstacle_grid[i][0] == 0:
            dp[i][0] = dp[i-1][0]
    
    for i in range(1, m):
        for j in range(1, n):
            if obstacle_grid[i][j] == 0:
                dp[i][j] = dp[i-1][j] + dp[i][j-1]
    
    return dp[m-1][n-1]
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n)

### 10.12 Triangle

**Problem Statement:** Given a triangle array, return the minimum path sum from top to bottom. For each step, you may move to an adjacent number of the row below.

**Intuition:** DP from bottom to top. Start from second last row and work upwards, updating each position with minimum of two possible paths below.

**Algorithm:**
1. Start from row len(triangle)-2 down to 0:
   - For each position j in row: triangle[i][j] += min(triangle[i+1][j], triangle[i+1][j+1])
2. Return triangle[0][0]

**C++ Code:**
```cpp
class Solution {
public:
    int minimumTotal(vector<vector<int>>& triangle) {
        int n = triangle.size();
        for (int i = n - 2; i >= 0; --i) {
            for (int j = 0; j <= i; ++j) {
                triangle[i][j] += min(triangle[i+1][j], triangle[i+1][j+1]);
            }
        }
        return triangle[0][0];
    }
};
```

**Python Code:**
```python
def minimum_total(triangle):
    n = len(triangle)
    for i in range(n - 2, -1, -1):
        for j in range(i + 1):
            triangle[i][j] += min(triangle[i+1][j], triangle[i+1][j+1])
    return triangle[0][0]
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(1) extra space (modifies input)

### 10.13 Maximum Subarray

**Problem Statement:** Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

**Intuition:** Kadane's algorithm. Keep track of current sum and maximum sum. Reset current sum when it becomes negative.

**Algorithm:**
1. Initialize max_sum = nums[0], current_sum = nums[0]
2. For i from 1 to n-1:
   - current_sum = max(nums[i], current_sum + nums[i])
   - max_sum = max(max_sum, current_sum)
3. Return max_sum

**C++ Code:**
```cpp
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        int max_sum = nums[0], current_sum = nums[0];
        for (size_t i = 1; i < nums.size(); ++i) {
            current_sum = max(nums[i], current_sum + nums[i]);
            max_sum = max(max_sum, current_sum);
        }
        return max_sum;
    }
};
```

**Python Code:**
```python
def max_subarray(nums):
    max_sum = current_sum = nums[0]
    for num in nums[1:]:
        current_sum = max(num, current_sum + num)
        max_sum = max(max_sum, current_sum)
    return max_sum
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(1)

### 10.14 Jump Game

**Problem Statement:** You are given an integer array nums. You are initially positioned at the first index, and each element in the array represents your maximum jump length at that position. Return true if you can reach the last index, or false otherwise.

**Intuition:** Keep track of the farthest position we can reach. If at any point current position > farthest, we can't proceed.

**Algorithm:**
1. Initialize farthest = 0
2. For i from 0 to n-1:
   - If i > farthest, return false
   - farthest = max(farthest, i + nums[i])
   - If farthest >= n-1, return true
3. Return true

**C++ Code:**
```cpp
class Solution {
public:
    bool canJump(vector<int>& nums) {
        int n = nums.size(), farthest = 0;
        for (int i = 0; i < n; ++i) {
            if (i > farthest) return false;
            farthest = max(farthest, i + nums[i]);
            if (farthest >= n - 1) return true;
        }
        return true;
    }
};
```

**Python Code:**
```python
def can_jump(nums):
    n = len(nums)
    farthest = 0
    for i in range(n):
        if i > farthest:
            return False
        farthest = max(farthest, i + nums[i])
        if farthest >= n - 1:
            return True
    return True
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(1)

### 10.15 Jump Game II

**Problem Statement:** Given an array of non-negative integers nums, you are initially positioned at the first index of the array. Each element in the array represents your maximum jump length at that position. Your goal is to reach the last index in the minimum number of jumps.

**Intuition:** Use greedy approach. Keep track of current end of range and farthest we can reach. When we reach current end, increment jump count.

**Algorithm:**
1. Initialize jumps = 0, current_end = 0, farthest = 0
2. For i from 0 to n-2:
   - farthest = max(farthest, i + nums[i])
   - If i == current_end:
     - jumps += 1
     - current_end = farthest
3. Return jumps

**C++ Code:**
```cpp
class Solution {
public:
    int jump(vector<int>& nums) {
        int n = nums.size(), jumps = 0, current_end = 0, farthest = 0;
        for (int i = 0; i < n - 1; ++i) {
            farthest = max(farthest, i + nums[i]);
            if (i == current_end) {
                jumps++;
                current_end = farthest;
            }
        }
        return jumps;
    }
};
```

**Python Code:**
```python
def jump(nums):
    n = len(nums)
    jumps = current_end = farthest = 0
    for i in range(n - 1):
        farthest = max(farthest, i + nums[i])
        if i == current_end:
            jumps += 1
            current_end = farthest
    return jumps
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(1)

### 10.16 Palindromic Substrings

**Problem Statement:** Given a string s, return the number of palindromic substrings in it. A string is a palindrome when it reads the same backward as forward. A substring is a contiguous sequence of characters within the string.

**Intuition:** Expand around centers. For each possible center (single char or between chars), expand while characters match.

**Algorithm:**
1. Initialize count = 0
2. For each center i from 0 to 2*n-1:
   - left = i // 2, right = left + i % 2
   - While left >= 0 and right < n and s[left] == s[right]:
     - count += 1
     - left -= 1, right += 1
3. Return count

**C++ Code:**
```cpp
class Solution {
public:
    int countSubstrings(string s) {
        int n = s.size(), count = 0;
        for (int center = 0; center < 2 * n - 1; ++center) {
            int left = center / 2;
            int right = left + center % 2;
            while (left >= 0 && right < n && s[left] == s[right]) {
                count++;
                left--;
                right++;
            }
        }
        return count;
    }
};
```

**Python Code:**
```python
def count_substrings(s):
    n = len(s)
    count = 0
    for center in range(2 * n - 1):
        left = center // 2
        right = left + center % 2
        while left >= 0 and right < n and s[left] == s[right]:
            count += 1
            left -= 1
            right += 1
    return count
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(1)

### 10.17 Longest Palindromic Substring

**Problem Statement:** Given a string s, return the longest palindromic substring in s.

**Intuition:** Expand around centers. Track the longest palindrome found during expansion.

**Algorithm:**
1. Initialize start = 0, max_len = 1
2. For each center i from 0 to 2*n-1:
   - left = i // 2, right = left + i % 2
   - While left >= 0 and right < n and s[left] == s[right]:
     - If right - left + 1 > max_len:
       - start = left, max_len = right - left + 1
     - left -= 1, right += 1
3. Return s[start:start+max_len]

**C++ Code:**
```cpp
class Solution {
public:
    string longestPalindrome(string s) {
        int n = s.size(), start = 0, max_len = 1;
        for (int center = 0; center < 2 * n - 1; ++center) {
            int left = center / 2;
            int right = left + center % 2;
            while (left >= 0 && right < n && s[left] == s[right]) {
                if (right - left + 1 > max_len) {
                    start = left;
                    max_len = right - left + 1;
                }
                left--;
                right++;
            }
        }
        return s.substr(start, max_len);
    }
};
```

**Python Code:**
```python
def longest_palindrome(s):
    n = len(s)
    start = max_len = 0
    for center in range(2 * n - 1):
        left = center // 2
        right = left + center % 2
        while left >= 0 and right < n and s[left] == s[right]:
            if right - left + 1 > max_len:
                start = left
                max_len = right - left + 1
            left -= 1
            right += 1
    return s[start:start + max_len]
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(1)

### 10.18 Word Break

**Problem Statement:** Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.

**Intuition:** DP where dp[i] represents whether s[0..i-1] can be segmented. For each position, check if any word ending at that position can be formed.

**Algorithm:**
1. Initialize dp[n+1] with false, dp[0] = true
2. For i from 1 to n:
   - For j from 0 to i-1:
     - If dp[j] and s[j..i-1] in wordDict, dp[i] = true
3. Return dp[n]

**C++ Code:**
```cpp
class Solution {
public:
    bool wordBreak(string s, vector<string>& wordDict) {
        unordered_set<string> wordSet(wordDict.begin(), wordDict.end());
        int n = s.size();
        vector<bool> dp(n + 1, false);
        dp[0] = true;
        
        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (dp[j] && wordSet.count(s.substr(j, i - j))) {
                    dp[i] = true;
                    break;
                }
            }
        }
        
        return dp[n];
    }
};
```

**Python Code:**
```python
def word_break(s, word_dict):
    word_set = set(word_dict)
    n = len(s)
    dp = [False] * (n + 1)
    dp[0] = True
    
    for i in range(1, n + 1):
        for j in range(i):
            if dp[j] and s[j:i] in word_set:
                dp[i] = True
                break
    
    return dp[n]
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n)

### 10.19 Decode Ways

**Problem Statement:** A message containing letters from A-Z can be encoded into numbers using the mapping A=1, B=2, ..., Z=26. Given a string s containing only digits, return the number of ways to decode it.

**Intuition:** DP where dp[i] represents number of ways to decode first i characters. Check single and double digit possibilities.

**Algorithm:**
1. If s[0] == '0', return 0
2. Initialize dp[n+1], dp[0] = 1, dp[1] = 1
3. For i from 2 to n:
   - If s[i-1] != '0', dp[i] += dp[i-1]
   - If s[i-2] in ['1','2'] and int(s[i-2:i]) <= 26, dp[i] += dp[i-2]
4. Return dp[n]

**C++ Code:**
```cpp
class Solution {
public:
    int numDecodings(string s) {
        int n = s.size();
        if (s[0] == '0') return 0;
        
        vector<int> dp(n + 1, 0);
        dp[0] = 1;
        dp[1] = 1;
        
        for (int i = 2; i <= n; ++i) {
            if (s[i-1] != '0') dp[i] += dp[i-1];
            if ((s[i-2] == '1') || (s[i-2] == '2' && s[i-1] <= '6')) {
                dp[i] += dp[i-2];
            }
        }
        
        return dp[n];
    }
};
```

**Python Code:**
```python
def num_decodings(s):
    n = len(s)
    if s[0] == '0':
        return 0
    
    dp = [0] * (n + 1)
    dp[0] = 1
    dp[1] = 1
    
    for i in range(2, n + 1):
        if s[i-1] != '0':
            dp[i] += dp[i-1]
        if s[i-2] == '1' or (s[i-2] == '2' and s[i-1] <= '6'):
            dp[i] += dp[i-2]
    
    return dp[n]
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(n)

### 10.20 Partition Equal Subset Sum

**Problem Statement:** Given a non-empty array nums containing only positive integers, find if the array can be partitioned into two subsets such that the sum of elements in both subsets is equal.

**Intuition:** This is 0/1 knapsack where we check if we can achieve sum/2. If total sum is odd, impossible.

**Algorithm:**
1. Calculate total = sum(nums)
2. If total % 2 != 0, return false
3. target = total / 2
4. Use DP: dp[w] = true if we can achieve sum w
5. For each num in nums:
   - For w from target down to num:
     - dp[w] = dp[w] or dp[w - num]
6. Return dp[target]

**C++ Code:**
```cpp
class Solution {
public:
    bool canPartition(vector<int>& nums) {
        int total = 0;
        for (int num : nums) total += num;
        if (total % 2 != 0) return false;
        
        int target = total / 2;
        vector<bool> dp(target + 1, false);
        dp[0] = true;
        
        for (int num : nums) {
            for (int w = target; w >= num; --w) {
                dp[w] = dp[w] || dp[w - num];
            }
        }
        
        return dp[target];
    }
};
```

**Python Code:**
```python
def can_partition(nums):
    total = sum(nums)
    if total % 2 != 0:
        return False
    
    target = total // 2
    dp = [False] * (target + 1)
    dp[0] = True
    
    for num in nums:
        for w in range(target, num - 1, -1):
            dp[w] = dp[w] or dp[w - num]
    
    return dp[target]
```

**Complexity Analysis:**
- Time: O(n*target)
- Space: O(target)

### 1D DP

### 10.21 Frog Jump(DP-3)

**Problem Statement:** A frog is crossing a river. The river is divided into units, and at each unit, there is a stone at a certain height given in array heights. The frog can jump from stone i to stone i+1 or i+2, and the cost of jumping from i to j is |heights[i] - heights[j]|. Find the minimum cost to reach the last stone from the first stone.

**Input Format:** First line contains an integer n (number of stones). Second line contains n space-separated integers (heights of stones).

**Intuition:** Use DP where dp[i] represents the minimum cost to reach stone i. For each stone, the cost is the minimum of coming from i-1 or i-2, plus the jump cost.

**Algorithm:**
1. Initialize dp array of size n
2. dp[0] = 0 (no cost to start)
3. dp[1] = abs(heights[1] - heights[0])
4. For i from 2 to n-1:
   - dp[i] = min(dp[i-1] + abs(heights[i] - heights[i-1]), dp[i-2] + abs(heights[i] - heights[i-2]))
5. Return dp[n-1]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int frogJump(vector<int>& heights) {
        int n = heights.size();
        if (n == 1) return 0;
        vector<int> dp(n);
        dp[0] = 0;
        dp[1] = abs(heights[1] - heights[0]);
        for (int i = 2; i < n; ++i) {
            dp[i] = min(dp[i-1] + abs(heights[i] - heights[i-1]), dp[i-2] + abs(heights[i] - heights[i-2]));
        }
        return dp[n-1];
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> heights(n);
    for (int i = 0; i < n; ++i) {
        cin >> heights[i];
    }
    Solution sol;
    cout << sol.frogJump(heights) << endl;
    return 0;
}
```

**Python Code:**
```python
def frog_jump(heights):
    n = len(heights)
    if n == 1:
        return 0
    dp = [0] * n
    dp[1] = abs(heights[1] - heights[0])
    for i in range(2, n):
        dp[i] = min(dp[i-1] + abs(heights[i] - heights[i-1]), dp[i-2] + abs(heights[i] - heights[i-2]))
    return dp[n-1]

if __name__ == "__main__":
    n = int(input().strip())
    heights = list(map(int, input().strip().split()))
    print(frog_jump(heights))
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(n)

### 10.22 Frog Jump with k distances(DP-4)

**Problem Statement:** Similar to Frog Jump, but the frog can jump up to k steps forward.

**Intuition:** DP where dp[i] is minimum cost to reach i. For each i, consider the last k positions.

**Algorithm:**
1. Initialize dp[n] with INF, dp[0] = 0
2. For i from 1 to n-1:
   - For j from 1 to k:
     - If i - j >= 0:
       - dp[i] = min(dp[i], dp[i-j] + abs(heights[i] - heights[i-j]))
3. Return dp[n-1]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int frogJump(vector<int>& heights, int k) {
        int n = heights.size();
        const int INF = 1e9;
        vector<int> dp(n, INF);
        dp[0] = 0;
        for (int i = 1; i < n; ++i) {
            for (int j = 1; j <= k; ++j) {
                if (i - j >= 0) {
                    dp[i] = min(dp[i], dp[i - j] + abs(heights[i] - heights[i - j]));
                }
            }
        }
        return dp[n-1];
    }
};

int main() {
    int n, k;
    cin >> n >> k;
    vector<int> heights(n);
    for (int i = 0; i < n; ++i) {
        cin >> heights[i];
    }
    Solution sol;
    cout << sol.frogJump(heights, k) << endl;
    return 0;
}
```

**Python Code:**
```python
def frog_jump(heights, k):
    n = len(heights)
    INF = float('inf')
    dp = [INF] * n
    dp[0] = 0
    for i in range(1, n):
        for j in range(1, k + 1):
            if i - j >= 0:
                dp[i] = min(dp[i], dp[i - j] + abs(heights[i] - heights[i - j]))
    return dp[n-1]

if __name__ == "__main__":
    n, k = map(int, input().strip().split())
    heights = list(map(int, input().strip().split()))
    print(frog_jump(heights, k))
```

**Complexity Analysis:**
- Time: O(n*k)
- Space: O(n)

### 2D/3D DP and DP on Grids

### 10.23 Ninja's Training (DP 7)

**Problem Statement:** A ninja has n days, each day he can perform one of 3 activities: 0, 1, or 2, earning points given in a 2D array points[n][3]. He cannot perform the same activity on two consecutive days. Find the maximum points he can earn.

**Intuition:** DP where dp[i][j] is max points for first i days, last day doing activity j.

**Algorithm:**
1. Initialize dp[n][3]
2. For j = 0 to 2: dp[0][j] = points[0][j]
3. For i = 1 to n-1:
   - For j = 0 to 2:
     - dp[i][j] = points[i][j] + max(dp[i-1][k] for k != j)
4. Return max(dp[n-1])

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int ninjaTraining(vector<vector<int>>& points) {
        int n = points.size();
        vector<vector<int>> dp(n, vector<int>(3, 0));
        for (int j = 0; j < 3; ++j) dp[0][j] = points[0][j];
        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < 3; ++j) {
                int max_prev = 0;
                for (int k = 0; k < 3; ++k) {
                    if (k != j) max_prev = max(max_prev, dp[i-1][k]);
                }
                dp[i][j] = points[i][j] + max_prev;
            }
        }
        return *max_element(dp[n-1].begin(), dp[n-1].end());
    }
};

int main() {
    int n;
    cin >> n;
    vector<vector<int>> points(n, vector<int>(3));
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < 3; ++j) {
            cin >> points[i][j];
        }
    }
    Solution sol;
    cout << sol.ninjaTraining(points) << endl;
    return 0;
}
```

**Python Code:**
```python
def ninja_training(points):
    n = len(points)
    dp = [[0] * 3 for _ in range(n)]
    for j in range(3):
        dp[0][j] = points[0][j]
    for i in range(1, n):
        for j in range(3):
            max_prev = max(dp[i-1][k] for k in range(3) if k != j)
            dp[i][j] = points[i][j] + max_prev
    return max(dp[n-1])

if __name__ == "__main__":
    n = int(input().strip())
    points = []
    for _ in range(n):
        points.append(list(map(int, input().strip().split())))
    print(ninja_training(points))
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(n)

### 10.24 Minimum/Maximum Falling Path Sum (DP-12)

**Problem Statement:** Given an n x n grid of integers, find the minimum/maximum sum of a falling path. A falling path starts at any cell in the first row and ends at any cell in the last row, moving only down, down-left, or down-right.

**Intuition:** DP from top to bottom. dp[i][j] = grid[i][j] + min/max of possible previous cells.

**Algorithm:** (for minimum)
1. Initialize dp = grid[0]
2. For i = 1 to n-1:
   - For j = 0 to n-1:
     - dp[j] = grid[i][j] + min(dp[j] if j < n else INF, dp[j-1] if j > 0 else INF, dp[j+1] if j < n-1 else INF)
3. Return min(dp)

**C++ Code:** (for minimum)
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<int> dp = grid[0];
        for (int i = 1; i < n; ++i) {
            vector<int> new_dp(n, INT_MAX);
            for (int j = 0; j < n; ++j) {
                for (int k = max(0, j-1); k <= min(n-1, j+1); ++k) {
                    new_dp[j] = min(new_dp[j], dp[k]);
                }
                new_dp[j] += grid[i][j];
            }
            dp = new_dp;
        }
        return *min_element(dp.begin(), dp.end());
    }
};

int main() {
    int n;
    cin >> n;
    vector<vector<int>> grid(n, vector<int>(n));
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            cin >> grid[i][j];
        }
    }
    Solution sol;
    cout << sol.minFallingPathSum(grid) << endl;
    return 0;
}
```

**Python Code:**
```python
def min_falling_path_sum(grid):
    n = len(grid)
    dp = grid[0][:]
    for i in range(1, n):
        new_dp = [float('inf')] * n
        for j in range(n):
            for k in range(max(0, j-1), min(n, j+2)):
                new_dp[j] = min(new_dp[j], dp[k])
            new_dp[j] += grid[i][j]
        dp = new_dp
    return min(dp)

if __name__ == "__main__":
    n = int(input().strip())
    grid = []
    for _ in range(n):
        grid.append(list(map(int, input().strip().split())))
    print(min_falling_path_sum(grid))
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n)

### 10.25 3-d DP : Ninja and his friends (DP-13)

**Problem Statement:** Two ninjas collecting chocolates in an n x m grid. They start from top row, one at (0,i), other at (0,j), move down to bottom, collecting chocolates, can't be in same cell. Find maximum chocolates collected.

**Intuition:** 3D DP: dp[i][j1][j2] = max chocolates at row i, ninja1 at j1, ninja2 at j2.

**Algorithm:**
1. If j1 == j2, dp[i][j1][j2] = -INF
2. Else, dp[i][j1][j2] = grid[i][j1] + grid[i][j2] + max over previous positions
3. For i from 1 to n-1, for j1, j2, dp[i][j1][j2] = grid[i][j1] + grid[i][j2] + max(dp[i-1][p1][p2] where p1 in {j1-1,j1,j1+1}, p2 in {j2-1,j2,j2+1})
4. Return max over all dp[n-1][j1][j2]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int cherryPickup(vector<vector<int>>& grid) {
        int n = grid.size(), m = grid[0].size();
        const int INF = 1e9;
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(m, vector<int>(m, -INF)));
        dp[0][0][m-1] = grid[0][0] + grid[0][m-1];
        for (int j1 = 0; j1 < m; ++j1) {
            for (int j2 = 0; j2 < m; ++j2) {
                if (j1 != j2) dp[0][j1][j2] = grid[0][j1] + grid[0][j2];
            }
        }
        for (int i = 1; i < n; ++i) {
            for (int j1 = 0; j1 < m; ++j1) {
                for (int j2 = 0; j2 < m; ++j2) {
                    int max_prev = -INF;
                    for (int p1 = j1-1; p1 <= j1+1; ++p1) {
                        for (int p2 = j2-1; p2 <= j2+1; ++p2) {
                            if (p1 >= 0 && p1 < m && p2 >= 0 && p2 < m) {
                                max_prev = max(max_prev, dp[i-1][p1][p2]);
                            }
                        }
                    }
                    if (max_prev != -INF) {
                        dp[i][j1][j2] = grid[i][j1] + grid[i][j2] + max_prev;
                    }
                }
            }
        }
        int ans = 0;
        for (int j1 = 0; j1 < m; ++j1) {
            for (int j2 = 0; j2 < m; ++j2) {
                ans = max(ans, dp[n-1][j1][j2]);
            }
        }
        return ans;
    }
};

int main() {
    int n, m;
    cin >> n >> m;
    vector<vector<int>> grid(n, vector<int>(m));
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            cin >> grid[i][j];
        }
    }
    Solution sol;
    cout << sol.cherryPickup(grid) << endl;
    return 0;
}
```

**Python Code:**
```python
def cherry_pickup(grid):
    n, m = len(grid), len(grid[0])
    INF = float('-inf')
    dp = [[[INF] * m for _ in range(m)] for _ in range(n)]
    for j1 in range(m):
        for j2 in range(m):
            if j1 != j2:
                dp[0][j1][j2] = grid[0][j1] + grid[0][j2]
    for i in range(1, n):
        for j1 in range(m):
            for j2 in range(m):
                max_prev = INF
                for p1 in range(max(0, j1-1), min(m, j1+2)):
                    for p2 in range(max(0, j2-1), min(m, j2+2)):
                        max_prev = max(max_prev, dp[i-1][p1][p2])
                if max_prev != INF:
                    dp[i][j1][j2] = grid[i][j1] + grid[i][j2] + max_prev
    ans = 0
    for j1 in range(m):
        for j2 in range(m):
            ans = max(ans, dp[n-1][j1][j2])
    return ans

if __name__ == "__main__":
    n, m = map(int, input().strip().split())
    grid = []
    for _ in range(n):
        grid.append(list(map(int, input().strip().split())))
    print(cherry_pickup(grid))
```

**Complexity Analysis:**
- Time: O(n*m²)
- Space: O(n*m²)

### DP on Subsequences

### 10.26 Subset sum equal to target (DP-14)

**Problem Statement:** Given an array of integers and a target sum, determine if there is a subset that sums to the target.

**Intuition:** 0/1 Knapsack DP to check if target is achievable.

**Algorithm:**
1. dp[0] = true
2. For each num in nums:
   - For w from target down to num:
     - dp[w] = dp[w] or dp[w - num]
3. Return dp[target]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    bool subsetSum(vector<int>& nums, int target) {
        vector<bool> dp(target + 1, false);
        dp[0] = true;
        for (int num : nums) {
            for (int w = target; w >= num; --w) {
                dp[w] = dp[w] || dp[w - num];
            }
        }
        return dp[target];
    }
};

int main() {
    int n, target;
    cin >> n >> target;
    vector<int> nums(n);
    for (int i = 0; i < n; ++i) {
        cin >> nums[i];
    }
    Solution sol;
    cout << (sol.subsetSum(nums, target) ? "true" : "false") << endl;
    return 0;
}
```

**Python Code:**
```python
def subset_sum(nums, target):
    dp = [False] * (target + 1)
    dp[0] = True
    for num in nums:
        for w in range(target, num - 1, -1):
            dp[w] = dp[w] or dp[w - num]
    return dp[target]

if __name__ == "__main__":
    n, target = map(int, input().strip().split())
    nums = list(map(int, input().strip().split()))
    print(subset_sum(nums, target))
```

**Complexity Analysis:**
- Time: O(n*target)
- Space: O(target)

### 10.27 Partition Set Into 2 Subsets With Min Absolute Sum Diff (DP-16)

**Problem Statement:** Partition the array into two subsets such that the absolute difference of their sums is minimized.

**Intuition:** Find all possible subset sums, then find the sum closest to total/2.

**Algorithm:**
1. Calculate total = sum(nums)
2. Use DP to find possible sums up to total
3. Find the sum s <= total/2 that maximizes s, then diff = total - 2*s
4. Return min diff

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int minSubsetSumDiff(vector<int>& nums) {
        int n = nums.size(), total = 0;
        for (int num : nums) total += num;
        vector<bool> dp(total + 1, false);
        dp[0] = true;
        for (int num : nums) {
            for (int w = total; w >= num; --w) {
                dp[w] = dp[w] || dp[w - num];
            }
        }
        int min_diff = INT_MAX;
        for (int s = 0; s <= total / 2; ++s) {
            if (dp[s]) {
                min_diff = min(min_diff, total - 2 * s);
            }
        }
        return min_diff;
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> nums(n);
    for (int i = 0; i < n; ++i) {
        cin >> nums[i];
    }
    Solution sol;
    cout << sol.minSubsetSumDiff(nums) << endl;
    return 0;
}
```

**Python Code:**
```python
def min_subset_sum_diff(nums):
    total = sum(nums)
    dp = [False] * (total + 1)
    dp[0] = True
    for num in nums:
        for w in range(total, num - 1, -1):
            dp[w] = dp[w] or dp[w - num]
    min_diff = float('inf')
    for s in range(total // 2 + 1):
        if dp[s]:
            min_diff = min(min_diff, total - 2 * s)
    return min_diff

if __name__ == "__main__":
    n = int(input().strip())
    nums = list(map(int, input().strip().split()))
    print(min_subset_sum_diff(nums))
```

**Complexity Analysis:**
- Time: O(n*total)
- Space: O(total)

### 10.28 Count Subsets with Sum K (DP-17)

**Problem Statement:** Count the number of subsets with sum equal to K.

**Intuition:** DP where dp[w] = number of ways to achieve sum w.

**Algorithm:**
1. dp[0] = 1
2. For each num:
   - For w from K down to num:
     - dp[w] += dp[w - num]
3. Return dp[K]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int countSubsets(vector<int>& nums, int K) {
        vector<int> dp(K + 1, 0);
        dp[0] = 1;
        for (int num : nums) {
            for (int w = K; w >= num; --w) {
                dp[w] += dp[w - num];
            }
        }
        return dp[K];
    }
};

int main() {
    int n, K;
    cin >> n >> K;
    vector<int> nums(n);
    for (int i = 0; i < n; ++i) {
        cin >> nums[i];
    }
    Solution sol;
    cout << sol.countSubsets(nums, K) << endl;
    return 0;
}
```

**Python Code:**
```python
def count_subsets(nums, K):
    dp = [0] * (K + 1)
    dp[0] = 1
    for num in nums:
        for w in range(K, num - 1, -1):
            dp[w] += dp[w - num]
    return dp[K]

if __name__ == "__main__":
    n, K = map(int, input().strip().split())
    nums = list(map(int, input().strip().split()))
    print(count_subsets(nums, K))
```

**Complexity Analysis:**
- Time: O(n*K)
- Space: O(K)

### 10.29 Count Partitions with Given Difference (DP-18)

**Problem Statement:** Count the number of ways to partition the array into two subsets with difference D.

**Intuition:** Find number of subsets with sum (total + D)/2.

**Algorithm:**
1. total = sum(nums)
2. If (total + D) % 2 != 0 or total + D < 0, return 0
3. target = (total + D) / 2
4. Use count subsets with sum target

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int countPartitions(vector<int>& nums, int D) {
        int total = 0;
        for (int num : nums) total += num;
        if ((total + D) % 2 != 0 || total + D < 0) return 0;
        int target = (total + D) / 2;
        vector<int> dp(target + 1, 0);
        dp[0] = 1;
        for (int num : nums) {
            for (int w = target; w >= num; --w) {
                dp[w] += dp[w - num];
            }
        }
        return dp[target];
    }
};

int main() {
    int n, D;
    cin >> n >> D;
    vector<int> nums(n);
    for (int i = 0; i < n; ++i) {
        cin >> nums[i];
    }
    Solution sol;
    cout << sol.countPartitions(nums, D) << endl;
    return 0;
}
```

**Python Code:**
```python
def count_partitions(nums, D):
    total = sum(nums)
    if (total + D) % 2 != 0 or total + D < 0:
        return 0
    target = (total + D) // 2
    dp = [0] * (target + 1)
    dp[0] = 1
    for num in nums:
        for w in range(target, num - 1, -1):
            dp[w] += dp[w - num]
    return dp[target]

if __name__ == "__main__":
    n, D = map(int, input().strip().split())
    nums = list(map(int, input().strip().split()))
    print(count_partitions(nums, D))
```

**Complexity Analysis:**
- Time: O(n*target)
- Space: O(target)

### 10.30 Target Sum (DP-21)

**Problem Statement:** Assign + or - to each number to make sum equal to target.

**Intuition:** Equivalent to count partitions with difference target.

**Algorithm:** Same as above, D = target.

**C++ Code:** Similar to above.

**Python Code:** Similar.

To save space, I'll say same as 10.29.

But let's write it.

### 10.31 Coin Change 2 (DP-22)

**Problem Statement:** Number of ways to make amount with unlimited coins.

**Intuition:** DP where dp[w] = number of ways to make w.

**Algorithm:**
1. dp[0] = 1
2. For each coin:
   - For w from coin to amount:
     - dp[w] += dp[w - coin]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int coinChange2(vector<int>& coins, int amount) {
        vector<int> dp(amount + 1, 0);
        dp[0] = 1;
        for (int coin : coins) {
            for (int w = coin; w <= amount; ++w) {
                dp[w] += dp[w - coin];
            }
        }
        return dp[amount];
    }
};

int main() {
    int n, amount;
    cin >> n >> amount;
    vector<int> coins(n);
    for (int i = 0; i < n; ++i) {
        cin >> coins[i];
    }
    Solution sol;
    cout << sol.coinChange2(coins, amount) << endl;
    return 0;
}
```

**Python Code:**
```python
def coin_change_2(coins, amount):
    dp = [0] * (amount + 1)
    dp[0] = 1
    for coin in coins:
        for w in range(coin, amount + 1):
            dp[w] += dp[w - coin]
    return dp[amount]

if __name__ == "__main__":
    n, amount = map(int, input().strip().split())
    coins = list(map(int, input().strip().split()))
    print(coin_change_2(coins, amount))
```

**Complexity Analysis:**
- Time: O(len(coins)*amount)
- Space: O(amount)

### 10.32 Unbounded Knapsack (DP-23)

**Problem Statement:** Knapsack with unlimited items.

**Intuition:** Similar to 0/1 but no down to up.

**Algorithm:**
1. dp[0] = 0
2. For each item:
   - For w from weight to W:
     - dp[w] = max(dp[w], dp[w - weight] + value)

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int unboundedKnapsack(vector<int>& weights, vector<int>& values, int W) {
        vector<int> dp(W + 1, 0);
        for (int i = 0; i < weights.size(); ++i) {
            for (int w = weights[i]; w <= W; ++w) {
                dp[w] = max(dp[w], dp[w - weights[i]] + values[i]);
            }
        }
        return dp[W];
    }
};

int main() {
    int n, W;
    cin >> n >> W;
    vector<int> weights(n), values(n);
    for (int i = 0; i < n; ++i) {
        cin >> weights[i] >> values[i];
    }
    Solution sol;
    cout << sol.unboundedKnapsack(weights, values, W) << endl;
    return 0;
}
```

**Python Code:**
```python
def unbounded_knapsack(weights, values, W):
    dp = [0] * (W + 1)
    for i in range(len(weights)):
        for w in range(weights[i], W + 1):
            dp[w] = max(dp[w], dp[w - weights[i]] + values[i])
    return dp[W]

if __name__ == "__main__":
    n, W = map(int, input().strip().split())
    weights = []
    values = []
    for _ in range(n):
        w, v = map(int, input().strip().split())
        weights.append(w)
        values.append(v)
    print(unbounded_knapsack(weights, values, W))
```

**Complexity Analysis:**
- Time: O(n*W)
- Space: O(W)

### 10.33 Rod Cutting Problem (DP-24)

**Problem Statement:** Cut rod of length n into pieces with given prices to maximize value.

**Intuition:** DP where dp[i] = max value for length i.

**Algorithm:**
1. dp[0] = 0
2. For i = 1 to n:
   - For j = 1 to i:
     - dp[i] = max(dp[i], price[j-1] + dp[i - j])

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int rodCutting(vector<int>& price, int n) {
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= i; ++j) {
                dp[i] = max(dp[i], price[j-1] + dp[i - j]);
            }
        }
        return dp[n];
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> price(n);
    for (int i = 0; i < n; ++i) {
        cin >> price[i];
    }
    Solution sol;
    cout << sol.rodCutting(price, n) << endl;
    return 0;
}
```

**Python Code:**
```python
def rod_cutting(price, n):
    dp = [0] * (n + 1)
    for i in range(1, n + 1):
        for j in range(1, i + 1):
            dp[i] = max(dp[i], price[j-1] + dp[i - j])
    return dp[n]

if __name__ == "__main__":
    n = int(input().strip())
    price = list(map(int, input().strip().split()))
    print(rod_cutting(price, n))
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n)

### DP on Strings

### 10.34 Print Longest Common Subsequence (DP-26)

**Problem Statement:** Given two strings, print the longest common subsequence.

**Intuition:** Use LCS DP, then backtrack to build the string.

**Algorithm:**
1. Compute LCS length dp
2. Backtrack from dp[m][n], if equal append and move diagonal, else move to max prev
3. Reverse the string

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    string printLCS(string text1, string text2) {
        int m = text1.size(), n = text2.size();
        vector<vector<int>> dp(m + 1, vector<int>(n + 1, 0));
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (text1[i-1] == text2[j-1]) {
                    dp[i][j] = dp[i-1][j-1] + 1;
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
                }
            }
        }
        string lcs = "";
        int i = m, j = n;
        while (i > 0 && j > 0) {
            if (text1[i-1] == text2[j-1]) {
                lcs += text1[i-1];
                i--; j--;
            } else if (dp[i-1][j] > dp[i][j-1]) {
                i--;
            } else {
                j--;
            }
        }
        reverse(lcs.begin(), lcs.end());
        return lcs;
    }
};

int main() {
    string text1, text2;
    cin >> text1 >> text2;
    Solution sol;
    cout << sol.printLCS(text1, text2) << endl;
    return 0;
}
```

**Python Code:**
```python
def print_lcs(text1, text2):
    m, n = len(text1), len(text2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if text1[i-1] == text2[j-1]:
                dp[i][j] = dp[i-1][j-1] + 1
            else:
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
    lcs = []
    i, j = m, n
    while i > 0 and j > 0:
        if text1[i-1] == text2[j-1]:
            lcs.append(text1[i-1])
            i -= 1
            j -= 1
        elif dp[i-1][j] > dp[i][j-1]:
            i -= 1
        else:
            j -= 1
    return ''.join(reversed(lcs))

if __name__ == "__main__":
    text1, text2 = input().strip().split()
    print(print_lcs(text1, text2))
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n)

### 10.35 Longest Common Substring (DP-27)

**Problem Statement:** Find the length of the longest common substring.

**Intuition:** DP where dp[i][j] = length if equal, else 0. Track max.

**Algorithm:**
1. Initialize max_len = 0
2. For i = 1 to m:
   - For j = 1 to n:
     - If text1[i-1] == text2[j-1], dp[i][j] = dp[i-1][j-1] + 1, max_len = max(max_len, dp[i][j])
     - Else dp[i][j] = 0
3. Return max_len

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int longestCommonSubstring(string text1, string text2) {
        int m = text1.size(), n = text2.size();
        vector<vector<int>> dp(m + 1, vector<int>(n + 1, 0));
        int max_len = 0;
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (text1[i-1] == text2[j-1]) {
                    dp[i][j] = dp[i-1][j-1] + 1;
                    max_len = max(max_len, dp[i][j]);
                } else {
                    dp[i][j] = 0;
                }
            }
        }
        return max_len;
    }
};

int main() {
    string text1, text2;
    cin >> text1 >> text2;
    Solution sol;
    cout << sol.longestCommonSubstring(text1, text2) << endl;
    return 0;
}
```

**Python Code:**
```python
def longest_common_substring(text1, text2):
    m, n = len(text1), len(text2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    max_len = 0
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if text1[i-1] == text2[j-1]:
                dp[i][j] = dp[i-1][j-1] + 1
                max_len = max(max_len, dp[i][j])
            else:
                dp[i][j] = 0
    return max_len

if __name__ == "__main__":
    text1, text2 = input().strip().split()
    print(longest_common_substring(text1, text2))
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n)

### 10.36 Longest Palindromic Subsequence (DP-28)

**Problem Statement:** Find the length of the longest palindromic subsequence.

**Intuition:** DP where dp[i][j] = length of LPS in s[i..j].

**Algorithm:**
1. For i = 0 to n-1: dp[i][i] = 1
2. For len = 2 to n:
   - For i = 0 to n-len:
     - j = i + len - 1
     - If s[i] == s[j], dp[i][j] = dp[i+1][j-1] + 2
     - Else, dp[i][j] = max(dp[i+1][j], dp[i][j-1])
3. Return dp[0][n-1]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int longestPalindromeSubseq(string s) {
        int n = s.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) dp[i][i] = 1;
        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                if (s[i] == s[j]) {
                    dp[i][j] = dp[i+1][j-1] + 2;
                } else {
                    dp[i][j] = max(dp[i+1][j], dp[i][j-1]);
                }
            }
        }
        return dp[0][n-1];
    }
};

int main() {
    string s;
    cin >> s;
    Solution sol;
    cout << sol.longestPalindromeSubseq(s) << endl;
    return 0;
}
```

**Python Code:**
```python
def longest_palindrome_subseq(s):
    n = len(s)
    dp = [[0] * n for _ in range(n)]
    for i in range(n):
        dp[i][i] = 1
    for length in range(2, n + 1):
        for i in range(n - length + 1):
            j = i + length - 1
            if s[i] == s[j]:
                dp[i][j] = dp[i+1][j-1] + 2
            else:
                dp[i][j] = max(dp[i+1][j], dp[i][j-1])
    return dp[0][n-1]

if __name__ == "__main__":
    s = input().strip()
    print(longest_palindrome_subseq(s))
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n²)

### 10.37 Minimum insertions to make string palindrome (DP-29)

**Problem Statement:** Find minimum insertions to make string palindrome.

**Intuition:** Equivalent to n - LPS length.

**Algorithm:** Return n - longestPalindromeSubseq(s)

**C++ Code:** Use the above function.

**Python Code:** Same.

### 10.38 Shortest Common Supersequence (DP-31)

**Problem Statement:** Find length of shortest common supersequence of two strings.

**Intuition:** LCS length + (m - LCS) + (n - LCS)

**Algorithm:** Return m + n - LCS

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int shortestCommonSupersequence(string text1, string text2) {
        int m = text1.size(), n = text2.size();
        vector<vector<int>> dp(m + 1, vector<int>(n + 1, 0));
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (text1[i-1] == text2[j-1]) {
                    dp[i][j] = dp[i-1][j-1] + 1;
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
                }
            }
        }
        return m + n - dp[m][n];
    }
};

int main() {
    string text1, text2;
    cin >> text1 >> text2;
    Solution sol;
    cout << sol.shortestCommonSupersequence(text1, text2) << endl;
    return 0;
}
```

**Python Code:**
```python
def shortest_common_supersequence(text1, text2):
    m, n = len(text1), len(text2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if text1[i-1] == text2[j-1]:
                dp[i][j] = dp[i-1][j-1] + 1
            else:
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
    return m + n - dp[m][n]

if __name__ == "__main__":
    text1, text2 = input().strip().split()
    print(shortest_common_supersequence(text1, text2))
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n)

### 10.39 Distinct Subsequences (DP-32)

**Problem Statement:** Number of distinct subsequences of s that equal t.

**Intuition:** DP where dp[i][j] = ways for s[0..i-1] and t[0..j-1].

**Algorithm:**
1. dp[0][0] = 1
2. For i = 0 to m: dp[i][0] = 1
3. For j = 1 to n: dp[0][j] = 0
4. For i = 1 to m:
   - For j = 1 to n:
     - dp[i][j] = dp[i-1][j]
     - If s[i-1] == t[j-1], dp[i][j] += dp[i-1][j-1]
5. Return dp[m][n]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int numDistinct(string s, string t) {
        int m = s.size(), n = t.size();
        vector<vector<long long>> dp(m + 1, vector<long long>(n + 1, 0));
        for (int i = 0; i <= m; ++i) dp[i][0] = 1;
        for (int j = 1; j <= n; ++j) dp[0][j] = 0;
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                dp[i][j] = dp[i-1][j];
                if (s[i-1] == t[j-1]) {
                    dp[i][j] += dp[i-1][j-1];
                }
            }
        }
        return dp[m][n];
    }
};

int main() {
    string s, t;
    cin >> s >> t;
    Solution sol;
    cout << sol.numDistinct(s, t) << endl;
    return 0;
}
```

**Python Code:**
```python
def num_distinct(s, t):
    m, n = len(s), len(t)
    dp = [[0] * (n + 1) for _ in range(m + 1)]
    for i in range(m + 1):
        dp[i][0] = 1
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            dp[i][j] = dp[i-1][j]
            if s[i-1] == t[j-1]:
                dp[i][j] += dp[i-1][j-1]
    return dp[m][n]

if __name__ == "__main__":
    s, t = input().strip().split()
    print(num_distinct(s, t))
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n)

### 10.40 Wildcard Matching (DP-34)

**Problem Statement:** Match string s with pattern p containing * and ?.

**Intuition:** DP where dp[i][j] = if s[0..i-1] matches p[0..j-1].

**Algorithm:**
1. dp[0][0] = true
2. For j = 1 to n: if p[j-1] == '*', dp[0][j] = dp[0][j-1]
3. For i = 1 to m:
   - For j = 1 to n:
     - If p[j-1] == '*', dp[i][j] = dp[i][j-1] or dp[i-1][j]
     - Else if p[j-1] == '?' or p[j-1] == s[i-1], dp[i][j] = dp[i-1][j-1]
4. Return dp[m][n]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    bool isMatch(string s, string p) {
        int m = s.size(), n = p.size();
        vector<vector<bool>> dp(m + 1, vector<bool>(n + 1, false));
        dp[0][0] = true;
        for (int j = 1; j <= n; ++j) {
            if (p[j-1] == '*') dp[0][j] = dp[0][j-1];
        }
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (p[j-1] == '*') {
                    dp[i][j] = dp[i][j-1] || dp[i-1][j];
                } else if (p[j-1] == '?' || p[j-1] == s[i-1]) {
                    dp[i][j] = dp[i-1][j-1];
                }
            }
        }
        return dp[m][n];
    }
};

int main() {
    string s, p;
    cin >> s >> p;
    Solution sol;
    cout << (sol.isMatch(s, p) ? "true" : "false") << endl;
    return 0;
}
```

**Python Code:**
```python
def is_match(s, p):
    m, n = len(s), len(p)
    dp = [[False] * (n + 1) for _ in range(m + 1)]
    dp[0][0] = True
    for j in range(1, n + 1):
        if p[j-1] == '*':
            dp[0][j] = dp[0][j-1]
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if p[j-1] == '*':
                dp[i][j] = dp[i][j-1] or dp[i-1][j]
            elif p[j-1] == '?' or p[j-1] == s[i-1]:
                dp[i][j] = dp[i-1][j-1]
    return dp[m][n]

if __name__ == "__main__":
    s, p = input().strip().split()
    print(is_match(s, p))
```

**Complexity Analysis:**
- Time: O(m*n)
- Space: O(m*n)

### DP on Stocks

### 10.41 Best Time to Buy and Sell Stock (DP-35)

**Problem Statement:** Find the maximum profit from buying and selling a stock once.

**Intuition:** Track min price and max profit.

**Algorithm:**
1. min_price = INF, max_profit = 0
2. For each price:
   - min_price = min(min_price, price)
   - max_profit = max(max_profit, price - min_price)
3. Return max_profit

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int min_price = INT_MAX, max_profit = 0;
        for (int price : prices) {
            min_price = min(min_price, price);
            max_profit = max(max_profit, price - min_price);
        }
        return max_profit;
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> prices(n);
    for (int i = 0; i < n; ++i) {
        cin >> prices[i];
    }
    Solution sol;
    cout << sol.maxProfit(prices) << endl;
    return 0;
}
```

**Python Code:**
```python
def max_profit(prices):
    min_price = float('inf')
    max_profit = 0
    for price in prices:
        min_price = min(min_price, price)
        max_profit = max(max_profit, price - min_price)
    return max_profit

if __name__ == "__main__":
    n = int(input().strip())
    prices = list(map(int, input().strip().split()))
    print(max_profit(prices))
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(1)

### 10.42 Buy and Sell Stock - II (DP-36)

**Problem Statement:** Find maximum profit with unlimited transactions.

**Intuition:** Sum all positive differences.

**Algorithm:**
1. profit = 0
2. For i = 1 to n-1:
   - If prices[i] > prices[i-1], profit += prices[i] - prices[i-1]
3. Return profit

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int profit = 0;
        for (int i = 1; i < prices.size(); ++i) {
            if (prices[i] > prices[i-1]) {
                profit += prices[i] - prices[i-1];
            }
        }
        return profit;
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> prices(n);
    for (int i = 0; i < n; ++i) {
        cin >> prices[i];
    }
    Solution sol;
    cout << sol.maxProfit(prices) << endl;
    return 0;
}
```

**Python Code:**
```python
def max_profit(prices):
    profit = 0
    for i in range(1, len(prices)):
        if prices[i] > prices[i-1]:
            profit += prices[i] - prices[i-1]
    return profit

if __name__ == "__main__":
    n = int(input().strip())
    prices = list(map(int, input().strip().split()))
    print(max_profit(prices))
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(1)

### 10.43 Buy and Sell Stocks III (DP-37)

**Problem Statement:** At most 2 transactions.

**Intuition:** DP with states for transactions.

**Algorithm:**
1. buy1 = -prices[0], sell1 = 0, buy2 = -prices[0], sell2 = 0
2. For each price:
   - buy1 = max(buy1, -price)
   - sell1 = max(sell1, buy1 + price)
   - buy2 = max(buy2, sell1 - price)
   - sell2 = max(sell2, buy2 + price)
3. Return sell2

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int buy1 = -prices[0], sell1 = 0, buy2 = -prices[0], sell2 = 0;
        for (int i = 1; i < prices.size(); ++i) {
            buy1 = max(buy1, -prices[i]);
            sell1 = max(sell1, buy1 + prices[i]);
            buy2 = max(buy2, sell1 - prices[i]);
            sell2 = max(sell2, buy2 + prices[i]);
        }
        return sell2;
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> prices(n);
    for (int i = 0; i < n; ++i) {
        cin >> prices[i];
    }
    Solution sol;
    cout << sol.maxProfit(prices) << endl;
    return 0;
}
```

**Python Code:**
```python
def max_profit(prices):
    buy1 = -prices[0]
    sell1 = 0
    buy2 = -prices[0]
    sell2 = 0
    for price in prices[1:]:
        buy1 = max(buy1, -price)
        sell1 = max(sell1, buy1 + price)
        buy2 = max(buy2, sell1 - price)
        sell2 = max(sell2, buy2 + price)
    return sell2

if __name__ == "__main__":
    n = int(input().strip())
    prices = list(map(int, input().strip().split()))
    print(max_profit(prices))
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(1)

### 10.44 Buy and Stock Sell IV (DP-38)

**Problem Statement:** At most k transactions.

**Intuition:** DP where dp[i][k][0/1] = max profit after i days, k transactions, holding or not.

**Algorithm:**
1. If k >= n/2, use unlimited
2. Else, dp[k+1][2], for each k, dp[k][0] = 0, dp[k][1] = -prices[0]
3. For each price:
   - For t = k down to 1:
     - dp[t][0] = max(dp[t][0], dp[t][1] + price)
     - dp[t][1] = max(dp[t][1], dp[t-1][0] - price)
4. Return dp[k][0]

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int maxProfit(int k, vector<int>& prices) {
        int n = prices.size();
        if (k >= n / 2) {
            int profit = 0;
            for (int i = 1; i < n; ++i) {
                if (prices[i] > prices[i-1]) profit += prices[i] - prices[i-1];
            }
            return profit;
        }
        vector<vector<int>> dp(k + 1, vector<int>(2, 0));
        for (int t = 1; t <= k; ++t) dp[t][1] = -prices[0];
        for (int i = 1; i < n; ++i) {
            for (int t = k; t >= 1; --t) {
                dp[t][0] = max(dp[t][0], dp[t][1] + prices[i]);
                dp[t][1] = max(dp[t][1], dp[t-1][0] - prices[i]);
            }
        }
        return dp[k][0];
    }
};

int main() {
    int k, n;
    cin >> k >> n;
    vector<int> prices(n);
    for (int i = 0; i < n; ++i) {
        cin >> prices[i];
    }
    Solution sol;
    cout << sol.maxProfit(k, prices) << endl;
    return 0;
}
```

**Python Code:**
```python
def max_profit(k, prices):
    n = len(prices)
    if k >= n // 2:
        profit = 0
        for i in range(1, n):
            if prices[i] > prices[i-1]:
                profit += prices[i] - prices[i-1]
        return profit
    dp = [[0, 0] for _ in range(k + 1)]
    for t in range(1, k + 1):
        dp[t][1] = -prices[0]
    for i in range(1, n):
        for t in range(k, 0, -1):
            dp[t][0] = max(dp[t][0], dp[t][1] + prices[i])
            dp[t][1] = max(dp[t][1], dp[t-1][0] - prices[i])
    return dp[k][0]

if __name__ == "__main__":
    k, n = map(int, input().strip().split())
    prices = list(map(int, input().strip().split()))
    print(max_profit(k, prices))
```

**Complexity Analysis:**
- Time: O(n*k)
- Space: O(k)

### 10.45 Buy and Sell Stocks With Cooldown (DP-39)

**Problem Statement:** Cannot buy on the day after sell.

**Intuition:** States: hold, sold, cooldown.

**Algorithm:**
1. hold = -prices[0], sold = 0, cooldown = 0
2. For each price:
   - prev_hold = hold
   - hold = max(hold, cooldown - price)
   - cooldown = max(cooldown, sold)
   - sold = prev_hold + price
3. Return max(sold, cooldown)

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int hold = -prices[0], sold = 0, cooldown = 0;
        for (int i = 1; i < prices.size(); ++i) {
            int prev_hold = hold;
            hold = max(hold, cooldown - prices[i]);
            cooldown = max(cooldown, sold);
            sold = prev_hold + prices[i];
        }
        return max(sold, cooldown);
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> prices(n);
    for (int i = 0; i < n; ++i) {
        cin >> prices[i];
    }
    Solution sol;
    cout << sol.maxProfit(prices) << endl;
    return 0;
}
```

**Python Code:**
```python
def max_profit(prices):
    hold = -prices[0]
    sold = 0
    cooldown = 0
    for price in prices[1:]:
        prev_hold = hold
        hold = max(hold, cooldown - price)
        cooldown = max(cooldown, sold)
        sold = prev_hold + price
    return max(sold, cooldown)

if __name__ == "__main__":
    n = int(input().strip())
    prices = list(map(int, input().strip().split()))
    print(max_profit(prices))
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(1)

### 10.46 Buy and Sell Stocks With Transaction Fee (DP-40)

**Problem Statement:** Fee for each transaction.

**Intuition:** Similar to II, but subtract fee on sell.

**Algorithm:**
1. hold = -prices[0], cash = 0
2. For each price:
   - hold = max(hold, cash - price)
   - cash = max(cash, hold + price - fee)
3. Return cash

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& prices, int fee) {
        int hold = -prices[0], cash = 0;
        for (int i = 1; i < prices.size(); ++i) {
            hold = max(hold, cash - prices[i]);
            cash = max(cash, hold + prices[i] - fee);
        }
        return cash;
    }
};

int main() {
    int n, fee;
    cin >> n >> fee;
    vector<int> prices(n);
    for (int i = 0; i < n; ++i) {
        cin >> prices[i];
    }
    Solution sol;
    cout << sol.maxProfit(prices, fee) << endl;
    return 0;
}
```

**Python Code:**
```python
def max_profit(prices, fee):
    hold = -prices[0]
    cash = 0
    for price in prices[1:]:
        hold = max(hold, cash - price)
        cash = max(cash, hold + price - fee)
    return cash

if __name__ == "__main__":
    n, fee = map(int, input().strip().split())
    prices = list(map(int, input().strip().split()))
    print(max_profit(prices, fee))
```

**Complexity Analysis:**
- Time: O(n)
- Space: O(1)

### DP on LIS

### 10.47 Printing Longest Increasing Subsequence (DP-42)

**Problem Statement:** Print the longest increasing subsequence.

**Intuition:** Use DP to find lengths, then backtrack to build the sequence.

**Algorithm:**
1. Compute dp as in LIS
2. Find max length and index
3. Backtrack: start from index, find prev with dp[prev] = dp[curr] - 1 and nums[prev] < nums[curr]
4. Reverse and return

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    vector<int> printLIS(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n, 1), prev(n, -1);
        int max_len = 1, max_idx = 0;
        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] > nums[j] && dp[i] < dp[j] + 1) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
            if (dp[i] > max_len) {
                max_len = dp[i];
                max_idx = i;
            }
        }
        vector<int> lis;
        int curr = max_idx;
        while (curr != -1) {
            lis.push_back(nums[curr]);
            curr = prev[curr];
        }
        reverse(lis.begin(), lis.end());
        return lis;
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> nums(n);
    for (int i = 0; i < n; ++i) {
        cin >> nums[i];
    }
    Solution sol;
    vector<int> lis = sol.printLIS(nums);
    for (int num : lis) cout << num << " ";
    cout << endl;
    return 0;
}
```

**Python Code:**
```python
def print_lis(nums):
    n = len(nums)
    dp = [1] * n
    prev = [-1] * n
    max_len = 1
    max_idx = 0
    for i in range(1, n):
        for j in range(i):
            if nums[i] > nums[j] and dp[i] < dp[j] + 1:
                dp[i] = dp[j] + 1
                prev[i] = j
        if dp[i] > max_len:
            max_len = dp[i]
            max_idx = i
    lis = []
    curr = max_idx
    while curr != -1:
        lis.append(nums[curr])
        curr = prev[curr]
    lis.reverse()
    return lis

if __name__ == "__main__":
    n = int(input().strip())
    nums = list(map(int, input().strip().split()))
    lis = print_lis(nums)
    print(' '.join(map(str, lis)))
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n)

### 10.48 Largest Divisible Subset (DP-44)

**Problem Statement:** Find the largest subset where every pair satisfies a % b == 0 or b % a == 0.

**Intuition:** Sort, then DP where dp[i] = max size ending at i.

**Algorithm:**
1. Sort nums
2. dp[i] = 1, prev[i] = -1
3. For i = 1 to n-1:
   - For j = 0 to i-1:
     - If nums[i] % nums[j] == 0 and dp[i] < dp[j] + 1:
       - dp[i] = dp[j] + 1, prev[i] = j
4. Find max dp, backtrack to build subset

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    vector<int> largestDivisibleSubset(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        vector<int> dp(n, 1), prev(n, -1);
        int max_size = 1, max_idx = 0;
        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] % nums[j] == 0 && dp[i] < dp[j] + 1) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
            if (dp[i] > max_size) {
                max_size = dp[i];
                max_idx = i;
            }
        }
        vector<int> subset;
        int curr = max_idx;
        while (curr != -1) {
            subset.push_back(nums[curr]);
            curr = prev[curr];
        }
        reverse(subset.begin(), subset.end());
        return subset;
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> nums(n);
    for (int i = 0; i < n; ++i) {
        cin >> nums[i];
    }
    Solution sol;
    vector<int> subset = sol.largestDivisibleSubset(nums);
    for (int num : subset) cout << num << " ";
    cout << endl;
    return 0;
}
```

**Python Code:**
```python
def largest_divisible_subset(nums):
    nums.sort()
    n = len(nums)
    dp = [1] * n
    prev = [-1] * n
    max_size = 1
    max_idx = 0
    for i in range(1, n):
        for j in range(i):
            if nums[i] % nums[j] == 0 and dp[i] < dp[j] + 1:
                dp[i] = dp[j] + 1
                prev[i] = j
        if dp[i] > max_size:
            max_size = dp[i]
            max_idx = i
    subset = []
    curr = max_idx
    while curr != -1:
        subset.append(nums[curr])
        curr = prev[curr]
    subset.reverse()
    return subset

if __name__ == "__main__":
    n = int(input().strip())
    nums = list(map(int, input().strip().split()))
    subset = largest_divisible_subset(nums)
    print(' '.join(map(str, subset)))
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n)

### 10.49 Longest String Chain (DP-45)

**Problem Statement:** Given words, find longest chain where each word is predecessor of next by inserting one char.

**Intuition:** Sort by length, DP where dp[i] = max chain ending at i.

**Algorithm:**
1. Sort words by length
2. dp[i] = 1
3. For i = 1 to n-1:
   - For j = 0 to i-1:
     - If len(words[i]) == len(words[j]) + 1 and is_predecessor(words[j], words[i]):
       - dp[i] = max(dp[i], dp[j] + 1)
4. Return max(dp)

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    bool isPredecessor(string a, string b) {
        if (a.size() + 1 != b.size()) return false;
        int i = 0, j = 0;
        while (i < a.size() && j < b.size()) {
            if (a[i] == b[j]) i++;
            j++;
        }
        return i == a.size();
    }
    
    int longestStrChain(vector<string>& words) {
        sort(words.begin(), words.end(), [](const string& a, const string& b) {
            return a.size() < b.size();
        });
        int n = words.size();
        vector<int> dp(n, 1);
        int max_chain = 1;
        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (words[i].size() == words[j].size() + 1 && isPredecessor(words[j], words[i])) {
                    dp[i] = max(dp[i], dp[j] + 1);
                }
            }
            max_chain = max(max_chain, dp[i]);
        }
        return max_chain;
    }
};

int main() {
    int n;
    cin >> n;
    vector<string> words(n);
    for (int i = 0; i < n; ++i) {
        cin >> words[i];
    }
    Solution sol;
    cout << sol.longestStrChain(words) << endl;
    return 0;
}
```

**Python Code:**
```python
def is_predecessor(a, b):
    if len(a) + 1 != len(b):
        return False
    i = j = 0
    while i < len(a) and j < len(b):
        if a[i] == b[j]:
            i += 1
        j += 1
    return i == len(a)

def longest_str_chain(words):
    words.sort(key=len)
    n = len(words)
    dp = [1] * n
    max_chain = 1
    for i in range(1, n):
        for j in range(i):
            if len(words[i]) == len(words[j]) + 1 and is_predecessor(words[j], words[i]):
                dp[i] = max(dp[i], dp[j] + 1)
        max_chain = max(max_chain, dp[i])
    return max_chain

if __name__ == "__main__":
    n = int(input().strip())
    words = input().strip().split()
    print(longest_str_chain(words))
```

**Complexity Analysis:**
- Time: O(n² * l)
- Space: O(n)

### 10.50 Longest Bitonic Subsequence (DP-46)

**Problem Statement:** Longest subsequence that increases then decreases.

**Intuition:** Compute LIS from left and right, sum -1.

**Algorithm:**
1. Compute lis_left[i] = LIS ending at i
2. lis_right[i] = LIS starting at i (reverse)
3. For each i, bitonic[i] = lis_left[i] + lis_right[i] - 1
4. Return max(bitonic)

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int longestBitonicSubsequence(vector<int>& nums) {
        int n = nums.size();
        vector<int> lis_left(n, 1), lis_right(n, 1);
        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] > nums[j]) {
                    lis_left[i] = max(lis_left[i], lis_left[j] + 1);
                }
            }
        }
        for (int i = n-2; i >= 0; --i) {
            for (int j = n-1; j > i; --j) {
                if (nums[i] > nums[j]) {
                    lis_right[i] = max(lis_right[i], lis_right[j] + 1);
                }
            }
        }
        int max_len = 0;
        for (int i = 0; i < n; ++i) {
            max_len = max(max_len, lis_left[i] + lis_right[i] - 1);
        }
        return max_len;
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> nums(n);
    for (int i = 0; i < n; ++i) {
        cin >> nums[i];
    }
    Solution sol;
    cout << sol.longestBitonicSubsequence(nums) << endl;
    return 0;
}
```

**Python Code:**
```python
def longest_bitonic_subsequence(nums):
    n = len(nums)
    lis_left = [1] * n
    lis_right = [1] * n
    for i in range(1, n):
        for j in range(i):
            if nums[i] > nums[j]:
                lis_left[i] = max(lis_left[i], lis_left[j] + 1)
    for i in range(n-2, -1, -1):
        for j in range(n-1, i, -1):
            if nums[i] > nums[j]:
                lis_right[i] = max(lis_right[i], lis_right[j] + 1)
    max_len = 0
    for i in range(n):
        max_len = max(max_len, lis_left[i] + lis_right[i] - 1)
    return max_len

if __name__ == "__main__":
    n = int(input().strip())
    nums = list(map(int, input().strip().split()))
    print(longest_bitonic_subsequence(nums))
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n)

### 10.51 Number of Longest Increasing Subsequences (DP-47)

**Problem Statement:** Count the number of longest increasing subsequences.

**Intuition:** DP for length and count.

**Algorithm:**
1. dp_len[i] = 1, dp_count[i] = 1
2. For i = 1 to n-1:
   - For j = 0 to i-1:
     - If nums[i] > nums[j]:
       - If dp_len[i] < dp_len[j] + 1:
         - dp_len[i] = dp_len[j] + 1
         - dp_count[i] = dp_count[j]
       - Else if dp_len[i] == dp_len[j] + 1:
         - dp_count[i] += dp_count[j]
3. Find max_len, sum dp_count where dp_len == max_len

**C++ Code:**
```cpp
#include <bits/stdc++.h>
using namespace std;

class Solution {
public:
    int findNumberOfLIS(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp_len(n, 1), dp_count(n, 1);
        int max_len = 1;
        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] > nums[j]) {
                    if (dp_len[i] < dp_len[j] + 1) {
                        dp_len[i] = dp_len[j] + 1;
                        dp_count[i] = dp_count[j];
                    } else if (dp_len[i] == dp_len[j] + 1) {
                        dp_count[i] += dp_count[j];
                    }
                }
            }
            max_len = max(max_len, dp_len[i]);
        }
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (dp_len[i] == max_len) count += dp_count[i];
        }
        return count;
    }
};

int main() {
    int n;
    cin >> n;
    vector<int> nums(n);
    for (int i = 0; i < n; ++i) {
        cin >> nums[i];
    }
    Solution sol;
    cout << sol.findNumberOfLIS(nums) << endl;
    return 0;
}
```

**Python Code:**
```python
def find_number_of_lis(nums):
    n = len(nums)
    dp_len = [1] * n
    dp_count = [1] * n
    max_len = 1
    for i in range(1, n):
        for j in range(i):
            if nums[i] > nums[j]:
                if dp_len[i] < dp_len[j] + 1:
                    dp_len[i] = dp_len[j] + 1
                    dp_count[i] = dp_count[j]
                elif dp_len[i] == dp_len[j] + 1:
                    dp_count[i] += dp_count[j]
        max_len = max(max_len, dp_len[i])
    count = 0
    for i in range(n):
        if dp_len[i] == max_len:
            count += dp_count[i]
    return count

if __name__ == "__main__":
    n = int(input().strip())
    nums = list(map(int, input().strip().split()))
    print(find_number_of_lis(nums))
```

**Complexity Analysis:**
- Time: O(n²)
- Space: O(n)

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