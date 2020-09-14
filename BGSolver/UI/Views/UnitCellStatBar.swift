//
//  UnitCellStatBar.swift
//  SwiftUItTest
//
//  Created by Igor Podolskiy on 11.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct UnitCellStatBar: View {

    enum UnitBarType {
        case attack
        case hp
    }

    let value: Int
    let type: UnitBarType

    var body: some View {
            Circle()
               .strokeBorder(Color.black,lineWidth: 4)
                .background(Circle().foregroundColor(getColorForBarType(type))).frame(width: 42, height: 42)
                .overlay(Text(getValue(value))
                    .foregroundColor(Color.black)
                    .lineLimit(1))
                    .font(.system(size: 18))
    }

    func getColorForBarType(_ type: UnitBarType) -> Color {
        switch type {
            case .attack:
                return Color.yellow
            case .hp:
                return Color.red
        }
    }

    func getValue(_ value: Int?) -> String {
        if let value = value {
            return String(value)
        }
        return "-"
    }
}

struct UnitCellStatBar_Previews: PreviewProvider {
    static var previews: some View {
        UnitCellStatBar(value: 3, type: .hp)
    }
}


