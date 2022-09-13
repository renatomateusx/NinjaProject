//
//  NinjaModel.swift
//  NinjaOneProject
//
//  Created by Renato Mateus on 12/09/22.
//

import Foundation

// MARK: - Createures
struct Creature: Codable {
    let data: DataClass
}

struct Cat: Codable {
    let data: Equipments
}

struct Item: Codable {
    let data: Equipment
}

// MARK: - DataClass
struct DataClass: Codable {
    let creatures: Creatures?
    let equipment, materials, monsters, treasure: [Equipment]?
}


// MARK: - Creatures
struct Creatures: Codable {
    let food, nonFood: [Equipment]

    enum CodingKeys: String, CodingKey {
        case food
        case nonFood = "non_food"
    }
}

typealias Equipments = [Equipment]
// MARK: - Equipment
struct Equipment: Codable {
    let category: Category
    let commonLocations: [String]?
    let cookingEffect: String?
    let equipmentDescription: String
    let heartsRecovered: Double?
    let id: Int
    let image: String
    let name: String
    let drops: [String]?
    let attack, defense: Int?

    enum CodingKeys: String, CodingKey {
        case category
        case commonLocations = "common_locations"
        case cookingEffect = "cooking_effect"
        case equipmentDescription = "description"
        case heartsRecovered = "hearts_recovered"
        case id, image, name, drops, attack, defense
    }
}

enum Category: String, Codable, CaseIterable {
    case creatures = "creatures"
    case equipment = "equipment"
    case materials = "materials"
    case monsters = "monsters"
    case treasure = "treasure"
}
