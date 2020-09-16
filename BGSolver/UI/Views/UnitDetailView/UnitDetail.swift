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
                HStack {
                PickUnitView()
                Button("Clear", action: {self.unit.deleteEntity()})
                }
            Image("legend").resizable().frame(width: 64, height: 64)
            }
            HStack {
                VStack{
                    Text("Attack: " + self.unit.attack)
                    Button("+", action: { self.unit.increaseAttack()
                    })
                    Button("-",action: { self.unit.decreaseAttack()
                    })
                }
                VStack{
                    Text("Health: " + self.unit.health)
                    Button("+", action: { self.unit.increaseHealth()
                    })
                    Button("-", action: { self.unit.decreaseHealth()
                        }) 
                }
                }.padding().frame(width: 170, height: 100)
            VStack(alignment: .leading) {
                Button(action: { guard self.unit.isUnitNotNil() else { return }
                    self.unit.isBubble.toggle()
                    }) {
                        Text("Bubble")
                            .frame(width: 50)
                    }.background(getColorForPropertiesButtons(statValue: unit.isBubble)).cornerRadius(5)
                Button(action: { guard self.unit.isUnitNotNil() else { return }
                    self.unit.isTaunt.toggle()
                    }) {
                        Text("Taunt").frame(width: 50)
                 }.background(getColorForPropertiesButtons(statValue: unit.isTaunt)).cornerRadius(5)
                Button(action: { guard self.unit.isUnitNotNil() else { return }
                    self.unit.isPoisoned.toggle()
                    }) {
                        Text("Poison").frame(width: 50)
                 }.background(getColorForPropertiesButtons(statValue: unit.isPoisoned)).cornerRadius(5)
            }
        }
            MechanicsDetailView(unit: unit)}.padding()
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

struct  UnitDetail_Previews: PreviewProvider {
    static var previews: some View {
        UnitDetail(detailViewWindow: nil, unit: EntityViewModel(unit:   Entity(attack: 2, health: 2, mechanics: [AurasBuffMechanics(forRace: .murloc, attackBuffCount: 2, healthBuffCount: 0), DeathRattleMechanics(withDamageForOppositeBoard: 4), RebornMechanics(RebornedUnit: Entity(attack: 2, health: 1, mechanics: [DeathRattleMechanics(withDamageForOppositeBoard: 4)]))])))
    }
}
