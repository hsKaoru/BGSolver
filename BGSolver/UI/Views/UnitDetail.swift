//
//  UnitCell.swift
//  SwiftUItTest
//
//  Created by Igor Podolskiy on 11.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct UnitDetail: View {

    let detailViewWindow:NSWindow?

    @ObservedObject var unit: EntityViewModel = EntityViewModel(unit: Entity())

    @State private var showGreeting = false
    

    var body: some View {

        HStack {
            VStack {
                Button(action: {self.unit.deleteEntity()}) {
                Text("Clear")
            }
            Image("legend").resizable().frame(width: 64, height: 64)
            }
            HStack {
                VStack{
                    Text("Attack: " + self.unit.attack)
                    Button(action: { self.unit.increaseAttack()
                    }) {
                        Text("+")
                    }
                    Button(action: { self.unit.decreaseAttack()
                    }) {
                         Text("-")
                     }
                }
                VStack{
                    Text("Health: " + self.unit.health)
                    Button(action: { self.unit.increaseHealth()
                    }) {
                        Text("+")
                    }
                    Button(action: { self.unit.decreaseHealth()
                        }) {
                         Text("-")
                     }
                }
                }.padding().frame(width: 170, height: 100)
            VStack(alignment: .leading) {
                Toggle(isOn: self.unit.$isBubble) {
                    Text("Bubble")
                }
                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    Text("Taunt")
                }
                Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(true)/*@END_MENU_TOKEN@*/) {
                    Text("Poison")
                }
            }
        }.padding()
    }
}

struct  UnitDetail_Previews: PreviewProvider {
    static var previews: some View {
        UnitDetail(detailViewWindow: nil, unit: EntityViewModel(unit: Entity()))
    }
}
