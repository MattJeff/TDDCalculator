//
//  TDDCalculatorTests.swift
//  TDDCalculatorTests
//
//  Created by Mathis Higuinen on 06/09/2022.
//

import XCTest
@testable import TDDCalculator

/// The operations that can be performed
enum Operator: String {
  case plus = "+", minus = "-", times = "X", divide = "÷"
}


class TDDCalculatorTests: XCTestCase {

    func calculate(_ operand1: Double, _ operatorType: Operator,  _ operand2: Double) -> Double {
      
      //Return the answer expected for the calculation
      switch operatorType {
      case .plus:
        return operand1 + operand2
      case .minus:
        return operand1 - operand2
      case .times:
        return operand1 * operand2
      case .divide:
        return operand1 / operand2
      }
    }
    
    
    /// Performs an addition calculation and checks the answer
    func testAddition() throws {
      let viewModel = CalculatorViewModel()
      let expectedAnswer = calculate(2, .plus, 2)
      let answer = viewModel.calculate(2, .plus, 2)
      XCTAssertEqual(expectedAnswer, answer, "Expected answer \(expectedAnswer) was different from calculator answer \(answer)")
    }

    /// Performs an subtraction calculation and checks the answer
    func testSubtraction() throws {
      let viewModel = CalculatorViewModel()
      let expectedAnswer = calculate(3, .minus, 2)
      let answer = viewModel.calculate(3, .minus, 2)
      XCTAssertEqual(expectedAnswer, answer, "Expected answer \(expectedAnswer) was different from calculator answer \(answer)")
    }

    /// Performs an multiplication calculation and checks the answer
    func testMultiplication() throws {
      let viewModel = CalculatorViewModel()
      let expectedAnswer = calculate(3, .times, 3)
      let answer = viewModel.calculate(3, .times, 3)
      XCTAssertEqual(expectedAnswer, answer, "Expected answer \(expectedAnswer) was different from calculator answer \(answer)")
    }

    /// Performs an division calculation and checks the answer
    func testDivision() throws {
      let viewModel = CalculatorViewModel()
      let expectedAnswer = calculate(3, .divide, 3)
      let answer = viewModel.calculate(3, .divide, 3)
      XCTAssertEqual(expectedAnswer, answer, "Expected answer \(expectedAnswer) was different from calculator answer \(answer)")
    }



}



class PrototypeRealWorld: XCTestCase {
    
    func testPrototypeRealWorld() {
        
        let author = Author(id: 10, username: "Ivan_83")
        let page = Page(title: "My First Page", contents: "Hello world!", author: author)
        
        page.add(comment: Comment(message: "Keep it up!"))
        
        /// Since NSCopying returns Any, the copied object should be unwrapped.
        guard let anotherPage = page.copy() as? Page else {
            XCTFail("Page was not copied")
            return
        }
        
        /// Comments should be empty as it is a new page.
        XCTAssert(anotherPage.comments.isEmpty)
        
        /// Note that the author is now referencing two objects.
        XCTAssert(author.pagesCount == 2)
        
        print("Original title: " + page.title)
        print("Copied title: " + anotherPage.title)
        print("Count of pages: " + String(author.pagesCount))
    }
}

private class Author {
    
    private var id: Int
    private var username: String
    private var pages = [Page]()
    
    init(id: Int, username: String) {
        self.id = id
        self.username = username
    }
    
    func add(page: Page) {
        pages.append(page)
    }
    
    var pagesCount: Int {
        return pages.count
    }
}

private class Page: NSCopying {
    
    private(set) var title: String
    private(set) var contents: String
    private weak var author: Author?
    private(set) var comments = [Comment]()
    
    init(title: String, contents: String, author: Author?) {
        self.title = title
        self.contents = contents
        self.author = author
        author?.add(page: self)
    }
    
    func add(comment: Comment) {
        comments.append(comment)
    }
    
    /// MARK: - NSCopying
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Page(title: "Copy of '" + title + "'", contents: contents, author: author)
    }
}

private struct Comment {
    
    let date = Date()
    let message: String
}


