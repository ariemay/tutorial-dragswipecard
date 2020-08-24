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
    @State var bottomPadding: CGFloat = 30
    @State var confWidth: CGFloat = ourscreen.bounds.width * 0.9
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Card(open: $currentHeight, confWidth: $confWidth)
                    .offset(y: viewState.height)
                    .animation(.spring())
                    .foregroundColor(Color.white)
                    .cornerRadius(30)
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
                            self.bottomPadding = 30
                            self.confWidth = ourscreen.bounds.width * 0.9
                        } else {
                            self.viewState = CGSize(width: 0, height: 0)
                            self.currentHeight = 0
                            self.bottomPadding = 0
                            self.confWidth = ourscreen.bounds.width
                        }
                        }
                )
            }
            .shadow(radius: 20)
            .padding(.bottom, self.bottomPadding)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct Card: View {
    @State var heightValue = CGFloat(500.0)
    @Binding var open: Int
    @Binding var confWidth: CGFloat
    
    var body: some View {
        ZStack (alignment: .top) {
            Rectangle()
                .frame(width: self.confWidth, height: self.heightValue, alignment: .bottom)
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
                    .animation(.easeIn)
                    HStack {
                        ForEach(0..<4) {_ in
                            Circle()
                                .foregroundColor(Color.red)
                                .frame(width: 80, height: 80, alignment: .center)
                        }
                    }
                    .animation(.easeIn)
                    HStack {
                        ForEach(0..<4) {_ in
                            Circle()
                                .foregroundColor(Color.red)
                                .frame(width: 80, height: 80, alignment: .center)
                        }
                    }
                    .animation(.easeIn)
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
