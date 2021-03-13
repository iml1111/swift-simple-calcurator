//
//  CustomButtonStyle.swift
//  calculator
//
//  Created by 신희재 on 2021/03/12.
//

import SwiftUI


struct TabButtonStyle : ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .font(.system(size: 40, weight: .bold))
            .background(
                Color(
                    red: 165 / 255,
                    green: 165 / 255,
                    blue: 165 / 255))
            .foregroundColor(Color.black)
            .scaleEffect(configuration.isPressed ? 1.4 : 1.0)
            .cornerRadius(40)
    }
}


struct NumericButtonStyle : ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .font(.system(size: 40, weight: .bold))
            .background(
                Color(
                    red: 51 / 255,
                    green: 51 / 255,
                    blue: 51 / 255))
            .foregroundColor(Color.white)
            .scaleEffect(configuration.isPressed ? 1.4 : 1.0)
            .cornerRadius(40)
    }
}


struct OperatorButtonStyle : ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .font(.system(size: 40, weight: .bold))
            .background(
                Color(
                    red: 242 / 255,
                    green: 162 / 255,
                    blue: 60 / 255))
            .foregroundColor(Color.white)
            .scaleEffect(configuration.isPressed ? 1.4 : 1.0)
            .cornerRadius(40)
    }
}

struct CustomButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
//        VStack {
//            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                Text("AC")
//            }).buttonStyle(TabButtonStyle())
//            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                Text("1")
//            }).buttonStyle(NumericButtonStyle())
//            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                Text("%")
//            }).buttonStyle(OperatorButtonStyle())
//
//        }
//        .frame(minWidth: 0,
//               maxWidth: .infinity)
        ContentView()
    }
}
