# Low Level Design (LLD) & Machine Coding Mastery Guide (C++)

This guide covers Object-Oriented Programming (OOP) in depth, SOLID principles, Design Patterns, and common Machine Coding/System Design questions, tailored for Software Development roles.

## Table of Contents
1.  [Part 1: Object-Oriented Programming (OOP) Deep Dive](#part-1-object-oriented-programming-oop-deep-dive)
    *   [The 4 Pillars of OOP](#1-the-4-pillars-of-oop)
    *   [C++ OOP Internals & Essentials](#2-c-oop-internals--essentials)
2.  [Part 2: SOLID Principles](#part-2-solid-principles)
3.  [Part 3: Design Patterns](#part-3-design-patterns-gang-of-four)
    *   [Creational Patterns](#a-creational-patterns)
    *   [Structural Patterns](#b-structural-patterns)
    *   [Behavioral Patterns](#c-behavioral-patterns)
4.  [Part 4: Standard Machine Coding Questions](#part-4-standard-machine-coding--lld-questions)

---

# Part 1: Object-Oriented Programming (OOP) Deep Dive

## 1. The 4 Pillars of OOP

### A. Encapsulation
**Definition:** Bundling data (variables) and methods (functions) into a single unit (class) and restricting direct access to some components.
**Why:** Protects object integrity and hides implementation details.

```cpp
#include <iostream>
using namespace std;

class BankAccount {
private:
    double balance; // Data hidden from outside world

public:
    BankAccount(double initial) {
        if (initial >= 0) balance = initial;
        else balance = 0;
    }

    // Public method to access private data (Getter)
    double getBalance() const {
        return balance;
    }

    // Public method to modify private data (Setter)
    void deposit(double amount) {
        if (amount > 0) balance += amount;
    }
};
```

### B. Abstraction
**Definition:** Hiding complex implementation details and showing only the essential features of the object.
**Implementation:** Uses **Abstract Classes** (classes with at least one pure virtual function) and **Interfaces**.

```cpp
// Abstract Class
class Shape {
public:
    virtual void draw() = 0; // Pure Virtual Function
    virtual ~Shape() {}      // Virtual Destructor (Crucial for abstract classes)
};

class Circle : public Shape {
public:
    void draw() override {
        cout << "Drawing Circle" << endl;
    }
};

class Rectangle : public Shape {
public:
    void draw() override {
        cout << "Drawing Rectangle" << endl;
    }
};

// Usage
void renderShape(Shape* s) {
    s->draw(); // Abstraction: We don't know what shape it is, we just know it draws.
}
```

### C. Inheritance
**Definition:** Mechanism where a new class acquires the properties and behavior of an existing class.
**Modes:**
*   `public`: Public members stay public, protected stay protected.
*   `protected`: Public and protected members become protected.
*   `private`: Public and protected members become private.

```cpp
class Animal {
public:
    void eat() { cout << "Eating..." << endl; }
};

class Dog : public Animal { // 'is-a' relationship
public:
    void bark() { cout << "Barking..." << endl; }
};
```

### D. Polymorphism
**Definition:** The ability of a message to be displayed in more than one form.

**1. Compile-time Polymorphism (Static Binding)**
*   **Function Overloading:** Same function name, different parameters.
*   **Operator Overloading:** Customizing operators for classes.

```cpp
class Math {
public:
    int add(int a, int b) { return a + b; }
    double add(double a, double b) { return a + b; } // Overloaded
};
```

**2. Run-time Polymorphism (Dynamic Binding)**
*   **Virtual Functions:** Resolved at runtime using V-Table.

```cpp
class Base {
public:
    virtual void show() { cout << "Base Show" << endl; }
};

class Derived : public Base {
public:
    void show() override { cout << "Derived Show" << endl; }
};

// Usage
Base* b = new Derived();
b->show(); // Output: Derived Show (Magic of Virtual Functions)
```

## 2. C++ OOP Internals & Essentials

### A. How Member Functions Work (`this` Pointer)
When you call `obj.func(10)`, the compiler actually converts it to `func(&obj, 10)`.
The `this` pointer is a hidden first argument passed to all non-static member functions.

```cpp
class Test {
    int x;
public:
    void setX(int x) {
        this->x = x; // 'this' distinguishes member 'x' from argument 'x'
    }
};
```

### B. Constructors & Destructors
*   **Default Constructor:** No args.
*   **Parameterized Constructor:** With args.
*   **Copy Constructor:** Creates a new object as a copy of an existing object.
*   **Destructor:** Cleans up resources.

**Initialization Lists (Performance Tip):** Always prefer initialization lists over assignment inside the body.
```cpp
class Entity {
    int x, y;
public:
    // Initialization List: Direct initialization (Faster)
    Entity(int x, int y) : x(x), y(y) {} 
    
    // Assignment: Default init then assign (Slower)
    // Entity(int x, int y) { this->x = x; this->y = y; } 
};
```

### C. Deep Copy vs Shallow Copy (Rule of 3)
If your class manages raw pointers, the default copy constructor performs a **Shallow Copy** (copies the pointer address, not the data). You MUST implement a **Deep Copy**.

**The Rule of 3:** If you define one of the following, you likely need all three:
1.  Destructor
2.  Copy Constructor
3.  Copy Assignment Operator

```cpp
class String {
private:
    char* buffer;
    int size;
public:
    String(const char* string) {
        size = strlen(string);
        buffer = new char[size + 1];
        strcpy(buffer, string);
    }

    // 1. Copy Constructor (Deep Copy)
    String(const String& other) : size(other.size) {
        buffer = new char[size + 1];
        strcpy(buffer, other.buffer);
    }

    // 2. Copy Assignment Operator
    String& operator=(const String& other) {
        if (this == &other) return *this; // Self-assignment check
        delete[] buffer; // Clear existing
        size = other.size;
        buffer = new char[size + 1];
        strcpy(buffer, other.buffer);
        return *this;
    }

    // 3. Destructor
    ~String() {
        delete[] buffer;
    }
};
```

### D. Virtual Functions & V-Table (Under the Hood)
*   **V-Table (Virtual Table):** A static array created by the compiler for every class that has virtual functions. It contains function pointers to the virtual functions.
*   **VPTR (Virtual Pointer):** A hidden pointer added to the object instance (usually the first 4/8 bytes) that points to the class's V-Table.
*   **Cost:** Extra memory for VPTR per object + Extra lookup time (dereferencing VPTR -> V-Table -> Function).

### E. Virtual Destructor
**ALWAYS** make the base class destructor `virtual` if you plan to inherit from it.
**Reason:** If you `delete` a derived object via a base pointer, and the base destructor is NOT virtual, the derived destructor will NOT be called. Memory Leak!

### F. Static Members
*   **Static Variable:** Shared by ALL instances of the class. Stored in the data segment, not the object.
*   **Static Function:** Can be called without an object (`Class::func()`). Can ONLY access static variables.

```cpp
class Counter {
public:
    static int count; // Declaration
    Counter() { count++; }
};
int Counter::count = 0; // Definition
```

### G. Const Correctness
*   **Const Variable:** Cannot be changed.
*   **Const Method:** `void func() const { ... }`. Promises not to modify any member variables of the object. Can be called on `const` objects.

### H. Friend
Allows a function or another class to access `private` and `protected` members.
**Note:** Breaks encapsulation, use sparingly.
```cpp
class Box {
private:
    int width;
public:
    friend void printWidth(Box b); // Friend function
};

void printWidth(Box b) {
    cout << b.width << endl; // Allowed
}
```

### I. Diamond Problem (Multiple Inheritance)
When `D` inherits from `B` and `C`, and both `B` and `C` inherit from `A`. `D` gets two copies of `A`.
**Fix:** Virtual Inheritance (`class B : virtual public A`).

### J. Padding & Alignment
Compilers add padding bytes to ensure data is aligned in memory (e.g., integers at addresses divisible by 4).
*   `class Empty {};` -> Size is **1 byte** (to ensure unique address).
*   `class A { char c; int i; };` -> Size is likely **8 bytes** (1 byte char + 3 bytes padding + 4 bytes int).


# Part 2: SOLID Principles

SOLID is a mnemonic for five design principles intended to make software designs more understandable, flexible, and maintainable.

## 1. Single Responsibility Principle (SRP)
**Definition:** A class should have only one reason to change. It should have only one job or responsibility.
**Why:** If a class does too many things, changing one thing might break others. It leads to "God Objects".
**Analogy:** A Swiss Army Knife is cool, but for professional work, you use a dedicated screwdriver, a dedicated knife, etc.

**Violation (The "God" Class):**
```cpp
class User {
public:
    void login(string username, string password) { /* Auth Logic */ }
    void sendEmail(string message) { /* Email Logic */ } 
    void logError(string error) { /* Logging Logic */ }
};
// Problem: If Email logic changes, we modify User class. If Auth changes, we modify User class.
```

**Correct (Separation of Concerns):**
```cpp
class UserAuth {
public:
    void login(string u, string p) { /* ... */ }
};

class EmailService {
public:
    void sendEmail(string m) { /* ... */ }
};

class Logger {
public:
    void logError(string e) { /* ... */ }
};
// Benefit: Changes in EmailService don't affect UserAuth.
```

## 2. Open/Closed Principle (OCP)
**Definition:** Software entities (classes, modules, functions) should be **open for extension**, but **closed for modification**.
**Why:** You should be able to add new functionality without touching existing, tested code.
**Analogy:** Extensions on a browser. You add a new extension to get new features without rewriting the browser's source code.

**Violation (Modification required for new features):**
```cpp
class Rectangle { public: double width, height; };
class Circle { public: double radius; };

class AreaCalculator {
public:
    double calculate(void* shape, string type) {
        if (type == "Rectangle") { /* calc rect */ }
        else if (type == "Circle") { /* calc circle */ }
        // To add "Triangle", we MUST modify this class! Bad!
    }
};
```

**Correct (Extension via Polymorphism):**
```cpp
class Shape {
public:
    virtual double area() = 0; // Abstraction
};

class Rectangle : public Shape {
    double width, height;
public:
    double area() override { return width * height; }
};

class Circle : public Shape {
    double radius;
public:
    double area() override { return 3.14 * radius * radius; }
};

// New Shape? Just create a new class. No change to calculateArea!
double calculateArea(Shape* shape) {
    return shape->area();
}
```

## 3. Liskov Substitution Principle (LSP)
**Definition:** Objects of a superclass should be replaceable with objects of its subclasses without breaking the application.
**Why:** Ensures inheritance hierarchies make semantic sense.
**Analogy:** If it looks like a duck, quacks like a duck, but needs batteries – you have the wrong abstraction.

**Violation (Square is NOT a Rectangle in code):**
Mathematically, a Square is a Rectangle. But in code, if `Rectangle` has `setWidth` and `setHeight`, `Square` breaks the behavior because setting width *must* change height.

```cpp
class Rectangle {
public:
    virtual void setWidth(int w) { width = w; }
    virtual void setHeight(int h) { height = h; }
protected:
    int width, height;
};

class Square : public Rectangle {
public:
    // Violation: Changing width changes height unexpectedly for a "Rectangle" user
    void setWidth(int w) override { width = height = w; }
    void setHeight(int h) override { width = height = h; }
};

void process(Rectangle& r) {
    r.setWidth(5);
    r.setHeight(10);
    // Expect area = 50. But if r is Square, area is 100! Logic Broken.
}
```

**Correct:** Separate them or use a common `Shape` interface without mutable setters that imply independence.

## 4. Interface Segregation Principle (ISP)
**Definition:** Clients should not be forced to depend upon interfaces that they do not use.
**Why:** Prevents "Fat Interfaces". Implementing a huge interface forces you to write dummy methods.
**Analogy:** USB ports. You don't have one giant port for everything; you have specific ports (or protocols) so a mouse doesn't need to know how to be a monitor.

**Violation (Fat Interface):**
```cpp
class Worker {
public:
    virtual void work() = 0;
    virtual void eat() = 0;
};

class Robot : public Worker {
public:
    void work() override { /* working */ }
    void eat() override { /* Robots don't eat! Forced to implement dummy method */ }
};
```

**Correct (Segregated Interfaces):**
```cpp
class Workable {
public:
    virtual void work() = 0;
};

class Feedable {
public:
    virtual void eat() = 0;
};

class Robot : public Workable {
public:
    void work() override { /* working */ }
};

class Human : public Workable, public Feedable {
public:
    void work() override { /* working */ }
    void eat() override { /* eating */ }
};
```

## 5. Dependency Inversion Principle (DIP)
**Definition:** High-level modules should not depend on low-level modules. Both should depend on abstractions.
**Why:** Decouples code. You can swap out low-level details (like database, UI, hardware) without changing high-level business logic.
**Analogy:** You plug your laptop into a wall socket (Abstraction). You don't solder it directly to the electrical wiring (Concrete Implementation).

**Violation (Tight Coupling):**
```cpp
class LightBulb {
public:
    void turnOn() {}
    void turnOff() {}
};

class Switch {
    LightBulb bulb; // Direct dependency on concrete class
public:
    void operate() {
        bulb.turnOn();
    }
};
```

**Correct (Dependency on Abstraction):**
```cpp
// Abstraction
class Switchable { 
public:
    virtual void turnOn() = 0;
    virtual void turnOff() = 0;
};

// Low-level module
class LightBulb : public Switchable {
public:
    void turnOn() override { /*...*/ }
    void turnOff() override { /*...*/ }
};

// Low-level module
class Fan : public Switchable {
public:
    void turnOn() override { /*...*/ }
    void turnOff() override { /*...*/ }
};

// High-level module
class Switch {
    Switchable& device; // Depends on abstraction, not concrete class
public:
    Switch(Switchable& dev) : device(dev) {} // Dependency Injection
    void operate() {
        device.turnOn();
    }
};
```



# Part 3: Design Patterns (Gang of Four)

## A. Creational Patterns
**Intent:** Deal with object creation mechanisms, increasing flexibility and reuse of existing code.

### 1. Singleton
**Intent:** Ensure a class has only one instance and provide a global point of access to it.
**Analogy:** The Government. A country can have only one official government.
**Code (Meyers' Singleton - Thread Safe in C++11+):**
```cpp
class Singleton {
public:
    static Singleton& getInstance() {
        static Singleton instance; // Initialized once, thread-safe
        return instance;
    }
    // Delete copy/move to prevent duplicates
    Singleton(const Singleton&) = delete;
    void operator=(const Singleton&) = delete;
private:
    Singleton() {} // Private Constructor
};
```

### 2. Factory Method
**Intent:** Define an interface for creating an object, but let subclasses decide which class to instantiate.
**Analogy:** Logistics. A logistics company can deliver by Truck or Ship. The `planDelivery` method is the same, but the `createTransport` method returns a different vehicle.

```cpp
class Transport {
public:
    virtual void deliver() = 0;
    virtual ~Transport() {}
};

class Truck : public Transport {
public:
    void deliver() override { cout << "Deliver by Land" << endl; }
};

class Ship : public Transport {
public:
    void deliver() override { cout << "Deliver by Sea" << endl; }
};

class Logistics {
public:
    virtual Transport* createTransport() = 0; // Factory Method
    void planDelivery() {
        Transport* t = createTransport();
        t->deliver();
        delete t;
    }
    virtual ~Logistics() {}
};

class RoadLogistics : public Logistics {
public:
    Transport* createTransport() override { return new Truck(); }
};
```

### 3. Abstract Factory
**Intent:** Produce families of related objects without specifying their concrete classes.
**Analogy:** Furniture Shop. You can buy a "Modern" set (Chair + Sofa) or a "Victorian" set. You don't mix Modern Chair with Victorian Sofa.

```cpp
// Abstract Products
class Chair { public: virtual void sit() = 0; };
class Sofa { public: virtual void lie() = 0; };

// Concrete Products
class ModernChair : public Chair { public: void sit() override { cout << "Sitting on Modern Chair" << endl; } };
class ModernSofa : public Sofa { public: void lie() override { cout << "Lying on Modern Sofa" << endl; } };

// Abstract Factory
class FurnitureFactory {
public:
    virtual Chair* createChair() = 0;
    virtual Sofa* createSofa() = 0;
};

// Concrete Factory
class ModernFactory : public FurnitureFactory {
public:
    Chair* createChair() override { return new ModernChair(); }
    Sofa* createSofa() override { return new ModernSofa(); }
};
```

### 4. Builder
**Intent:** Construct a complex object step by step.
**Analogy:** Subway Sandwich. You choose bread, then meat, then veggies, then sauce. The process creates a complex "Sandwich" object.

```cpp
class Pizza {
public:
    string dough, sauce, topping;
    void show() { cout << dough << " + " << sauce << " + " << topping << endl; }
};

class PizzaBuilder {
protected:
    Pizza* pizza;
public:
    PizzaBuilder() { pizza = new Pizza(); }
    virtual void buildDough() = 0;
    virtual void buildSauce() = 0;
    virtual void buildTopping() = 0;
    Pizza* getPizza() { return pizza; }
};

class SpicyPizzaBuilder : public PizzaBuilder {
public:
    void buildDough() override { pizza->dough = "Pan Dough"; }
    void buildSauce() override { pizza->sauce = "Hot Sauce"; }
    void buildTopping() override { pizza->topping = "Pepperoni"; }
};

class Director {
public:
    void make(PizzaBuilder* pb) {
        pb->buildDough();
        pb->buildSauce();
        pb->buildTopping();
    }
};
```

### 5. Prototype
**Intent:** Create new objects by copying an existing object (cloning).
**Analogy:** Cell Division (Mitosis). A cell splits to create an identical copy of itself.

```cpp
class Prototype {
public:
    virtual Prototype* clone() = 0;
    virtual ~Prototype() {}
};

class Robot : public Prototype {
    int id;
public:
    Robot(int i) : id(i) {}
    Prototype* clone() override {
        return new Robot(*this); // Copy Constructor
    }
};
```

## B. Structural Patterns
**Intent:** Explain how to assemble objects and classes into larger structures while keeping these structures flexible and efficient.

### 1. Adapter
**Intent:** Allows objects with incompatible interfaces to collaborate.
**Analogy:** Power Adapter. It translates the interface of a US plug to a European socket.

```cpp
// Target Interface (What client expects)
class MediaPlayer {
public:
    virtual void play(string type, string file) = 0;
};

// Adaptee (Incompatible interface)
class AdvancedMediaPlayer {
public:
    void playVlc(string file) { cout << "Playing vlc: " << file << endl; }
};

// Adapter
class MediaAdapter : public MediaPlayer {
    AdvancedMediaPlayer* advancedMusicPlayer;
public:
    MediaAdapter() { advancedMusicPlayer = new AdvancedMediaPlayer(); }
    void play(string type, string file) override {
        if (type == "vlc") advancedMusicPlayer->playVlc(file);
    }
};
```

### 2. Bridge
**Intent:** Split a large class into two separate hierarchies (Abstraction and Implementation) so they can vary independently.
**Analogy:** Remote Control (Abstraction) and TV (Implementation). You can have different remotes working with different TVs.

```cpp
// Implementation
class Device {
public:
    virtual void turnOn() = 0;
    virtual void turnOff() = 0;
};

class TV : public Device {
public:
    void turnOn() override { cout << "TV On" << endl; }
    void turnOff() override { cout << "TV Off" << endl; }
};

// Abstraction
class Remote {
protected:
    Device* device;
public:
    Remote(Device* d) : device(d) {}
    virtual void togglePower() {
        device->turnOn();
        device->turnOff();
    }
};
```

### 3. Composite
**Intent:** Compose objects into tree structures to represent part-whole hierarchies. Treat individual objects and compositions uniformly.
**Analogy:** File System. A Folder can contain Files or other Folders. You can "delete" a File or a Folder (which deletes everything inside) using the same command.

```cpp
class FileSystemComponent {
public:
    virtual void showDetails() = 0;
};

class File : public FileSystemComponent {
    string name;
public:
    File(string n) : name(n) {}
    void showDetails() override { cout << "File: " << name << endl; }
};

class Folder : public FileSystemComponent {
    string name;
    vector<FileSystemComponent*> children;
public:
    Folder(string n) : name(n) {}
    void add(FileSystemComponent* c) { children.push_back(c); }
    void showDetails() override {
        cout << "Folder: " << name << endl;
        for (auto c : children) c->showDetails();
    }
};
```

### 4. Decorator
**Intent:** Attach new behaviors to objects dynamically by placing them inside wrapper objects.
**Analogy:** Clothing. You wear a shirt. If it's cold, you wear a jacket *over* the shirt. If it's raining, you wear a raincoat *over* the jacket.

```cpp
class Coffee {
public:
    virtual double cost() = 0;
    virtual string desc() = 0;
};

class SimpleCoffee : public Coffee {
public:
    double cost() override { return 5.0; }
    string desc() override { return "Coffee"; }
};

class MilkDecorator : public Coffee {
    Coffee* coffee;
public:
    MilkDecorator(Coffee* c) : coffee(c) {}
    double cost() override { return coffee->cost() + 2.0; }
    string desc() override { return coffee->desc() + ", Milk"; }
};
```

### 5. Facade
**Intent:** Provide a simplified interface to a library, a framework, or any other complex set of classes.
**Analogy:** Car Starter Button. You press one button to start the car. Behind the scenes, it triggers the battery, starter motor, fuel injection, etc.

```cpp
class CPU { public: void freeze() { cout << "CPU Freeze" << endl; } };
class Memory { public: void load() { cout << "Memory Load" << endl; } };
class HardDrive { public: void read() { cout << "HD Read" << endl; } };

class ComputerFacade {
    CPU cpu; Memory ram; HardDrive hd;
public:
    void start() {
        cpu.freeze();
        ram.load();
        hd.read();
        cout << "Computer Started" << endl;
    }
};
```

### 6. Flyweight
**Intent:** Fit more objects into RAM by sharing common parts of state between multiple objects.
**Analogy:** Counter-Strike Game. You have 1000 terrorists. They all look the same (same 3D model, texture). You store the model *once* and just change the position (x, y, z) for each terrorist.

```cpp
// Intrinsic State (Shared)
class TreeType {
    string name, color, texture;
public:
    TreeType(string n, string c, string t) : name(n), color(c), texture(t) {}
    void draw(int x, int y) { cout << "Drawing " << name << " at " << x << "," << y << endl; }
};

// Extrinsic State (Unique)
class Tree {
    int x, y;
    TreeType* type;
public:
    Tree(int x, int y, TreeType* t) : x(x), y(y), type(t) {}
    void draw() { type->draw(x, y); }
};
```

### 7. Proxy
**Intent:** Provide a placeholder for another object to control access to it.
**Analogy:** Credit Card. It's a proxy for the cash in your bank account.

```cpp
class Internet {
public:
    virtual void connectTo(string site) = 0;
};

class RealInternet : public Internet {
public:
    void connectTo(string site) override { cout << "Connecting to " << site << endl; }
};

class ProxyInternet : public Internet {
    RealInternet* realInternet;
    // Banned sites list...
public:
    ProxyInternet() { realInternet = new RealInternet(); }
    void connectTo(string site) override {
        if (site == "banned.com") cout << "Access Denied" << endl;
        else realInternet->connectTo(site);
    }
};
```



## C. Behavioral Patterns
**Intent:** Deal with algorithms and the assignment of responsibilities between objects.

### 1. Chain of Responsibility
**Intent:** Pass requests along a chain of handlers. Upon receiving a request, each handler decides either to process the request or to pass it to the next handler in the chain.
**Analogy:** Tech Support. You call support (L1). If they can't fix it, they pass you to a Specialist (L2). If they can't fix it, they pass you to an Engineer (L3).

```cpp
class Handler {
protected:
    Handler* next;
public:
    Handler() : next(nullptr) {}
    void setNext(Handler* h) { next = h; }
    virtual void handle(int level) {
        if (next) next->handle(level);
    }
};

class Level1Support : public Handler {
public:
    void handle(int level) override {
        if (level == 1) cout << "Level 1 fixed it." << endl;
        else Handler::handle(level);
    }
};

class Level2Support : public Handler {
public:
    void handle(int level) override {
        if (level == 2) cout << "Level 2 fixed it." << endl;
        else Handler::handle(level);
    }
};
```

### 2. Command
**Intent:** Encapsulate a request as an object, thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations.
**Analogy:** Restaurant Order. You give an order (Command) to the waiter (Invoker). The waiter hands it to the chef (Receiver). You don't know who the chef is, you just want the meal.

```cpp
// Command Interface
class Command {
public:
    virtual void execute() = 0;
};

// Receiver
class Light {
public:
    void on() { cout << "Light On" << endl; }
    void off() { cout << "Light Off" << endl; }
};

// Concrete Command
class LightOnCommand : public Command {
    Light* light;
public:
    LightOnCommand(Light* l) : light(l) {}
    void execute() override { light->on(); }
};

// Invoker
class RemoteControl {
    Command* command;
public:
    void setCommand(Command* c) { command = c; }
    void pressButton() { command->execute(); }
};
```

### 3. Interpreter
**Intent:** Given a language, define a representation for its grammar along with an interpreter that uses the representation to interpret sentences in the language.
**Analogy:** Musicians. They read sheet music (Language) and interpret the notes to play music.

```cpp
class Expression {
public:
    virtual bool interpret(string context) = 0;
};

class TerminalExpression : public Expression {
    string data;
public:
    TerminalExpression(string data) : data(data) {}
    bool interpret(string context) override {
        return context.find(data) != string::npos;
    }
};

class OrExpression : public Expression {
    Expression *expr1, *expr2;
public:
    OrExpression(Expression* e1, Expression* e2) : expr1(e1), expr2(e2) {}
    bool interpret(string context) override {
        return expr1->interpret(context) || expr2->interpret(context);
    }
};
```

### 4. Iterator
**Intent:** Provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation.
**Analogy:** TV Remote. You press "Next Channel" to iterate through channels. You don't need to know how the TV stores the channel frequencies.

```cpp
class Iterator {
public:
    virtual bool hasNext() = 0;
    virtual int next() = 0;
};

class Container {
public:
    virtual Iterator* createIterator() = 0;
};
```

### 5. Mediator
**Intent:** Define an object that encapsulates how a set of objects interact. Promotes loose coupling by keeping objects from referring to each other explicitly.
**Analogy:** Air Traffic Control (ATC). Planes don't talk to each other directly ("I'm landing, you move"). They talk to ATC, and ATC tells them what to do.

```cpp
class Mediator;

class Colleague {
protected:
    Mediator* mediator;
public:
    Colleague(Mediator* m) : mediator(m) {}
    virtual void send(string message) = 0;
    virtual void receive(string message) = 0;
};

class ConcreteMediator : public Mediator {
    // Manages colleagues and communication logic
};
```

### 6. Memento
**Intent:** Capture and externalize an object's internal state so that the object can be restored to this state later.
**Analogy:** Save Game. You save your game state before a boss fight. If you die, you reload (restore) that state.

```cpp
class Memento {
    string state;
public:
    Memento(string s) : state(s) {}
    string getState() { return state; }
};

class Originator {
    string state;
public:
    void setState(string s) { state = s; }
    Memento* save() { return new Memento(state); }
    void restore(Memento* m) { state = m->getState(); }
};
```

### 7. Observer
**Intent:** Define a subscription mechanism to notify multiple objects about any events that happen to the object they're observing.
**Analogy:** YouTube Subscription. You subscribe to a channel. When they upload a video (Event), you get a notification.

```cpp
class Observer {
public:
    virtual void update(int state) = 0;
};

class Subject {
    vector<Observer*> observers;
    int state;
public:
    void attach(Observer* o) { observers.push_back(o); }
    void setState(int s) {
        state = s;
        notify();
    }
    void notify() {
        for (auto o : observers) o->update(state);
    }
};

class ConcreteObserver : public Observer {
public:
    void update(int state) override { cout << "Observer received state: " << state << endl; }
};
```

### 8. State
**Intent:** Let an object alter its behavior when its internal state changes. It appears as if the object changed its class.
**Analogy:** Mobile Phone. If state is "Ringing", pressing volume button silences it. If state is "Unlocked", pressing volume button changes volume.

```cpp
class State {
public:
    virtual void handle() = 0;
};

class Context {
    State* state;
public:
    void setState(State* s) { state = s; }
    void request() { state->handle(); }
};

class ConcreteStateA : public State {
public:
    void handle() override { cout << "Handling in State A" << endl; }
};
```

### 9. Strategy
**Intent:** Define a family of algorithms, encapsulate each one, and make them interchangeable. Strategy lets the algorithm vary independently from clients that use it.
**Analogy:** Navigation App. You can choose "Walk", "Car", or "Public Transport". The goal (A to B) is the same, but the strategy (Algorithm) is different.

```cpp
class Strategy {
public:
    virtual int execute(int a, int b) = 0;
};

class AddStrategy : public Strategy {
public:
    int execute(int a, int b) override { return a + b; }
};

class MultiplyStrategy : public Strategy {
public:
    int execute(int a, int b) override { return a * b; }
};

class Context {
    Strategy* strategy;
public:
    Context(Strategy* s) : strategy(s) {}
    int executeStrategy(int a, int b) { return strategy->execute(a, b); }
};
```

### 10. Template Method
**Intent:** Define the skeleton of an algorithm in the superclass but let subclasses override specific steps of the algorithm without changing its structure.
**Analogy:** Building a House. The steps are fixed: Foundation -> Walls -> Roof. But a "Wooden House" builds wooden walls, while a "Brick House" builds brick walls.

```cpp
class Game {
public:
    // Template Method (Final)
    void play() {
        initialize();
        startPlay();
        endPlay();
    }
protected:
    virtual void initialize() = 0;
    virtual void startPlay() = 0;
    virtual void endPlay() = 0;
};

class Cricket : public Game {
protected:
    void initialize() override { cout << "Cricket Init" << endl; }
    void startPlay() override { cout << "Cricket Start" << endl; }
    void endPlay() override { cout << "Cricket End" << endl; }
};
```

### 11. Visitor
**Intent:** Separate algorithms from the objects on which they operate.
**Analogy:** Taxi Driver. The driver (Visitor) goes to a Hotel (Element) and drops a passenger. Then goes to a Hospital (Element) and picks up a passenger. The places don't change, but the driver performs different actions on them.

```cpp
class Element;
class Visitor {
public:
    virtual void visit(Element* e) = 0;
};

class Element {
public:
    virtual void accept(Visitor* v) = 0;
};

class ConcreteElement : public Element {
public:
    void accept(Visitor* v) override { v->visit(this); }
    string operation() { return "Element"; }
};

class ConcreteVisitor : public Visitor {
public:
    void visit(Element* e) override {
        cout << "Visited " << ((ConcreteElement*)e)->operation() << endl;
    }
};
```

Deal with algorithms and the assignment of responsibilities between objects.

### 1. Chain of Responsibility
Passes requests along a chain of handlers.

```cpp
class Handler {
protected:
    Handler* next;
public:
    void setNext(Handler* h) { next = h; }
    virtual void handle(int request) {
        if (next) next->handle(request);
    }
};

class ConcreteHandler1 : public Handler {
public:
    void handle(int request) override {
        if (request < 10) cout << "Handled by 1" << endl;
        else Handler::handle(request);
    }
};
```

### 2. Command
Encapsulates a request as an object, thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations.

```cpp
class Command {
public:
    virtual void execute() = 0;
};

class Light {
public:
    void on() { cout << "Light On" << endl; }
};

class LightOnCommand : public Command {
    Light* light;
public:
    LightOnCommand(Light* l) : light(l) {}
    void execute() override { light->on(); }
};

class RemoteControl {
    Command* command;
public:
    void setCommand(Command* c) { command = c; }
    void pressButton() { command->execute(); }
};
```

### 3. Interpreter
Given a language, defines a representation for its grammar along with an interpreter that uses the representation to interpret sentences in the language.

```cpp
class Expression {
public:
    virtual bool interpret(string context) = 0;
};

class TerminalExpression : public Expression {
    string data;
public:
    TerminalExpression(string data) : data(data) {}
    bool interpret(string context) override {
        return context.find(data) != string::npos;
    }
};

class OrExpression : public Expression {
    Expression *expr1, *expr2;
public:
    OrExpression(Expression* e1, Expression* e2) : expr1(e1), expr2(e2) {}
    bool interpret(string context) override {
        return expr1->interpret(context) || expr2->interpret(context);
    }
};
```

### 4. Iterator
Provides a way to access the elements of an aggregate object sequentially without exposing its underlying representation.

```cpp
class Iterator {
public:
    virtual bool hasNext() = 0;
    virtual int next() = 0;
};

class Container {
public:
    virtual Iterator* createIterator() = 0;
};
```

### 5. Mediator
Defines an object that encapsulates how a set of objects interact.

```cpp
class Mediator;
class Colleague {
protected:
    Mediator* mediator;
public:
    Colleague(Mediator* m) : mediator(m) {}
    virtual void send(string message) = 0;
    virtual void receive(string message) = 0;
};

class ConcreteMediator : public Mediator {
    // Manages colleagues and communication
};
```

### 6. Memento
Captures and externalizes an object's internal state so that the object can be restored to this state later.

```cpp
class Memento {
    string state;
public:
    Memento(string s) : state(s) {}
    string getState() { return state; }
};

class Originator {
    string state;
public:
    void setState(string s) { state = s; }
    Memento* save() { return new Memento(state); }
    void restore(Memento* m) { state = m->getState(); }
};
```

### 7. Observer
Defines a subscription mechanism to notify multiple objects about any events that happen to the object they're observing.

```cpp
class Observer {
public:
    virtual void update(int state) = 0;
};

class Subject {
    vector<Observer*> observers;
    int state;
public:
    void attach(Observer* o) { observers.push_back(o); }
    void setState(int s) {
        state = s;
        notify();
    }
    void notify() {
        for (auto o : observers) o->update(state);
    }
};

class ConcreteObserver : public Observer {
public:
    void update(int state) override { cout << "State updated: " << state << endl; }
};
```

### 8. State
Lets an object alter its behavior when its internal state changes.

```cpp
class State {
public:
    virtual void handle() = 0;
};

class Context {
    State* state;
public:
    void setState(State* s) { state = s; }
    void request() { state->handle(); }
};

class ConcreteStateA : public State {
public:
    void handle() override { cout << "State A" << endl; }
};
```

### 9. Strategy
Defines a family of algorithms, encapsulates each one, and makes them interchangeable.

```cpp
class Strategy {
public:
    virtual int execute(int a, int b) = 0;
};

class AddStrategy : public Strategy {
public:
    int execute(int a, int b) override { return a + b; }
};

class Context {
    Strategy* strategy;
public:
    Context(Strategy* s) : strategy(s) {}
    int executeStrategy(int a, int b) { return strategy->execute(a, b); }
};
```

### 10. Template Method
Defines the skeleton of an algorithm in the superclass but lets subclasses override specific steps of the algorithm without changing its structure.

```cpp
class Game {
public:
    void play() {
        initialize();
        startPlay();
        endPlay();
    }
protected:
    virtual void initialize() = 0;
    virtual void startPlay() = 0;
    virtual void endPlay() = 0;
};

class Cricket : public Game {
protected:
    void initialize() override { cout << "Cricket Init" << endl; }
    void startPlay() override { cout << "Cricket Start" << endl; }
    void endPlay() override { cout << "Cricket End" << endl; }
};
```

### 11. Visitor
Separates algorithms from the objects on which they operate.

```cpp
class Element;
class Visitor {
public:
    virtual void visit(Element* e) = 0;
};

class Element {
public:
    virtual void accept(Visitor* v) = 0;
};

class ConcreteElement : public Element {
public:
    void accept(Visitor* v) override { v->visit(this); }
    string operation() { return "Element"; }
};

class ConcreteVisitor : public Visitor {
public:
    void visit(Element* e) override {
        cout << "Visited " << ((ConcreteElement*)e)->operation() << endl;
    }
};
```


# Part 4: Standard Machine Coding / LLD Questions

This section provides detailed, step-by-step solutions for common machine coding rounds.
**Approach for every problem:**
1.  **Clarify Requirements:** Ask questions (What features? Scale?).
2.  **Define Entities:** Identify core classes.
3.  **Design Interfaces:** Define methods and relationships.
4.  **Implement:** Write clean, modular C++ code.

---

## 1. Design a Parking Lot System
**Requirements:**
*   Multiple floors, multiple entry/exit points.
*   Different spot types (Compact, Large, Handicapped, Motorcycle).
*   Ticketing system: Issue ticket at entry, calculate fee at exit.
*   Payment: Cash, Credit Card.

**Core Entities:**
*   `ParkingLot`: Singleton, manages floors.
*   `ParkingFloor`: Manages spots.
*   `ParkingSpot`: Base class for spots.
*   `Vehicle`: Base class for vehicles.
*   `Ticket`: Tracks entry time and spot.
*   `Gate`: Entry and Exit gates.

**Code:**
```cpp
#include <iostream>
#include <vector>
#include <string>
#include <ctime>
#include <map>

using namespace std;

// Enums
enum VehicleType { MOTORCYCLE, CAR, TRUCK };
enum SpotType { MOTORCYCLE_SPOT, COMPACT_SPOT, LARGE_SPOT };

// --- Vehicle Hierarchy ---
class Vehicle {
    string licensePlate;
    VehicleType type;
public:
    Vehicle(string plate, VehicleType t) : licensePlate(plate), type(t) {}
    VehicleType getType() { return type; }
    string getLicensePlate() { return licensePlate; }
};

class Car : public Vehicle { public: Car(string plate) : Vehicle(plate, CAR) {} };
class Motorcycle : public Vehicle { public: Motorcycle(string plate) : Vehicle(plate, MOTORCYCLE) {} };

// --- Parking Spot Hierarchy ---
class ParkingSpot {
    int id;
    bool free;
    SpotType type;
    Vehicle* vehicle;
public:
    ParkingSpot(int id, SpotType t) : id(id), free(true), type(t), vehicle(nullptr) {}
    
    bool isFree() { return free; }
    SpotType getType() { return type; }
    
    virtual bool canFit(Vehicle* v) {
        if (type == LARGE_SPOT) return true; // Large fits all
        if (type == COMPACT_SPOT) return v->getType() == CAR || v->getType() == MOTORCYCLE;
        if (type == MOTORCYCLE_SPOT) return v->getType() == MOTORCYCLE;
        return false;
    }

    void park(Vehicle* v) {
        vehicle = v;
        free = false;
    }

    void removeVehicle() {
        vehicle = nullptr;
        free = true;
    }
    
    int getId() { return id; }
};

// --- Ticket ---
class Ticket {
    long entryTime;
    string vehiclePlate;
    int spotId;
public:
    Ticket(string plate, int spot) : vehiclePlate(plate), spotId(spot) {
        entryTime = time(0);
    }
    long getEntryTime() { return entryTime; }
    int getSpotId() { return spotId; }
};

// --- Parking Floor ---
class ParkingFloor {
    int floorId;
    vector<ParkingSpot*> spots;
public:
    ParkingFloor(int id) : floorId(id) {}
    
    void addSpot(ParkingSpot* spot) { spots.push_back(spot); }
    
    ParkingSpot* findSpot(Vehicle* v) {
        for (auto spot : spots) {
            if (spot->isFree() && spot->canFit(v)) {
                return spot;
            }
        }
        return nullptr;
    }
};

// --- Parking Lot (Singleton) ---
class ParkingLot {
    static ParkingLot* instance;
    vector<ParkingFloor*> floors;
    ParkingLot() {}
public:
    static ParkingLot* getInstance() {
        if (instance == nullptr) instance = new ParkingLot();
        return instance;
    }
    
    void addFloor(ParkingFloor* floor) { floors.push_back(floor); }
    
    Ticket* parkVehicle(Vehicle* v) {
        for (auto floor : floors) {
            ParkingSpot* spot = floor->findSpot(v);
            if (spot) {
                spot->park(v);
                return new Ticket(v->getLicensePlate(), spot->getId());
            }
        }
        cout << "Parking Full!" << endl;
        return nullptr;
    }
    
    double calculateFee(Ticket* ticket) {
        long duration = time(0) - ticket->getEntryTime();
        // Simple logic: $1 per second for demo
        return duration * 1.0; 
    }
};
ParkingLot* ParkingLot::instance = nullptr;
```

---

## 2. Design Snake and Ladder Game
**Requirements:**
*   Board size N*N.
*   Multiple players.
*   Dice roll (1-6).
*   Snakes (Start > End) and Ladders (Start < End).
*   Game ends when a player reaches 100.

**Core Entities:**
*   `Board`: Contains cells, snakes, ladders.
*   `Player`: Name, current position.
*   `Dice`: Random number generator.
*   `Game`: Controls flow.

**Code:**
```cpp
#include <iostream>
#include <map>
#include <queue>
#include <cstdlib>

using namespace std;

class Dice {
public:
    static int roll() { return (rand() % 6) + 1; }
};

class Board {
    int size;
    map<int, int> snakes;
    map<int, int> ladders;
public:
    Board(int s) : size(s) {}
    
    void addSnake(int start, int end) { 
        if (start > end) snakes[start] = end; 
    }
    
    void addLadder(int start, int end) { 
        if (end > start) ladders[start] = end; 
    }
    
    int getNewPosition(int pos) {
        if (pos > size) return pos; // Can't move beyond end
        
        // Check for snake or ladder (recursively or iteratively)
        // Simple version: just one jump
        if (snakes.count(pos)) {
            cout << "Bit by Snake! Down to " << snakes[pos] << endl;
            return snakes[pos];
        }
        if (ladders.count(pos)) {
            cout << "Climbed Ladder! Up to " << ladders[pos] << endl;
            return ladders[pos];
        }
        return pos;
    }
    
    int getSize() { return size; }
};

class Player {
    string name;
    int position;
public:
    Player(string n) : name(n), position(0) {}
    string getName() { return name; }
    int getPosition() { return position; }
    void setPosition(int p) { position = p; }
};

class SnakeLadderGame {
    Board* board;
    queue<Player*> players;
    bool isGameOver;
public:
    SnakeLadderGame(Board* b) : board(b), isGameOver(false) {}
    
    void addPlayer(Player* p) { players.push(p); }
    
    void play() {
        while (!isGameOver) {
            Player* currentPlayer = players.front();
            players.pop();
            
            int roll = Dice::roll();
            int oldPos = currentPlayer->getPosition();
            int newPos = oldPos + roll;
            
            if (newPos > board->getSize()) {
                newPos = oldPos; // Stay put if roll exceeds board
            } else {
                newPos = board->getNewPosition(newPos);
            }
            
            currentPlayer->setPosition(newPos);
            
            cout << currentPlayer->getName() << " rolled " << roll 
                 << " | " << oldPos << " -> " << newPos << endl;
            
            if (newPos == board->getSize()) {
                cout << "WINNER: " << currentPlayer->getName() << endl;
                isGameOver = true;
            } else {
                players.push(currentPlayer); // Add back to queue
            }
        }
    }
};
```

---

## 3. Design a Rate Limiter
**Requirements:**
*   Limit requests based on User ID / IP.
*   Strategy: Token Bucket (most common).
*   Thread-safe.

**Core Entities:**
*   `TokenBucket`: Logic for refilling and consuming.
*   `RateLimiter`: Manages buckets for different users.

**Code:**
```cpp
#include <iostream>
#include <unordered_map>
#include <chrono>
#include <mutex>

using namespace std;

class TokenBucket {
    long maxCapacity;
    long currentTokens;
    long refillRate; // Tokens per second
    long lastRefillTime;
    mutex mtx;

public:
    TokenBucket(long capacity, long rate) 
        : maxCapacity(capacity), currentTokens(capacity), refillRate(rate) {
        lastRefillTime = std::chrono::system_clock::now().time_since_epoch().count();
    }

    bool allowRequest(int tokens) {
        lock_guard<mutex> lock(mtx);
        refill();
        if (currentTokens >= tokens) {
            currentTokens -= tokens;
            return true;
        }
        return false;
    }

private:
    void refill() {
        long now = std::chrono::system_clock::now().time_since_epoch().count();
        long durationSeconds = (now - lastRefillTime) / 1000000000; // Nanoseconds to seconds
        
        if (durationSeconds > 0) {
            long tokensToAdd = durationSeconds * refillRate;
            currentTokens = min(maxCapacity, currentTokens + tokensToAdd);
            lastRefillTime = now;
        }
    }
};

class RateLimiter {
    unordered_map<string, TokenBucket*> userBuckets;
public:
    bool allow(string userId) {
        if (userBuckets.find(userId) == userBuckets.end()) {
            // Default: 10 tokens capacity, 1 token/sec refill
            userBuckets[userId] = new TokenBucket(10, 1); 
        }
        return userBuckets[userId]->allowRequest(1);
    }
};
```

---

## 4. Design Splitwise (Expense Sharing App)
**Requirements:**
*   Users can add expenses.
*   Split types: Equal, Exact, Percent.
*   Show balance sheet (Who owes whom).
*   Simplify debt (Optional advanced feature).

**Core Entities:**
*   `User`: Id, Name.
*   `Expense`: Amount, PaidBy, Splits.
*   `Split`: User, Amount.
*   `ExpenseManager`: Central controller.

**Code:**
```cpp
#include <iostream>
#include <vector>
#include <map>
#include <string>

using namespace std;

enum SplitType { EQUAL, EXACT, PERCENT };

class User {
    string id;
    string name;
public:
    User(string id, string name) : id(id), name(name) {}
    string getId() { return id; }
};

class Split {
    User* user;
    double amount;
public:
    Split(User* u) : user(u) {}
    User* getUser() { return user; }
    double getAmount() { return amount; }
    void setAmount(double a) { amount = a; }
};

class Expense {
    string id;
    double amount;
    User* paidBy;
    vector<Split*> splits;
    SplitType type;
public:
    Expense(string id, double amount, User* paidBy, vector<Split*> splits, SplitType type)
        : id(id), amount(amount), paidBy(paidBy), splits(splits), type(type) {}
    
    User* getPaidBy() { return paidBy; }
    vector<Split*> getSplits() { return splits; }
};

class ExpenseManager {
    vector<Expense*> expenses;
    map<string, User*> userMap;
    map<string, map<string, double>> balanceSheet; // User -> (OwesTo -> Amount)

public:
    void addUser(User* user) {
        userMap[user->getId()] = user;
        balanceSheet[user->getId()] = map<string, double>();
    }

    void addExpense(string id, double amount, string paidByUserId, vector<Split*> splits, SplitType type) {
        User* paidBy = userMap[paidByUserId];
        Expense* expense = new Expense(id, amount, paidBy, splits, type);
        expenses.push_back(expense);

        for (auto split : splits) {
            string paidTo = split->getUser()->getId();
            
            // Logic: paidBy lends to paidTo
            // balanceSheet[paidBy][paidTo] += amount;
            // balanceSheet[paidTo][paidBy] -= amount;
            
            if (paidTo != paidByUserId) {
                balanceSheet[paidByUserId][paidTo] += split->getAmount();
                balanceSheet[paidTo][paidByUserId] -= split->getAmount();
            }
        }
    }

    void showBalance(string userId) {
        bool isEmpty = true;
        for (auto& entry : balanceSheet[userId]) {
            if (entry.second != 0) {
                isEmpty = false;
                if (entry.second > 0) 
                    cout << userId << " owes " << entry.first << ": " << abs(entry.second) << endl;
                else 
                    cout << entry.first << " owes " << userId << ": " << abs(entry.second) << endl;
            }
        }
        if (isEmpty) cout << "No balances for " << userId << endl;
    }
};
```

---

## 5. Design BookMyShow (Movie Ticket Booking)
**Requirements:**
*   List Cities > Cinemas > Movies > Shows.
*   Select Seats.
*   **Concurrency:** Handle multiple users trying to book the same seat.

**Core Entities:**
*   `Cinema`, `Screen`, `Seat`.
*   `Show`: Movie at a specific time.
*   `Booking`: User, Show, Seats.
*   `SeatLock`: Mechanism to temporarily hold seats.

**Code:**
```cpp
#include <iostream>
#include <vector>
#include <map>
#include <mutex>

using namespace std;

enum SeatStatus { AVAILABLE, LOCKED, BOOKED };

class Seat {
    int id;
    SeatStatus status;
public:
    Seat(int id) : id(id), status(AVAILABLE) {}
    bool isAvailable() { return status == AVAILABLE; }
    void setStatus(SeatStatus s) { status = s; }
    int getId() { return id; }
};

class Show {
    int id;
    vector<Seat*> seats;
public:
    Show(int id, int seatCount) : id(id) {
        for (int i = 0; i < seatCount; ++i) seats.push_back(new Seat(i));
    }
    
    Seat* getSeat(int seatId) {
        if (seatId < seats.size()) return seats[seatId];
        return nullptr;
    }
};

class BookingSystem {
    map<int, Show*> shows; // ShowID -> Show
    mutex mtx; // Global lock for simplicity (In real life, distributed lock)

public:
    void addShow(Show* show) { shows[1] = show; } // Demo ID 1

    bool bookTicket(User* user, int showId, vector<int> seatIds) {
        lock_guard<mutex> lock(mtx); // Critical Section Start
        
        Show* show = shows[showId];
        // 1. Check availability
        for (int id : seatIds) {
            Seat* seat = show->getSeat(id);
            if (!seat || !seat->isAvailable()) {
                cout << "Seat " << id << " not available!" << endl;
                return false;
            }
        }
        
        // 2. Lock/Book seats
        for (int id : seatIds) {
            show->getSeat(id)->setStatus(BOOKED);
        }
        
        cout << "Booking Successful for " << user->getId() << endl;
        return true; 
        // Critical Section End
    }
};
```

---

## 6. Design Stack Overflow
**Requirements:**
*   Users can Post Questions.
*   Users can Answer Questions.
*   Users can Comment on both.
*   Voting (Up/Down) on Questions and Answers.
*   Search (by tag/keyword).

**Core Entities:**
*   `Question`, `Answer`, `Comment` (All implement `Post` interface?).
*   `User`, `Tag`.
*   `Vote`.

**Code:**
```cpp
#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class User {
    string name;
    int reputation;
public:
    User(string n) : name(n), reputation(0) {}
    void updateReputation(int score) { reputation += score; }
};

class Comment {
    string text;
    User* author;
public:
    Comment(string t, User* u) : text(t), author(u) {}
};

class Votable {
public:
    virtual void upvote() = 0;
    virtual void downvote() = 0;
    virtual int getVoteCount() = 0;
};

class Answer : public Votable {
    string text;
    User* author;
    int votes;
    vector<Comment*> comments;
public:
    Answer(string t, User* u) : text(t), author(u), votes(0) {}
    void upvote() override { votes++; author->updateReputation(10); }
    void downvote() override { votes--; author->updateReputation(-1); }
    int getVoteCount() override { return votes; }
    void addComment(Comment* c) { comments.push_back(c); }
};

class Question : public Votable {
    string title;
    string body;
    User* author;
    vector<Answer*> answers;
    vector<Comment*> comments;
    vector<string> tags;
    int votes;
public:
    Question(string t, string b, User* u) : title(t), body(b), author(u), votes(0) {}
    
    void addAnswer(Answer* a) { answers.push_back(a); }
    void addTag(string tag) { tags.push_back(tag); }
    
    void upvote() override { votes++; author->updateReputation(5); }
    void downvote() override { votes--; author->updateReputation(-1); }
    int getVoteCount() override { return votes; }
    
    bool hasTag(string tag) {
        return find(tags.begin(), tags.end(), tag) != tags.end();
    }
    
    string getTitle() { return title; }
};

class StackOverflow {
    vector<Question*> questions;
public:
    void postQuestion(Question* q) { questions.push_back(q); }
    
    vector<Question*> searchByTag(string tag) {
        vector<Question*> result;
        for (auto q : questions) {
            if (q->hasTag(tag)) result.push_back(q);
        }
        return result;
    }
};
```

---

## 7. Design ATM System
**Requirements:**
*   Authenticate User (Card + PIN).
*   Balance Inquiry, Withdraw Cash, Deposit.
*   Hardware interaction (Card Reader, Cash Dispenser).

**Core Entities:**
*   `ATM`: Facade for hardware.
*   `BankService`: Connects to bank.
*   `ATMState`: State pattern (Idle, HasCard, Authenticated).

**Code:**
```cpp
#include <iostream>
#include <string>

using namespace std;

// Mock Bank Service
class BankService {
public:
    bool authenticate(string card, int pin) { return true; } // Mock
    double getBalance(string card) { return 1000.0; }
    bool withdraw(string card, double amount) { return true; }
};

// State Interface
class ATMState {
public:
    virtual void insertCard() = 0;
    virtual void enterPin(int pin) = 0;
    virtual void withdraw(double amount) = 0;
    virtual void ejectCard() = 0;
};

class ATM {
    ATMState* currentState;
    BankService bankService;
    string currentCard;
public:
    ATM(); // Defined below
    void setState(ATMState* state) { currentState = state; }
    BankService& getBankService() { return bankService; }
    void setCard(string card) { currentCard = card; }
    string getCard() { return currentCard; }
    
    // Actions delegated to state
    void insertCard();
    void enterPin(int pin);
    void withdraw(double amount);
    void ejectCard();
};

class IdleState : public ATMState {
    ATM* atm;
public:
    IdleState(ATM* a) : atm(a) {}
    void insertCard() override {
        cout << "Card Inserted" << endl;
        // Transition to HasCardState (omitted for brevity)
    }
    void enterPin(int pin) override { cout << "Insert Card First" << endl; }
    void withdraw(double amount) override { cout << "Insert Card First" << endl; }
    void ejectCard() override { cout << "No Card" << endl; }
};

// ... Other states (HasCardState, AuthenticatedState) would follow similar pattern.
```

---

## 8. Design Vending Machine
**Requirements:**
*   Select Item.
*   Insert Money (Coins/Notes).
*   Dispense Item + Change.
*   State Pattern (Idle, Selection, MoneyInserted, Dispensing).

**Core Entities:**
*   `VendingMachine`: Context.
*   `State`: Abstract State.
*   `Inventory`: Manages products.

**Code:**
```cpp
#include <iostream>
#include <map>

using namespace std;

class VendingMachine;

class State {
protected:
    VendingMachine* machine;
public:
    State(VendingMachine* m) : machine(m) {}
    virtual void selectProduct(string code) = 0;
    virtual void insertMoney(double amount) = 0;
    virtual void dispense() = 0;
};

class VendingMachine {
    State* idleState;
    State* readyState;
    State* currentState;
    double currentBalance;
public:
    VendingMachine() {
        // Initialize states...
        currentBalance = 0;
    }
    void setState(State* s) { currentState = s; }
    void addBalance(double amount) { currentBalance += amount; }
    
    void selectProduct(string code) { currentState->selectProduct(code); }
    void insertMoney(double amount) { currentState->insertMoney(amount); }
};

class IdleState : public State {
public:
    IdleState(VendingMachine* m) : State(m) {}
    void selectProduct(string code) override {
        cout << "Product " << code << " selected." << endl;
        // Transition to ReadyState
    }
    void insertMoney(double amount) override { cout << "Select product first" << endl; }
    void dispense() override { cout << "Select product first" << endl; }
};
```

---

## 9. Design Elevator System
**Requirements:**
*   N Elevators, M Floors.
*   Optimized scheduling (Minimize wait time).
*   Handle internal (inside elevator) and external (hallway) requests.

**Core Entities:**
*   `Elevator`: Position, Direction, State (Moving, Idle).
*   `Dispatcher`: Algorithm to assign elevator.
*   `Request`: Floor, Direction.

**Code:**
```cpp
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

enum Direction { UP, DOWN, IDLE };

class Request {
    int floor;
    Direction direction;
public:
    Request(int f, Direction d) : floor(f), direction(d) {}
    int getFloor() { return floor; }
};

class Elevator {
    int id;
    int currentFloor;
    Direction direction;
    vector<int> stops; // Sorted list of stops
public:
    Elevator(int id) : id(id), currentFloor(0), direction(IDLE) {}
    
    void addStop(int floor) {
        stops.push_back(floor);
        sort(stops.begin(), stops.end()); // Simple logic: sort stops
        if (direction == IDLE) {
            direction = (floor > currentFloor) ? UP : DOWN;
        }
    }
    
    void move() {
        if (stops.empty()) {
            direction = IDLE;
            return;
        }
        
        int nextStop = stops[0]; // Simplification
        cout << "Elevator " << id << " moving from " << currentFloor << " to " << nextStop << endl;
        currentFloor = nextStop;
        stops.erase(stops.begin());
    }
};

class ElevatorSystem {
    vector<Elevator*> elevators;
public:
    ElevatorSystem(int n) {
        for (int i = 0; i < n; ++i) elevators.push_back(new Elevator(i));
    }
    
    void requestElevator(int floor, Direction d) {
        // Simple Dispatch: Round Robin or Nearest
        // For demo, assign to first elevator
        elevators[0]->addStop(floor);
    }
};
```

---

## 10. Design Tic-Tac-Toe (Scalable)
**Requirements:**
*   N*N Board.
*   2 Players.
*   Check Win in O(1) or O(N).

**Core Entities:**
*   `TicTacToe`: Game logic.
*   `Player`.

**Code:**
```cpp
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class TicTacToe {
    int n;
    vector<vector<int>> board;
    vector<int> rowSum, colSum;
    int diagSum, antiDiagSum;
    
public:
    TicTacToe(int n) : n(n), board(n, vector<int>(n, 0)), 
                       rowSum(n, 0), colSum(n, 0), diagSum(0), antiDiagSum(0) {}
    
    // Player 1 adds +1, Player 2 adds -1
    // Return: 0: No Winner, 1: Player 1 Wins, 2: Player 2 Wins
    int move(int row, int col, int player) {
        int val = (player == 1) ? 1 : -1;
        
        board[row][col] = val;
        
        rowSum[row] += val;
        colSum[col] += val;
        if (row == col) diagSum += val;
        if (row + col == n - 1) antiDiagSum += val;
        
        if (abs(rowSum[row]) == n || abs(colSum[col]) == n || 
            abs(diagSum) == n || abs(antiDiagSum) == n) {
            return player;
        }
        
        return 0;
    }
};
```






