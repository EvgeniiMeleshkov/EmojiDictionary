//
//  InfoViewController.swift
//  EmojiDictionary
//
//  Created by Евгений Мелешков on 08.10.2021.
//

import UIKit

class InfoViewController: UIViewController {

    var emoji: Emoji?
    init?(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet var symbolTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var usageTextField: UITextField!
    
    
    
//_________________________________________________________________________________________
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        // Do any additional setup after loading the view.
    }
//_________________________________________________________________________________________

    func updateView() {
        if let emoji = emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
        }
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let symbol = symbolTextField.text,
        let name = nameTextField.text,
        let description = descriptionTextField.text,
        let usage = usageTextField.text else {return}
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
        
        performSegue(withIdentifier: "recive", sender: self)
    }
    

}
