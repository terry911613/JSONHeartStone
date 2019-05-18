//
//  CardViewController.swift
//  JSONHeartStone
//
//  Created by 李泰儀 on 2019/5/17.
//  Copyright © 2019 TerryLee. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var cardTableView: UITableView!
    @IBOutlet weak var selectedRarity: UISegmentedControl!
    @IBOutlet weak var selectedCost: UISegmentedControl!
    @IBOutlet weak var selectedCardClass: UISegmentedControl!
    
    var showCards = [Card]()
    
    var commomCards = [Card]()
    var rareCards = [Card]()
    var epicCards = [Card]()
    var legendaryCards = [Card]()
    var allCardsArray = [[Card]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                                if let cost = card.cost, let cardClass = card.cardClass{
                                    if cost == 0 && cardClass == CardClass(rawValue: 0)?.cardClassEng{
                                        self.showCards.append(card)
                                    }
                                }
                            }
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
    @IBAction func cardClassSegmented(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            getCardClass(cardClassNumber: 0)
        case 1:
            getCardClass(cardClassNumber: 1)
        case 2:
            getCardClass(cardClassNumber: 2)
        case 3:
            getCardClass(cardClassNumber: 3)
        case 4:
            getCardClass(cardClassNumber: 4)
        case 5:
            getCardClass(cardClassNumber: 5)
        case 6:
            getCardClass(cardClassNumber: 6)
        case 7:
            getCardClass(cardClassNumber: 7)
        case 8:
            getCardClass(cardClassNumber: 8)
        case 9:
            getCardClass(cardClassNumber: 9)
        default:
            break
        }
    }
    func getCardClass(cardClassNumber: Int){
        showCards = [Card]()
        for i in 0...3{
            if selectedRarity.selectedSegmentIndex == i{
                for k in 0...9{
                    if selectedCost.selectedSegmentIndex == k{
                        for card in allCardsArray[i]{
                            if let cardCost = card.cost, let cardClass = card.cardClass{
                                if cardCost == k && cardClass == CardClass(rawValue: cardClassNumber)?.cardClassEng{
                                    showCards.append(card)
                                }
                            }
                        }
                        break
                    }
                }
                if selectedCost.selectedSegmentIndex == 10{
                    for card in allCardsArray[i]{
                        if let cardCost = card.cost, let cardClass = card.cardClass{
                            if cardCost >= 10 && cardClass == CardClass(rawValue: cardClassNumber)?.cardClassEng{
                                showCards.append(card)
                            }
                        }
                    }
                }
            }
        }
        DispatchQueue.main.async {
            self.cardTableView.reloadData()
        }
    }
    
    @IBAction func raritySegmented(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getRarityCard(rarity: 0)
        case 1:
            getRarityCard(rarity: 1)
        case 2:
            getRarityCard(rarity: 2)
        case 3:
            getRarityCard(rarity: 3)
        default:
            break
        }
    }
    func getRarityCard(rarity: Int){
        showCards = [Card]()
        for k in 0...9{
            if selectedCardClass.selectedSegmentIndex == k{
                for i in 0...9{
                    if selectedCost.selectedSegmentIndex == i{
                        for card in allCardsArray[rarity]{
                            if let cardCost = card.cost, let cardClass = card.cardClass{
                                if cardCost == i && cardClass == CardClass(rawValue: k)?.cardClassEng{
                                    showCards.append(card)
                                }
                            }
                        }
                        break
                    }
                }
                if selectedCardClass.selectedSegmentIndex == 10{
                    for card in allCardsArray[rarity]{
                        if let cardCost = card.cost, let cardClass = card.cardClass{
                            if cardCost >= 10 && cardClass == CardClass(rawValue: k)?.cardClassEng{
                                showCards.append(card)
                            }
                        }
                    }
                    break
                }
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
        case 1:
            getOneToNineCostCard(cost: 1)
        case 2:
            getOneToNineCostCard(cost: 2)
        case 3:
            getOneToNineCostCard(cost: 3)
        case 4:
            getOneToNineCostCard(cost: 4)
        case 5:
            getOneToNineCostCard(cost: 5)
        case 6:
            getOneToNineCostCard(cost: 6)
        case 7:
            getOneToNineCostCard(cost: 7)
        case 8:
            getOneToNineCostCard(cost: 8)
        case 9:
            getOneToNineCostCard(cost: 9)
        case 10:
            getTenPlusCard()
        default:
            break
        }
    }
    func getOneToNineCostCard(cost: Int){
        showCards = [Card]()
        for i in 0...3{
            if selectedRarity.selectedSegmentIndex == i{
                for k in 0...9{
                    if selectedCardClass.selectedSegmentIndex == k{
                        for card in allCardsArray[i]{
                            if let cardCost = card.cost, let cardClass = card.cardClass{
                                if cardCost == cost && cardClass == CardClass(rawValue: k)?.cardClassEng{
                                    showCards.append(card)
                                }
                            }
                        }
                        break
                    }
                }
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
                for k in 0...9{
                    if selectedCardClass.selectedSegmentIndex == k{
                        for card in allCardsArray[i]{
                            if let cardCost = card.cost, let cardClass = card.cardClass{
                                if cardCost >= 10 && cardClass == CardClass(rawValue: k)?.cardClassEng{
                                    showCards.append(card)
                                }
                            }
                        }
                        break
                    }
                }
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
