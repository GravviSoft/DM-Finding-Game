//
//  GameBrain.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/17/23.

import Foundation

class GameBrain {

    static let shared = GameBrain()
    var targetLetter = ""
    var randomLetters = [String]()
    var score = 0
    var highScore = 0
//    var numLetters = 0 - I dont use this in my solution.
    var secondsRemaining = 30
    let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    func generateRandomLetters(numLetters: Int) -> [String] {
        var copyIt = letters
        copyIt.shuffle()
        return Array(copyIt[0...numLetters])
    }
    
    func shuffleNumbers() {
        randomLetters = generateRandomLetters(numLetters: 11)
        targetLetter = randomLetters[Int.random(in: 0...11)]
    }
    
    func newGame(){
        score = 0
        secondsRemaining = 30
    }
    
    func letterSelected(letter: String){
        score += 1
    }
    
}
