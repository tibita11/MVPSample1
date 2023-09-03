//
//  LibraryViewPresenter.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/03.
//

import Foundation

protocol LibraryViewPresenterInput: AnyObject {
    var itemData: [[(title: String, imageName: String)]] { get }
}

protocol LibraryViewPresenterOutput: AnyObject {
    
}

final class LibraryViewPresenter {
    private weak var output: LibraryViewPresenterOutput?
    
    init(output: LibraryViewPresenterOutput) {
        self.output = output
    }
}


// MARK: - LibraryViewPresenterInput

extension LibraryViewPresenter: LibraryViewPresenterInput {
    var itemData: [[(title: String, imageName: String)]] {
        [[(title: "マイリスト", imageName: "list.clipboard"),
          (title: "ダウンロード済み", imageName: "arrow.down.to.line")]]
    }
}
