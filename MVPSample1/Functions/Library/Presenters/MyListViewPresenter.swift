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
    func fetchObject(searchWord: String)
}

protocol MyListViewPresenterOutput: AnyObject {
    /// CollectionViewに反映する
    func applySnapshot(items: [ItemData])
}

class MyListViewPresenter {
    private weak var output: MyListViewPresenterOutput?
    private var itemCache: [ItemData] = []
    
    init(output: MyListViewPresenterOutput) {
        self.output = output
    }
}


// MARK: - MyListViewPresenterInput

extension MyListViewPresenter: MyListViewPresenterInput {
    var items: [ItemData] {
        itemCache
    }
    
    func fetchArray() {
        let myList: [MyList] = CoreDataRepository.array()
        let items = myList.map{ItemData(id: $0.id, title: $0.title ?? "", description: $0.detail ?? "")}
        itemCache = items
        output?.applySnapshot(items: items)
    }
    
    func fetchObject(searchWord: String) {
        guard let myList: [MyList] = CoreDataRepository.fetchObject<MyList>(searchWord: searchWord) else {
            // MEMO: 検索結果がない場合、空で返す
            itemCache = []
            output?.applySnapshot(items: [])
            return
        }
        let items = myList.map{ItemData(id: $0.id, title: $0.title ?? "", description: $0.detail ?? "")}
        itemCache = items
        output?.applySnapshot(items: items)
    }
}
