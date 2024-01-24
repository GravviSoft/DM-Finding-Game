//
//  GameViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 2/19/23.


import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet var btnCollection: [UIButton]!
    
    var scoreBoardTimer: Timer!
    var btnColorTimer: Timer!
    let gameBrain = GameBrain.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configureTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scoreBoardTimer.invalidate()
    }
    
    func configureTimer() {
        scoreBoardTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: fireTimer(timer:))
        RunLoop.current.add(scoreBoardTimer, forMode: .common)
    }
    
    func fireTimer(timer: Timer) {
        gameBrain.secondsRemaining -= 1
        secondsLabel.text = "Seconds: \(gameBrain.secondsRemaining)"
        if gameBrain.secondsRemaining <= 0{
            timer.invalidate()
            gameOver()
        }
    }
    
    @IBAction func letterBtn(_ sender: UIButton) {
        let selectedletter = sender.titleLabel!.text!
        if selectedletter == gameBrain.targetLetter{
            gameBrain.letterSelected(letter: selectedletter )
            updateUI()
            sender.backgroundColor = .green
            scoreLabel.text = "Score: \(gameBrain.score)"
        } else{
            sender.backgroundColor = UIColor.red
            updateUI()
        }
        btnColorTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (Timer) in
            sender.backgroundColor = UIColor.systemCyan
        }
    }
    

    @IBAction func backBtn(_ sender: UIButton) {
        gameOver()
    }
    
    func gameOver(){
        self.performSegue(withIdentifier: "backToStartController", sender: self)
        gameBrain.score > gameBrain.highScore ? gameBrain.highScore = gameBrain.score : nil
    }
    
    func updateUI() {
        gameBrain.shuffleNumbers()
        targetLabel.text = gameBrain.targetLetter
        for (index, letter) in gameBrain.randomLetters.enumerated() {
            btnCollection[index].setTitle(letter, for: .normal)
        }
    }
}
