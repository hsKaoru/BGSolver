//
//  BoardWiew.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 15.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct BoardView: View {
    let unitCells = [UnitCell(),UnitCell(),UnitCell(),UnitCell(),UnitCell(),UnitCell(),UnitCell()]

    var body: some View {
        HStack {
            ForEach(0..<unitCells.count) { index in
                self.unitCells[index]
            }
        }
    }

    func getBoard() -> Board {
        let board = Board()
        for unitSlot in unitCells {
            if let unit = unitSlot.unit.getUnit() {
                board.addUnit(unit: unit)
            }
        }
        return board
    }
}


struct BoardWiew_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
