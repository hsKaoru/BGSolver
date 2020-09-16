//
//  EntityViewModel.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 14.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import Foundation

class EntityViewModel: ObservableObject {
    private var unit: Entity?

    @Published var attack: String = ""
    @Published var health: String = ""

    @Published var isBubble = false {
        didSet {
            unit?.isBubble = self.isBubble
        }
    }
    @Published var isPoisoned = false {
        didSet {
            unit?.isPoisoned = self.isPoisoned
        }
    }
    @Published var isTaunt = false {
        didSet {
            unit?.isTaunt = self.isTaunt
        }
    }

    @Published var mechanicsText: String = ""


    init(unit: Entity?) {
        self.unit = unit
        updateUnitAttack()
        updateUnitHealth()
        mechanicsTextShaping()
    }

    func deleteEntity() {
        self.unit = nil
        updateUnitAttack()
        updateUnitHealth()
        mechanicsTextShaping()
    }

    func isUnitNotNil() -> Bool {
        return self.unit != nil
    }

    func getUnit() -> Entity? {
        return self.unit ?? nil
    }

}

// MARK: - Work with Stats

extension EntityViewModel {
    func updateUnitAttack() {
         if let attack = unit?.attack {
             self.attack = String(attack) } else {
             self.attack = "-" }
     }

     func updateUnitHealth() {
         if let health = unit?.health {
             self.health = String(health) } else {
             self.health = "-" }
     }

     func increaseAttack() {
         if let unit = unit {
             unit.attack += 1
         } else {
             self.unit = Entity(attack: 0, health: 1)
             updateUnitHealth()
         }
         updateUnitAttack()
     }

     func decreaseAttack() {
         if let unit = unit, unit.attack > 0 {
             unit.attack -= 1
         }
         updateUnitAttack()
     }

     func increaseHealth() {
         if let unit = unit {
             unit.health += 1
         } else {
             self.unit = Entity(attack: 0, health: 1)
             updateUnitAttack()
         }
         updateUnitHealth()
     }

     func decreaseHealth() {
         if let unit = unit, unit.health > 1 {
             unit.health -= 1
         }
         updateUnitHealth()
     }

}

// MARK: - Mechanics

extension EntityViewModel {

    func fetchMechanicText(_ mechanic: EntityMeachanics) -> String {
        switch mechanic.type {
        case .deathrattle:
            if let _ = mechanic as? RivendareMechanics {
                return "Your minions trigger their Deathrattles twice"
            }
            return "DeathRattle"
        case .buff:
            if let buff = mechanic as? BuffMechanics {
                return "Give a friendly \(buff.buffedRace) +\(buff.attackBuffCount)/+\(buff.healthBuffCount)"
            }
            return ""
        case .cleave:
            return "Also Damages the minions next to whomever this attacks"
        case .reborn:
            return "Reborn"
        }
    }

    func mechanicsTextShaping() {
        self.mechanicsText = ""
        if let unit = unit {
            for mechanics in unit.mechanics {
                self.mechanicsText.append(fetchMechanicText(mechanics)+"\n")
            }
        }
    }

    func addMechanic(mechanic: EntityMeachanics) {
        if let unit = unit {
            unit.mechanics.append(mechanic)
        }
        mechanicsTextShaping()
    }
}
