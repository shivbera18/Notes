# 🐍 Complete Guide: How to Run Python Code on Your System

## 📋 Your System Setup

You have **TWO** Python installations on your system:

### 1️⃣ **Standalone Python 3.11.9**
- **Location:** `C:\Users\Shiv\AppData\Local\Programs\Python\Python311\`
- **Version:** Python 3.11.9
- **Status:** ✅ Added to PATH (Default)

### 2️⃣ **Anaconda Python 3.11.5**
- **Location:** `C:\Users\Shiv\Anaconda3\`
- **Version:** Python 3.11.5
- **Conda Version:** 23.9.0
- **Status:** ⚠️ NOT in PATH (needs manual path or activation)

---

## 🚀 How to Run Python Code - 5 Methods

### **Method 1: Using Default Python (Easiest & Recommended)**

This is the **SIMPLEST** way since Python is already in your PATH.

#### **Step 1:** Open PowerShell or Command Prompt
- Press `Win + R`, type `powershell`, and hit Enter
- Or right-click in your folder → "Open in Terminal"

#### **Step 2:** Navigate to your code folder (if not already there)
```powershell
cd C:\Users\Shiv\Desktop\Notes
```

#### **Step 3:** Run your Python file
```powershell
python main.py
```

**✅ That's it! Your code will run.**

---

### **Method 2: Using VS Code (Best for Development)**

This is the **BEST** method for writing and running code regularly.

#### **Step 1:** Open your Python file in VS Code
- Open `main.py` in VS Code

#### **Step 2:** Run the code
Choose one of these options:

**Option A: Run Button**
- Click the ▶️ **Run** button at the top-right corner

**Option B: Keyboard Shortcut**
- Press `Ctrl + F5` to run without debugging
- Or press `F5` to run with debugging

**Option C: Right-click Method**
- Right-click in the editor
- Select "Run Python File in Terminal"

---

### **Method 3: Using Anaconda Python**

Use this if you need Anaconda-specific packages or environments.

#### **Step 1:** Initialize Anaconda (One-time setup)
```powershell
C:\Users\Shiv\Anaconda3\Scripts\conda.exe init powershell
```

**Then close and reopen PowerShell/Terminal.**

#### **Step 2:** Activate base environment
```powershell
conda activate base
```

#### **Step 3:** Run your code
```powershell
python main.py
```

---

### **Method 4: Using Full Paths (No Setup Needed)**

#### **For Standalone Python:**
```powershell
C:\Users\Shiv\AppData\Local\Programs\Python\Python311\python.exe main.py
```

#### **For Anaconda Python:**
```powershell
C:\Users\Shiv\Anaconda3\python.exe main.py
```

---

### **Method 5: Interactive Python Shell**

#### **Open Python Shell:**
```powershell
python
```

You'll see:
```
Python 3.11.9 (main, ...)
>>>
```

#### **Type code directly:**
```python
>>> print("Hello World!")
Hello World!
>>> x = 5 + 3
>>> print(x)
8
>>> exit()
```

Type `exit()` or press `Ctrl + Z` then `Enter` to quit.

---

## 🎯 Quick Testing - Let's Verify Everything Works!

### Test 1: Check Python is Working
```powershell
python --version
```
**Expected Output:** `Python 3.11.9`

### Test 2: Run a Simple Command
```powershell
python -c "print('Hello from Python!')"
```
**Expected Output:** `Hello from Python!`

### Test 3: Run Your main.py File
```powershell
python main.py
```
**Expected Output:** Your merge sort program output

---

## 🛠️ Common Commands Reference

### Running Python Files
```powershell
# Run a Python file
python filename.py

# Run with full path
python C:\path\to\your\file.py

# Run with arguments
python script.py arg1 arg2
```

### Package Management
```powershell
# Install a package
pip install package_name

# Install multiple packages
pip install numpy pandas matplotlib

# List installed packages
pip list

# Uninstall a package
pip uninstall package_name
```

### Anaconda Commands
```powershell
# Activate base environment
conda activate base

# Deactivate environment
conda deactivate

# List all environments
conda env list

# Create new environment
conda create -n myenv python=3.11

# Install package with conda
conda install numpy
```

---

## 💡 Which Method Should You Use?

### **For Beginners:** 
→ Use **Method 1** (Default Python in Terminal)

### **For Regular Development:** 
→ Use **Method 2** (VS Code)

### **For Data Science/ML Projects:** 
→ Use **Method 3** (Anaconda)

### **For Quick Testing:** 
→ Use **Method 5** (Interactive Shell)

---

## ⚠️ Important Notes

1. **Your default `python` command uses Python 3.11.9** (standalone installation)
   
2. **Anaconda is installed but not in PATH** - you need to:
   - Either use full paths
   - Or run `conda init` and activate environments

3. **In VS Code**, you can select which Python interpreter to use:
   - Press `Ctrl + Shift + P`
   - Type "Python: Select Interpreter"
   - Choose between Python 3.11.9 or Anaconda Python 3.11.5

4. **Your main.py has a syntax issue:**
   - Line 1 and 45 have `//` comments (JavaScript style)
   - Python uses `#` for comments
   - Fix: Change `//` to `#`

---

## 🐛 Troubleshooting

### Problem: "python is not recognized"
**Solution:** Restart your terminal/PowerShell

### Problem: "No module named 'xyz'"
**Solution:** Install the module:
```powershell
pip install xyz
```

### Problem: Code runs but hangs waiting for input
**Solution:** Your code (main.py) waits for user input at line 46. Type numbers and press Enter.

### Problem: "conda is not recognized"
**Solution:** Run this once:
```powershell
C:\Users\Shiv\Anaconda3\Scripts\conda.exe init powershell
```
Then restart terminal.

---

## 📝 Example: Running Your main.py

```powershell
# Navigate to your folder
cd C:\Users\Shiv\Desktop\Notes

# Run the code
python main.py

# Output will show:
# Unsorted array: [38, 27, 43, 3, 9, 82, 10]
# Sorted array: [3, 9, 10, 27, 38, 43, 82]
# Enter numbers separated by spaces: 
# (Type numbers like: 5 2 8 1 9)
# Sorted user array: [1, 2, 5, 8, 9]
```

---

## 🎓 Next Steps

1. ✅ **Test Python is working** using Method 1
2. ✅ **Run your main.py file**
3. ✅ **Fix the comment syntax** in main.py (change `//` to `#`)
4. ✅ **Set up VS Code** for easier development
5. ✅ **Learn pip** for installing packages
6. ✅ **Explore Anaconda environments** if needed for data science

---

## 📚 Additional Resources

- **Python Documentation:** https://docs.python.org/3/
- **VS Code Python Tutorial:** https://code.visualstudio.com/docs/python/python-tutorial
- **Anaconda Documentation:** https://docs.anaconda.com/
- **Package Index (PyPI):** https://pypi.org/

---

**Happy Coding! 🎉**

*Last Updated: January 6, 2026*
