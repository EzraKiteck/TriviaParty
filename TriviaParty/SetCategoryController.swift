//
//  SetCategory.swift
//  TriviaParty
//
//  Created by Ezra Kiteck on 10/25/18.
//  Copyright © 2018 Ezra Kiteck. All rights reserved.
//

import UIKit

class SetCategoryController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Makes stuff easier
        let defaults = UserDefaults.standard
        
        //Gets value from the default "dictionary"
        let wins = defaults.integer(forKey: "wins")
        
        //Changes the value in the dictionary for a certain key
        defaults.set(wins + 1, forKey: "wins")
        
    }

    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(sender.tag, forKey: "category")
    }
    
    

}
