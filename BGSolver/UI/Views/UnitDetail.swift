//
//  UnitCell.swift
//  SwiftUItTest
//
//  Created by Igor Podolskiy on 11.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct UnitDetail: View {
    @State var bubbleToggle = true
    var body: some View {
        HStack {
            Image("legend").resizable().frame(width: 32, height: 32)
            HStack {
                VStack{
                    Text("Attack: 1")
                    Button(action: {}) {
                        Text("+")
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                         Text("-")
                     }
//                    Button(action: {
//                        print("12345")
//                    }, label: {
//                        Image("legend")
//                            .background(Color.init(#colorLiteral(red: 0.9531342387, green: 0.9490900636, blue: 0.9562709928, alpha: 1)))
//                            .cornerRadius(10)
//                    })
                }
                VStack{
                    Text("Health: 1")
                    Button(action: {}) {
                        Text("+")
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                         Text("-")
                     }
                }
                VStack {
                HStack{
                    Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                        Text("Bubble")
                    }

                }
                HStack{
                    Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                        Text("Taunt")
                    }
                }
                HStack{
                     Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                         Text("Poisoned")
                     }
                 }
                }
                VStack{
                    Text("Mechanics")
                    Button(action: {}) {
                        Text("+")
                    }
                    Text("")
                 }
            }
        }
    }
}

struct  UnitDetail_Previews: PreviewProvider {
    static var previews: some View {
        UnitDetail()
    }
}
