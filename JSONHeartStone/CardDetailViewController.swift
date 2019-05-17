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
    
    var text = ""
    var image = UIImage()
    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if let card = card {
            self.cardNameLabel.text = card.name
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
}
