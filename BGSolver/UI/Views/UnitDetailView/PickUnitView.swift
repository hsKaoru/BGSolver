//
//  PickUnitView.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 16.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct PickUnitView: View {
    private enum PickUnitViewOptions {
        static let maxTier = 6
        static let iconSymbol = "▼"
    }

    @State private var showingPopover:Bool = false

    var count = 5

    var body: some View {
        Button(PickUnitViewOptions.iconSymbol, action: { self.showingPopover.toggle() })
            .popover(isPresented: self.$showingPopover) {
            List {
                ForEach(1..<PickUnitViewOptions.maxTier+1) { tierIndex in
                    Section(header: Text("Tier \(tierIndex) units")) {
                    ForEach(0..<self.count) { index in
                            PickUnitTableRowView()
                        }
                    }
                }
                }}
    }
}

struct PickUnitTableRowView: View {

    var body: some View {
        HStack() {
            Button(action: {
                print("privet")
                     }) {
                        Text("Show details")
            }.buttonStyle(PickUnitButtonStyle())
        }
    }
}

struct PickUnitButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            //.frame(minWidth: 100, maxWidth: .infinity)
            //.padding()
            .background(configuration.isPressed ? Color.blue : Color.secondary)
            .foregroundColor(.white)
    }
}

struct PickUnitView_Previews: PreviewProvider {
    static var previews: some View {
        PickUnitView()
    }
}
