//
//  FoodStore.swift
//  AnimationHeaderDemo (iOS)
//
//  Created by 岡優志 on 2021/04/08.
//

import SwiftUI
import Contentful
import Combine




let client = Client(spaceId: "prkf2xx6qvgl", accessToken: "_yul2oqW4UPpSNZaqoOlSVCrYFSrYDnWzN0aXo1GYBM")

func getArray(id: String, completion: @escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)

    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .failure(let error):
            print(error)
        }
    }
}

class FoodStore: ObservableObject {
    @Published var foodsData: [FoodData] = foods

    init() {
        getArray(id: "food"){ (items) in
            items.forEach{ (item) in
                self.foodsData.append(FoodData(
                                        title: item.fields["title"] as! String,
                                        description: item.fields["description"] as! String,
                                        price: item.fields["price"] as! String,
                                        image: #imageLiteral(resourceName: "4")))
            }
        }
    }
}
