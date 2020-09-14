//
//  EntityViewModel.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 14.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import Foundation
import SwiftUI

class EntityViewModel: ObservableObject {
    var unit: Entity?

    @Published var attack: String = "-"
    @Published var health: String = "-"
    @State var isBubble = false
    @Published var isPoisoned = false
    @Published var isTaunt = false


    init(unit: Entity?) {
        self.unit = unit
        updateUnitAttack()
        updateUnitHealth()
    }

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
            self.unit?.isBubble = true
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

    func deleteEntity() {
        self.unit = nil
        updateUnitAttack()
        updateUnitHealth()
    }

}
