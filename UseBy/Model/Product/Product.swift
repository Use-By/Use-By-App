//
//  Product.swift
//  UseBy
//
//  Created by Nadezda Svoykina on 11/22/20.
//

import Foundation

struct Product {
    var id: String
    var name: String
    var photoUrl: String?
    var tag: String?
    var isLiked: Bool
    var expirationDate: Date
}

struct ProductToCreate {
    var name: String
    var tag: String?
    var openedDate: Date
    var afterOpenening: Date
    var useByDate: Date
    var photo: Data?
}

enum SortDirection {
    case asc
    case desc
}

struct ProductFilters {
    var searchByName: String?
    var isLiked: Bool?
    var isExpired: Bool?
    var tag: String?
    var sort: SortDirection?
}

enum ProductError {
    case unknownError
}

protocol ProductModelProtocol {
    func get(filters: ProductFilters, completion: @escaping ([Product]?, ProductError?) -> Void)
    func delete(id: String, completion: @escaping (ProductError?) -> Void)
    func like(id: String, completion: @escaping (ProductError?) -> Void)
    func create(data: ProductToCreate, completion: @escaping (Product?, ProductError?) -> Void)
    func update(data: Product, completion: @escaping (Product?, ProductError?) -> Void)
}

class ProductModel: ProductModelProtocol {
    func get(filters: ProductFilters, completion: @escaping ([Product]?, ProductError?) -> Void) {
        let formatter = DateFormatter()

        let product = Product(
            id: "1",
            name: "Chanel Les Beiges",
            tag: "Makeup",
            isLiked: false,
            expirationDate: Date()
        )

        completion([product, product, product, product, product, product], nil)
    }

    func delete(id: String, completion: @escaping (ProductError?) -> Void) {
        completion(nil)
    }

    func like(id: String, completion: @escaping (ProductError?) -> Void) {
        completion(nil)
    }

    func create(data: ProductToCreate, completion: @escaping (Product?, ProductError?) -> Void) {
        let product = Product(
            id: "1",
            name: data.name,
            tag: data.tag,
            isLiked: false,
            expirationDate: data.useByDate
        )

        completion(product, nil)
    }

    func update(data: Product, completion: @escaping (Product?, ProductError?) -> Void) {
        completion(data, nil)
    }
}
