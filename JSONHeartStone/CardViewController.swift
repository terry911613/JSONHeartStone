//
//  CardViewController.swift
//  JSONHeartStone
//
//  Created by 李泰儀 on 2019/5/17.
//  Copyright © 2019 TerryLee. All rights reserved.
//

import UIKit

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

class CardViewController: UIViewController {
    
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var selectedRarity: UISegmentedControl!
    @IBOutlet weak var selectedCost: UISegmentedControl!
    
    var showCards = [Card]()
    
    var commomCards = [Card]()
    var rareCards = [Card]()
    var epicCards = [Card]()
    var legendaryCards = [Card]()
    var allCardsArray = [[Card]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Rarity(rawValue: 0)?.rarity
        
        let urlString = "https://api.hearthstonejson.com/v1/25770/zhTW/cards.json"
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let cards = try decoder.decode([Card].self, from: data)
                        
                        for card in cards{
                            if let rarity = card.rarity{
                                if rarity == Rarity(rawValue: 0)!.rarity{
                                    self.commomCards.append(card)
                                }
                                else if rarity == Rarity(rawValue: 1)!.rarity{
                                    self.rareCards.append(card)
                                }
                                else if rarity == Rarity(rawValue: 2)!.rarity{
                                    self.epicCards.append(card)
                                }
                                else if rarity == Rarity(rawValue: 3)!.rarity{
                                    self.legendaryCards.append(card)
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.allCardsArray.append(self.commomCards)
                            self.allCardsArray.append(self.rareCards)
                            self.allCardsArray.append(self.epicCards)
                            self.allCardsArray.append(self.legendaryCards)
                            for card in self.commomCards{
                                if let cost = card.cost{
                                    if cost == 0{
                                        self.showCards.append(card)
                                    }
                                }
                            }
                            self.title = "COMMOM Cost : 0"
                            self.cardTableView.reloadData()
                        }
                    }
                    catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    @IBAction func raritySegmented(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            getRarityCard(rarity: 0)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : \(selectedCost.selectedSegmentIndex)"
            }
        case 1:
            getRarityCard(rarity: 1)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : \(selectedCost.selectedSegmentIndex)"
            }
        case 2:
            getRarityCard(rarity: 2)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : \(selectedCost.selectedSegmentIndex)"
            }
        case 3:
            getRarityCard(rarity: 3)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : \(selectedCost.selectedSegmentIndex)"
            }
        default:
            break
        }
    }
    func getRarityCard(rarity: Int){
        showCards = [Card]()
        for i in 0...10{
            if selectedCost.selectedSegmentIndex == i{
                for card in allCardsArray[selectedRarity.selectedSegmentIndex]{
                    if let cardCost = card.cost{
                        if cardCost == i{
                            showCards.append(card)
                        }
                    }
                }
                break
            }
        }
        DispatchQueue.main.async {
            self.cardTableView.reloadData()
        }
    }
    
    @IBAction func costSegmented(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getOneToNineCostCard(cost: 0)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : 0"
            }
        case 1:
            getOneToNineCostCard(cost: 1)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : 1"
            }
        case 2:
            getOneToNineCostCard(cost: 2)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : 2"
            }
        case 3:
            getOneToNineCostCard(cost: 3)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : 3"
            }
        case 4:
            getOneToNineCostCard(cost: 4)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : 4"
            }
        case 5:
            getOneToNineCostCard(cost: 5)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : 5"
            }
        case 6:
            getOneToNineCostCard(cost: 6)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : 6"
            }
        case 7:
            getOneToNineCostCard(cost: 7)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : 7"
            }
        case 8:
            getOneToNineCostCard(cost: 8)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : 8"
            }
        case 9:
            getOneToNineCostCard(cost: 9)
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : 9"
            }
        case 10:
            getTenPlusCard()
            if let rarity = Rarity(rawValue: selectedRarity.selectedSegmentIndex)?.rarity{
                self.title = "\(rarity) Cost : 10"
            }
        default:
            break
        }
    }
    func getOneToNineCostCard(cost: Int){
        showCards = [Card]()
        for i in 0...3{
            if selectedRarity.selectedSegmentIndex == i{
                for card in allCardsArray[i]{
                    if let cardCost = card.cost{
                        if cardCost == cost{
                            showCards.append(card)
                        }
                    }
                }
                break
            }
        }
        DispatchQueue.main.async {
            self.cardTableView.reloadData()
        }
    }
    func getTenPlusCard(){
        showCards = [Card]()
        for i in 0...3{
            if selectedRarity.selectedSegmentIndex == i{
                for card in allCardsArray[i]{
                    if let cardCost = card.cost{
                        if cardCost >= 10{
                            showCards.append(card)
                        }
                    }
                }
                break
            }
        }
        DispatchQueue.main.async {
            self.cardTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardDetailSegue"{
            if let indexPath = cardTableView.indexPathForSelectedRow {
                let cardDetailVC = segue.destination as! CardDetailViewController
                cardDetailVC.card = showCards[indexPath.row]
            }
        }
    }
}

extension CardViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardTableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardTableViewCell
        let card = showCards[indexPath.row]
        cell.cardNameLabel.text = card.name
        if let id = card.id{
            let urlString = "https://art.hearthstonejson.com/v1/render/latest/enUS/512x/\(id).png"
            if let url = URL(string: urlString) {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            cell.cardImageView.image = UIImage(data: data)
                        }
                    }
                }
                task.resume()
            }
        }
        return cell
    }
    
}
