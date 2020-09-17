//
//  Entity.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 31.08.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import Foundation

enum Race {
    case murloc
    case beast
    case demon
    case dragon
    case pirate
    case mech
    case all
    case neutral
}

class Entity {
    let uid: String = UUID().uuidString

    //MARK: - card properties
    var name: String = ""
    //let techLevel: Int = 1
    let race: Race
    var health: Int
    var attack: Int

    //MARK: - mechanics properties
    var isBubble: Bool
    var isTaunt: Bool
    var isPoisoned: Bool
    var mechanics: [EntityMeachanics]

    //MARK: - unit status properties
    var isAttack = false
    var isDie = false

    //

    init(uid: String = UUID().uuidString,
         race: Race = .neutral,
         attack: Int = 1,
         health: Int = 1,
         isBubble: Bool = false,
         isPoisoned: Bool = false,
         isTaunt: Bool = false,
         mechanics: [EntityMeachanics] = []) {
        self.race = race
        self.health = health
        self.attack = attack
        self.isBubble = isBubble
        self.isPoisoned = isPoisoned
        self.isTaunt = isTaunt
        self.mechanics = mechanics
    }

    // MARK: - Manegement properties

    func die() {
        self.isDie = true
    }

    func causeDamage(damage: Int) {
        self.setUnitHealth(health: calculateUnitHealth(enemy: Entity(attack: damage)))
    }

    func makeBattleWithEnemy(enemy: Entity) {
        self.setUnitHealth(health: calculateUnitHealth(enemy: enemy))
    }

    private func calculateUnitHealth(enemy: Entity) -> Int {
        if self.isBubble && enemy.attack > 0 {
            self.isBubble = false
            return self.health
        }
        if enemy.isPoisoned {
            return 0
        }
        return self.health - enemy.attack
    }

    private func setUnitHealth(health: Int) {
        if health <= 0 {
            self.die()
        } else {
            self.health = health
        }
    }

    // MARK: - Mechanics management

    func getDeathrattles() -> [DeathRattleMechanics] {
        return mechanics.filter { $0.type == .deathrattle }.map { $0 as! DeathRattleMechanics}
    }

    func getUnitBuffMechanics() -> [AurasBuffMechanics] {
        var unitBuffs: [AurasBuffMechanics] = []
        for mechanics in mechanics {
            if mechanics is AurasBuffMechanics {
                unitBuffs.append(mechanics as! AurasBuffMechanics)
            }
        }
        return unitBuffs
    }

    func getRebornMecahnics() -> RebornMechanics? {

        return mechanics.first(where: {$0.type == .reborn}) as? RebornMechanics
    }

    func isRivendare() -> Bool {
        return mechanics.filter { $0 is RivendareMechanics }.count > 0
    }

    func isCleave() -> Bool {
        return mechanics.filter { $0.type == .cleave }.count > 0
    }
}




// MARK: - Helpers
extension Entity {
    func copy() -> Entity {
        return Entity(uid: self.uid,
                      race: self.race,
                      attack: self.attack,
                      health: self.health,
                      isBubble: self.isBubble,
                      isPoisoned: self.isPoisoned,
                      isTaunt: self.isTaunt,
                      mechanics: self.mechanics)
    }
}

extension Entity: Equatable {
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.uid == rhs.uid
    }

}
