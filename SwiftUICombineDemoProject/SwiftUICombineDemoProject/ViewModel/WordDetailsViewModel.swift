//
//  WordDetailsViewModel.swift
//  SwiftUICombineDemoProject
//
//  Created by Payal Porwal on 01/04/24.
//


import Foundation
import Combine


final class WordDetailsViewModel: ObservableObject {
    @Published var wordData: [WordDetailsModel] = []
    @Published var hasError = false
    @Published var error: FailureTypeError?
    @Published private(set) var isRefreshing = false
    private var bag = Set<AnyCancellable>()
    typealias DTP = AnyPublisher <
         URLSession.DataTaskPublisher.Output,
         URLSession.DataTaskPublisher.Failure
     >
    
    func fetchWordDetails(selectedWord: String) {
        let urlString = "\(ConstantsString.serverBaseUrl)\(selectedWord)"
        if let jsonUrl = URL(string: urlString) {
            self.isRefreshing = true
            getDetails(url: jsonUrl)
        }
    }
    
    func getDetails(url: URL) {
        let pub = self.dataTaskPublisher(for: url)
        self.createPipelineFromPublisher(pub: pub)
    }
    
    func dataTaskPublisher(for url: URL) -> DTP {
           URLSession.shared.dataTaskPublisher(for: url).eraseToAnyPublisher()
       }
    
    func createPipelineFromPublisher(pub: DTP) {
         pub
            .tryMap({ res in
                guard let response = res.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                    throw FailureTypeError.invalidStatusCode
                }
                guard let wordDetails = try? JSONDecoder().decode([WordDetailsModel].self, from: res.data) else {
    
                    throw FailureTypeError.failedToDecode
                }
                return wordDetails
            })
             .receive(on: DispatchQueue.main)
             .sink { [weak self] res in
                 defer { self?.isRefreshing = false }
                 switch res {
                 case .failure(let error):
                     self?.hasError = true
                     self?.error = FailureTypeError.custom(error: error)
                 default:
                     break
                     
                 }
             } receiveValue: { [weak self] wordDatas in
                 self?.wordData = wordDatas
             }
             .store(in: &self.bag)
     }
}


extension WordDetailsViewModel {
    enum FailureTypeError: LocalizedError {
        case failedToDecode
        case custom(error: Error)
        case invalidStatusCode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return ErrorStrings.failedToDecode.rawValue
            case .custom(let error):
                return error.localizedDescription
            case .invalidStatusCode:
                return ErrorStrings.invalidStatusCode.rawValue
                
            }
        }
    }
}
