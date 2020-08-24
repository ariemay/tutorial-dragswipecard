//
//  ContentView.swift
//  Tutorial-DragSwipeCard
//
//  Created by Arie May Wibowo on 11/08/20.
//  Copyright © 2020 Arie May Wibowo. All rights reserved.
//

import SwiftUI

let ourscreen = UIScreen.main

struct ContentView: View {
    @State var viewState = CGSize.zero
    @State var currentHeight: Int = 0
    
    var body: some View {
        VStack (alignment: .center) {
            ZStack {
                VStack (alignment: .center) {
                    Spacer()
                    Card(open: $currentHeight)
                        .offset(y: viewState.height)
                        .cornerRadius(30)
                        .animation(.spring())
                        .foregroundColor(Color.white)
                        .onAppear(perform: {
                            self.viewState = CGSize(width: 0, height: 400)
                            self.currentHeight = 400
                        })
                        .gesture(DragGesture()
                            .onChanged {
                                value in
                                if (self.viewState.height > -1.0) && (self.currentHeight != 400) {
                                    self.viewState = value.translation
                                } else if (self.currentHeight == 400) && (value.translation.height < 0) && (value.translation.height > -144) {
                                    self.viewState = value.translation
                                }
                        }
                        .onEnded{
                            value in
                            if self.viewState.height > 200 {
                                self.viewState = CGSize(width: 0, height: 400)
                                self.currentHeight = 400
                            } else {
                                self.viewState = CGSize(width: 0, height: 0)
                                self.currentHeight = 0
                            }
                            }
                        )
                }
                .shadow(radius: 50)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct Card: View {
    @State var heightValue = CGFloat(500.0)
    @Binding var open: Int
    
    var body: some View {
        ZStack (alignment: .top) {
            Rectangle()
                .frame(height: self.heightValue, alignment: .bottom)
                .padding(.bottom, (open == 0) ? 0 : 20)
                .padding(.horizontal, (open == 0) ? 0 : 20)
            VStack {
                HStack {
                    ForEach(0..<4) {number in
                        ZStack {
                            Circle()
                                .foregroundColor(Color.red)
                                .frame(width: 80, height: 80, alignment: .center)
                            Text("\(number)")
                        }
                    }
                }
                if open == 0 {
                    HStack {
                        ForEach(4..<8) {number in
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.red)
                                    .frame(width: 80, height: 80, alignment: .center)
                                Text("\(number)")
                            }
                        }
                    }
                    .animation(.easeInOut)
                    HStack {
                        ForEach(0..<4) {_ in
                            Circle()
                                .foregroundColor(Color.red)
                                .frame(width: 80, height: 80, alignment: .center)
                        }
                    }
                    .animation(.easeInOut)
                    HStack {
                        ForEach(0..<4) {_ in
                            Circle()
                                .foregroundColor(Color.red)
                                .frame(width: 80, height: 80, alignment: .center)
                        }
                    }
                    .animation(.easeInOut)
                }
            }
            .padding(.top, 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
