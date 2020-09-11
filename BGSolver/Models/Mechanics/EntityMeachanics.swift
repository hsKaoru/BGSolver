//
//  EntityMeachanics.swift
//  BGSolver
//
//  Created by Igor Podolskiy on 02.09.2020.
//  Copyright © 2020 Igor Podolskiy. All rights reserved.
//

import Foundation

protocol EntityMeachanics {
    var type: EntityMeachanicsType { get }
    func triggerMechanics(forBoard board: Board)
}

enum EntityMeachanicsType {
    case deathrattle
    case buff
    case cleave
    case reborn
}

