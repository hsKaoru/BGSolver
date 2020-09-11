//
//  UnitCell.swift
//  SwiftUItTest
//
//  Created by Igor Podolskiy on 11.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct UnitCell: View {

    var unit: Entity?

    var body: some View {
        HStack {
            Image("legend").resizable().frame(width: 96, height: 96).overlay(UnitCellStatBar(value: unit?.attack, type: .attack),alignment: .bottomLeading).overlay(UnitCellStatBar(value: unit?.health, type: .hp),alignment: .bottomTrailing)
        }
    }
}


struct UnitCell_Previews: PreviewProvider {
    static var previews: some View {
        UnitCell(unit: Entity())
    }
}
