//
//  Card.swift
//  JSONHeartStone
//
//  Created by 李泰儀 on 2019/5/17.
//  Copyright © 2019 TerryLee. All rights reserved.
//

import Foundation

struct Card: Codable {
    var name: String?
    var rarity: String?
    var cost: Int?
    var attack: Int?
    var health: Int?
    var cardClass: String?
    var id: String?
}
