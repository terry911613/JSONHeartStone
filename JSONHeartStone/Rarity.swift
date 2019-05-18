//
//  Rarity.swift
//  JSONHeartStone
//
//  Created by 李泰儀 on 2019/5/19.
//  Copyright © 2019 TerryLee. All rights reserved.
//

import Foundation

enum Rarity : Int{
    case COMMON = 0, RARE, EPIC, LEGENDARY
    var rarity: String{
        var text = ""
        switch self {
        case .COMMON:
            text = "COMMON"
        case .RARE:
            text = "RARE"
        case .EPIC:
            text = "EPIC"
        case .LEGENDARY:
            text = "LEGENDARY"
        }
        return text
    }
}
