//
//  UnitCell.swift
//  SwiftUItTest
//
//  Created by Igor Podolskiy on 11.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct UnitDetail: View {

    @State var unit: Entity? = Entity()
    @State var attackText = "-"
    @State var hpText = "-"

    var body: some View {
        HStack {
            Image("legend").resizable().frame(width: 64, height: 64)
            HStack {
                VStack{
                    Text("Attack: " + attackText)
                    Button(action: { self.increaseAttack()
                        self.attackText = self.getUnitAttack()
                    }) {
                        Text("+")
                    }
                    Button(action: { self.decreaseAttack()
                        self.attackText = self.getUnitAttack()
                    }) {
                         Text("-")
                     }
                }
                VStack{
                    Text("Health: " + hpText)
                    Button(action: { self.increaseHealth()
                        self.hpText = self.getUnitHealth()
                    }) {
                        Text("+")
                    }
                    Button(action: { self.decreaseHealth()
                    self.hpText = self.getUnitHealth()}) {
                         Text("-")
                     }
                }
                }.padding().frame(width: 170, height: 100)
        }
    }

    func getUnitAttack() -> String {
        if let attack = unit?.attack {
            return String(attack) }
        return "-"
    }

    func getUnitHealth() -> String {
        if let health = unit?.health {
            return String(health) }
        return "-"
    }

    func increaseAttack() {
        if let unit = unit {
            unit.attack += 1
        }
    }

    func decreaseAttack() {
        if let unit = unit, unit.attack > 0 {
            unit.attack -= 1
        }
    }

    func increaseHealth() {
        if let unit = unit {
            unit.health += 1
        }
    }

    func decreaseHealth() {
        if let unit = unit, unit.attack > 0 {
            unit.health -= 1
        }
    }

}

struct  UnitDetail_Previews: PreviewProvider {
    static var previews: some View {
        UnitDetail(unit: Entity())
    }
}
