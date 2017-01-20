//
//  TennisKataTests.swift
//  TennisKataTests
//
//  Created by Ophir on 16/12/2016.
//  Copyright © 2016 Epsi. All rights reserved.
//

import XCTest
@testable import TennisKata

extension Int {
    func times(f:()->()) {
        for _ in 0..<self {
            f()
        }
    }
}

class Tennis {
    enum Player {
        case Player1
        case Player2
    }
    
    var points:(player1:Int, player2: Int) = (0, 0)
    
    func scores(player:Player) {
        switch player {
        case .Player1:
            points.player1 = incrementScore(score: points.player1)
        case .Player2:
            points.player2 = incrementScore(score: points.player2)
        }
    }
    
    func incrementScore(score: Int) -> Int {
        return score == 30 ? 40 : score + 15
    }
    
    func pointsString(points: Int) -> String {
        switch points {
        case let p where p > 40:
            return "Adv"
        default:
            return "\(points)"
        }
    }
    
    func score() -> String {
        if points.player1 == points.player2 && points.player1 > 0 {
            return "\(points.player1)A"
        } else {
            return pointsString(points: points.player1) + " - " + pointsString(points: points.player2)
        }
    }
}

class TennisKataTests: XCTestCase {
    var tennis = Tennis()
    
    func player1Scores() {
        tennis.scores(player: .Player1)
    }
    
    func player2Scores() {
        tennis.scores(player: .Player2)
    }
    
    func assert(score: String) {
        XCTAssertEqual(tennis.score(), score)
    }
    
    override func setUp() {
        tennis = Tennis()
    }
    
    func testNoOnePlayed() {
        assert(score:"0 - 0")
    }
    
    func testPlayerOneScores() {
        player1Scores()
        assert(score:"15 - 0")
    }
    
    func testPlayerTwoScores() {
        player2Scores()
        assert(score:"0 - 15")
    }
    
    func testPlayerOneScoresTwice() {
        2.times { self.player1Scores() }
        assert(score:"30 - 0")
    }
    
    func testPlayerOneScoresThreeTimes() {
        3.times { self.player1Scores() }
        assert(score:"40 - 0")
    }
    
    func testPlayersAreEquals() {
        player1Scores()
        player2Scores()
        assert(score: "15A")
    }
    
    func testAdvantage() {
        3.times { self.player1Scores() }
        3.times { self.player2Scores() }
        player1Scores()
        assert(score: "Adv - 40")
    }
}