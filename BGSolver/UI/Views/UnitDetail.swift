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
    @State var attackText = "-"
    @State var hpText = "-"

    var body: some View {

        HStack {
            Image("legend").resizable().frame(width: 64, height: 64)
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
        }
    }

}

struct  UnitDetail_Previews: PreviewProvider {
    static var previews: some View {
        UnitDetail(detailViewWindow: nil, unit: EntityViewModel(unit: Entity()))
    }
}
