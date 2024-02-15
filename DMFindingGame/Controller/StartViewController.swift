

import UIKit
import CoreData

class StartViewController: UIViewController {
    
    let gameBrain = GameBrain.shared
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var highScoreLabel: UILabel!
    
    var myArray = [Score]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHighScore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Start Game Btn Method
    @IBAction func startGameBtn(_ sender: Any) {
        self.performSegue(withIdentifier: K.goToGameController, sender: self)
        gameBrain.newGame()
    }
    
    //MARK: - Load HighScore Method
    func loadHighScore(with request: NSFetchRequest<Score> = Score.fetchRequest()){
        request.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        request.fetchLimit = 1
        do{
            myArray = try context.fetch(request)
            if let highScoreYo = myArray.first?.score{
                print(highScoreYo)
                highScoreLabel.text =  "High Score: \(highScoreYo)"
            }
        } catch{
            print("Error fetching high score.")
        }
    }
    
}
