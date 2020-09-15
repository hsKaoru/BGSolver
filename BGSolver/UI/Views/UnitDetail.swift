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

    var body: some View {
        VStack {
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
                Button(action: { guard let _ = self.unit.unit else { return }
                    self.unit.isBubble.toggle()
                    }) {
                        Text("Bubble")
                            .frame(width: 50)
                    }.background(getColorForPropertiesButtons(statValue: unit.isBubble)).cornerRadius(5)
                Button(action: { guard let _ = self.unit.unit else { return }
                    self.unit.isTaunt.toggle()
                    }) {
                        Text("Taunt").frame(width: 50)
                 }.background(getColorForPropertiesButtons(statValue: unit.isTaunt)).cornerRadius(5)
                Button(action: { guard let _ = self.unit.unit else { return }
                    self.unit.isPoisoned.toggle()
                    }) {
                        Text("Poison").frame(width: 50)
                 }.background(getColorForPropertiesButtons(statValue: unit.isPoisoned)).cornerRadius(5)
            }
        }.padding()
            HStack {
            ScrollView {
                Text("1. Призвать 3 механизма 1-1 и взорвать бомбу\n2. Нанести 4 урона случайному юниту противника\n3. Также наносит урон по обе стороны от цели")
            }.frame(width: 180, height: 80).border(Color.gray, width: 1)
            Button("Add Mechanics", action: {})
            }}.padding()
    }
}

struct  UnitDetail_Previews: PreviewProvider {
    static var previews: some View {
        UnitDetail(detailViewWindow: nil, unit: EntityViewModel(unit: Entity()))
    }
}

extension UnitDetail {
    func getColorForPropertiesButtons(statValue: Bool?) -> Color {
        if let value = statValue {
            if value {
                return Color.blue
            }
        }
        return Color.black
    }
}
