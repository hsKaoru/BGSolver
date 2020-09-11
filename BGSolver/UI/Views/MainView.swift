//
//  ContentView.swift
//  SwiftUItTest
//
//  Created by Igor Podolskiy on 11.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct MainView: View {

    @State var resultText = "WIN: 0% LOSE: 0% TIE:0%"

    var body: some View {
        VStack {
            HStack {
                BoardView()
            }
            HStack {
                Button(action: {
                    self.resultText  = self.testBattle()
                }) {
                Text("Start Battle")
                }
                Text(resultText)
            }
            HStack {
                BoardView()
            }
        }
    }
}

struct BoardView: View {
    var body: some View {
        HStack {
            UnitCell()
            UnitCell()
            UnitCell()
            UnitCell()
            UnitCell()
            UnitCell()
            UnitCell()
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    func testBattle() -> String {

        var myBoard = Board()

        myBoard.units = [Entity(race: .murloc, attack: 2, health: 1),Entity(race: .murloc, attack: 2, health: 1),Entity(race: .murloc, attack: 1, health: 1),
                         Entity(attack: 2, health: 2, mechanics: [DeathRattleMechanics(withDamageForOppositeBoard: 4), RebornMechanics(RebornedUnit: Entity(attack: 2, health: 1, mechanics: [DeathRattleMechanics(withDamageForOppositeBoard: 4)]))]),
                         Entity(attack: 2, health: 2, mechanics: [DeathRattleMechanics(withDamageForOppositeBoard: 4)]),
                         Entity(race: .murloc, attack: 3, health: 3, mechanics: [AurasBuffMechanics(forRace: .murloc, attackBuffCount: 2, healthBuffCount: 0)]),
                         Entity(race: .murloc, attack: 3, health: 3, mechanics: [AurasBuffMechanics(forRace: .murloc, attackBuffCount: 2, healthBuffCount: 0)])
        ]

        var opponentBoard = Board()

        opponentBoard.units = [Entity(attack: 4, health: 6, isTaunt: true),
                               Entity(attack: 2, health: 3, mechanics: [DeathRattleMechanics(withSummonedUnit: Entity(attack: 2, health: 1))]),
                               Entity(attack: 2, health: 3, mechanics: [DeathRattleMechanics(withSummonedUnit: Entity(attack: 2, health: 1))]),
                               Entity(attack: 3, health: 3, isTaunt: true, mechanics: [DeathRattleMechanics(withSummonedUnit: Entity(attack: 1, health: 1))]),
                               Entity(attack: 3, health: 3, isTaunt: true, mechanics: [DeathRattleMechanics(withSummonedUnit: Entity(attack: 1, health: 1))]),

        ]

        var BG = BattleGround(playerBoard: myBoard, enemyBoard: opponentBoard)

        for i in 0..<100{
            BG.startBattle()
        }

        print(BG.battleLog.getLog())
        return(BG.returnResultInPercent())
    }
}
