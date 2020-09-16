//
//  PickUnitView.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 16.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

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

struct PickUnitView_Previews: PreviewProvider {
    static var previews: some View {
        PickUnitView()
    }
}
