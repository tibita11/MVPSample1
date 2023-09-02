//
//  SampleItem.swift
//  MVPSample1
//
//  Created by 鈴木楓香 on 2023/09/01.
//

import Foundation

struct Category {
    let title: String
    let itemSection: [ItemSection]
    
    static func createCategory() -> [Category] {
        let category = [
            Category(title: "ビデオ", itemSection: [
                ItemSection(title: "洋画一覧", items: [
                    ItemData(title: "ザ・スーパーマリオブラザーズ・ムービー", description: "スーパーマリオブラザーズの世界を原作してアニメ化！")
                ]),
                ItemSection(title: "アニメ一覧", items: [
                    ItemData(title: "無職転生Ⅱ~異世界行ったら本気だす~", description: "歩みだそう。再び立ち上がるために。異世界転生ファンタジー第2弾！"),
                    ItemData(title: "私の幸せな結婚", description: "これは、少女があいされて幸せになるまでの物語。"),
                    ItemData(title: "英雄教室", description: "目指せ普通！取り戻せ青春！最強元勇者、念願の学園生活スタート！！"),
                    ItemData(title: "文豪ストレイドッグス", description: "文豪の名を懐くキャラクターたちが繰り広げる異能バトルアクション"),
                    ItemData(title: "レベル1だけどユニークスキルで最強です", description: "「小説家になろう」で日間・週間・月間・四半期1位を獲得した人気タイトル"),
                    ItemData(title: "おかしな転生", description: "甘くておかしな王道スイーツ・ファンタジー開演！"),
                    ItemData(title: "ワンピース ワノ国編", description: "麦わら海賊団がサムライの国に集結！")
                ])
            ])
        ]
        return category
    }
}

struct ItemSection {
    let title: String
    let items: [ItemData]
}

struct ItemData {
    let title: String
    let description: String
}
