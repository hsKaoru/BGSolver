//
//  UnitCell.swift
//  SwiftUItTest
//
//  Created by Igor Podolskiy on 11.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

func showUnitDetailWindow(unit: EntityViewModel) {
    let mouseLocation = NSEvent.mouseLocation
    var windowRef:NSWindow
    windowRef = NSWindow(
        contentRect: NSRect(x: mouseLocation.x+24, y: mouseLocation.y, width: 100, height: 100),
        styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
        backing: .buffered, defer: false)
    windowRef.contentView = NSHostingView(rootView: UnitDetail(detailViewWindow: windowRef, unit: unit))
    windowRef.makeKeyAndOrderFront(nil)
}

struct UnitCell: View {

    @ObservedObject var unit: EntityViewModel = EntityViewModel(unit: nil)

    var body: some View {
        HStack {
            Image("legend")
                .resizable()
                .frame(width: 96, height: 96)
                .overlay(UnitCellStatBar(value: unit.attack, type: .attack),alignment: .bottomLeading)
                    .overlay(UnitCellStatBar(value: unit.health, type: .hp),alignment: .bottomTrailing)
                .gesture(TapGesture().onEnded({ showUnitDetailWindow(unit: self.unit)}))
        }
    }
}


struct UnitCell_Previews: PreviewProvider {
    static var previews: some View {
        UnitCell(unit: EntityViewModel(unit: Entity()))
    }
}
