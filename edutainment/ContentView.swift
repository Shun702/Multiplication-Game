//
//  ContentView.swift
//  edutainment
//
//  Created by Shun Le Yi Mon on 21/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var maxNum = 5
    @State private var numOfQ = 5
    let numOfQs = [3, 5, 10, 12, 15, 20, 25, 30]
    @State private var QueNo = 0
    @State private var firstNum = 0
    @State private var secNum = 0
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var startFlag = false
    @State private var endgame = false
    @State private var questionNum = [Int]()
    
    @State private var answer = 0
    @State private var correctSelection = false
    @State private var score = 0
    
    @State private var alertTitle = ""
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.purple, .white], startPoint: .top, endPoint: .bottomLeading).ignoresSafeArea()
            VStack {
                Text("Multiplication Game").font(.largeTitle.weight(.bold))
                Spacer()
                Section {
                    Picker("To", selection: $maxNum){
                        ForEach(5..<16){
                            Text("\($0)")
                        }
                    }
                } header: {
                    Text("Select challenge level: 2").fontWeight(.bold)
                }
                Section{
                    //Text("Number of games").font(.headline)
                    Picker("Number of questions", selection: $numOfQ){
                        ForEach(numOfQs, id: \.self){
                            Text($0, format: .number)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Select number of games").fontWeight(.bold)
                }
                Button("Start!") {
                    createNewNum()
                    askQuestion()
                    startFlag = true
                }.padding()
                    .background(Color(red:1, green: 0.5, blue: 0.5))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                Spacer()
                Spacer()
                if startFlag {
                    Text("Select the correct answer").font(.title2.weight(.bold))
                    Text("\(firstNum) x \(secNum)").font(.title.weight(.bold))
                    
                    HStack (spacing: 20){
                        ForEach(0..<3){
                            number in Button(action: {
                                buttonTapped(number)
                            }) {
                                if correctSelection{
                                    //another if and else
                                    //if (do sth with the correct button)
                                    //else(do sth with the rest of the button
                                    if number == correctAnswer {
                                        Circle()
                                            .something()
                                            .overlay(
                                                Text("\(questionNum[number])").foregroundColor(.white).font(.title)
                                            )

                                    }
                                    else {
                                        Circle()
                                            .something()
                                            .overlay(
                                                Text("\(questionNum[number])").foregroundColor(.white).font(.title)
                                            )
                                    }
                                }else{
                                    Circle()
                                        .something()
                                        .overlay(
                                            Text("\(questionNum[number])").foregroundColor(.white).font(.title)
                                        )
                                }
                            }
                        }
                    }
                    Spacer()
                    Spacer()
                    HStack {
                        Text("Socre: ").font(.title.bold())
                        Text(score, format: .number).font(.title.bold())
                    }
                    HStack {
                        Text("Question ").font(.title.bold())
                        Text(QueNo, format: .number).font(.title.bold())
                    }
                    Spacer()
                    Spacer()
                }
            }.padding()
                .alert(alertTitle, isPresented: $endgame) {
                    Button("New Game", action: createNewGame)
                } message: {
                    Text("You got \(score) / \(numOfQ)")
                }
        }
    }
    
    func createNewNum(){
        firstNum = Int.random(in: 0...12)
        secNum = Int.random(in: 2...maxNum+5)
    }
    func askQuestion() {
        answer = firstNum * secNum
        let num1 = Int.random(in: 0...180)
        let num2 = Int.random(in: 0...180)
        if num1 == num2 {
            _ = Int.random(in: 0...180)
        }else {
            questionNum = [answer, num1, num2]
            questionNum.shuffle()
            correctAnswer = questionNum.firstIndex(of: answer) ?? 0
        }
        
    }
    
    func buttonTapped(_ number: Int) {
        QueNo += 1
        if number == correctAnswer {
            score += 1
        }else {
            //wrong answer
            score -= 1
        }
        if QueNo == numOfQ {
            endgame = true
            alertTitling()
        }
        else {
            createNewNum()
            askQuestion()
        }
    }
    
    func createNewGame() {
        startFlag = false
        score = 0
        QueNo = 0
    }
    
    func alertTitling(){
        if score < 0 {
            alertTitle = "You need more practice!"
        }else if score < Int(numOfQ/2) {
            alertTitle = "Good job! Could do better?"
        }else if score > Int(numOfQ/2) && score != numOfQ {
            alertTitle = "Well Done! A few more to get full score!"
        }else if score == numOfQ {
            alertTitle = "Excellent! Are you up for a new challenge?"
        }
        
    }
    
    
    
}

struct buttomView: ViewModifier{
    func body(content: Content) -> some View{
        content
            .foregroundColor(.blue)
            .frame(width: 100, height: 100)
    }
}
extension View {
    func something() -> some View{
        self.modifier(buttomView())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
