# Low Level Design (LLD) & Machine Coding Mastery Guide (C++)

This guide covers Object-Oriented Programming (OOP) in depth, SOLID principles, Design Patterns, and common Machine Coding/System Design questions, tailored for Software Development roles.

---

# Part 1: Object-Oriented Programming (OOP) Deep Dive

## 1. Core Concepts

### Encapsulation
Bundling data (variables) and methods (functions) that operate on the data into a single unit (class). It also involves restricting direct access to some of an object's components (data hiding).

```cpp
#include <iostream>
#include <string>

class BankAccount {
private:
    double balance; // Hidden data

public:
    BankAccount(double initialBalance) : balance(initialBalance) {}

    void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }

    double getBalance() const { // Read-only access
        return balance;
    }
};
```

### Abstraction
Hiding complex implementation details and showing only the necessary features of an object. Achieved using abstract classes and interfaces.

### Inheritance
Mechanism where a new class derives attributes and behavior from an existing class.

### Polymorphism
The ability of a message to be displayed in more than one form.
*   **Compile-time (Static):** Function Overloading, Operator Overloading.
*   **Run-time (Dynamic):** Virtual Functions (Function Overriding).

## 2. Advanced OOP Concepts

### Virtual Functions & V-Table
A `virtual` function is a member function that you expect to be redefined in derived classes. When you refer to a derived class object using a pointer or a reference to the base class, you can call a virtual function for that object and execute the derived class's version of the function.

**How it works (V-Table):**
*   The compiler creates a **V-Table (Virtual Table)** for each class having virtual functions. This table contains addresses of virtual functions.
*   The object contains a **VPTR (Virtual Pointer)** pointing to the V-Table of that class.
*   At runtime, the correct function is resolved using VPTR.

```cpp
#include <iostream>

class Base {
public:
    virtual void show() { std::cout << "Base show" << std::endl; }
    void print() { std::cout << "Base print" << std::endl; }
    virtual ~Base() { std::cout << "Base Destructor" << std::endl; } // IMPORTANT: Virtual Destructor
};

class Derived : public Base {
public:
    void show() override { std::cout << "Derived show" << std::endl; }
    void print() { std::cout << "Derived print" << std::endl; }
    ~Derived() { std::cout << "Derived Destructor" << std::endl; }
};

int main() {
    Base* bptr = new Derived();
    
    // Runtime Polymorphism (Virtual function)
    bptr->show(); // Output: Derived show
    
    // Static Binding (Non-virtual function)
    bptr->print(); // Output: Base print
    
    delete bptr; // Correctly calls Derived destructor then Base destructor because Base destructor is virtual
    return 0;
}
```

### Virtual Destructors
**Critical Interview Question:** Why do we need virtual destructors?
*   If the base class destructor is **not** virtual, deleting a derived class object through a base class pointer results in **undefined behavior** (usually the derived class destructor is NOT called, leading to memory leaks).

### Abstract Classes (Interfaces)
A class containing at least one **pure virtual function** (`= 0`) is an abstract class. You cannot instantiate it.

```cpp
class Shape {
public:
    virtual void draw() = 0; // Pure virtual function
    virtual ~Shape() {}
};

class Circle : public Shape {
public:
    void draw() override {
        std::cout << "Drawing Circle" << std::endl;
    }
};
```

### Diamond Problem (Multiple Inheritance)
Occurs when two superclasses of a class have a common base class.
**Solution:** Use `virtual` inheritance.

```cpp
class A { public: int x; };
class B : virtual public A {};
class C : virtual public A {};
class D : public B, public C {}; // D has only one copy of A's members
```

---

# Part 2: SOLID Principles

## 1. Single Responsibility Principle (SRP)
A class should have only one reason to change. It should have only one job.

**Violation:**
```cpp
class User {
public:
    void login(string username, string password) { /* logic */ }
    void sendEmail(string email, string message) { /* logic */ } // Wrong: Email logic in User class
    void logError(string error) { /* logic */ } // Wrong: Logging logic in User class
};
```

**Correct:**
```cpp
class UserAuth {
public:
    void login(string username, string password) { /* ... */ }
};

class EmailService {
public:
    void sendEmail(string email, string message) { /* ... */ }
};

class Logger {
public:
    void logError(string error) { /* ... */ }
};
```

## 2. Open/Closed Principle (OCP)
Software entities should be **open for extension, but closed for modification**.

**Violation:**
```cpp
class Rectangle { public: double width, height; };
class Circle { public: double radius; };

class AreaCalculator {
public:
    double calculate(void* shape, string type) {
        if (type == "Rectangle") { /* calculate rect area */ }
        else if (type == "Circle") { /* calculate circle area */ }
        // Adding a new shape requires modifying this class!
    }
};
```

**Correct:**
```cpp
class Shape {
public:
    virtual double area() = 0;
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

// No modification needed here for new shapes
double calculateArea(Shape* shape) {
    return shape->area();
}
```

## 3. Liskov Substitution Principle (LSP)
Objects of a superclass should be replaceable with objects of its subclasses without breaking the application.
*   "If it looks like a duck, quacks like a duck, but needs batteries – you have the wrong abstraction."

**Violation (Classic Square-Rectangle problem):**
If `Square` inherits from `Rectangle` and setting width changes height automatically, it might break code expecting a `Rectangle` where width and height are independent.

## 4. Interface Segregation Principle (ISP)
Clients should not be forced to depend upon interfaces that they do not use. Split large interfaces into smaller, specific ones.

**Violation:**
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

**Correct:**
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
High-level modules should not depend on low-level modules. Both should depend on abstractions.

**Violation:**
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

**Correct:**
```cpp
class Switchable { // Abstraction
public:
    virtual void turnOn() = 0;
    virtual void turnOff() = 0;
};

class LightBulb : public Switchable {
public:
    void turnOn() override { /*...*/ }
    void turnOff() override { /*...*/ }
};

class Fan : public Switchable {
public:
    void turnOn() override { /*...*/ }
    void turnOff() override { /*...*/ }
};

class Switch {
    Switchable& device; // Depends on abstraction
public:
    Switch(Switchable& dev) : device(dev) {}
    void operate() {
        device.turnOn();
    }
};
```


# Part 3: Design Patterns (Gang of Four)

## A. Creational Patterns
Deal with object creation mechanisms.

### 1. Singleton
Ensures a class has only one instance and provides a global point of access to it.

```cpp
class Singleton {
private:
    static Singleton* instance;
    Singleton() {} // Private constructor

public:
    // Delete copy constructor and assignment operator
    Singleton(const Singleton&) = delete;
    void operator=(const Singleton&) = delete;

    static Singleton* getInstance() {
        if (instance == nullptr) {
            instance = new Singleton();
        }
        return instance;
    }
};

Singleton* Singleton::instance = nullptr;
```
*Thread-safe version (Meyers' Singleton):*
```cpp
class Singleton {
public:
    static Singleton& getInstance() {
        static Singleton instance; // Guaranteed to be thread-safe in C++11
        return instance;
    }
    Singleton(const Singleton&) = delete;
    void operator=(const Singleton&) = delete;
private:
    Singleton() {}
};
```

### 2. Factory Method
Defines an interface for creating an object, but lets subclasses alter the type of objects that will be created.

```cpp
class Product { public: virtual void use() = 0; };
class ConcreteProductA : public Product { public: void use() override { cout << "Using A" << endl; } };
class ConcreteProductB : public Product { public: void use() override { cout << "Using B" << endl; } };

class Creator {
public:
    virtual Product* createProduct() = 0;
    void someOperation() {
        Product* p = createProduct();
        p->use();
        delete p;
    }
};

class ConcreteCreatorA : public Creator {
public:
    Product* createProduct() override { return new ConcreteProductA(); }
};
```

### 3. Abstract Factory
Produces families of related objects without specifying their concrete classes.

```cpp
class Chair { public: virtual void sit() = 0; };
class Sofa { public: virtual void lie() = 0; };

class ModernChair : public Chair { public: void sit() override { cout << "Modern Chair" << endl; } };
class ModernSofa : public Sofa { public: void lie() override { cout << "Modern Sofa" << endl; } };

class FurnitureFactory {
public:
    virtual Chair* createChair() = 0;
    virtual Sofa* createSofa() = 0;
};

class ModernFurnitureFactory : public FurnitureFactory {
public:
    Chair* createChair() override { return new ModernChair(); }
    Sofa* createSofa() override { return new ModernSofa(); }
};
```

### 4. Builder
Constructs complex objects step by step.

```cpp
class House {
public:
    string walls, roof, garage;
    void show() { cout << walls << ", " << roof << ", " << garage << endl; }
};

class HouseBuilder {
protected:
    House* house;
public:
    HouseBuilder() { house = new House(); }
    virtual void buildWalls() = 0;
    virtual void buildRoof() = 0;
    House* getResult() { return house; }
};

class StoneHouseBuilder : public HouseBuilder {
public:
    void buildWalls() override { house->walls = "Stone Walls"; }
    void buildRoof() override { house->roof = "Stone Roof"; }
};

class Director {
public:
    void construct(HouseBuilder* builder) {
        builder->buildWalls();
        builder->buildRoof();
    }
};
```

### 5. Prototype
Creates new objects by copying an existing object (cloning).

```cpp
class Prototype {
public:
    virtual Prototype* clone() = 0;
};

class ConcretePrototype : public Prototype {
    int field;
public:
    ConcretePrototype(int f) : field(f) {}
    Prototype* clone() override {
        return new ConcretePrototype(*this);
    }
};
```

## B. Structural Patterns
Deal with object composition.

### 1. Adapter
Allows objects with incompatible interfaces to collaborate.

```cpp
class Target {
public:
    virtual void request() { cout << "Target request" << endl; }
};

class Adaptee {
public:
    void specificRequest() { cout << "Adaptee specific request" << endl; }
};

class Adapter : public Target {
private:
    Adaptee* adaptee;
public:
    Adapter(Adaptee* a) : adaptee(a) {}
    void request() override {
        adaptee->specificRequest();
    }
};
```

### 2. Bridge
Splits a large class or a set of closely related classes into two separate hierarchies—abstraction and implementation—which can be developed independently.

```cpp
class Implementor {
public:
    virtual void operationImpl() = 0;
};

class ConcreteImplementorA : public Implementor {
public:
    void operationImpl() override { cout << "Impl A" << endl; }
};

class Abstraction {
protected:
    Implementor* impl;
public:
    Abstraction(Implementor* i) : impl(i) {}
    virtual void operation() { impl->operationImpl(); }
};
```

### 3. Composite
Composes objects into tree structures to represent part-whole hierarchies.

```cpp
#include <vector>
class Component {
public:
    virtual void operation() = 0;
};

class Leaf : public Component {
public:
    void operation() override { cout << "Leaf" << endl; }
};

class Composite : public Component {
    vector<Component*> children;
public:
    void add(Component* c) { children.push_back(c); }
    void operation() override {
        for (auto c : children) c->operation();
    }
};
```

### 4. Decorator
Attaches new behaviors to objects by placing these objects inside special wrapper objects that contain the behaviors.

```cpp
class Coffee {
public:
    virtual double cost() = 0;
};

class SimpleCoffee : public Coffee {
public:
    double cost() override { return 10.0; }
};

class CoffeeDecorator : public Coffee {
protected:
    Coffee* coffee;
public:
    CoffeeDecorator(Coffee* c) : coffee(c) {}
};

class MilkDecorator : public CoffeeDecorator {
public:
    MilkDecorator(Coffee* c) : CoffeeDecorator(c) {}
    double cost() override { return coffee->cost() + 2.0; }
};
```

### 5. Facade
Provides a simplified interface to a library, a framework, or any other complex set of classes.

```cpp
class CPU { public: void freeze() {} void jump(long position) {} void execute() {} };
class Memory { public: void load(long position, char* data) {} };
class HardDrive { public: char* read(long lba, int size) { return nullptr; } };

class ComputerFacade {
    CPU cpu; Memory memory; HardDrive hardDrive;
public:
    void start() {
        cpu.freeze();
        memory.load(0, hardDrive.read(0, 1024));
        cpu.jump(0);
        cpu.execute();
    }
};
```

### 6. Flyweight
Lets you fit more objects into the available amount of RAM by sharing common parts of state between multiple objects instead of keeping all of the data in each object.

```cpp
class TreeType {
    string name;
    string color;
    // Shared state
};

class Tree {
    int x, y;
    TreeType* type; // Pointer to shared state
};
```

### 7. Proxy
Provides a placeholder for another object to control access to it.

```cpp
class Subject { public: virtual void request() = 0; };
class RealSubject : public Subject { public: void request() override { cout << "Real Request" << endl; } };

class Proxy : public Subject {
    RealSubject* realSubject;
public:
    void request() override {
        if (checkAccess()) {
            if (!realSubject) realSubject = new RealSubject();
            realSubject->request();
        }
    }
    bool checkAccess() { return true; }
};
```


## C. Behavioral Patterns
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



