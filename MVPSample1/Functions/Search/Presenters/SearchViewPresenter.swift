//
//  SearchViewPresenter.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/02.
//

import Foundation

protocol SearchViewPresenterInput {
    var category: [Category] { get }
}

protocol SearchViewPresenterOutput: AnyObject {
    
}

final class SearchViewPresenter {
    private weak var output: SearchViewPresenterOutput?
    
    init(output: SearchViewPresenterOutput) {
        self.output = output
    }
}


// MARK: - SearchViewPresenterInput

extension SearchViewPresenter: SearchViewPresenterInput {
    var category: [Category] {
        Category.createCategory()
    }
}
