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

struct MechanicsDetailView: View {
    @ObservedObject var unit: EntityViewModel
    @State private var showingPopover:Bool = false

    var body: some View {
        HStack {
        ScrollView {
            Text(unit.mechanicsText).foregroundColor(Color.gray).padding(1).frame(width:215)
            }.frame(width: 220, height: 80).border(Color.gray, width: 1)
            Button("Add Mechanics", action: {
                if self.unit.isUnitNotNil() {
                    self.showingPopover.toggle()}}).popover(isPresented: self.$showingPopover) { VStack { Button(action: {
                                       self.unit.addMechanic(mechanic: DeathRattleMechanics(withSummonedUnit: Entity(race: .mech), count: 3))
                                       self.showingPopover = false
                                   }) {
                                       Text("Replicator")
                                   }
                                   Button(action: {
                                        self.unit.addMechanic(mechanic: DeathRattleMechanics(withSummonedUnit: Entity(race: .mech), count: 3))
                                       self.showingPopover = false
                                   }) {
                                       Text("Golden Replicator")
                                   }
                        }
            }
        }
    }
}

struct PickUnitView: View {
    @State private var showingPopover:Bool = false

    enum TableOptions {
        static let maxTier = 6
    }

    var count = 5

    var body: some View {
        Button("▼", action: { self.showingPopover.toggle() })
            .popover(isPresented: self.$showingPopover) {
            List {
                ForEach(1..<TableOptions.maxTier+1) { tierIndex in
                    Section(header: Text("Tier \(tierIndex) units")) {
                    ForEach(0..<self.count) { index in
                        HStack{
                        Text("ME")
                        Text("PickMe")}
                        }
                    }
                }
                }}
    }
}

//ForEach(httpSections) { section in
//    Section(header: SectionHeaderView(section: section)) {
//        ForEach(section.statuses) { status in
//            NavigationLink(destination: DetailView(httpStatus: status)) {
//                TableRowView(status: status)
//            }
//        }
//    }
//}


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
