//
//  StatsViewController.swift
//  DMFindingGame
//
//  Created by Beau Enslow on 2/14/24.
//

import UIKit
import CoreData

class StatsViewController: UITableViewController {
    
    var scoreArray = [Score]()
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadScores()
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.StatsCellID, for: indexPath)
        let score = scoreArray[indexPath.row]
        cell.textLabel?.text = String(score.score)
        return cell
    }
    
    //MARK: - Delete score when pressed.  TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        context.delete(scoreArray[indexPath.row])
        scoreArray.remove(at: indexPath.row)
        saveCoreData()
    }
    
    //MARK: - Load Scores
    func loadScores(with request: NSFetchRequest<Score> = Score.fetchRequest()){
        
        do {
            scoreArray = try context.fetch(request)
        }catch{
            print("Error fetching all scores.")
        }
    }
    
    //MARK: - Save CoreData Methods
    func saveCoreData(){
        do{
            try context.save()
        }catch{
            print("Error saving delete score core data method.")
        }
        tableView.reloadData()
    }
    
}
