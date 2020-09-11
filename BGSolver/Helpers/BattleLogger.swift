//
//  BattleLogger.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 03.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import Foundation


class BattleLogger {

    enum BattleLogTitles: String {
        case battleCycleStart = "\n!!!BATTLE CYCLE START!!!"
        case battleCycleEnd = "!!!BATTLE CYCLE END!!!"
    }

    private var log: String = ""

    func addUnitLogInfo(unit: Entity, additionalInfo: String = "") {
        log.append("\(additionalInfo) Unit: A:\(unit.attack) H:\(unit.health) B:\(unit.isBubble) T:\(unit.isTaunt) R:\(unit.getRebornMecahnics()) Deathrattle:\(unit.getDeathrattles()) \n")
    }

    func addDefaultTitle(title: BattleLogTitles) {
        log.append(title.rawValue + "\n")
    }

    func addAdditionalInformation(info: String) {
        log.append(info + "\n")
    }

    func getLog() -> String {
        return log
    }

    func clearLog() {
        log = ""
    }

    func addLogInfoForBattleGroundPosition(attackerBoard: Board, defenderBoard: Board ) {
        for unit in attackerBoard.units {
            self.addUnitLogInfo(unit: unit, additionalInfo: "Attacker")
        }

        self.addAdditionalInformation(info: "VS")

        for unit in defenderBoard.units {
             self.addUnitLogInfo(unit: unit, additionalInfo: "Defender")
        }
    }
}
