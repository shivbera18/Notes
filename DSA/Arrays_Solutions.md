# 🐍 DSA Problems & Solutions: Comprehensive Python Guide

This comprehensive solutions guide covers Data Structures and Algorithms problems in Python, with detailed explanations, code implementations, and best practices. Perfect for competitive programming and interview preparation.

## Index
1. [Python for DSA (C++ Experts)](#1-python-for-dsa-c-experts)
2. [Arrays](#2-arrays)
   - 2.1 [Easy Problems](#21-easy-problems)
   - 2.2 [Medium Problems](#22-medium-problems)
   - 2.3 [Hard Problems](#23-hard-problems)
3. [Binary Search](#3-binary-search)
4. [Strings](#4-strings)
5. [Linked Lists](#5-linked-lists)
6. [Stacks & Queues](#6-stacks--queues)
7. [Trees](#7-trees)
8. [Graphs](#8-graphs)
9. [Dynamic Programming](#9-dynamic-programming)
10. [Greedy Algorithms](#10-greedy-algorithms)
11. [Backtracking](#11-backtracking)
12. [Bit Manipulation](#12-bit-manipulation)
13. [Math Problems](#13-math-problems)
14. [Two Pointers & Sliding Window](#14-two-pointers--sliding-window)
15. [Advanced Topics](#15-advanced-topics)

---

## 1. Python for DSA (C++ Experts)

This guide is tailored for programmers proficient in C++ (at a candidate master level) transitioning to Python for Data Structures and Algorithms (DSA). Python's simplicity and built-in features make it excellent for DSA, but there are key differences to note.

### Key Differences Between C++ and Python for DSA

1. **Data Types and Memory Management**:
   - C++: Static typing, manual memory management with pointers and references.
   - Python: Dynamic typing, automatic memory management (garbage collection). No need to worry about memory leaks or explicit deallocation.

2. **Arrays vs Lists**:
   - C++: Fixed-size arrays (`int arr[5];`) or dynamic vectors (`std::vector<int>`).
   - Python: Lists are dynamic arrays that can grow/shrink automatically. Use `list` for most array-like operations.

3. **Syntax and Readability**:
   - C++: Verbose syntax with semicolons, braces, and explicit type declarations.
   - Python: Clean, readable syntax using indentation. No semicolons or braces needed.

4. **Standard Library**:
   - C++: Rich STL with containers like `vector`, `array`, algorithms like `sort`, `find`.
   - Python: Built-in data structures and functions. No need for separate includes; everything is available.

5. **Performance**:
   - C++: Generally faster for computational-heavy tasks due to compiled nature.
   - Python: Slower but sufficient for most DSA problems. Focus on algorithmic efficiency over micro-optimizations.

6. **Error Handling**:
   - C++: Exceptions with `try-catch`.
   - Python: Exceptions similar, but more commonly used for runtime errors.

### List Operations in Python

Python lists are versatile and handle most array operations efficiently:

- **Creation**: `arr = [1, 2, 3]` or `arr = list(range(5))`
- **Access**: `arr[0]` (same as C++)
- **Length**: `len(arr)` (equivalent to `arr.size()` in C++)
- **Append**: `arr.append(4)` (like `push_back` in vector)
- **Insert**: `arr.insert(index, value)` (shifts elements)
- **Remove**: `arr.pop(index)` (removes and returns element)
- **Slicing**: `arr[start:end]` (creates sublist, similar to substrings)
- **Concatenation**: `arr1 + arr2`
- **Repetition**: `arr * 3`
- **Membership**: `x in arr` (O(n) time)
- **Sorting**: `arr.sort()` (in-place) or `sorted(arr)` (returns new list)
- **Reversing**: `arr.reverse()` (in-place) or `arr[::-1]` (creates new list)
- **Copying**: `arr.copy()` or `arr[:]` (shallow copy)

### Common Patterns and Idioms

1. **List Comprehensions**: Concise way to create lists.
   ```python
   # C++ equivalent: vector<int> squares; for(int i=0; i<10; i++) squares.push_back(i*i);
   squares = [i*i for i in range(10)]
   ```

2. **Enumerate for Index-Value Pairs**:
   ```python
   # C++ equivalent: for(int i=0; i<arr.size(); i++) { int val = arr[i]; ... }
   for i, val in enumerate(arr):
       # i is index, val is value
   ```

3. **Unpacking**:
   ```python
   a, b, c = [1, 2, 3]  # Assigns a=1, b=2, c=3
   ```

4. **Negative Indexing**: `arr[-1]` is the last element.

5. **Infinite Loops with Conditions**: Use `while True:` instead of `for(;;)`.

6. **Lambda Functions**: For simple functions.
   ```python
   # C++ equivalent: auto cmp = [](int a, int b){ return a < b; };
   cmp = lambda a, b: a < b
   ```

7. **Built-in Functions**: `max()`, `min()`, `sum()`, `any()`, `all()` are very useful.

8. **No Pointers**: Use references directly; Python handles object references.

### Tips for Efficient Python DSA

- Use list comprehensions for readability and speed.
- Prefer built-in functions over manual loops when possible.
- For large inputs, be mindful of O(n) operations like `in` for membership.
- Use `collections` module for advanced data structures (e.g., `deque` for queues).
- Profile code if needed, but focus on algorithm choice first.

### Input Handling in Python

For competitive programming like Codeforces, efficient input reading is crucial due to large inputs.

1. **Basic Input**:
   - `input()` reads a line as string, strip() to remove newline.
   - `int(input())` for single integer.
   - `list(map(int, input().split()))` for list of ints.

2. **Fast Input for Large Data**:
   - Use `sys.stdin.read()` to read all input at once.
   ```python
   import sys
   input = sys.stdin.read
   data = input().split()
   ```
   - Then, use an index to parse: `index = 0; n = int(data[index]); index += 1`

3. **Multiple Test Cases**:
   - Read T, then loop T times.
   ```python
   T = int(input())
   for _ in range(T):
       # read case
   ```

4. **Reading Matrices**:
   ```python
   n, m = map(int, input().split())
   matrix = [list(map(int, input().split())) for _ in range(n)]
   ```

5. **Common Patterns**:
   - For array: `n = int(input()); arr = list(map(int, input().split()))`
   - Use `sys.stdin.readline()` for line-by-line if needed, but `sys.stdin.read()` is faster.

### For Loops and Iteration in Python vs C++

Python's for loops are more powerful and readable than C++'s traditional for loops.

1. **Range-based Loops**:
   ```python
   # Python: Iterate over range
   for i in range(5):  # 0, 1, 2, 3, 4
       print(i)
   
   # C++ equivalent: for(int i=0; i<5; i++) { cout << i << endl; }
   ```

2. **Iterating over Collections**:
   ```python
   # Python: Direct iteration
   arr = [1, 2, 3, 4, 5]
   for num in arr:
       print(num)
   
   # C++ equivalent: for(int num : arr) { cout << num << endl; } (C++11 range-based)
   # Or: for(auto it=arr.begin(); it!=arr.end(); ++it) { cout << *it << endl; }
   ```

3. **Index and Value (Enumerate)**:
   ```python
   # Python: Get both index and value
   for i, num in enumerate(arr):
       print(f"Index {i}: {num}")
   
   # C++ equivalent: for(size_t i=0; i<arr.size(); i++) { cout << "Index " << i << ": " << arr[i] << endl; }
   ```

4. **Reverse Iteration**:
   ```python
   # Python: Reverse
   for num in reversed(arr):
       print(num)
   
   # C++ equivalent: for(auto it=arr.rbegin(); it!=arr.rend(); ++it) { cout << *it << endl; }
   ```

5. **Step-based Iteration**:
   ```python
   # Python: Every other element
   for num in arr[::2]:  # Start:End:Step
       print(num)
   
   # C++ equivalent: for(size_t i=0; i<arr.size(); i+=2) { cout << arr[i] << endl; }
   ```

6. **Nested Loops**:
   ```python
   # Python: Matrix iteration
   matrix = [[1, 2], [3, 4]]
   for row in matrix:
       for num in row:
           print(num)
   
   # C++ equivalent: for(auto& row : matrix) { for(int num : row) { cout << num << endl; } }
   ```

7. **List Comprehensions (Advanced)**:
   ```python
   # Python: Create new list with conditions
   squares = [x*x for x in range(10) if x % 2 == 0]
   
   # C++ equivalent: vector<int> squares; for(int x=0; x<10; x++) { if(x%2==0) squares.push_back(x*x); }
   ```

### Understanding "for x in iterable" Syntax

Python's `for x in iterable` is fundamentally different from C++'s traditional `for(int i=0; i<n; i++)` loop:

1. **Direct Iteration over Elements**:
   ```python
   # Python: Iterate over actual elements
   fruits = ["apple", "banana", "cherry"]
   for fruit in fruits:  # fruit gets each string directly
       print(fruit)
   
   # C++ equivalent: for(string fruit : fruits) { cout << fruit << endl; } (C++11 range-based)
   # Or: for(size_t i=0; i<fruits.size(); i++) { cout << fruits[i] << endl; }
   ```

2. **No Index Management**:
   ```python
   # Python: Focus on elements, not indices
   numbers = [10, 20, 30]
   for num in numbers:
       print(num * 2)  # Direct access to values
   
   # C++ equivalent: for(int num : numbers) { cout << num * 2 << endl; }
   ```

3. **Works with Any Iterable**:
   ```python
   # Python: Works with strings, sets, dictionaries, etc.
   word = "hello"
   for char in word:  # Iterate over characters
       print(char)
   
   my_set = {1, 2, 3}
   for item in my_set:  # Iterate over set elements
       print(item)
   
   # C++ equivalent: for(char ch : word) { cout << ch << endl; }
   # For sets: for(int item : my_set) { cout << item << endl; }
   ```

4. **Automatic Unpacking**:
   ```python
   # Python: Unpack tuples/lists automatically
   pairs = [(1, 'a'), (2, 'b'), (3, 'c')]
   for number, letter in pairs:  # Unpacks each tuple
       print(f"{number}: {letter}")
   
   # C++ equivalent: for(auto& pair : pairs) { cout << pair.first << ": " << pair.second << endl; }
   ```

### Matrix Operations and 2D Arrays

Python handles 2D arrays (matrices) using lists of lists, which is more flexible than C++ arrays:

1. **Creating Matrices**:
   ```python
   # Python: Different ways to create matrices
   # Method 1: List of lists
   matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
   
   # Method 2: Using loops
   rows, cols = 3, 4
   matrix = [[0 for _ in range(cols)] for _ in range(rows)]
   
   # Method 3: Using list comprehension
   matrix = [[i*cols + j for j in range(cols)] for i in range(rows)]
   
   # C++ equivalent:
   # vector<vector<int>> matrix(rows, vector<int>(cols, 0));
   # Or: int matrix[3][4] = {{1,2,3},{4,5,6},{7,8,9}};
   ```

2. **Accessing Matrix Elements**:
   ```python
   # Python: matrix[row][col]
   value = matrix[1][2]  # Row 1, Column 2
   matrix[0][0] = 99    # Modify element
   
   # C++ equivalent: matrix[1][2] or matrix.at(1).at(2)
   ```

3. **Iterating Over Matrices**:
   ```python
   # Python: Multiple ways
   matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
   
   # Method 1: Nested loops with indices
   for i in range(len(matrix)):      # i = row index
       for j in range(len(matrix[i])): # j = col index
           print(f"matrix[{i}][{j}] = {matrix[i][j]}")
   
   # Method 2: Direct element iteration
   for row in matrix:      # row is a list
       for element in row: # element is the value
           print(element)
   
   # Method 3: Enumerate for indices and values
   for i, row in enumerate(matrix):
       for j, val in enumerate(row):
           print(f"Position ({i},{j}): {val}")
   
   # C++ equivalent:
   # for(size_t i=0; i<matrix.size(); i++) {
   #     for(size_t j=0; j<matrix[i].size(); j++) {
   #         cout << "matrix[" << i << "][" << j << "] = " << matrix[i][j] << endl;
   #     }
   # }
   ```

4. **Matrix Operations**:
   ```python
   # Python: Common matrix operations
   matrix = [[1, 2], [3, 4]]
   
   # Transpose
   transpose = [[row[i] for row in matrix] for i in range(len(matrix[0]))]
   # Or: transpose = list(map(list, zip(*matrix)))
   
   # Flatten (convert to 1D)
   flat = [element for row in matrix for element in row]
   
   # Sum of all elements
   total = sum(sum(row) for row in matrix)
   
   # Find max in each row
   row_maxes = [max(row) for row in matrix]
   
   # Matrix addition
   matrix2 = [[5, 6], [7, 8]]
   result = [[matrix[i][j] + matrix2[i][j] for j in range(len(matrix[i]))] for i in range(len(matrix))]
   
   # C++ equivalent would require nested loops or algorithms
   ```

5. **Advanced Matrix Patterns**:
   ```python
   # Python: Diagonal traversal
   matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
   
   # Main diagonal
   diagonal = [matrix[i][i] for i in range(min(len(matrix), len(matrix[0])))]
   
   # Anti-diagonal
   anti_diagonal = [matrix[i][len(matrix[0])-1-i] for i in range(min(len(matrix), len(matrix[0])))]
   
   # Spiral traversal
   def spiral_order(matrix):
       result = []
       while matrix:
           # Top row
           result += matrix.pop(0)
           # Right column
           if matrix and matrix[0]:
               for row in matrix:
                   result.append(row.pop())
           # Bottom row (reversed)
           if matrix:
               result += matrix.pop()[::-1]
           # Left column (reversed)
           if matrix and matrix[0]:
               for row in matrix[::-1]:
                   result.append(row.pop(0))
       return result
   
   # C++ equivalent: Would require careful index management and boundary checks
   ```

### Nested Loops: Loops Inside Loops

Python's nested loops are straightforward and readable:

1. **Basic Nested Loops**:
   ```python
   # Python: Multiplication table
   for i in range(1, 4):     # Outer loop: rows
       for j in range(1, 4): # Inner loop: columns
           print(f"{i*j:2}", end=" ")
       print()  # New line after each row
   
   # Output:
   # 1 2 3
   # 2 4 6
   # 3 6 9
   
   # C++ equivalent:
   # for(int i=1; i<4; i++) {
   #     for(int j=1; j<4; j++) {
   #         cout << setw(2) << i*j << " ";
   #     }
   #     cout << endl;
   # }
   ```

2. **Nested Loops with Different Iterables**:
   ```python
   # Python: Combine elements from different lists
   colors = ["red", "blue", "green"]
   sizes = ["small", "medium", "large"]
   
   for color in colors:
       for size in sizes:
           print(f"{size} {color} item")
   
   # C++ equivalent:
   # vector<string> colors = {"red", "blue", "green"};
   # vector<string> sizes = {"small", "medium", "large"};
   # for(const string& color : colors) {
   #     for(const string& size : sizes) {
   #         cout << size << " " << color << " item" << endl;
   #     }
   # }
   ```

3. **Nested Loops with Break/Continue**:
   ```python
   # Python: Finding first match and breaking
   matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
   target = 5
   
   found = False
   for i, row in enumerate(matrix):
       for j, val in enumerate(row):
           if val == target:
               print(f"Found {target} at position ({i}, {j})")
               found = True
               break  # Break inner loop
       if found:
           break  # Break outer loop
   
   # C++ equivalent: Same logic with break statements
   ```

4. **List Comprehensions with Nested Loops**:
   ```python
   # Python: Flatten matrix using nested comprehension
   matrix = [[1, 2], [3, 4], [5, 6]]
   flat = [val for row in matrix for val in row]
   # Result: [1, 2, 3, 4, 5, 6]
   
   # Create all combinations
   combinations = [(x, y) for x in range(3) for y in range(3) if x != y]
   # Result: [(0, 1), (0, 2), (1, 0), (1, 2), (2, 0), (2, 1)]
   
   # C++ equivalent would require nested loops or std::transform
   ```

### Advanced Input Handling Techniques

1. **Reading Multiple Lines**:
   ```python
   # Python: Read N lines
   n = int(input())
   lines = [input().strip() for _ in range(n)]
   
   # C++ equivalent: int n; cin >> n; vector<string> lines(n); for(auto& line : lines) getline(cin, line);
   ```

2. **Reading Until EOF**:
   ```python
   # Python: Read all lines until EOF
   import sys
   for line in sys.stdin:
       # Process line
       pass
   
   # C++ equivalent: string line; while(getline(cin, line)) { /* process */ }
   ```

3. **Fast Input with sys.stdin.read()**:
   ```python
   # Python: Best for large inputs
   import sys
   data = sys.stdin.read().split()
   index = 0
   t = int(data[index]); index += 1
   for _ in range(t):
       n = int(data[index]); index += 1
       arr = [int(data[index + i]) for i in range(n)]; index += n
       # Process arr
   
   # C++ equivalent: Use fast input methods or read all at once
   ```

4. **String Input Processing**:
   ```python
   # Python: Process space-separated values
   s = input().strip()
   parts = s.split()  # Split by whitespace
   nums = list(map(int, parts))
   
   # C++ equivalent: string s; getline(cin, s); stringstream ss(s); vector<int> nums; int num; while(ss >> num) nums.push_back(num);
   ```

5. **Character-by-Character Input**:
   ```python
   # Python: Read single characters
   import sys
   chars = list(sys.stdin.read().replace('\n', '').replace(' ', ''))
   
   # C++ equivalent: char ch; vector<char> chars; while(cin.get(ch)) { if(ch != '\n' && ch != ' ') chars.push_back(ch); }
   ```

### Control Structures Comparison

1. **If-Else**:
   ```python
   # Python
   if x > 0:
       print("Positive")
   elif x < 0:
       print("Negative")
   else:
       print("Zero")
   
   # C++ equivalent: Same structure but with braces and semicolons
   ```

2. **While Loops**:
   ```python
   # Python
   i = 0
   while i < 10:
       print(i)
       i += 1
   
   # C++ equivalent: Identical
   ```

3. **Break and Continue**:
   ```python
   # Python: Same as C++
   for i in range(10):
       if i == 5:
           break
       if i % 2 == 0:
           continue
       print(i)
   ```

### Exception Handling

```python
# Python
try:
    x = int(input())
    result = 10 / x
except ValueError:
    print("Invalid input")
except ZeroDivisionError:
    print("Division by zero")
except Exception as e:
    print(f"Error: {e}")

# C++ equivalent:
# try { int x; cin >> x; int result = 10/x; }
# catch(const invalid_argument& e) { cout << "Invalid"; }
# catch(const runtime_error& e) { cout << "Division by zero"; }
```

### Essential DSA Data Structures and Utilities in Python

Python has powerful built-ins and modules for DSA.

1. **Dictionary (HashMap)**:
   - `d = {}` or `d = dict()`
   - Operations: `d[key] = value`, `d.get(key, default)`, `key in d`
   - Time: O(1) average for insert/lookup.

2. **Set (HashSet)**:
   - `s = set()`
   - Operations: `s.add(x)`, `x in s`, `s.remove(x)`
   - For unique elements, fast membership.

3. **Heap (Priority Queue)**:
   - `import heapq`
   - `heap = []`; `heapq.heappush(heap, val)`; `heapq.heappop(heap)`
   - Min-heap by default; use negative for max-heap.

4. **Deque (Double-Ended Queue)**:
   - `from collections import deque`
   - `dq = deque()`
   - `dq.append()`, `dq.appendleft()`, `dq.pop()`, `dq.popleft()`
   - Efficient for queues/stacks.

5. **Counter**:
   - `from collections import Counter`
   - `c = Counter(arr)` for frequency count.

6. **Defaultdict**:
   - `from collections import defaultdict`
   - `d = defaultdict(int)` or `defaultdict(list)`
   - Avoids KeyError.

7. **Other Utilities**:
   - `math` module: `math.inf`, `math.gcd`, etc.
   - `functools` for `lru_cache` (memoization).
   - `itertools` for permutations, combinations.

---

## 2. Arrays

<details>
<summary>2.1 Easy Problems</summary>

- Largest Element in an Array
- Second Largest Element
- Check if Array is Sorted
- Remove Duplicates from Sorted Array
- Move Zeros to End
- Find Missing Number
- Single Number
- Intersection of Two Arrays
- Plus One
- Two Sum

</details>

### 2.1 Easy Problems

*Detailed solutions to be added...*

<details>
<summary>2.2 Medium Problems</summary>

- 3Sum
- Container With Most Water
- Maximum Subarray
- Product of Array Except Self
- Find Minimum in Rotated Sorted Array
- Search in Rotated Sorted Array
- Majority Element
- Sort Colors
- Merge Intervals
- Next Permutation

</details>

### 2.2 Medium Problems

*Detailed solutions to be added...*

<details>
<summary>2.3 Hard Problems</summary>

- Trapping Rain Water
- Median of Two Sorted Arrays
- Longest Consecutive Sequence
- First Missing Positive
- Jump Game II
- Merge k Sorted Lists
- Maximum Product Subarray
- Find the Duplicate Number
- Game of Life
- Sliding Window Maximum

</details>

### 2.3 Hard Problems

*Detailed solutions to be added...*

### 2.1 Easy Problems

#### 1. Largest Element in an Array

#### Problem Statement
Find the largest element in an array of integers.

#### Intuition
Iterate through the array, keeping track of the maximum value encountered.

#### Algorithm
1. Initialize max_val to the first element or negative infinity.
2. Iterate through each element in the array.
3. If current element > max_val, update max_val.
4. Return max_val.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int largestElement(vector<int>& arr) {
    int max_val = INT_MIN;
    for(int num : arr) {
        if(num > max_val) max_val = num;
    }
    return max_val;
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cout << largestElement(arr) << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def largest_element(arr):
    if not arr:
        return None  # or raise ValueError
    max_val = float('-inf')
    for num in arr:
        if num > max_val:
            max_val = num
    return max_val

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    result = largest_element(arr)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### 2. Second Largest Element in an Array without sorting

#### Problem Statement
Find the second largest element in an array without sorting.

#### Intuition
Track the largest and second largest elements in a single pass.

#### Algorithm
1. Initialize largest and second_largest to negative infinity.
2. Iterate through the array:
   - If current > largest, update second_largest = largest, largest = current
   - Else if current > second_largest and current != largest, update second_largest = current
3. Return second_largest.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int secondLargest(vector<int>& arr) {
    int largest = INT_MIN, second_largest = INT_MIN;
    for(int num : arr) {
        if(num > largest) {
            second_largest = largest;
            largest = num;
        } else if(num > second_largest && num != largest) {
            second_largest = num;
        }
    }
    return second_largest;
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cout << secondLargest(arr) << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def second_largest(arr):
    if len(arr) < 2:
        return None
    largest = second_largest = float('-inf')
    for num in arr:
        if num > largest:
            second_largest = largest
            largest = num
        elif num > second_largest and num != largest:
            second_largest = num
    return second_largest if second_largest != float('-inf') else None

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    result = second_largest(arr)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### 3. Check if the array is sorted

#### Problem Statement
Check if the array is sorted in non-decreasing order.

#### Intuition
Check if each element is less than or equal to the next.

#### Algorithm
1. Iterate from index 0 to n-2.
2. If arr[i] > arr[i+1], return false.
3. Return true.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

bool isSorted(vector<int>& arr) {
    for(size_t i = 0; i < arr.size() - 1; ++i) {
        if(arr[i] > arr[i+1]) return false;
    }
    return true;
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cout << (isSorted(arr) ? "true" : "false") << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def is_sorted(arr):
    for i in range(len(arr) - 1):
        if arr[i] > arr[i + 1]:
            return False
    return True

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    result = is_sorted(arr)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### 4. Remove duplicates from Sorted array

#### Problem Statement
Remove duplicates from a sorted array in-place and return the new length.

#### Intuition
Use two pointers to overwrite duplicates.

#### Algorithm
1. If array is empty, return 0.
2. Initialize i = 0.
3. For j from 1 to n-1:
   - If arr[j] != arr[i], arr[++i] = arr[j]
4. Return i+1.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int removeDuplicates(vector<int>& arr) {
    if(arr.empty()) return 0;
    int i = 0;
    for(size_t j = 1; j < arr.size(); ++j) {
        if(arr[j] != arr[i]) {
            arr[++i] = arr[j];
        }
    }
    return i + 1;
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    int newLength = removeDuplicates(arr);
    cout << newLength << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def remove_duplicates(arr):
    if not arr:
        return 0
    i = 0
    for j in range(1, len(arr)):
        if arr[j] != arr[i]:
            i += 1
            arr[i] = arr[j]
    return i + 1

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    result = remove_duplicates(arr)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### 5. Left Rotate an array by one place

#### Problem Statement
Rotate the array to the left by one position.

#### Intuition
Store the first element, shift all elements left, put the stored element at the end.

#### Algorithm
1. If array is empty, return.
2. Store arr[0] in temp.
3. For i from 0 to n-2, arr[i] = arr[i+1]
4. arr[n-1] = temp.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

void leftRotateOne(vector<int>& arr) {
    if(arr.empty()) return;
    int temp = arr[0];
    for(size_t i = 0; i < arr.size() - 1; ++i) {
        arr[i] = arr[i+1];
    }
    arr.back() = temp;
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    leftRotateOne(arr);
    for(int num : arr) cout << num << " ";
    cout << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def left_rotate_one(arr):
    if not arr:
        return
    temp = arr[0]
    for i in range(len(arr) - 1):
        arr[i] = arr[i + 1]
    arr[-1] = temp

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    left_rotate_one(arr)
    print(' '.join(map(str, arr)))
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### 6. Left rotate an array by D places

#### Problem Statement
Rotate the array to the left by D positions.

#### Intuition
Use reversal algorithm: reverse first D, then D to end, then whole array.

#### Algorithm
1. D = D % n
2. Reverse arr[0..D-1]
3. Reverse arr[D..n-1]
4. Reverse arr[0..n-1]

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

void reverse(vector<int>& arr, int start, int end) {
    while(start < end) {
        swap(arr[start], arr[end]);
        start++;
        end--;
    }
}

void leftRotateD(vector<int>& arr, int d) {
    int n = arr.size();
    d %= n;
    reverse(arr, 0, d-1);
    reverse(arr, d, n-1);
    reverse(arr, 0, n-1);
}

int main() {
    int n, d;
    cin >> n >> d;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    leftRotateD(arr, d);
    for(int num : arr) cout << num << " ";
    cout << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def reverse(arr, start, end):
    while start < end:
        arr[start], arr[end] = arr[end], arr[start]
        start += 1
        end -= 1

def left_rotate_d(arr, d):
    n = len(arr)
    d %= n
    reverse(arr, 0, d - 1)
    reverse(arr, d, n - 1)
    reverse(arr, 0, n - 1)

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    d = int(data[1])
    arr = list(map(int, data[2:2+n]))
    left_rotate_d(arr, d)
    print(' '.join(map(str, arr)))
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### 7. Move Zeros to end

#### Problem Statement
Move all zeros to the end of the array while maintaining the relative order of non-zero elements.

#### Intuition
Use two pointers: one for non-zero placement, one for traversal.

#### Algorithm
1. Initialize j = 0
2. For i from 0 to n-1:
   - If arr[i] != 0, arr[j++] = arr[i]
3. For i from j to n-1, arr[i] = 0

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

void moveZeros(vector<int>& arr) {
    int j = 0;
    for(int num : arr) {
        if(num != 0) {
            arr[j++] = num;
        }
    }
    while(j < arr.size()) {
        arr[j++] = 0;
    }
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    moveZeros(arr);
    for(int num : arr) cout << num << " ";
    cout << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def move_zeros(arr):
    j = 0
    for num in arr:
        if num != 0:
            arr[j] = num
            j += 1
    while j < len(arr):
        arr[j] = 0
        j += 1

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    move_zeros(arr)
    print(' '.join(map(str, arr)))
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### 8. Linear Search

#### Problem Statement
Find the index of a target element in the array, or return -1 if not found.

#### Intuition
Iterate through the array and check each element.

#### Algorithm
1. For i from 0 to n-1:
   - If arr[i] == target, return i
2. Return -1

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int linearSearch(vector<int>& arr, int target) {
    for(size_t i = 0; i < arr.size(); ++i) {
        if(arr[i] == target) return i;
    }
    return -1;
}

int main() {
    int n, target;
    cin >> n >> target;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cout << linearSearch(arr, target) << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def linear_search(arr, target):
    for i, num in enumerate(arr):
        if num == target:
            return i
    return -1

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    target = int(data[1])
    arr = list(map(int, data[2:2+n]))
    result = linear_search(arr, target)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### 9. Find the Union

#### Problem Statement
Find the union of two sorted arrays (unique elements).

#### Intuition
Use two pointers to merge and avoid duplicates.

#### Algorithm
1. Initialize result vector, i=0, j=0
2. While i < n1 and j < n2:
   - If arr1[i] < arr2[j], add arr1[i++]
   - Else if arr1[i] > arr2[j], add arr2[j++]
   - Else, add arr1[i++], j++
3. Add remaining elements from arr1 and arr2

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

vector<int> findUnion(vector<int>& arr1, vector<int>& arr2) {
    vector<int> result;
    size_t i = 0, j = 0;
    while(i < arr1.size() && j < arr2.size()) {
        if(arr1[i] < arr2[j]) {
            result.push_back(arr1[i++]);
        } else if(arr1[i] > arr2[j]) {
            result.push_back(arr2[j++]);
        } else {
            result.push_back(arr1[i++]);
            j++;
        }
    }
    while(i < arr1.size()) result.push_back(arr1[i++]);
    while(j < arr2.size()) result.push_back(arr2[j++]);
    return result;
}

int main() {
    int n1, n2;
    cin >> n1 >> n2;
    vector<int> arr1(n1), arr2(n2);
    for(int i = 0; i < n1; i++) cin >> arr1[i];
    for(int i = 0; i < n2; i++) cin >> arr2[i];
    vector<int> result = findUnion(arr1, arr2);
    for(int num : result) cout << num << " ";
    cout << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def find_union(arr1, arr2):
    result = []
    i = j = 0
    while i < len(arr1) and j < len(arr2):
        if arr1[i] < arr2[j]:
            result.append(arr1[i])
            i += 1
        elif arr1[i] > arr2[j]:
            result.append(arr2[j])
            j += 1
        else:
            result.append(arr1[i])
            i += 1
            j += 1
    result.extend(arr1[i:])
    result.extend(arr2[j:])
    return result

if __name__ == "__main__":
    data = sys.stdin.read().split()
    index = 0
    n1 = int(data[index])
    index += 1
    arr1 = list(map(int, data[index:index+n1]))
    index += n1
    n2 = int(data[index])
    index += 1
    arr2 = list(map(int, data[index:index+n2]))
    result = find_union(arr1, arr2)
    print(' '.join(map(str, result)))
```

#### Time Complexity
O(n + m)

#### Space Complexity
O(n + m)

### 10. Find missing number in an array

#### Problem Statement
Find the missing number in an array of size n containing numbers from 1 to n+1.

#### Intuition
Use XOR or sum formula.

#### Algorithm (XOR)
1. XOR all numbers from 1 to n+1
2. XOR with all array elements
3. Result is the missing number

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int findMissing(vector<int>& arr) {
    int n = arr.size() + 1;
    int xor1 = 0, xor2 = 0;
    for(int i = 1; i <= n; ++i) xor1 ^= i;
    for(int num : arr) xor2 ^= num;
    return xor1 ^ xor2;
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cout << findMissing(arr) << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def find_missing(arr):
    n = len(arr) + 1
    xor1 = 0
    for i in range(1, n + 1):
        xor1 ^= i
    xor2 = 0
    for num in arr:
        xor2 ^= num
    return xor1 ^ xor2

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    result = find_missing(arr)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### 11. Maximum Consecutive Ones

#### Problem Statement
Find the maximum number of consecutive 1's in a binary array.

#### Intuition
Track current and maximum streak of 1's.

#### Algorithm
1. Initialize max_count = 0, current = 0
2. For each num in arr:
   - If num == 1, current++
   - Else, max_count = max(max_count, current), current = 0
3. Return max(max_count, current)

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int maxConsecutiveOnes(vector<int>& arr) {
    int max_count = 0, current = 0;
    for(int num : arr) {
        if(num == 1) {
            current++;
            max_count = max(max_count, current);
        } else {
            current = 0;
        }
    }
    return max_count;
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cout << maxConsecutiveOnes(arr) << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def max_consecutive_ones(arr):
    max_count = current = 0
    for num in arr:
        if num == 1:
            current += 1
            max_count = max(max_count, current)
        else:
            current = 0
    return max_count

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    result = max_consecutive_ones(arr)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### 12. Find the number that appears once, and other numbers twice

#### Problem Statement
Find the number that appears once in an array where others appear twice.

#### Intuition
Use XOR: a ^ a = 0, a ^ 0 = a.

#### Algorithm
1. XOR all elements.
2. The result is the number that appears once.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int findSingle(vector<int>& arr) {
    int result = 0;
    for(int num : arr) {
        result ^= num;
    }
    return result;
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cout << findSingle(arr) << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def find_single(arr):
    result = 0
    for num in arr:
        result ^= num
    return result

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    result = find_single(arr)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### Longest subarray with given sum K(positives)

#### Problem Statement
Find the length of the longest subarray with sum equal to K (all positive numbers).

#### Intuition
Use sliding window: expand right, shrink left when sum > K.

#### Algorithm
1. Initialize left = 0, sum = 0, max_len = 0
2. For right from 0 to n-1:
   - sum += arr[right]
   - While sum > K and left <= right:
     - sum -= arr[left], left++
   - If sum == K, max_len = max(max_len, right - left + 1)
3. Return max_len

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int longestSubarraySumK(vector<int>& arr, int k) {
    int left = 0, sum = 0, max_len = 0;
    for(int right = 0; right < arr.size(); ++right) {
        sum += arr[right];
        while(sum > k && left <= right) {
            sum -= arr[left++];
        }
        if(sum == k) {
            max_len = max(max_len, right - left + 1);
        }
    }
    return max_len;
}

int main() {
    int n, k;
    cin >> n >> k;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cout << longestSubarraySumK(arr, k) << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def longest_subarray_sum_k(arr, k):
    left = 0
    current_sum = 0
    max_len = 0
    for right in range(len(arr)):
        current_sum += arr[right]
        while current_sum > k and left <= right:
            current_sum -= arr[left]
            left += 1
        if current_sum == k:
            max_len = max(max_len, right - left + 1)
    return max_len

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    k = int(data[1])
    arr = list(map(int, data[2:2+n]))
    result = longest_subarray_sum_k(arr, k)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### Longest subarray with sum K (Positives + Negatives)

#### Problem Statement
Find the length of the longest subarray with sum equal to K (can have negatives).

#### Intuition
Use hashmap to store prefix sums and their indices.

#### Algorithm
1. Initialize sum = 0, max_len = 0, hashmap with {0: -1}
2. For i from 0 to n-1:
   - sum += arr[i]
   - If sum - k in hashmap, max_len = max(max_len, i - hashmap[sum - k])
   - If sum not in hashmap, hashmap[sum] = i
3. Return max_len

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int longestSubarraySumK(vector<int>& arr, int k) {
    unordered_map<int, int> prefix;
    prefix[0] = -1;
    int sum = 0, max_len = 0;
    for(int i = 0; i < arr.size(); ++i) {
        sum += arr[i];
        if(prefix.find(sum - k) != prefix.end()) {
            max_len = max(max_len, i - prefix[sum - k]);
        }
        if(prefix.find(sum) == prefix.end()) {
            prefix[sum] = i;
        }
    }
    return max_len;
}

int main() {
    int n, k;
    cin >> n >> k;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cout << longestSubarraySumK(arr, k) << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def longest_subarray_sum_k(arr, k):
    prefix = {0: -1}
    current_sum = 0
    max_len = 0
    for i, num in enumerate(arr):
        current_sum += num
        if current_sum - k in prefix:
            max_len = max(max_len, i - prefix[current_sum - k])
        if current_sum not in prefix:
            prefix[current_sum] = i
    return max_len

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    k = int(data[1])
    arr = list(map(int, data[2:2+n]))
    result = longest_subarray_sum_k(arr, k)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(n)

### 2.2 Medium Problems

#### 2Sum Problem

#### Problem Statement
Find two numbers in an array that add up to a target sum.

#### Intuition
Use a hashmap to store complements.

#### Algorithm
1. Create a hashmap.
2. For each num in arr:
   - If target - num in hashmap, return indices.
   - Else, hashmap[num] = index

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

vector<int> twoSum(vector<int>& nums, int target) {
    unordered_map<int, int> map;
    for(int i = 0; i < nums.size(); ++i) {
        int complement = target - nums[i];
        if(map.find(complement) != map.end()) {
            return {map[complement], i};
        }
        map[nums[i]] = i;
    }
    return {};
}

int main() {
    int n, target;
    cin >> n >> target;
    vector<int> nums(n);
    for(int i = 0; i < n; i++) {
        cin >> nums[i];
    }
    vector<int> result = twoSum(nums, target);
    if(!result.empty()) {
        cout << result[0] << " " << result[1] << endl;
    } else {
        cout << "No solution" << endl;
    }
    return 0;
}
```

#### Python Code
```python
import sys

def two_sum(nums, target):
    map_ = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in map_:
            return [map_[complement], i]
        map_[num] = i
    return []

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    target = int(data[1])
    nums = list(map(int, data[2:2+n]))
    result = two_sum(nums, target)
    if result:
        print(' '.join(map(str, result)))
    else:
        print("No solution")
```

#### Time Complexity
O(n)

#### Space Complexity
O(n)

### Sort an array of 0's 1's and 2's

#### Problem Statement
Sort an array containing only 0s, 1s, and 2s.

#### Intuition
Use Dutch National Flag algorithm with three pointers.

#### Algorithm
1. Initialize low = 0, mid = 0, high = n-1
2. While mid <= high:
   - If arr[mid] == 0, swap arr[low], arr[mid], low++, mid++
   - If arr[mid] == 1, mid++
   - If arr[mid] == 2, swap arr[mid], arr[high], high--

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

void sort012(vector<int>& arr) {
    int low = 0, mid = 0, high = arr.size() - 1;
    while(mid <= high) {
        if(arr[mid] == 0) {
            swap(arr[low], arr[mid]);
            low++;
            mid++;
        } else if(arr[mid] == 1) {
            mid++;
        } else {
            swap(arr[mid], arr[high]);
            high--;
        }
    }
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    sort012(arr);
    for(int num : arr) cout << num << " ";
    cout << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def sort_012(arr):
    low = mid = 0
    high = len(arr) - 1
    while mid <= high:
        if arr[mid] == 0:
            arr[low], arr[mid] = arr[mid], arr[low]
            low += 1
            mid += 1
        elif arr[mid] == 1:
            mid += 1
        else:
            arr[mid], arr[high] = arr[high], arr[mid]
            high -= 1

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    sort_012(arr)
    print(' '.join(map(str, arr)))
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### Majority Element (>n/2 times)

#### Problem Statement
Find the majority element that appears more than n/2 times.

#### Intuition
Use Boyer-Moore Voting Algorithm.

#### Algorithm
1. Initialize candidate = arr[0], count = 1
2. For i from 1 to n-1:
   - If count == 0, candidate = arr[i], count = 1
   - Else if arr[i] == candidate, count++
   - Else count--
3. Verify the candidate.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int majorityElement(vector<int>& nums) {
    int candidate = nums[0], count = 1;
    for(size_t i = 1; i < nums.size(); ++i) {
        if(count == 0) {
            candidate = nums[i];
            count = 1;
        } else if(nums[i] == candidate) {
            count++;
        } else {
            count--;
        }
    }
    // Verification omitted for brevity
    return candidate;
}

int main() {
    int n;
    cin >> n;
    vector<int> nums(n);
    for(int i = 0; i < n; i++) {
        cin >> nums[i];
    }
    cout << majorityElement(nums) << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def majority_element(nums):
    candidate = nums[0]
    count = 1
    for num in nums[1:]:
        if count == 0:
            candidate = num
            count = 1
        elif num == candidate:
            count += 1
        else:
            count -= 1
    # Verification omitted
    return candidate

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    nums = list(map(int, data[1:1+n]))
    result = majority_element(nums)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### Kadane's Algorithm, maximum subarray sum

#### Problem Statement
Find the maximum sum of a contiguous subarray.

#### Intuition
Keep track of current sum, reset if negative.

#### Algorithm
1. Initialize max_sum = INT_MIN, current_sum = 0
2. For each num in arr:
   - current_sum = max(num, current_sum + num)
   - max_sum = max(max_sum, current_sum)
3. Return max_sum

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int maxSubarraySum(vector<int>& arr) {
    int max_sum = INT_MIN, current_sum = 0;
    for(int num : arr) {
        current_sum = max(num, current_sum + num);
        max_sum = max(max_sum, current_sum);
    }
    return max_sum;
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cout << maxSubarraySum(arr) << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def max_subarray_sum(arr):
    max_sum = float('-inf')
    current_sum = 0
    for num in arr:
        current_sum = max(num, current_sum + num)
        max_sum = max(max_sum, current_sum)
    return max_sum

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    result = max_subarray_sum(arr)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### Print subarray with maximum subarray sum

#### Problem Statement
Print the subarray with maximum sum.

#### Intuition
Modify Kadane's to track start and end indices.

#### Algorithm
1. Initialize max_sum = INT_MIN, current_sum = 0, start = 0, end = 0, temp_start = 0
2. For i from 0 to n-1:
   - current_sum += arr[i]
   - If current_sum > max_sum:
     - max_sum = current_sum, start = temp_start, end = i
   - If current_sum < 0:
     - current_sum = 0, temp_start = i+1
3. Print arr[start..end]

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

void printMaxSubarray(vector<int>& arr) {
    int max_sum = INT_MIN, current_sum = 0;
    int start = 0, end = 0, temp_start = 0;
    for(int i = 0; i < arr.size(); ++i) {
        current_sum += arr[i];
        if(current_sum > max_sum) {
            max_sum = current_sum;
            start = temp_start;
            end = i;
        }
        if(current_sum < 0) {
            current_sum = 0;
            temp_start = i + 1;
        }
    }
    for(int i = start; i <= end; ++i) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    printMaxSubarray(arr);
    return 0;
}
```

#### Python Code
```python
import sys

def print_max_subarray(arr):
    max_sum = float('-inf')
    current_sum = 0
    start = end = temp_start = 0
    for i, num in enumerate(arr):
        current_sum += num
        if current_sum > max_sum:
            max_sum = current_sum
            start = temp_start
            end = i
        if current_sum < 0:
            current_sum = 0
            temp_start = i + 1
    print(' '.join(map(str, arr[start:end+1])))

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    print_max_subarray(arr)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### Stock Buy and Sell

#### Problem Statement
Find the maximum profit from buying and selling stocks (one transaction).

#### Intuition
Track minimum price and maximum profit.

#### Algorithm
1. Initialize min_price = INT_MAX, max_profit = 0
2. For each price:
   - min_price = min(min_price, price)
   - max_profit = max(max_profit, price - min_price)
3. Return max_profit

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int maxProfit(vector<int>& prices) {
    int min_price = INT_MAX, max_profit = 0;
    for(int price : prices) {
        min_price = min(min_price, price);
        max_profit = max(max_profit, price - min_price);
    }
    return max_profit;
}

int main() {
    int n;
    cin >> n;
    vector<int> prices(n);
    for(int i = 0; i < n; i++) {
        cin >> prices[i];
    }
    cout << maxProfit(prices) << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def max_profit(prices):
    min_price = float('inf')
    max_profit = 0
    for price in prices:
        min_price = min(min_price, price)
        max_profit = max(max_profit, price - min_price)
    return max_profit

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    prices = list(map(int, data[1:1+n]))
    result = max_profit(prices)
    print(result)
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### Rearrange the array in alternating positive and negative items

#### Problem Statement
Rearrange array with positive and negative numbers alternately.

#### Intuition
Separate positives and negatives, then merge alternately.

#### Algorithm
1. Create two lists: positives and negatives.
2. Iterate and place alternately.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

void rearrange(vector<int>& arr) {
    vector<int> pos, neg;
    for(int num : arr) {
        if(num >= 0) pos.push_back(num);
        else neg.push_back(num);
    }
    size_t i = 0, j = 0, k = 0;
    while(i < pos.size() && j < neg.size()) {
        arr[k++] = pos[i++];
        arr[k++] = neg[j++];
    }
    while(i < pos.size()) arr[k++] = pos[i++];
    while(j < neg.size()) arr[k++] = neg[j++];
}

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for(int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    rearrange(arr);
    for(int num : arr) cout << num << " ";
    cout << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def rearrange(arr):
    pos = [x for x in arr if x >= 0]
    neg = [x for x in arr if x < 0]
    result = []
    i = j = 0
    while i < len(pos) and j < len(neg):
        result.append(pos[i])
        result.append(neg[j])
        i += 1
        j += 1
    result.extend(pos[i:])
    result.extend(neg[j:])
    arr[:] = result

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    arr = list(map(int, data[1:1+n]))
    rearrange(arr)
    print(' '.join(map(str, arr)))
```

#### Time Complexity
O(n)

#### Space Complexity
O(n)

### Next Permutation

#### Problem Statement
Find the next lexicographical permutation of the array.

#### Intuition
Find the first decreasing element from right, swap with next greater, reverse suffix.

#### Algorithm
1. Find largest i where arr[i] < arr[i+1]
2. If no such i, reverse whole array
3. Find largest j > i where arr[j] > arr[i], swap arr[i], arr[j]
4. Reverse arr[i+1..end]

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

void nextPermutation(vector<int>& nums) {
    int n = nums.size(), i = n - 2;
    while(i >= 0 && nums[i] >= nums[i+1]) i--;
    if(i >= 0) {
        int j = n - 1;
        while(nums[j] <= nums[i]) j--;
        swap(nums[i], nums[j]);
    }
    reverse(nums.begin() + i + 1, nums.end());
}

int main() {
    int n;
    cin >> n;
    vector<int> nums(n);
    for(int i = 0; i < n; i++) {
        cin >> nums[i];
    }
    nextPermutation(nums);
    for(int num : nums) cout << num << " ";
    cout << endl;
    return 0;
}
```

#### Python Code
```python
import sys

def next_permutation(nums):
    n = len(nums)
    i = n - 2
    while i >= 0 and nums[i] >= nums[i + 1]:
        i -= 1
    if i >= 0:
        j = n - 1
        while nums[j] <= nums[i]:
            j -= 1
        nums[i], nums[j] = nums[j], nums[i]
    nums[i + 1:] = reversed(nums[i + 1:])

if __name__ == "__main__":
    data = sys.stdin.read().split()
    n = int(data[0])
    nums = list(map(int, data[1:1+n]))
    next_permutation(nums)
    print(' '.join(map(str, nums)))
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### Leaders in an Array problem

#### Problem Statement
Find all leaders (elements greater than all to their right).

#### Intuition
Traverse from right, keep track of max so far.

#### Algorithm
1. Initialize max_right = arr[n-1], leaders = {arr[n-1]}
2. For i from n-2 downto 0:
   - If arr[i] > max_right, leaders.add(arr[i]), max_right = arr[i]
3. Return leaders in order.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

vector<int> leaders(vector<int>& arr) {
    vector<int> result;
    int max_right = arr.back();
    result.push_back(max_right);
    for(int i = arr.size() - 2; i >= 0; --i) {
        if(arr[i] > max_right) {
            result.push_back(arr[i]);
            max_right = arr[i];
        }
    }
    reverse(result.begin(), result.end());
    return result;
}
```

#### Python Code
```python
def leaders(arr):
    if not arr:
        return []
    max_right = arr[-1]
    result = [max_right]
    for num in reversed(arr[:-1]):
        if num > max_right:
            result.append(num)
            max_right = num
    return result[::-1]
```

#### Time Complexity
O(n)

#### Space Complexity
O(n)

### Longest Consecutive Sequence in an Array

#### Problem Statement
Find the length of the longest consecutive sequence.

#### Intuition
Use a set to check for sequences.

#### Algorithm
1. Put all elements in a set.
2. For each num, if num-1 not in set, start sequence, count length.
3. Track max length.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int longestConsecutive(vector<int>& nums) {
    unordered_set<int> s(nums.begin(), nums.end());
    int max_len = 0;
    for(int num : nums) {
        if(s.find(num - 1) == s.end()) {
            int current = num, len = 1;
            while(s.find(current + 1) != s.end()) {
                current++;
                len++;
            }
            max_len = max(max_len, len);
        }
    }
    return max_len;
}
```

#### Python Code
```python
def longest_consecutive(nums):
    num_set = set(nums)
    max_len = 0
    for num in nums:
        if num - 1 not in num_set:
            current = num
            length = 1
            while current + 1 in num_set:
                current += 1
                length += 1
            max_len = max(max_len, length)
    return max_len
```

#### Time Complexity
O(n)

#### Space Complexity
O(n)

### Set Matrix Zeros

#### Problem Statement
Set entire row and column to zero if an element is zero.

#### Intuition
Use first row and column as markers.

#### Algorithm
1. Check if first row/column have zero.
2. Mark rows/columns using first row/column.
3. Set zeros based on markers.
4. Handle first row/column.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

void setZeroes(vector<vector<int>>& matrix) {
    int m = matrix.size(), n = matrix[0].size();
    bool firstRow = false, firstCol = false;
    for(int j = 0; j < n; ++j) if(matrix[0][j] == 0) firstRow = true;
    for(int i = 0; i < m; ++i) if(matrix[i][0] == 0) firstCol = true;
    for(int i = 1; i < m; ++i) {
        for(int j = 1; j < n; ++j) {
            if(matrix[i][j] == 0) {
                matrix[i][0] = 0;
                matrix[0][j] = 0;
            }
        }
    }
    for(int i = 1; i < m; ++i) {
        for(int j = 1; j < n; ++j) {
            if(matrix[i][0] == 0 || matrix[0][j] == 0) {
                matrix[i][j] = 0;
            }
        }
    }
    if(firstRow) for(int j = 0; j < n; ++j) matrix[0][j] = 0;
    if(firstCol) for(int i = 0; i < m; ++i) matrix[i][0] = 0;
}
```

#### Python Code
```python
def set_zeroes(matrix):
    if not matrix:
        return
    m, n = len(matrix), len(matrix[0])
    first_row = any(matrix[0][j] == 0 for j in range(n))
    first_col = any(matrix[i][0] == 0 for i in range(m))
    for i in range(1, m):
        for j in range(1, n):
            if matrix[i][j] == 0:
                matrix[i][0] = 0
                matrix[0][j] = 0
    for i in range(1, m):
        for j in range(1, n):
            if matrix[i][0] == 0 or matrix[0][j] == 0:
                matrix[i][j] = 0
    if first_row:
        for j in range(n):
            matrix[0][j] = 0
    if first_col:
        for i in range(m):
            matrix[i][0] = 0
```

#### Time Complexity
O(m*n)

#### Space Complexity
O(1)

### Rotate Matrix by 90 degrees

#### Problem Statement
Rotate the matrix 90 degrees clockwise in-place.

#### Intuition
Transpose then reverse each row.

#### Algorithm
1. Transpose: swap matrix[i][j] with matrix[j][i]
2. Reverse each row.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

void rotate(vector<vector<int>>& matrix) {
    int n = matrix.size();
    // Transpose
    for(int i = 0; i < n; ++i) {
        for(int j = i; j < n; ++j) {
            swap(matrix[i][j], matrix[j][i]);
        }
    }
    // Reverse each row
    for(int i = 0; i < n; ++i) {
        reverse(matrix[i].begin(), matrix[i].end());
    }
}
```

#### Python Code
```python
def rotate(matrix):
    n = len(matrix)
    # Transpose
    for i in range(n):
        for j in range(i, n):
            matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
    # Reverse each row
    for row in matrix:
        row.reverse()
```

#### Time Complexity
O(n^2)

#### Space Complexity
O(1)

### Print the matrix in spiral manner

#### Problem Statement
Print the matrix elements in spiral order.

#### Intuition
Use four pointers for boundaries.

#### Algorithm
1. Initialize top=0, bottom=m-1, left=0, right=n-1
2. While top <= bottom and left <= right:
   - Traverse right: top row
   - Traverse down: right column
   - If top <= bottom, traverse left: bottom row
   - If left <= right, traverse up: left column
   - Update boundaries

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

vector<int> spiralOrder(vector<vector<int>>& matrix) {
    vector<int> result;
    if(matrix.empty()) return result;
    int m = matrix.size(), n = matrix[0].size();
    int top = 0, bottom = m - 1, left = 0, right = n - 1;
    while(top <= bottom && left <= right) {
        for(int j = left; j <= right; ++j) result.push_back(matrix[top][j]);
        top++;
        for(int i = top; i <= bottom; ++i) result.push_back(matrix[i][right]);
        right--;
        if(top <= bottom) {
            for(int j = right; j >= left; --j) result.push_back(matrix[bottom][j]);
            bottom--;
        }
        if(left <= right) {
            for(int i = bottom; i >= top; --i) result.push_back(matrix[i][left]);
            left++;
        }
    }
    return result;
}
```

#### Python Code
```python
def spiral_order(matrix):
    if not matrix:
        return []
    result = []
    m, n = len(matrix), len(matrix[0])
    top = left = 0
    bottom = m - 1
    right = n - 1
    while top <= bottom and left <= right:
        # Top row
        for j in range(left, right + 1):
            result.append(matrix[top][j])
        top += 1
        # Right column
        for i in range(top, bottom + 1):
            result.append(matrix[i][right])
        right -= 1
        # Bottom row
        if top <= bottom:
            for j in range(right, left - 1, -1):
                result.append(matrix[bottom][j])
            bottom -= 1
        # Left column
        if left <= right:
            for i in range(bottom, top - 1, -1):
                result.append(matrix[i][left])
            left += 1
    return result
```

#### Time Complexity
O(m*n)

#### Space Complexity
O(1) excluding output

### Count subarrays with given sum

#### Problem Statement
Count subarrays with sum equal to K.

#### Intuition
Use prefix sum and hashmap.

#### Algorithm
1. Initialize sum = 0, count = 0, prefix = {0:1}
2. For each num:
   - sum += num
   - If sum - k in prefix, count += prefix[sum - k]
   - prefix[sum] += 1

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int subarraySum(vector<int>& nums, int k) {
    unordered_map<int, int> prefix;
    prefix[0] = 1;
    int sum = 0, count = 0;
    for(int num : nums) {
        sum += num;
        if(prefix.find(sum - k) != prefix.end()) {
            count += prefix[sum - k];
        }
        prefix[sum]++;
    }
    return count;
}
```

#### Python Code
```python
def subarray_sum(nums, k):
    prefix = {0: 1}
    current_sum = 0
    count = 0
    for num in nums:
        current_sum += num
        if current_sum - k in prefix:
            count += prefix[current_sum - k]
        prefix[current_sum] = prefix.get(current_sum, 0) + 1
    return count
```

#### Time Complexity
O(n)

#### Space Complexity
O(n)

### 2.3 Hard Problems

#### Pascal's Triangle

#### Problem Statement
Generate the first n rows of Pascal's triangle.

#### Intuition
Each row is generated from the previous.

#### Algorithm
1. Initialize result as empty list
2. For each row i from 0 to n-1:
   - Start with [1]
   - For j from 1 to i, append prev[j-1] + prev[j]
   - Append 1
   - Add to result

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

vector<vector<int>> generate(int numRows) {
    vector<vector<int>> result;
    for(int i = 0; i < numRows; ++i) {
        vector<int> row;
        row.push_back(1);
        for(int j = 1; j < i; ++j) {
            row.push_back(result[i-1][j-1] + result[i-1][j]);
        }
        if(i > 0) row.push_back(1);
        result.push_back(row);
    }
    return result;
}
```

#### Python Code
```python
def generate(num_rows):
    result = []
    for i in range(num_rows):
        row = [1]
        if i > 0:
            for j in range(1, i):
                row.append(result[i-1][j-1] + result[i-1][j])
            row.append(1)
        result.append(row)
    return result
```

#### Time Complexity
O(n^2)

#### Space Complexity
O(n^2)

### Majority Element (n/3 times)

#### Problem Statement
Find elements that appear more than n/3 times.

#### Intuition
Use Boyer-Moore for two candidates.

#### Algorithm
1. Initialize candidate1, candidate2, count1=0, count2=0
2. For each num:
   - If num == candidate1, count1++
   - Else if num == candidate2, count2++
   - Else if count1==0, candidate1=num, count1=1
   - Else if count2==0, candidate2=num, count2=1
   - Else count1--, count2--
3. Verify counts.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

vector<int> majorityElement(vector<int>& nums) {
    int candidate1 = 0, candidate2 = 0, count1 = 0, count2 = 0;
    for(int num : nums) {
        if(num == candidate1) count1++;
        else if(num == candidate2) count2++;
        else if(count1 == 0) { candidate1 = num; count1 = 1; }
        else if(count2 == 0) { candidate2 = num; count2 = 1; }
        else { count1--; count2--; }
    }
    // Verification omitted
    vector<int> result;
    if(count1 > 0) result.push_back(candidate1);
    if(count2 > 0) result.push_back(candidate2);
    return result;
}
```

#### Python Code
```python
def majority_element(nums):
    candidate1 = candidate2 = None
    count1 = count2 = 0
    for num in nums:
        if num == candidate1:
            count1 += 1
        elif num == candidate2:
            count2 += 1
        elif count1 == 0:
            candidate1 = num
            count1 = 1
        elif count2 == 0:
            candidate2 = num
            count2 = 1
        else:
            count1 -= 1
            count2 -= 1
    # Verification omitted
    result = []
    if count1 > 0:
        result.append(candidate1)
    if count2 > 0:
        result.append(candidate2)
    return result
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### 3-Sum Problem

#### Problem Statement
Find all unique triplets that sum to zero.

#### Intuition
Sort array, use two pointers for each fixed element.

#### Algorithm
1. Sort the array.
2. For i from 0 to n-3:
   - If i > 0 and nums[i] == nums[i-1], skip
   - Set left = i+1, right = n-1
   - While left < right:
     - sum = nums[i] + nums[left] + nums[right]
     - If sum == 0, add triplet, skip duplicates
     - Else if sum < 0, left++
     - Else right--

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

vector<vector<int>> threeSum(vector<int>& nums) {
    vector<vector<int>> result;
    sort(nums.begin(), nums.end());
    for(int i = 0; i < nums.size() - 2; ++i) {
        if(i > 0 && nums[i] == nums[i-1]) continue;
        int left = i + 1, right = nums.size() - 1;
        while(left < right) {
            int sum = nums[i] + nums[left] + nums[right];
            if(sum == 0) {
                result.push_back({nums[i], nums[left], nums[right]});
                while(left < right && nums[left] == nums[left+1]) left++;
                while(left < right && nums[right] == nums[right-1]) right--;
                left++;
                right--;
            } else if(sum < 0) {
                left++;
            } else {
                right--;
            }
        }
    }
    return result;
}
```

#### Python Code
```python
def three_sum(nums):
    nums.sort()
    result = []
    for i in range(len(nums) - 2):
        if i > 0 and nums[i] == nums[i - 1]:
            continue
        left, right = i + 1, len(nums) - 1
        while left < right:
            total = nums[i] + nums[left] + nums[right]
            if total == 0:
                result.append([nums[i], nums[left], nums[right]])
                while left < right and nums[left] == nums[left + 1]:
                    left += 1
                while left < right and nums[right] == nums[right - 1]:
                    right -= 1
                left += 1
                right -= 1
            elif total < 0:
                left += 1
            else:
                right -= 1
    return result
```

#### Time Complexity
O(n^2)

#### Space Complexity
O(1) excluding output

### 4-Sum Problem

#### Problem Statement
Find all unique quadruplets that sum to target.

#### Intuition
Similar to 3-sum, add another loop.

#### Algorithm
1. Sort array.
2. For i from 0 to n-4:
   - For j from i+1 to n-3:
     - Set left = j+1, right = n-1
     - While left < right, check sum == target

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

vector<vector<int>> fourSum(vector<int>& nums, int target) {
    vector<vector<int>> result;
    sort(nums.begin(), nums.end());
    for(int i = 0; i < nums.size() - 3; ++i) {
        if(i > 0 && nums[i] == nums[i-1]) continue;
        for(int j = i + 1; j < nums.size() - 2; ++j) {
            if(j > i + 1 && nums[j] == nums[j-1]) continue;
            int left = j + 1, right = nums.size() - 1;
            while(left < right) {
                long long sum = (long long)nums[i] + nums[j] + nums[left] + nums[right];
                if(sum == target) {
                    result.push_back({nums[i], nums[j], nums[left], nums[right]});
                    while(left < right && nums[left] == nums[left+1]) left++;
                    while(left < right && nums[right] == nums[right-1]) right--;
                    left++;
                    right--;
                } else if(sum < target) {
                    left++;
                } else {
                    right--;
                }
            }
        }
    }
    return result;
}
```

#### Python Code
```python
def four_sum(nums, target):
    nums.sort()
    result = []
    for i in range(len(nums) - 3):
        if i > 0 and nums[i] == nums[i - 1]:
            continue
        for j in range(i + 1, len(nums) - 2):
            if j > i + 1 and nums[j] == nums[j - 1]:
                continue
            left, right = j + 1, len(nums) - 1
            while left < right:
                total = nums[i] + nums[j] + nums[left] + nums[right]
                if total == target:
                    result.append([nums[i], nums[j], nums[left], nums[right]])
                    while left < right and nums[left] == nums[left + 1]:
                        left += 1
                    while left < right and nums[right] == nums[right - 1]:
                        right -= 1
                    left += 1
                    right -= 1
                elif total < target:
                    left += 1
                else:
                    right -= 1
    return result
```

#### Time Complexity
O(n^3)

#### Space Complexity
O(1) excluding output

### Largest Subarray with 0 Sum

#### Problem Statement
Find the length of the largest subarray with sum 0.

#### Intuition
Use prefix sum and hashmap.

#### Algorithm
1. Initialize sum = 0, max_len = 0, prefix = {0: -1}
2. For i from 0 to n-1:
   - sum += arr[i]
   - If sum in prefix, max_len = max(max_len, i - prefix[sum])
   - Else prefix[sum] = i

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int maxLen(vector<int>& arr) {
    unordered_map<int, int> prefix;
    prefix[0] = -1;
    int sum = 0, max_len = 0;
    for(int i = 0; i < arr.size(); ++i) {
        sum += arr[i];
        if(prefix.find(sum) != prefix.end()) {
            max_len = max(max_len, i - prefix[sum]);
        } else {
            prefix[sum] = i;
        }
    }
    return max_len;
}
```

#### Python Code
```python
def max_len(arr):
    prefix = {0: -1}
    current_sum = 0
    max_len = 0
    for i, num in enumerate(arr):
        current_sum += num
        if current_sum in prefix:
            max_len = max(max_len, i - prefix[current_sum])
        else:
            prefix[current_sum] = i
    return max_len
```

#### Time Complexity
O(n)

#### Space Complexity
O(n)

### Count number of subarrays with given xor K

#### Problem Statement
Count subarrays with XOR equal to K.

#### Intuition
Use prefix XOR and hashmap.

#### Algorithm
1. Initialize xor_val = 0, count = 0, prefix = {0:1}
2. For each num:
   - xor_val ^= num
   - If xor_val ^ k in prefix, count += prefix[xor_val ^ k]
   - prefix[xor_val] += 1

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int subarraysWithXorK(vector<int>& arr, int k) {
    unordered_map<int, int> prefix;
    prefix[0] = 1;
    int xor_val = 0, count = 0;
    for(int num : arr) {
        xor_val ^= num;
        if(prefix.find(xor_val ^ k) != prefix.end()) {
            count += prefix[xor_val ^ k];
        }
        prefix[xor_val]++;
    }
    return count;
}
```

#### Python Code
```python
def subarrays_with_xor_k(arr, k):
    prefix = {0: 1}
    xor_val = 0
    count = 0
    for num in arr:
        xor_val ^= num
        if xor_val ^ k in prefix:
            count += prefix[xor_val ^ k]
        prefix[xor_val] = prefix.get(xor_val, 0) + 1
    return count
```

#### Time Complexity
O(n)

#### Space Complexity
O(n)

### Merge Overlapping Subintervals

#### Problem Statement
Merge all overlapping intervals.

#### Intuition
Sort intervals, merge if overlap.

#### Algorithm
1. Sort intervals by start.
2. Initialize result with first interval.
3. For each interval:
   - If current.start <= last.end, merge (update end)
   - Else add new

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

vector<vector<int>> merge(vector<vector<int>>& intervals) {
    if(intervals.empty()) return {};
    sort(intervals.begin(), intervals.end());
    vector<vector<int>> result;
    result.push_back(intervals[0]);
    for(size_t i = 1; i < intervals.size(); ++i) {
        if(intervals[i][0] <= result.back()[1]) {
            result.back()[1] = max(result.back()[1], intervals[i][1]);
        } else {
            result.push_back(intervals[i]);
        }
    }
    return result;
}
```

#### Python Code
```python
def merge(intervals):
    if not intervals:
        return []
    intervals.sort(key=lambda x: x[0])
    result = [intervals[0]]
    for interval in intervals[1:]:
        if interval[0] <= result[-1][1]:
            result[-1][1] = max(result[-1][1], interval[1])
        else:
            result.append(interval)
    return result
```

#### Time Complexity
O(n log n)

#### Space Complexity
O(n)

### Merge two sorted arrays without extra space

#### Problem Statement
Merge two sorted arrays in-place.

#### Intuition
Start from end, place larger elements.

#### Algorithm
1. i = m-1, j = n-1, k = m+n-1
2. While i >=0 and j >=0:
   - If arr1[i] > arr2[j], arr1[k--] = arr1[i--]
   - Else arr1[k--] = arr2[j--]
3. Copy remaining arr2 to arr1

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

void merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
    int i = m - 1, j = n - 1, k = m + n - 1;
    while(i >= 0 && j >= 0) {
        if(nums1[i] > nums2[j]) {
            nums1[k--] = nums1[i--];
        } else {
            nums1[k--] = nums2[j--];
        }
    }
    while(j >= 0) {
        nums1[k--] = nums2[j--];
    }
}
```

#### Python Code
```python
def merge(nums1, m, nums2, n):
    i = m - 1
    j = n - 1
    k = m + n - 1
    while i >= 0 and j >= 0:
        if nums1[i] > nums2[j]:
            nums1[k] = nums1[i]
            i -= 1
        else:
            nums1[k] = nums2[j]
            j -= 1
        k -= 1
    while j >= 0:
        nums1[k] = nums2[j]
        j -= 1
        k -= 1
```

#### Time Complexity
O(m + n)

#### Space Complexity
O(1)

### Find the repeating and missing number

#### Problem Statement
Find the repeating and missing number in array 1 to n.

#### Intuition
Use math: sum and sum of squares.

#### Algorithm
1. Compute actual_sum, actual_sum_sq
2. expected_sum = n*(n+1)/2, expected_sum_sq = n*(n+1)*(2n+1)/6
3. diff = expected_sum - actual_sum
4. diff_sq = expected_sum_sq - actual_sum_sq
5. repeating = (diff_sq / diff + diff) / 2
6. missing = repeating - diff

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

vector<int> findRepeatingMissing(vector<int>& arr) {
    long long n = arr.size();
    long long sum = 0, sum_sq = 0;
    for(int num : arr) {
        sum += num;
        sum_sq += (long long)num * num;
    }
    long long expected_sum = n * (n + 1) / 2;
    long long expected_sum_sq = n * (n + 1) * (2 * n + 1) / 6;
    long long diff = expected_sum - sum;
    long long diff_sq = expected_sum_sq - sum_sq;
    long long repeating = (diff_sq / diff + diff) / 2;
    long long missing = repeating - diff;
    return {(int)repeating, (int)missing};
}
```

#### Python Code
```python
def find_repeating_missing(arr):
    n = len(arr)
    sum_val = sum(arr)
    sum_sq = sum(x * x for x in arr)
    expected_sum = n * (n + 1) // 2
    expected_sum_sq = n * (n + 1) * (2 * n + 1) // 6
    diff = expected_sum - sum_val
    diff_sq = expected_sum_sq - sum_sq
    repeating = (diff_sq // diff + diff) // 2
    missing = repeating - diff
    return [repeating, missing]
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)

### Count Inversions

#### Problem Statement
Count pairs where i < j and arr[i] > arr[j].

#### Intuition
Use merge sort to count inversions.

#### Algorithm
Merge sort with inversion count.

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

long long merge(vector<int>& arr, int left, int mid, int right) {
    vector<int> temp(right - left + 1);
    int i = left, j = mid + 1, k = 0;
    long long inv = 0;
    while(i <= mid && j <= right) {
        if(arr[i] <= arr[j]) {
            temp[k++] = arr[i++];
        } else {
            temp[k++] = arr[j++];
            inv += (mid - i + 1);
        }
    }
    while(i <= mid) temp[k++] = arr[i++];
    while(j <= right) temp[k++] = arr[j++];
    for(int p = 0; p < k; ++p) arr[left + p] = temp[p];
    return inv;
}

long long mergeSort(vector<int>& arr, int left, int right) {
    long long inv = 0;
    if(left < right) {
        int mid = left + (right - left) / 2;
        inv += mergeSort(arr, left, mid);
        inv += mergeSort(arr, mid + 1, right);
        inv += merge(arr, left, mid, right);
    }
    return inv;
}

long long countInversions(vector<int>& arr) {
    return mergeSort(arr, 0, arr.size() - 1);
}
```

#### Python Code
```python
def merge(arr, left, mid, right):
    temp = []
    i = left
    j = mid + 1
    inv = 0
    while i <= mid and j <= right:
        if arr[i] <= arr[j]:
            temp.append(arr[i])
            i += 1
        else:
            temp.append(arr[j])
            j += 1
            inv += (mid - i + 1)
    temp.extend(arr[i:mid+1])
    temp.extend(arr[j:right+1])
    arr[left:right+1] = temp
    return inv

def merge_sort(arr, left, right):
    inv = 0
    if left < right:
        mid = (left + right) // 2
        inv += merge_sort(arr, left, mid)
        inv += merge_sort(arr, mid + 1, right)
        inv += merge(arr, left, mid, right)
    return inv

def count_inversions(arr):
    return merge_sort(arr, 0, len(arr) - 1)
```

#### Time Complexity
O(n log n)

#### Space Complexity
O(n)

### Reverse Pairs

#### Problem Statement
Count pairs where i < j and arr[i] > 2*arr[j].

#### Intuition
Modified merge sort.

#### Algorithm
Similar to inversions, but condition arr[i] > 2*arr[j].

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

long long merge(vector<int>& arr, int left, int mid, int right) {
    vector<int> temp(right - left + 1);
    int i = left, j = mid + 1, k = 0;
    long long rev = 0;
    // Count reverse pairs
    int p = left;
    for(int q = mid + 1; q <= right; ++q) {
        while(p <= mid && arr[p] <= 2LL * arr[q]) p++;
        rev += (mid - p + 1);
    }
    // Merge
    i = left, j = mid + 1, k = 0;
    while(i <= mid && j <= right) {
        if(arr[i] <= arr[j]) {
            temp[k++] = arr[i++];
        } else {
            temp[k++] = arr[j++];
        }
    }
    while(i <= mid) temp[k++] = arr[i++];
    while(j <= right) temp[k++] = arr[j++];
    for(int p = 0; p < k; ++p) arr[left + p] = temp[p];
    return rev;
}

long long mergeSort(vector<int>& arr, int left, int right) {
    long long rev = 0;
    if(left < right) {
        int mid = left + (right - left) / 2;
        rev += mergeSort(arr, left, mid);
        rev += mergeSort(arr, mid + 1, right);
        rev += merge(arr, left, mid, right);
    }
    return rev;
}

long long reversePairs(vector<int>& nums) {
    return mergeSort(nums, 0, nums.size() - 1);
}
```

#### Python Code
```python
def merge(arr, left, mid, right):
    temp = []
    rev = 0
    # Count reverse pairs
    p = left
    for q in range(mid + 1, right + 1):
        while p <= mid and arr[p] <= 2 * arr[q]:
            p += 1
        rev += (mid - p + 1)
    # Merge
    i = left
    j = mid + 1
    while i <= mid and j <= right:
        if arr[i] <= arr[j]:
            temp.append(arr[i])
            i += 1
        else:
            temp.append(arr[j])
            j += 1
    temp.extend(arr[i:mid+1])
    temp.extend(arr[j:right+1])
    arr[left:right+1] = temp
    return rev

def merge_sort(arr, left, right):
    rev = 0
    if left < right:
        mid = (left + right) // 2
        rev += merge_sort(arr, left, mid)
        rev += merge_sort(arr, mid + 1, right)
        rev += merge(arr, left, mid, right)
    return rev

def reverse_pairs(nums):
    return merge_sort(nums, 0, len(nums) - 1)
```

#### Time Complexity
O(n log n)

#### Space Complexity
O(n)

### Maximum Product Subarray

#### Problem Statement
Find the maximum product of a contiguous subarray.

#### Intuition
Track max and min product, handle negatives.

#### Algorithm
1. Initialize max_prod = min_prod = result = arr[0]
2. For i from 1 to n-1:
   - If arr[i] < 0, swap max_prod, min_prod
   - max_prod = max(arr[i], max_prod * arr[i])
   - min_prod = min(arr[i], min_prod * arr[i])
   - result = max(result, max_prod)

#### C++ Code
```cpp
#include <bits/stdc++.h>
using namespace std;

int maxProduct(vector<int>& nums) {
    if(nums.empty()) return 0;
    int max_prod = nums[0], min_prod = nums[0], result = nums[0];
    for(size_t i = 1; i < nums.size(); ++i) {
        if(nums[i] < 0) swap(max_prod, min_prod);
        max_prod = max(nums[i], max_prod * nums[i]);
        min_prod = min(nums[i], min_prod * nums[i]);
        result = max(result, max_prod);
    }
    return result;
}
```

#### Python Code
```python
def max_product(nums):
    if not nums:
        return 0
    max_prod = min_prod = result = nums[0]
    for num in nums[1:]:
        if num < 0:
            max_prod, min_prod = min_prod, max_prod
        max_prod = max(num, max_prod * num)
        min_prod = min(num, min_prod * num)
        result = max(result, max_prod)
    return result
```

#### Time Complexity
O(n)

#### Space Complexity
O(1)