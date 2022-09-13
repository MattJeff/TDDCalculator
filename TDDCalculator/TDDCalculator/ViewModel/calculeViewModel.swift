//
//  calculeViewModel.swift
//  TDDCalculator
//
//  Created by Mathis Higuinen on 06/09/2022.
//

import Foundation

/// The operations that can be performed
enum Operator: String {
  case plus = "+", minus = "-", times = "X", divide = "÷"
}


protocol Calculatable:ObservableObject{
    
    func calculate(_ operand1: Double, _ operatorType: Operator,  _ operand2: Double) -> Double
     
     /// The first number
     var operand1: Double { get }
     /// The second number
     var operand2: Double { get }
     /// The operation to be completed
     var operatorType: Operator? { get }
    
}


class  CalculatorViewModel:ObservableObject,Calculatable{
    
    
    
    func calculate(_ operand1: Double, _ operatorType: Operator, _ operand2: Double) -> Double {
        
        
        var answer:Double?
        
        switch operatorType {
            case .plus:
                answer = operand1 + operand2
            case .minus:
                answer = operand1 - operand2
            case .times:
                answer = operand1 * operand2
            case .divide:
                answer = operand1 / operand2
        }
        
       
        //Ensure answer is not nil (which should be impossible)
         guard let answer = answer else {
           fatalError("No answer was calculated")
         }
         //Remove operator after using it
         self.operatorType = nil
         //Set operand1 as the answer for future calculations
         self.operand1 = answer
         //Set operand2 to zero
         self.operand2 = 0
         //Return the answer
         return answer
    }
    
    @Published var operand1: Double = Double()
    
    @Published var operand2: Double  = Double()
    
    @Published var operatorType: Operator?
    
    
    
  
}

