//
//  Deat.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 07.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import Foundation

class DeathRattleMechanics: EntityMeachanics {

    let type: EntityMeachanicsType = .deathrattle

    let summonedUnitType: Entity?
    let summonedUnitCount: Int?

    let buffType: BuffMechanics?

    let damageForUnit: Int?
    let damagedUnitCount: Int?

    init(withSummonedUnit unit: Entity, count: Int = 1) {
        self.summonedUnitType = unit
        self.summonedUnitCount = count
        self.buffType = nil
        self.damageForUnit = nil
        self.damagedUnitCount = nil
    }

    init(withBuff buff: BuffMechanics) {
        self.summonedUnitType = nil
        self.summonedUnitCount = nil
        self.damageForUnit = nil
        self.damagedUnitCount = nil
        self.buffType = buff
    }

    init(withDamageForOppositeBoard damage: Int, count: Int = 1) {
        self.summonedUnitType = nil
        self.summonedUnitCount = nil
        self.damageForUnit = damage
        self.damagedUnitCount = count
        self.buffType = nil
    }

    func triggerMechanics(forBoard board: Board) {
        if let summon = summonedUnitType, let count = summonedUnitCount {
            for _ in 0..<count {
                board.addAtIndexUnit(unit: summon.copy(), index: board.lastRemovedUnitIndex)
            }
        }
        if let buff = buffType {
            buff.triggerMechanics(forBoard: board)
        }
    }

    func triggerMechanicsForOppositeBoard(oppositeBoard board: Board) {
        if let damage = damageForUnit, let count = damagedUnitCount {
            if count == 7 {
                for unit in board.units {
                    unit.causeDamage(damage: damage)
                }
                return
            }
            for _ in 0..<count {
                if let unit = board.getRandomUnit() {
                    unit.causeDamage(damage: damage)
                }
            }
        }
    }
}

class RivendareMechanics: EntityMeachanics {

    let type: EntityMeachanicsType = .deathrattle

    func triggerMechanics(forBoard board: Board) {
        board.isRivendare = false
    }


}
