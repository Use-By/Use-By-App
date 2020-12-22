import Foundation
import Firebase

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
    var afterOpenening: Date?
    var useByDate: Date?
    var photo: Data?
}

enum SortDirection {
    case asc
    case desc
}

struct ProductFilters {
    var searchByName: String?
    var isLiked: Bool
    var isExpired: Bool
    var tag: String?
    var sort: SortDirection?
}

enum ProductError {
    case unknownError
    case fetchProductsError
}

protocol ProductModelProtocol {
    func get(filters: ProductFilters, completion: @escaping ([Product]?, ProductError?) -> Void)
    func delete(id: String, completion: @escaping (ProductError?) -> Void)
    func like(id: String, completion: @escaping (ProductError?) -> Void)
    func create(data: ProductToCreate, completion: @escaping (Product?, ProductError?) -> Void)
    func update(data: Product, completion: @escaping (Product?, ProductError?) -> Void)
}

class ProductModel: ProductModelProtocol {
    private func getUserID() -> String? {
        guard let currentUser = Auth.auth().currentUser else {
            return nil
        }

        return currentUser.uid
    }

    private func getExpirationDate(useByDate: Date?, afterOpeningDate: Date?) -> Date {
        if let useByDate = useByDate, let afterOpeningDate = afterOpeningDate {
            return useByDate < afterOpeningDate ? useByDate : afterOpeningDate
        }

        if let useByDate = useByDate {
            return useByDate
        }

        if let afterOpeningDate = afterOpeningDate {
            return afterOpeningDate
        }

        return Date()
    }

    func get(filters: ProductFilters, completion: @escaping ([Product]?, ProductError?) -> Void) {
        let productsDB = Firestore.firestore().collection("products")

        guard let userID = self.getUserID() else {
            return
        }

        productsDB.whereField("userID", isEqualTo: userID).getDocuments { (snapshot, error) in
            if error != nil {
                completion(nil, .fetchProductsError)
                return
            }

            let documents = snapshot?.documents ?? []
            let products: [Product] = documents.map {
                let data = $0.data()
                let documentID = $0.documentID
                let name = data["name"] as? String ?? ""
                let tag = data["tag"] as? String
                let isLiked = data["liked"] as? Bool ?? false
                let useByDate = (data["use-by"] as? Timestamp)?.dateValue()
                let afterOpeningDate = (data["after-opening"] as? Timestamp)?.dateValue()

                let product: Product = Product(
                    id: documentID,
                    name: name,
                    photoUrl: nil,
                    tag: tag,
                    isLiked: isLiked,
                    expirationDate: self.getExpirationDate(useByDate: useByDate, afterOpeningDate: afterOpeningDate)
                )

                return product
            }

            completion(products, nil)
        }
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
            expirationDate: Date()
        )

        completion(product, nil)
    }

    func update(data: Product, completion: @escaping (Product?, ProductError?) -> Void) {
        completion(data, nil)
    }
}
