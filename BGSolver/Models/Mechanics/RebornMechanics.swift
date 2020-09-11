//
//  RerbornMechanics.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 09.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import Foundation

class RebornMechanics: EntityMeachanics {
    let type: EntityMeachanicsType = .reborn
    let rebornedUnit: Entity

    init(RebornedUnit unit: Entity) {
        self.rebornedUnit = unit
    }

    func triggerMechanics(forBoard board: Board) {
        board.addAtIndexUnit(unit: rebornedUnit.copy(), index: board.lastRemovedUnitIndex)
    }
}
