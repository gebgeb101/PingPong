//
//  PlayingView.swift
//  PingPong
//
//  Created by Gabriella Sengkey on 28/07/25.
//

import SwiftUI
import WatchKit

//struct PlayingView: View {
//    var body: some View {
//        
//        var score = 0
//        
//        NavigationStack {
//                    VStack {
//                        NavigationLink("Back", destination: PlayingView())
//                    }
//                    .overlay{
//                    }.navigationTitle("back") .offset(y: -100) // Acts like a navigation bar title
//                }

struct PlayingView: View {
    
    @State private var score = 0
    @State private var setScore = 0

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.primaryRed)
                        .frame(width: 180, height: 90)
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                        .offset(y: 0)
                    
                    VStack {
                        Label {
                            Text("Team Red")
                                .font(.footnote)
                                .fontWeight(.medium)
                        } icon: {
                            Image("LogoPP")
                                .resizable()
                                .frame(width: 10, height: 10)
                            //input logic for logo appear if we choose this team blue
                        }
                        .multilineTextAlignment(.center)
                        .offset(x: -40, y: 0)
                        
                        HStack {
                            Text("\(score)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding()
                                .position(x: 60, y: 25)
                            
                            VStack() {
                                Image(systemName: "plus")
                                    .onTapGesture {
                                        score += 1
                                    }
                                    .padding(40)
                                                                
                                Image(systemName: "minus")
                                    .onTapGesture {
                                        score -= 1
                                    }
                            }
                            .fontWeight(.bold)
                            .position(x: 50, y: 0)
                        }
                    }
                }
                
                HStack {
                    Text("\(setScore)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryRed)
                    //input logic for setScore
                    
                    Text("vs")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("\(setScore)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryBlue)
                    //input logic for setScore
                }
                .multilineTextAlignment(.center)
                .offset(y: 0)

                ZStack {
                    Rectangle()
                        .fill(Color.primaryBlue)
                        .frame(width: 180, height: 70)
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                        .offset(y: 0)
                    
                    VStack {
                        Label {
                            Text("Team Blue")
                                .font(.footnote)
                                .fontWeight(.medium)
                        } icon: {
                            Image("LogoPP")
                                .resizable()
                                .frame(width: 10, height: 10)
                            //input logic for logo appear if we choose this team blue
                        }
                        .multilineTextAlignment(.center)
                        .offset(x: -40, y: 0)
                        
                        HStack {
                            Text("\(score)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding()
                                .position(x: 60, y: 20)
                            
                            VStack() {
                                Image(systemName: "plus")
                                    .onTapGesture {
                                        score += 1
                                    }
                                    .padding(30)
                                                                
                                Image(systemName: "minus")
                                    .onTapGesture {
                                        score -= 1
                                    }
                            }
                            .fontWeight(.bold)
                            .position(x: 50, y: 0)
                        }
                    }
                }
            }
            .navigationTitle {
                Text ("Rematch")
                    .font(.footnote)
                    .offset(x: -100, y: -20)
                    .foregroundColor(.blue)
            }
            .navigationBarBackButtonHidden(false) //native system will provide the chevron left arrow
        }
    }
}

#Preview {
    ContentView()
}
