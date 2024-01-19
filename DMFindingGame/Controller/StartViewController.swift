

import UIKit

class StartViewController: UIViewController {
    
    let gameBrain = GameBrain.shared
    

    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        highScoreLabel.text = "High Score: \(String(gameBrain.highScore))"
        
    }

    @IBAction func startGameBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "goToGameController", sender: self)
        gameBrain.secondsRemaining = 30
        gameBrain.score = 0
    }
    
    
    
}
