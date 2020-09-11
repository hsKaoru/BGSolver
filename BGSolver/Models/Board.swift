//
//  Board.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 31.08.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//



import Foundation

class Board {
    enum BoardProperties {
        static let boardSize = 7
    }

    let uid: String = UUID().uuidString

    var units: [Entity] = []
    var lastRemovedUnitIndex = 0

    //MARK: - bool board properties

    var isRivendare: Bool = false

    //MARK: - getUnits
    
    func getAttackedUnitIndex() -> Entity {
        return getRandomUnitWithTaunt() ?? units[Int.random(in: 0..<units.count)]
    }

    func getAttackerUnitIndex() -> Entity {
        guard let unitOffset = self.units.firstIndex(where: {$0.isAttack == false}) else {
            for unit in units {
                unit.isAttack = false
            }
            units[0].isAttack = true
            return units[0]
        }
        units[unitOffset].isAttack = true
        return units[unitOffset]
    }

    func getRandomUnit() -> Entity? {
        let notDiedUnits = units.filter { $0.isDie == false }
        if notDiedUnits.count > 0 {
            return notDiedUnits[Int.random(in: 0..<notDiedUnits.count)]
        }
        return nil
    }

    func getRandomUnitWithTaunt() -> Entity? {
        let tauntArray = units.filter { $0.isTaunt == true }
        if tauntArray.count >= 1 {
            return tauntArray[Int.random(in: 0..<tauntArray.count)]
        }
        return nil
    }

    func getUnitNeighbors(unit: Entity) -> [Entity] {
        guard let unitOffset = self.units.firstIndex(where: {$0 == unit}) else { return [] }
        var neighbors: [Entity] = []
        if unitOffset > 0 {
            neighbors.append(units[unitOffset-1])
        }
        if unitOffset < units.count-1 {
            neighbors.append(units[unitOffset+1])
        }
        return neighbors
    }

    //MARK: - units management

    func removeUnit(with uid: String) {
        if let unitOffset = self.units.firstIndex(where: {$0.uid == uid}) {
            self.units.remove(at: unitOffset)
            lastRemovedUnitIndex = unitOffset
        }
    }

    func addUnit(unit: Entity) {
        guard units.count < BoardProperties.boardSize else { return }
        units.append(unit)
    }

    func addAtIndexUnit(unit: Entity, index: Int) {
        guard units.count < BoardProperties.boardSize && index <= units.endIndex else { return }
        units.insert(unit, at: index)
    }

    //MARK: - board management

    //Deprecated

//    func updateBoardStatus(forStage stage: BattleStage) {
//        switch stage {
//        case .beforeBattleRoundStart:
//            updateBoardStatusBeforeStartRound()
//        case .BattleRoundEnd:
//            updateBattleStatusForEndRound()
//        }
//    }
//
//    func updateBoardStatusBeforeStartRound() {
//        for unit in units {
//            if unit.isRivendare() {
//                self.isRivendare = true
//            }
//            for buff in unit.getUnitBuffMechanics() {
//                buff.triggerMechanics(forBoard: self, without: unit)
//            }
//        }
//    }
//
//    func updateBattleStatusForEndRound() {
//        for unit in units {
//            for buff in unit.getUnitBuffMechanics() {
//                buff.debuff(forBoard: self, without: unit)
//            }
//            if unit.isDie == true {
//                removeUnit(with: unit.uid)
//                for deathrattles in unit.getDeathrattles() {
//                    if self.isRivendare {
//                        deathrattles.triggerMechanics(forBoard: self)
//                    }
//                    deathrattles.triggerMechanics(forBoard: self)
//                }
//                if let reborn = unit.getRebornMecahnics() {
//                    reborn.triggerMechanics(forBoard: self)
//                }
//            }
//        }
//    }
}



