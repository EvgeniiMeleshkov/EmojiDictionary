//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Евгений Мелешков on 07.10.2021.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var emojis: [Emoji] = [
       Emoji(symbol: "😀",
             name: "Grinning Face",
             description: "A typical smiley face.",
             usage: "happiness"),
       Emoji(symbol: "😕",
             name: "Confused Face",
             description: "A confused, puzzled face.",
             usage: "unsure what to think; displeasure"),
       Emoji(symbol: "😍",
             name: "Heart Eyes",
             description: "A smiley face with hearts for eyes.",
             usage: "love of something; attractive"),
       Emoji(symbol: "🧑‍💻",
             name: "Developer",
             description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).",
             usage: "apps, software, programming"),
       Emoji(symbol: "🐢",
             name: "Turtle",
             description: "A cute turtle.",
             usage: "something slow"),
       Emoji(symbol: "🐘",
             name: "Elephant",
             description: "A gray elephant.",
             usage: "good memory"),
       Emoji(symbol: "🍝",
             name: "Spaghetti",
             description: "A plate of spaghetti.",
             usage: "spaghetti"),
       Emoji(symbol: "🎲",
             name: "Die",
             description: "A single die.",
             usage: "taking a risk, chance; game"),
       Emoji(symbol: "⛺️",
             name: "Tent",
             description: "A small tent.",
             usage: "camping"),
       Emoji(symbol: "📚",
             name: "Stack of Books",
             description: "Three colored books stacked on each other.",
             usage: "homework, studying"),
       Emoji(symbol: "💔",
             name: "Broken Heart",
             description: "A red, broken heart.",
             usage: "extreme sadness"),
       Emoji(symbol: "💤",
             name: "Snore",
             description: "Three blue \'z\'s.",
             usage: "tired, sleepiness"),
       Emoji(symbol: "🏁",
             name: "Checkered Flag",
             description: "A black-and-white checkered flag.",
             usage: "completion"),
       Emoji(symbol: "☘️",
             name: "Green flower",
             description: "Green flower with three lives",
             usage: "to wish a good luck"),
       Emoji(symbol: "🗿",
             name: "A head",
             description: "A big head oof stone",
             usage: "unknown"),
       Emoji(symbol: "🧻",
             name: "Toilet paper",
             description: "The roll of paper",
             usage: "clean your ass"),
       Emoji(symbol: "🐈‍⬛",
             name: "Black Cat",
             description: "Cute black cat",
             usage: "reminde about the cat"),
       Emoji(symbol: "🎃",
             name: "Pumpkin",
             description: "Pumpkin with a face",
             usage: "helloween"),
       Emoji(symbol: "👁",
             name: "Eye",
             description: "Strange eye",
             usage: "watch out"),
       Emoji(symbol: "🥷🏼",
             name: "Ninja",
             description: "Black dressed ninja",
             usage: "be cool"),
       Emoji(symbol: "🌕",
             name: "Full Moon",
             description: "A beautifull full moon",
             usage: "moony night"),
       Emoji(symbol: "❄️",
             name: "Snowflake",
             description: "Cute snowflake",
             usage: "winter is comming"),
       Emoji(symbol: "🎸",
             name: "Guitar",
             description: "Red guitar",
             usage: "rock yeah!")
    ]
    
    
//_____________________________________________________________________________________________
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationItem.leftBarButtonItem = editButtonItem
    }

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    //_____________________________________________________________________________________
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
        
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //_____________________________________________________________________________________
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emoji = emojis[indexPath.row]
        print("\(emoji.symbol) \(indexPath)")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojis.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath)
        let emoji = emojis[indexPath.row]
        cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)"
        cell.detailTextLabel?.text = emoji.description
        // Configure the cell...
        cell.showsReorderControl = true

        return cell
    }
    

    
    
    //_____________________________________________________________________________________
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    @IBSegueAction func addEmoji(_ coder: NSCoder) -> InfoViewController? {
        return InfoViewController(coder: coder, emoji: nil)
    }
    
    @IBSegueAction func editEmoji(_ coder: NSCoder, sender: Any?) -> InfoViewController? {
        let emojiToEdit: Emoji?
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            emojiToEdit = emojis[indexPath.row]
        } else {
            emojiToEdit = nil
        }
        return InfoViewController(coder: coder, emoji: emojiToEdit)
    }
    
    
    @IBAction func reciveTheEmojiObject (segue: UIStoryboardSegue) {
        guard let infoViewController = segue.source as? InfoViewController,
              let emoji = infoViewController.emoji
        else {return}
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
        } else {
            emojis.append(emoji)
        }
    
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
