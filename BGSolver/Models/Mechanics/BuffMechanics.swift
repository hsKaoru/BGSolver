//
//  BuffMechanics.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 07.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import Foundation

class BuffMechanics: EntityMeachanics {

    let type: EntityMeachanicsType = .buff

    let buffedRace: Race

    let attackBuffCount: Int
    let healthBuffCount: Int

    init(forRace race: Race, attackBuffCount: Int = 0, healthBuffCount: Int = 0) {
        self.buffedRace = race
        self.healthBuffCount = healthBuffCount
        self.attackBuffCount = attackBuffCount
    }

    func triggerMechanics(forBoard board: Board) {
        for unit in board.units {
            if unit.race == buffedRace || buffedRace == .neutral {
                unit.attack += attackBuffCount
                unit.health += healthBuffCount
            }
        }
    }

    func debuff(forBoard board: Board) {
        for unit in board.units {
            if unit.race == buffedRace || buffedRace == .neutral {
                unit.attack -= attackBuffCount
                unit.health -= healthBuffCount
            }
        }
    }
}

class AurasBuffMechanics: BuffMechanics {
    //TODO: - does not work correctly for summoned Units
    func triggerMechanics(forBoard board: Board, without buffUnit: Entity) {
        for unit in board.units {
            if unit.race == buffedRace && unit != buffUnit
                || buffedRace == .neutral && unit != buffUnit {
                unit.attack += attackBuffCount
                unit.health += healthBuffCount
            }
        }
    }

    func debuff(forBoard board: Board, without buffUnit: Entity) {
        for unit in board.units {
            if unit.race == buffedRace && unit != buffUnit
                || buffedRace == .neutral && unit != buffUnit {
                unit.attack -= attackBuffCount
                unit.health -= healthBuffCount
            }
        }
    }
}
