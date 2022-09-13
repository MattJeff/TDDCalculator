//
//  TDDCalculatorUITests.swift
//  TDDCalculatorUITests
//
//  Created by Mathis Higuinen on 06/09/2022.
//

import XCTest


/// The operations that can be performed
enum Operator: String {
  case plus = "+", minus = "-", times = "X", divide = "÷"
}


class TDDCalculatorUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }
    
    func typeNumber(_ number: Double) {
        
      let numberString = String(format: "%.6f", number)
        
      let digits = Array(numberString)
        
      for digit in digits {
          
        if digit == "." {
            break
            
        } else {
            
         // app.buttons[String(digit)].tap()
            
        }
      }
    }
    
    
    func calculate(_ operand1: Double, _ operatorType: Operator,  _ operand2: Double) -> Double {
      //Type the first number
      typeNumber(operand1)
      
      //Enter the operator
      app.buttons[operatorType.rawValue].tap()
      
      //Type the second number
      typeNumber(operand2)
      
      //Calculate the answer
      app.buttons["="].tap()
      
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
      XCTAssertTrue(app.staticTexts["0.000000"].exists, "Zero was not displayed on launch")
      
      //Single digit calculation
      var answer = calculate(2, .plus, 2)
      XCTAssertTrue(app.staticTexts[String(format: "%.6f", answer)].exists, "Answer was not displayed")
      
      //Multiple digit calculation
      answer = calculate(12, .plus, 12)
      XCTAssertTrue(app.staticTexts[String(format: "%.6f", answer)].exists, "Answer was not displayed")
    }

    /// Performs a subtraction calculation and checks the answer
    func testSubtraction() throws {
      XCTAssertTrue(app.staticTexts["0.000000"].exists, "Zero was not displayed on launch")
      
      //Single digit calculation
      var answer = calculate(3, .minus, 2)
      XCTAssertTrue(app.staticTexts[String(format: "%.6f", answer)].exists, "Answer was not displayed")
      
      //Multiple digit calculation
      answer = calculate(13, .minus, 12)
      XCTAssertTrue(app.staticTexts[String(format: "%.6f", answer)].exists, "Answer was not displayed")
    }

    /// Performs an multiplication calculation and checks the answer
    func testMultiplication() throws {
      //XCTAssertTrue(app.staticTexts["0.000000"].exists, "Zero was not displayed on launch")
      
      //Single digit calculation
      var answer = calculate(3, .times, 3)
      XCTAssertTrue(app.staticTexts[String(format: "%.6f", answer)].exists, "Answer was not displayed")
      
      //Multiple digit calculation
      answer = calculate(13, .times, 13)
      XCTAssertTrue(app.staticTexts[String(format: "%.6f", answer)].exists, "Answer was not displayed")
    }

    /// Performs an division calculation and checks the answer
    func testDivision() throws {
      XCTAssertTrue(app.staticTexts["0.000000"].exists, "Zero was not displayed on launch")
      
      //Single digit calculation
      var answer = calculate(3, .divide, 3)
      XCTAssertTrue(app.staticTexts[String(format: "%.6f", answer)].exists, "Answer was not displayed")
      
      //Multiple digit calculation
      answer = calculate(33, .divide, 11)
      XCTAssertTrue(app.staticTexts[String(format: "%.6f", answer)].exists, "Answer was not displayed")
    }
    

}
