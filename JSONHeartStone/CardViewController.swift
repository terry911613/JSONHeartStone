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
    
    var showCards = [Card]()
    
    var commomCards = [Card]()
    var rareCards = [Card]()
    var epicCards = [Card]()
    var legendaryCards = [Card]()
    
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
                            self.showCards = self.commomCards
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
            showCards = commomCards
            self.title = Rarity(rawValue: 0)?.rarity
        case 1:
            showCards = rareCards
            self.title = Rarity(rawValue: 1)?.rarity
        case 2:
            showCards = epicCards
            self.title = Rarity(rawValue: 2)?.rarity
        case 3:
            showCards = legendaryCards
            self.title = Rarity(rawValue: 3)?.rarity
        default:
            break
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
