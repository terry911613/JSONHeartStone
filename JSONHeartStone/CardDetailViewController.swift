//
//  CardDetailViewController.swift
//  JSONHeartStone
//
//  Created by 李泰儀 on 2019/5/17.
//  Copyright © 2019 TerryLee. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardClassLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var textTextView: UITextView!
    
    var text = ""
    var image = UIImage()
    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if let card = card {
            self.cardNameLabel.text = card.name
            self.title = card.name
            for i in 0...9{
                if let cardClass = card.cardClass{
                    if cardClass == CardClass(rawValue: i)?.cardClassEng{
                        self.cardClassLabel.text = CardClass(rawValue: i)?.cardClassTW
                        break
                    }
                }
            }
            if let cost = card.cost{
                self.costLabel.text = "費用 ： \(cost)"
            }
            if let attack = card.attack{
                self.attackLabel.text = "攻擊 ： \(attack)"
            }
            if let health = card.health{
                self.healthLabel.text = "血量 ： \(health)"
            }
            self.textTextView.text = card.text
            if let id = card.id{
                let urlString = "https://art.hearthstonejson.com/v1/render/latest/enUS/512x/\(id).png"
                if let url = URL(string: urlString) {
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                self.cardImageView.image = UIImage(data: data)
                                
                            }
                        }
                        
                    }
                    task.resume()
                }
            }
        }
    }
    
    func clearLabel(){
        cardNameLabel.text = ""
        cardClassLabel.text = ""
        costLabel.text = ""
        attackLabel.text = ""
        healthLabel.text = ""
        textTextView.text = ""
    }
}
