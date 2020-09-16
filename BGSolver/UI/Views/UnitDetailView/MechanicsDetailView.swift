//
//  SwiftUIView.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 16.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MechanicsDetailView(unit: EntityViewModel(unit: Entity()))
    }
}
