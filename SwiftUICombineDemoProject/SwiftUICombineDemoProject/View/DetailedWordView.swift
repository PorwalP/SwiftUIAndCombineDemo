//
//  DetailedWordView.swift
//  SwiftUICombineDemoProject
//
//  Created by Payal Porwal on 01/04/24.
//

import SwiftUI

struct DetailedWordView: View {
    let selectedWord : String
    @StateObject private var vm = WordDetailsViewModel()
    var body: some View {
        VStack(alignment: .leading){
            if vm.isRefreshing {
                ProgressView()
            } else {
                List {
                    Text("**\(DetailedViewScreenString.word.rawValue)** \(vm.wordData.first?.word ?? "") ")
                    Text("**\(DetailedViewScreenString.sourceUrl.rawValue)** \(vm.wordData.first?.sourceUrls.first ?? "") ")
                    Text("**\(DetailedViewScreenString.licenseName.rawValue)** \(vm.wordData.first?.license.name ?? "")  ")
                    Text("**\(DetailedViewScreenString.licenseURL.rawValue)** \(vm.wordData.first?.license.url ?? "")")
                }
                .listStyle(.plain)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding(.horizontal, 4)
            }
        }
        .onAppear {
            vm.fetchWordDetails(selectedWord: selectedWord)
//            vm.fatchWordDetailsThroughCombine(selectedWord: selectedWord)
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
        }
    }
}


#Preview {
    DetailedWordView(selectedWord: ConstantsString.defaultSelectedWord)
}
