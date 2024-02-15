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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        updateUI()
        configureTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        scoreBoardTimer.invalidate()
    }
    
    //MARK: - Timer Methods
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
    
    //MARK: - UIButton Method
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
    
    //MARK: - Back Btn
    @IBAction func backBtn(_ sender: UIButton) {
        gameOver()
    }
    
    //MARK: - GameOver Method/Perform Save CoreData
    func gameOver(){
        self.performSegue(withIdentifier: K.backToStartController, sender: self)
        let newScore = Score(context: self.context)
        newScore.score = Int16(gameBrain.score)
        saveScores()
//        gameBrain.score > gameBrain.highScore ? gameBrain.highScore = gameBrain.score : nil
    }
    
    //MARK: - Update UI W/ New Letters
    func updateUI() {
        gameBrain.shuffleNumbers()
        targetLabel.text = gameBrain.targetLetter
        for (index, letter) in gameBrain.randomLetters.enumerated() {
            btnCollection[index].setTitle(letter, for: .normal)
        }
    }
    
    
    //MARK: - Saving Scores To CoreData
    func saveScores(){
        do{
            try context.save()
        } catch{
            print("Error saving scores to CoreData")
        }
    }
}
