//
//  WorksDetailViewPresenter.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/05.
//

import Foundation

protocol WorksDetailViewPresenterInput: AnyObject {
    var title: String { get }
    var description: String { get }
    var isRegistered: Bool { get }
    func changeMyListStatus()
}

protocol WorksDetailViewPresenterOutput: AnyObject {
    /// マイリストの状況をUIに反映する
    func updateMyList(isRegistered: Bool)
}

class WorksDetailViewPresenter {
    private weak var output: WorksDetailViewPresenterOutput?
    private let itemData: ItemData!
    
    init(output: WorksDetailViewPresenterOutput, itemData: ItemData) {
        self.output = output
        self.itemData = itemData
    }
}


// MARK: - WorksDetailViewPresenterInput

extension WorksDetailViewPresenter: WorksDetailViewPresenterInput {
    var title: String {
        itemData.title
    }
    
    var description: String {
        itemData.description
    }
    
    var isRegistered: Bool {
        // MEMO: idを検索する
        let coreData: MyList? = CoreDataRepository.fetchObject(id: itemData.id)
        return coreData != nil
    }
    
    func changeMyListStatus() {
        if isRegistered {
            // MEMO: 登録済みの場合は、マイリストから削除する
            if let myList: MyList = CoreDataRepository.fetchObject(id: itemData.id) {
                CoreDataRepository.delete(myList)
            }
        } else {
            // MEMO: 未登録の場合は、マイリストに追加する
            CoreDataRepository.add(MyList.new(itemData: itemData))
            CoreDataRepository.save()
        }
        // MEMO: UIに反映
        output?.updateMyList(isRegistered: self.isRegistered)
    }
}
