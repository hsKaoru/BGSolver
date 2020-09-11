//
//  BattleGround.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 31.08.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//
enum BattleStage {
    case beforeBattleRoundStart
    case battleRoundEnd
}

enum BattleResult {
    case win
    case lose
    case tie
}

class BattleGround {
    var battleLog: BattleLogger = BattleLogger()

    let playerBoard: Board
    let enemyBoard: Board
    var isPlayerGoesFirst: Bool = true

    var playerStartBoard: [Entity] = []
    var enemyStartBoard: [Entity] = []

    var results: [BattleResult:Int] = [.win:0, .lose:0, .tie:0]

    init(playerBoard: Board, enemyBoard: Board) {
        self.playerBoard = playerBoard
        self.enemyBoard = enemyBoard
        for units in playerBoard.units {
            playerStartBoard.append(units.copy())
        }
        for units in enemyBoard.units {
            enemyStartBoard.append(units.copy())
        }
    }

    func startBattle() {
        battleLog.clearLog()
        var battleRound = 0

        switch isPlayerGoesFirst {
        case true:
            while (playerBoard.units.count > 0 && enemyBoard.units.count > 0) {
                if battleRound % 2 == 0 {
                    playBattleRound(attackerBoard: playerBoard, defenderBoard: enemyBoard)
                }
                if battleRound % 2 == 1 {
                    playBattleRound(attackerBoard: enemyBoard, defenderBoard: playerBoard)
                }
                battleRound += 1
            }
        case false:
            while (playerBoard.units.count > 0 && enemyBoard.units.count > 0) {
                if battleRound % 2 == 0 {
                    playBattleRound(attackerBoard: enemyBoard, defenderBoard: playerBoard)
                }
                if battleRound % 2 == 1 {
                    playBattleRound(attackerBoard: playerBoard, defenderBoard: enemyBoard)
                }
                battleRound += 1
            }
        }

        if playerBoard.units.count == 0 && enemyBoard.units.count == 0 {
            results[.tie]! += 1
        } else if playerBoard.units.count == 0  && enemyBoard.units.count > 0 {
            results[.lose]! += 1
        } else if playerBoard.units.count > 0 && enemyBoard.units.count == 0 {
            results[.win]! += 1
        }

        resetBoards()
    }
}

// MARK: - Utills

extension BattleGround {
    private func resetBoards() {
        playerBoard.units = []
        for units in playerStartBoard {
            playerBoard.units.append(units.copy())
        }
        enemyBoard.units = []
        for units in enemyStartBoard {
            enemyBoard.units.append(units.copy())
        }
    }

    private func getOppositeBoard(oppositeFor board: Board) -> Board? {
        guard board.uid == enemyBoard.uid  || board.uid  == playerBoard.uid  else {
            return nil}
        if board.uid  == enemyBoard.uid  {
            return playerBoard
        }
        return enemyBoard
    }
}

// MARK: - Battle Logic

extension BattleGround {
    private func unitsBattle(attacker: Entity, defender: Entity, defenderBoard: Board) {
        attacker.makeBattleWithEnemy(enemy: defender)
        defender.makeBattleWithEnemy(enemy: attacker)

        if attacker.isCleave() {
            for unit in defenderBoard.getUnitNeighbors(unit: defender) {
                unit.causeDamage(damage: attacker.attack)
            }
        }
    }

    private func playBattleRound(attackerBoard: Board, defenderBoard: Board) {
        updateBoardStatus(board: attackerBoard, forStage: .beforeBattleRoundStart)
        updateBoardStatus(board: defenderBoard, forStage: .beforeBattleRoundStart)

        battleLog.addDefaultTitle(title: .battleCycleStart)
        battleLog.addLogInfoForBattleGroundPosition(attackerBoard: attackerBoard, defenderBoard: defenderBoard)

        unitsBattle(attacker: attackerBoard.getAttackerUnitIndex(), defender: defenderBoard.getAttackedUnitIndex(), defenderBoard: defenderBoard)

        updateBoardStatus(board: attackerBoard, forStage: .battleRoundEnd)
        updateBoardStatus(board: defenderBoard, forStage: .battleRoundEnd)

        battleLog.addDefaultTitle(title: .battleCycleEnd)
        battleLog.addLogInfoForBattleGroundPosition(attackerBoard: attackerBoard, defenderBoard: defenderBoard)
    }
}

//MARK: - Boards management

extension BattleGround {
    func updateBoardStatus(board: Board, forStage stage: BattleStage) {
        switch stage {
        case .beforeBattleRoundStart:
            updateBoardStatusBeforeStartRound(board: board)
        case .battleRoundEnd:
            updateBoardStatusForEndRound(board: board)
        }
    }

    func updateBoardStatusBeforeStartRound(board: Board) {
        for unit in board.units {
            if unit.isRivendare() {
                board.isRivendare = true
            }
            for buff in unit.getUnitBuffMechanics() {
                buff.triggerMechanics(forBoard: board, without: unit)
            }
        }
    }

    func updateBoardStatusForEndRound(board: Board) {
        for unit in board.units {
            for buff in unit.getUnitBuffMechanics() {
                buff.debuff(forBoard: board, without: unit)
            }
            if unit.isDie == true {
                board.removeUnit(with: unit.uid)
                triggeredUnitDeathrattles(unit: unit, forBoard: board)

                if let reborn = unit.getRebornMecahnics() {
                    reborn.triggerMechanics(forBoard: board)
                }
            }
        }
    }

    private func triggeredUnitDeathrattles(unit: Entity, forBoard board: Board) {
        for deathrattles in unit.getDeathrattles() {
            if board.isRivendare {
                deathrattles.triggerMechanics(forBoard: board)
                if let oppositeBoard = getOppositeBoard(oppositeFor: board) {
                    deathrattles.triggerMechanicsForOppositeBoard(oppositeBoard: oppositeBoard)
                    updateBoardStatus(board: oppositeBoard, forStage: .battleRoundEnd)
                    updateBoardStatus(board: oppositeBoard, forStage: .beforeBattleRoundStart)
                }
            }
            deathrattles.triggerMechanics(forBoard: board)
            if let oppositeBoard = getOppositeBoard(oppositeFor: board) {
                deathrattles.triggerMechanicsForOppositeBoard(oppositeBoard: oppositeBoard)
                updateBoardStatus(board: oppositeBoard, forStage: .battleRoundEnd)
                updateBoardStatus(board: oppositeBoard, forStage: .beforeBattleRoundStart)
            }
        }
    }
}

// MARK: - Helpers

extension BattleGround {
    func returnResultInPercent() -> String {
        guard let winCount = results[.win] else { return ""}
        guard let loseCount = results[.lose] else { return ""}
        guard let tieCount = results[.tie] else { return ""}

        let sumOfEvents = Double(winCount + loseCount + tieCount)

        return "WIN: " + String(Double(winCount)/(sumOfEvents/100)) + "% "
        + "LOSE: " + String(Double(loseCount)/(sumOfEvents/100)) + "% "
        + "TIE: " + String(Double(tieCount)/(sumOfEvents/100)) + "%"

    }
}

