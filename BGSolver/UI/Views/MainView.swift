//
//  ContentView.swift
//  SwiftUItTest
//
//  Created by Igor Podolskiy on 11.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct MainView: View {

    let bottomBoardView = BoardView()
    let topBoardView = BoardView()

    @State var resultText = "WIN: 0% LOSE: 0% TIE:0%"

    var body: some View {
        VStack {
            HStack {
                topBoardView
            }
            HStack {
                Button(action: {
                    self.resultText  = self.startBattle(bottomBoard: self.bottomBoardView.getBoard(), topBoard: self.topBoardView.getBoard())
                }) {
                Text("Start Battle")
                }
                Text(resultText)
            }
            HStack {
                bottomBoardView
            }
        }
    }
}


struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    func startBattle(bottomBoard: Board, topBoard: Board) -> String {
        let BG = BattleGround(playerBoard: bottomBoard, enemyBoard: topBoard)
        for _ in 0..<100{
            BG.startBattle()
        }
        print(BG.battleLog.getLog())
        return(BG.returnResultInPercent())
    }

    func testBattle() -> String {

        let myBoard = Board()

        myBoard.units = [Entity(race: .murloc, attack: 2, health: 1),Entity(race: .murloc, attack: 2, health: 1),Entity(race: .murloc, attack: 1, health: 1),
                         Entity(attack: 2, health: 2, mechanics: [DeathRattleMechanics(withDamageForOppositeBoard: 4), RebornMechanics(RebornedUnit: Entity(attack: 2, health: 1, mechanics: [DeathRattleMechanics(withDamageForOppositeBoard: 4)]))]),
                         Entity(attack: 2, health: 2, mechanics: [DeathRattleMechanics(withDamageForOppositeBoard: 4)]),
                         Entity(race: .murloc, attack: 3, health: 3, mechanics: [AurasBuffMechanics(forRace: .murloc, attackBuffCount: 2, healthBuffCount: 0)]),
                         Entity(race: .murloc, attack: 3, health: 3, mechanics: [AurasBuffMechanics(forRace: .murloc, attackBuffCount: 2, healthBuffCount: 0)])
        ]

        let opponentBoard = Board()

        opponentBoard.units = [Entity(attack: 4, health: 6, isTaunt: true),
                               Entity(attack: 2, health: 3, mechanics: [DeathRattleMechanics(withSummonedUnit: Entity(attack: 2, health: 1))]),
                               Entity(attack: 2, health: 3, mechanics: [DeathRattleMechanics(withSummonedUnit: Entity(attack: 2, health: 1))]),
                               Entity(attack: 3, health: 3, isTaunt: true, mechanics: [DeathRattleMechanics(withSummonedUnit: Entity(attack: 1, health: 1))]),
                               Entity(attack: 3, health: 3, isTaunt: true, mechanics: [DeathRattleMechanics(withSummonedUnit: Entity(attack: 1, health: 1))]),

        ]

        let BG = BattleGround(playerBoard: myBoard, enemyBoard: opponentBoard)

        for _ in 0..<100{
            BG.startBattle()
        }

        print(BG.battleLog.getLog())
        return(BG.returnResultInPercent())
    }
}
