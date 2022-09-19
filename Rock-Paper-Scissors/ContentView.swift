//
//  ContentView.swift
//  Rock-Paper-Scissors
//
//  Created by Jesus Calleja on 13/9/22.
//

import SwiftUI

struct ContentView: View {
    
    private var moves = ["🪨", "🧻", "✂️"]
    @State private var roundCount = 0
    @State private var userScore = 0
    @State private var appMove = Int.random(in: 0..<3)
    @State private var playerWin = Bool.random()
    @State private var showingAlert = false
    private let maxRounds = 10
    
    private func calculateScore(move: String) {
        
        switch self.moves[self.appMove] {
            case "🪨":
                if(self.playerWin) {
                    if(move == "🧻") {
                        self.userScore += 1
                    } else {
                        self.userScore -= 1
                    }
                } else {
                    if(move == "✂️") {
                        self.userScore += 1
                    } else {
                        self.userScore -= 1
                    }
                }
            case "🧻":
            if(self.playerWin) {
                if(move == "✂️") {
                    self.userScore += 1
                } else {
                    self.userScore -= 1
                }
            } else {
                if(move == "🪨") {
                    self.userScore += 1
                } else {
                    self.userScore -= 1
                }
            }
            case "✂️":
            if(self.playerWin) {
                if(move == "🪨") {
                    self.userScore += 1
                } else {
                    self.userScore -= 1
                }
            } else {
                if(move == "🧻") {
                    self.userScore += 1
                } else {
                    self.userScore -= 1
                }
            }
            default:
                return
            
        }
        self.increaseRound()
    }
    
    private func increaseRound() {
        if(self.roundCount >= self.maxRounds) {
            self.showingAlert = true
        } else {
            self.playerWin = Bool.random()
            self.appMove = Int.random(in: 0..<3)
            self.roundCount += 1
        }
    }
    
    private func resetGame() {
        self.roundCount = 0
        self.userScore = 0
    }
    
    
    struct RoundButton: ButtonStyle {
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(40)
                .font(.title)
                .background( Circle()
                    .fill(Color.black))
        }
        
    }
    
    var body: some View {
        
        VStack {
            Text("Round \(self.roundCount) of 10")
                .bold()
                .font(.system(.title))
                .foregroundColor(Color.white)
                .padding()
            Spacer()
            Button(self.moves[self.appMove]){}
                .padding(40)
                .font(.title)
                .background(Rectangle()
                    .fill(Color.yellow))
            Spacer()
            let goal = self.playerWin ? "WIN" : "LOSE"
            Text(goal)
                .bold()
                .font(.system(.title))
                .foregroundColor(Color.white)
                .padding()
            Spacer()
            HStack {
                Spacer()
                Button(self.moves[0]) {
                    self.calculateScore(move: self.moves[0])
                }.buttonStyle(RoundButton())
                Spacer()
                Button(self.moves[1]) {
                    self.calculateScore(move: self.moves[1])
                }.buttonStyle(RoundButton())
                Spacer()
                Button(self.moves[2]) {
                    self.calculateScore(move: self.moves[2])
                }.buttonStyle(RoundButton())
                Spacer()
            }
            Spacer()
            Spacer()
            Text("Score: \(self.userScore)")
                .bold()
                .font(.system(.title))
                .foregroundColor(Color.white)
                .padding()
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        )
        .background(
            LinearGradient(colors: [.red, .black],
                           startPoint: .top,
                           endPoint: .bottom)
        )
        
        
        .alert("Game finished\n Your score is \(self.userScore)", isPresented: $showingAlert) {
            Button("Try Again") {
                self.resetGame()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
