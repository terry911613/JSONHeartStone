//
//  CardClass.swift
//  JSONHeartStone
//
//  Created by 李泰儀 on 2019/5/19.
//  Copyright © 2019 TerryLee. All rights reserved.
//

import Foundation

enum CardClass : Int{
    case NEUTRAL = 0, MAGE, PRIEST, ROGUE, DRUID, HUNTER, WARRIOR, SHAMAN, WARLOCK, PALADIN
    var cardClassEng: String{
        var text = ""
        switch self {
        case .NEUTRAL:
            text = "NEUTRAL"
        case .MAGE:
            text = "MAGE"
        case .PRIEST:
            text = "PRIEST"
        case .ROGUE:
            text = "ROGUE"
        case .DRUID:
            text = "DRUID"
        case .HUNTER:
            text = "HUNTER"
        case .WARRIOR:
            text = "WARRIOR"
        case .SHAMAN:
            text = "SHAMAN"
        case .WARLOCK:
            text = "WARLOCK"
        case .PALADIN:
            text = "PALADIN"
        }
        return text
    }
    var cardClassTW: String{
        var text = ""
        switch self {
        case .NEUTRAL:
            text = "中立"
        case .MAGE:
            text = "法師"
        case .PRIEST:
            text = "牧師"
        case .ROGUE:
            text = "盜賊"
        case .DRUID:
            text = "德魯伊"
        case .HUNTER:
            text = "獵人"
        case .WARRIOR:
            text = "戰士"
        case .SHAMAN:
            text = "薩滿"
        case .WARLOCK:
            text = "術士"
        case .PALADIN:
            text = "聖騎士"
        }
        return text
    }
}
