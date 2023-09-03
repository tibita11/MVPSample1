//
//  SearchViewPresenter.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/02.
//

import Foundation

protocol SearchViewPresenterInput {
    var category: [Category] { get }
    func getSection(at indexPath: IndexPath)
}

protocol SearchViewPresenterOutput: AnyObject {
    func transitionToNext(itemSection: ItemSection)
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
    
    func getSection(at indexPath: IndexPath) {
        let section = Category.getSection(at: indexPath)
        output?.transitionToNext(itemSection: section)
    }
}
