//
//  ContentView.swift
//  Fortunator
//
//  Created by Jack Smoot on 3/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Fortune Cookie")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
                .padding()
            
            Image("fortunecookie")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
                        
            Button(action: {
                print("Fortune told!")
            }) {
                Text("Get Fortune")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(30)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
