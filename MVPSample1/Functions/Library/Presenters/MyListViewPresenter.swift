//
//  MyListViewPresenter.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/06.
//

import Foundation

enum Section {
    case main
}

protocol MyListViewPresenterInput: AnyObject {
    var items: [ItemData] { get }
    func fetchArray()
}

protocol MyListViewPresenterOutput: AnyObject {
    /// CollectionViewに反映する
    func applySnapshot(items: [ItemData])
}

class MyListViewPresenter {
    private weak var output: MyListViewPresenterOutput?
    
    init(output: MyListViewPresenterOutput) {
        self.output = output
    }
}


// MARK: - MyListViewPresenterInput

extension MyListViewPresenter: MyListViewPresenterInput {
    var items: [ItemData] {
        let myList: [MyList] = CoreDataRepository.array()
        return myList.map{ItemData(id: $0.id, title: $0.title ?? "", description: $0.detail ?? "")}
    }
    
    func fetchArray() {
        output?.applySnapshot(items: items)
    }
}
