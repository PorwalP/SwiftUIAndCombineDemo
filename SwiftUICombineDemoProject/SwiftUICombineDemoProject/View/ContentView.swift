//
//  ContentView.swift
//  SwiftUICombineDemoProject
//
//  Created by Payal Porwal on 01/04/24.
//

import SwiftUI

struct ContentView: View {
       var body: some View {
        NavigationStack {
            List(Constant.words, id: \.self){ word in
                    HStack {
                        Text(word)
                        NavigationLink(destination: DetailedWordView(selectedWord: word)) {
                        }
                    }
                }
                .font(.subheadline)
                .bold()
                .contentShape(Rectangle())
                .listStyle(.plain)
                .navigationTitle(ConstantsString.navigationTitle)
            }
            .padding()
        }
    }
#Preview {
    ContentView()
}
