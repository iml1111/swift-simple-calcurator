//
//  ContentView.swift
//  calculator
//
//  Created by 신희재 on 2021/03/12.
//

import SwiftUI

extension NSExpression {

    func toFloatingPoint() -> NSExpression {
        switch expressionType {
        case .constantValue:
            if let value = constantValue as? NSNumber {
                return NSExpression(forConstantValue: NSNumber(value: value.doubleValue))
            }
        case .function:
           let newArgs = arguments.map { $0.map { $0.toFloatingPoint() } }
           return NSExpression(forFunction: operand, selectorName: function, arguments: newArgs)
        case .conditional:
           return NSExpression(forConditional: predicate, trueExpression: self.true.toFloatingPoint(), falseExpression: self.false.toFloatingPoint())
        case .unionSet:
            return NSExpression(forUnionSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .intersectSet:
            return NSExpression(forIntersectSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .minusSet:
            return NSExpression(forMinusSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .subquery:
            if let subQuery = collection as? NSExpression {
                return NSExpression(forSubquery: subQuery.toFloatingPoint(), usingIteratorVariable: variable, predicate: predicate)
            }
        case .aggregate:
            if let subExpressions = collection as? [NSExpression] {
                return NSExpression(forAggregate: subExpressions.map { $0.toFloatingPoint() })
            }
        case .anyKey:
            fatalError("anyKey not yet implemented")
        case .block:
            fatalError("block not yet implemented")
        case .evaluatedObject, .variable, .keyPath:
            break // Nothing to do here
        }
        return self
    }
}


struct ContentView: View {
    @State var inputValue: String = "0"
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                VStack {
                    Spacer()
                    
                    Text(inputValue)
                        .font(.system(size:geometry.size.height / 15))
                        .foregroundColor(.white)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(15)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .trailing)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.trailing)
                        
                }.frame(height: geometry.size.height / 2.5)
                
                HStack {
                    
                    Button(
                        action: {
                            self.inputValue = "0"
                        }, label: {Text("AC")}
                    )
                    .buttonStyle(TabButtonStyle())
                    .scaleEffect()
                    
                    Button(
                        action: {
                            var input: String = self.inputValue
                            input = input.replacingOccurrences(of: "x", with: "*")
                            input = input.replacingOccurrences(of: "%", with: "/")
                            let exp: NSExpression = NSExpression(format: input)
                            let result: Double = exp.toFloatingPoint().expressionValue(with: nil, context: nil) as! Double
                            if Double(Int(result)) == result {
                                self.inputValue = String(Int(result))
                            }
                            else{
                                self.inputValue = String(result)
                            }
                        }
                        , label: {Image(systemName: "equal")}
                    ).buttonStyle(TabButtonStyle())
                
                }
                .frame(minWidth: 0,
                       maxWidth: .infinity)
                
                HStack {
                    
                    Button(
                        action: {
                            self.add_numeric(num: "7")
                        }, label: {Text("7")}
                    ).buttonStyle(NumericButtonStyle())
                    
                    Button(
                        action: {
                            self.add_numeric(num: "8")
                        }, label: {Text("8")}
                    ).buttonStyle(NumericButtonStyle())
                
                    Button(
                        action: {
                            self.add_numeric(num: "9")
                        }, label: {Text("9")}
                    ).buttonStyle(NumericButtonStyle())
                    
                    Button(
                        action: {
                            add_operator(op: "%")
                        }, label: {Image(systemName: "divide")}
                    ).buttonStyle(OperatorButtonStyle())
                }
                .frame(minWidth: 0,
                       maxWidth: .infinity)
                
                HStack {
                    
                    Button(
                        action: {
                            self.add_numeric(num: "4")
                        }, label: {Text("4")}
                    ).buttonStyle(NumericButtonStyle())
                    
                    Button(
                        action: {
                            self.add_numeric(num: "5")
                        }, label: {Text("5")}
                    ).buttonStyle(NumericButtonStyle())
                
                    Button(
                        action: {
                            self.add_numeric(num: "6")
                        }, label: {Text("6")}
                    ).buttonStyle(NumericButtonStyle())
                    
                    Button(
                        action: {
                            add_operator(op: "x")
                        }, label: {Image(systemName: "multiply")}
                    ).buttonStyle(OperatorButtonStyle())
                    
                }
                .frame(minWidth: 0,
                       maxWidth: .infinity)
                
                HStack {
                    
                    Button(
                        action: {
                            self.add_numeric(num: "1")
                        }, label: {Text("1")}
                    ).buttonStyle(NumericButtonStyle())
                    
                    Button(
                        action: {
                            self.add_numeric(num: "2")
                        }, label: {Text("2")}
                    ).buttonStyle(NumericButtonStyle())
                
                    Button(
                        action: {
                            self.add_numeric(num: "3")
                        }, label: {Text("3")}
                    ).buttonStyle(NumericButtonStyle())
                    
                    Button(
                        action: {
                            add_operator(op: "-")
                        }, label: {Image(systemName: "minus")}
                    ).buttonStyle(OperatorButtonStyle())
                    
                }
                .frame(minWidth: 0,
                       maxWidth: .infinity)
                
                HStack {
                    
                    Button(
                        action: {
                            self.add_numeric(num: "0")
                        }, label: {Text("0")}
                    )
                    .buttonStyle(NumericButtonStyle())
                    .frame(width: geometry.size.width / 2)
                
                    Button(
                        action: {
                            self.add_dot()
                        }, label: {Text(".")}
                    ).buttonStyle(NumericButtonStyle())
                    
                    Button(
                        action: {
                            add_operator(op: "+")
                        }, label: {Image(systemName: "plus")}
                    )
                    .buttonStyle(OperatorButtonStyle())
                }
                
                Spacer().frame(height: geometry.size.height / 20)
                
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
    
    func add_numeric(num: String) {
        if !self.check_max_len(){
            return
        }
        self.inputValue = self.inputValue == "0" ? num : self.inputValue + num
    }
    
    func add_dot(){
        if !self.check_max_len(){
            return
        }
        var dot_check: Bool = false
        for char in self.inputValue {
            if char == "." {
                dot_check = true
            }
            else if self.is_operator(str: char){
                dot_check = false
            }
        }
        
        if !dot_check {
            self.inputValue += "."
        }
    }
    
    func add_operator(op: String) {
        if !self.check_max_len(){
            return
        }
        if self.is_operator(str: self.inputValue.last!){
            self.inputValue.removeLast()
        }
        self.inputValue += op
    }
    
    func is_operator(str: Character) -> Bool {
        return (
            str == "+" ||
            str == "-" ||
            str == "x" ||
            str == "%"
        )
    }
    
    func check_max_len() -> Bool {
        return self.inputValue.count < 36
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
