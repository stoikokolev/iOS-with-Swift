import XCTest

/*:
 Declare a generic type Stack. A stack is a LIFO (last-in-first-out) data structure that supports the following operations:
 
 - peek: returns the top element on the stack without removing it. Returns nil if the stack is empty.
 - push: adds an element on top of the stack.
 - pop: returns and removes the top element on the stack. Returns nil if the stack is empty.
 - count: returns the size of the stack.
 
 Ensure that these operations are the only exposed interface. In other words, additional properties or methods needed to implement the type should not be visible.
 */

//: Psst, don't forget to use some Doxygen documentation cause other devs might need to use your stack some day

// Implement me here
struct Stack<Element> {
    var elements: [Element]
    var count: Int {
        get {
            elements.count
        }
    }
    
    init(_ elements: [Element]) {
        self.elements = elements
    }
    
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        if elements.isEmpty {
            return nil
        } else {
            return elements.remove(at: elements.count - 1)
        }
    }
    
    func peek() -> Element? {
        if elements.isEmpty {
            return nil
        } else {
            return elements[elements.count - 1]
        }
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
}


// MARK: - Unit Tests
class StackTest: XCTestCase {
    // MARK: - Test init
    func testInit_IntElements() {
        let stack = Stack([1, 2, 4, 5, 6])
        XCTAssertNotNil(stack)
        XCTAssertTrue(type(of: stack) == Stack<Int>.self)
    }
    
    func testInit_StringElements() {
        let stack = Stack(["a", "b", "c", "d"])
        XCTAssertNotNil(stack)
        XCTAssertTrue(type(of: stack) == Stack<String>.self)
    }
    
    func testInit_DoubleElements() {
        let stack = Stack([2.3, 3, 4.5, 7.8])
        XCTAssertNotNil(stack)
        XCTAssertTrue(type(of: stack) == Stack<Double>.self)
    }
    
    // MARK: - Test empty
    func testIsEmpty_EmptyElements() {
        let stack: Stack<Int> = Stack([])
        XCTAssertTrue(stack.isEmpty)
    }
    
    func testIsEmpty_NonEmptyElements() {
        let stack = Stack([2.3, 3, 4.5, 7.8])
        XCTAssertFalse(stack.isEmpty)
    }
    
    // MARK: - Test peek
    func testPeek_EmptyStack() {
        let stack: Stack<Int> = Stack([])
        XCTAssertNil(stack.peek())
    }
    
    func testPeek_NonEmptyStack() {
        let stack = Stack([1, 2, 4, 5, 6])
        XCTAssertNotNil(stack.peek())
        XCTAssertTrue(stack.peek() == 6)
    }
    
    // MARK: - Test push
    func testPush_NonEmptyStack() {
        var stack = Stack([1, 2, 4, 5, 6])
        stack.push(7)
        XCTAssertNotNil(stack.peek())
        XCTAssertTrue(stack.peek() == 7)
    }
    
    // MARK: - Test pop
    func testPop_NonEmptyStack() {
        var stack = Stack([1, 2, 4, 5, 6])
        stack.push(7)
        XCTAssertNotNil(stack.pop())
        XCTAssertTrue(stack.pop() == 6)
    }
    
    func testPop_EmptyStack() {
        var stack = Stack([])
        XCTAssertNil(stack.pop())
    }
}
StackTest.defaultTestSuite.run()
