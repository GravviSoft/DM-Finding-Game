////
////  LetterGameBrain.swift
////  DMFindingGame
////
////  Created by Beau Enslow on 1/16/24.
//
//
//import Foundation
//
//
//struct GameBrain{
//    var targetLetter = ""
//    var randomLetters = [String]()
//    var score = 0
//    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
//    
//    func generateRandomLetters(numLetters: Int) -> [String] {
//        var copyIt = letters
//        copyIt.shuffle()
//        return Array(copyIt[0...numLetters])
//    }
//    
//    mutating func shuffleNumbers() {
//        randomLetters = generateRandomLetters(numLetters: 11)
//        targetLetter = randomLetters[Int.random(in: 0...11)]
//    }
//    
//    
//    mutating func updateScore() -> String {
//        score += 1
//        return String(score)
//    }
//    
//    func updateTargetLetterLabel() -> String{
//        return targetLetter
//    }
//       
//    
//}
