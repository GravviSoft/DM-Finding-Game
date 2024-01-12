//
//  GameViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 2/19/23.
//

import UIKit

class GameViewController: UIViewController {
    
    var targetLetter = ""
    var randomLetters = [String]()
    var score = 0
    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet var btnCollection: [UIButton]!
    
    @IBAction func letterBtn(_ sender: UIButton) {
            calculateNewScore(selectedLetter: sender.titleLabel!.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound() {
        randomLetters = generateRandomLetters(numLetters: 11)
        targetLetter = randomLetters[Int.random(in: 0...11)]
        updateTargetLetterLabel()
        updateLetterButtons()
    }
    
    func generateRandomLetters(numLetters: Int) -> [String] {
        var copyIt = letters
        copyIt.shuffle()
        return Array(copyIt[0...numLetters])
    }
    
    func calculateNewScore(selectedLetter: String) {
        selectedLetter == targetLetter ? updateScoreLabel() : newRound()
    }
    
    func updateTargetLetterLabel() {
        targetLabel.text = targetLetter
    }
    
    func updateScoreLabel() {
        score += 1
        scoreLabel.text = String(score)
        newRound()
    }
    
    func updateLetterButtons() {
        for (index, letter) in randomLetters.enumerated() {
            btnCollection[index].backgroundColor = UIColor.systemCyan
            btnCollection[index].setTitle(letter, for: .normal)
            btnCollection[index].setTitleColor(.white, for: .normal)
            btnCollection[index].titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        }
    }
}
