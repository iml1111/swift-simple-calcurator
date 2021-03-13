//
//  ButtonView.swift
//  calculator
//
//  Created by 신희재 on 2021/03/12.
//

import SwiftUI

struct ImageButtonView : View {
    
    var symbol: String
    
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Image(systemName: symbol)
        })
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ImageButtonView(symbol: "percent")
    }
}



