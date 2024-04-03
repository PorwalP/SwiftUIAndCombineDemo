//
//  TestWordDetailsViewModel.swift
//  SwiftUICombineDemoProjectTests
//
//  Created by Payal Porwal on 03/04/24.
//

import Foundation
import XCTest
import Combine
@testable import SwiftUICombineDemoProject


final class TestWordDetailsViewModel: XCTestCase {
    
    var viewModel: WordDetailsViewModel?
    private var subscriptions = Set<AnyCancellable>()
    override func setUpWithError() throws {
        self.viewModel = WordDetailsViewModel()
    }
    
    override func tearDownWithError() throws {
        self.viewModel = nil
    }
    
    func dataTaskPublisherMock(data: Data) -> WordDetailsViewModel.DTP {
        let fakeResult = (data, URLResponse())
        let pub = Just<URLSession.DataTaskPublisher.Output>(fakeResult)
            .setFailureType(to: URLSession.DataTaskPublisher.Failure.self)
        return pub.eraseToAnyPublisher()
    }

    func testWordFetchPipline(){
        if let bundlePath = Bundle.main.path(forResource: "wordDetails", ofType: "json"),
           let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) {
            let pub = dataTaskPublisherMock(data: jsonData)
            viewModel?.createPipelineFromPublisher(pub: pub)
            let pred = NSPredicate { viewModel, _ in (viewModel as? WordDetailsViewModel)?.wordData != nil }
            let expectation = XCTNSPredicateExpectation(predicate: pred, object: viewModel)
            self.wait(for: [expectation], timeout: 10)
            let wordData = try? XCTUnwrap(viewModel?.wordData)
        }
    }
}
