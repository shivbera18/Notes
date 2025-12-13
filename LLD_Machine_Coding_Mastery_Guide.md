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

## 1. Rate Limiter (Token Bucket Algorithm)
**Problem:** Design a rate limiter that allows `N` requests per `T` seconds.

```cpp
#include <iostream>
#include <chrono>
#include <thread>
#include <mutex>

class TokenBucket {
private:
    long maxTokens;
    long currentTokens;
    long refillRate; // tokens per second
    std::chrono::steady_clock::time_point lastRefillTimestamp;
    std::mutex mtx;

    void refill() {
        auto now = std::chrono::steady_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::seconds>(now - lastRefillTimestamp).count();
        
        if (duration > 0) {
            long tokensToAdd = duration * refillRate;
            currentTokens = std::min(maxTokens, currentTokens + tokensToAdd);
            lastRefillTimestamp = now;
        }
    }

public:
    TokenBucket(long maxTokens, long refillRate) 
        : maxTokens(maxTokens), currentTokens(maxTokens), refillRate(refillRate) {
        lastRefillTimestamp = std::chrono::steady_clock::now();
    }

    bool allowRequest(int tokens = 1) {
        std::lock_guard<std::mutex> lock(mtx);
        refill();
        if (currentTokens >= tokens) {
            currentTokens -= tokens;
            return true;
        }
        return false;
    }
};
```

## 2. Notification System
**Problem:** Design a notification system that can send emails, SMS, and push notifications.

```cpp
// Interface for Notification Channels
class NotificationChannel {
public:
    virtual void send(string to, string message) = 0;
};

class EmailChannel : public NotificationChannel {
public:
    void send(string to, string message) override { cout << "Email to " << to << ": " << message << endl; }
};

class SMSChannel : public NotificationChannel {
public:
    void send(string to, string message) override { cout << "SMS to " << to << ": " << message << endl; }
};

// Factory for creating channels
class ChannelFactory {
public:
    static NotificationChannel* createChannel(string type) {
        if (type == "EMAIL") return new EmailChannel();
        else if (type == "SMS") return new SMSChannel();
        return nullptr;
    }
};

// Notification Service (Facade)
class NotificationService {
public:
    void sendNotification(string type, string to, string message) {
        NotificationChannel* channel = ChannelFactory::createChannel(type);
        if (channel) {
            channel->send(to, message);
            delete channel;
        }
    }
};
```

## 3. Parking Lot System
**Problem:** Design a parking lot with different spot types and pricing.

```cpp
enum VehicleType { CAR, BIKE, TRUCK };

class Vehicle {
public:
    string licensePlate;
    VehicleType type;
    Vehicle(string plate, VehicleType t) : licensePlate(plate), type(t) {}
};

class ParkingSpot {
public:
    int id;
    bool isFree;
    VehicleType type;
    Vehicle* vehicle;

    ParkingSpot(int id, VehicleType t) : id(id), isFree(true), type(t), vehicle(nullptr) {}

    void park(Vehicle* v) {
        vehicle = v;
        isFree = false;
    }

    void removeVehicle() {
        vehicle = nullptr;
        isFree = true;
    }
};

class ParkingLot {
    vector<ParkingSpot*> spots;
public:
    ParkingLot() {
        // Initialize spots
        spots.push_back(new ParkingSpot(1, CAR));
        spots.push_back(new ParkingSpot(2, BIKE));
    }

    bool parkVehicle(Vehicle* v) {
        for (auto spot : spots) {
            if (spot->isFree && spot->type == v->type) {
                spot->park(v);
                cout << "Parked vehicle " << v->licensePlate << " at spot " << spot->id << endl;
                return true;
            }
        }
        cout << "Parking full for type " << v->type << endl;
        return false;
    }
};
```

## 4. Snake and Ladder
**Problem:** Design a Snake and Ladder game.

```cpp
#include <map>
#include <queue>

class Board {
    int size;
    map<int, int> snakes;
    map<int, int> ladders;
public:
    Board(int s) : size(s) {}
    void addSnake(int start, int end) { snakes[start] = end; }
    void addLadder(int start, int end) { ladders[start] = end; }
    
    int getNewPosition(int pos) {
        if (snakes.count(pos)) return snakes[pos];
        if (ladders.count(pos)) return ladders[pos];
        return pos;
    }
    int getSize() { return size; }
};

class Game {
    Board* board;
    queue<string> players;
    map<string, int> playerPositions;
public:
    Game(Board* b) : board(b) {}
    void addPlayer(string name) {
        players.push(name);
        playerPositions[name] = 0;
    }

    void play() {
        while (true) {
            string player = players.front();
            players.pop();
            
            int dice = (rand() % 6) + 1;
            int currentPos = playerPositions[player];
            int nextPos = currentPos + dice;
            
            if (nextPos > board->getSize()) {
                players.push(player);
                continue;
            }
            
            nextPos = board->getNewPosition(nextPos);
            playerPositions[player] = nextPos;
            
            cout << player << " rolled " << dice << " -> " << nextPos << endl;
            
            if (nextPos == board->getSize()) {
                cout << player << " WINS!" << endl;
                break;
            }
            players.push(player);
        }
    }
};
```

## 5. Google Docs (Collaborative Editor) - High Level
**Key Concepts:**
*   **Operational Transformation (OT)** or **CRDT (Conflict-free Replicated Data Types)**: To handle concurrent edits.
*   **WebSocket**: For real-time communication.

**Basic Class Structure:**
```cpp
class Document {
    string content;
    vector<User*> activeUsers;
public:
    void applyOperation(Operation op) {
        // Apply insert/delete at position
        // Transform operation if needed (OT logic)
    }
};

class Operation {
public:
    enum Type { INSERT, DELETE };
    Type type;
    int position;
    char character;
};
```
*Note: Implementing full OT/CRDT is complex and usually beyond a 45-min interview scope, but knowing the classes and `applyOperation` logic is key.*



