//
//  PlayingView.swift
//  PingPong
//
//  Created by Gabriella Sengkey on 28/07/25.
//

import SwiftUI
import WatchKit

struct PlayingView: View {
    
    @State private var scoreRed = 0
    @State private var scoreBlue = 0
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
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 5) {
                            Text("Team Red")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .padding(.leading, 20)
                            //input logic for red appear on top if we choose this team red
                            
                            Image("LogoPP")
                                .resizable()
                                .frame(width: 10, height: 10)
                            //input logic for logo appear if we choose this team red
                        }
                        
                        HStack(spacing: 20) {
                            HStack {
                                Image(systemName: "minus")
                                    .font(.title2)
                                    .onTapGesture {
                                        scoreRed -= 1
                                    }
                            }
                            .position(x: 50, y: 30)
                            
                            HStack {
                                Text("\(scoreRed)")
                                    .font(.largeTitle)
                            }
                            .position(x: 25, y: 30)
                            
                            HStack {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .onTapGesture {
                                        scoreRed += 1
                                    }
                            }
                            .position(x: 0, y: 30)
                        }
                        .fontWeight(.bold)
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
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 5) {
                            Text("Team Blue")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .padding(.leading, 20)
                            //input logic for blue appear on top if we choose this team blue
                            
                            Image("LogoPP")
                                .resizable()
                                .frame(width: 10, height: 10)
                            //input logic for logo appear if we choose this team blue
                        }
                        
                        HStack(spacing: 20) {
                            HStack {
                                Image(systemName: "minus")
                                    .font(.title2)
                                    .onTapGesture {
                                        scoreBlue -= 1
                                    }
                            }
                            .position(x: 50, y: 20)
                            
                            HStack {
                                Text("\(scoreBlue)")
                                    .font(.largeTitle)
                            }
                            .position(x: 25, y: 20)
                            
                            HStack {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .onTapGesture {
                                        scoreBlue += 1
                                    }
                            }
                            .position(x: 0, y: 20)
                        }
                        .fontWeight(.bold)
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
    PlayingView()
}
