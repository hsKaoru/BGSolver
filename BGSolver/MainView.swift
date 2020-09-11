//
//  ContentView.swift
//  SwiftUItTest
//
//  Created by Igor Podolskiy on 11.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            HStack {
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
                UnitCell()
            }
            HStack {
                Button(action: { self.testBattle() }) {
                Text("Start battle")
                }
                ResultTextView()
            }
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

    func testBattle() {

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
        print(BG.returnResultInPercent())

    }
}

struct ResultTextView: View {
    var result: String?
    var body: some View {
        Text(textForResult(text: result))
    }

    func textForResult(text: String?) -> String {
        if let text = text {
            return text
        }
        return "WIN: " + "0" + "% "
        + "LOSE: " + "0" + "% "
        + "TIE: " + "0" + "%"
    }
}


struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
