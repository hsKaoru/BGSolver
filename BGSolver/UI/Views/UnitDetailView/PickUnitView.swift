//
//  PickUnitView.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 16.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct PickUnitView: View {
    private enum Options {
        static let maxTier = 6 + 1
        static let iconSymbol = "▼"
        static let frameWidth: CGFloat = 256
        static let frameHeight: CGFloat = 256
        static let imageSize: CGFloat = 24

    }

    @State private var showingPopover:Bool = false

    var count = 5

    var body: some View {
        Button(Options.iconSymbol, action: { self.showingPopover.toggle() })
            .popover(isPresented: self.$showingPopover) {
            List {
                ForEach(1..<Options.maxTier) { tierIndex in
                    Section(header: Text("Tier \(tierIndex) units")) {
                    ForEach(0..<self.count) { index in
                            PickUnitTableRowView()
                        }
                    }
                }
            }.frame(width: Options.frameWidth,
                    height: Options.frameHeight)
        }
    }
}

struct PickUnitTableRowView: View {
    private enum Options {
        static let imageSize: CGFloat = 24
        static let rowFrameWidth: CGFloat = 256
    }

    var body: some View {
        HStack() {
            Button(action: {
                     }) {
                        HStack {
                            Image("legend")
                                .resizable()
                                .frame(width: Options.imageSize,
                                       height: Options.imageSize)
                            Text("Hydra")
                        }.frame(width: Options.rowFrameWidth)

            }.buttonStyle(PickUnitButtonStyle())
        }
    }
}

struct PickUnitButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.blue : Color.clear)
            .foregroundColor(.white)

    }
}

struct PickUnitView_Previews: PreviewProvider {
    static var previews: some View {
        PickUnitView()
    }
}
