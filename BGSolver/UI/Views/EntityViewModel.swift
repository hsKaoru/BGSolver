//
//  EntityViewModel.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 14.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import Foundation

class EntityViewModel: ObservableObject {
    let unit: Entity?

    @Published var attack: String = "-"
    @Published var health: String = "-"


    init(unit: Entity?) {
        self.unit = unit
        self.attack = getUnitAttack()
        self.health = getUnitHealth()
    }

    func getUnitAttack() -> String {
        if let attack = unit?.attack {
            return String(attack) }
        return "-"
    }

    func getUnitHealth() -> String {
        if let attack = unit?.attack {
            return String(attack) }
        return "-"
    }

    func increaseAttack() {
        if let unit = unit {
            unit.attack += 1
        }
    }

    func decreaseAttack() {
        if let unit = unit, unit.attack > 0 {
            unit.attack -= 1
        }
    }

    func increaseHealth() {
        if let unit = unit {
            unit.health += 1
        }
    }

    func decreaseHealth() {
        if let unit = unit, unit.attack > 0 {
            unit.health -= 1
        }
    }

}
