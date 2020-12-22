import Foundation
import Firebase

protocol ProductInfo {
    var name: String { get }
    var tag: String? { get }
    var openedDate: Date? { get }
    var afterOpenening: Date? { get }
    var useByDate: Date? { get }
    var isLiked: Bool { get }
}

struct Product: ProductInfo {
    var id: String
    var name: String
    var photoUrl: String?
    var tag: String?
    var isLiked: Bool
    var expirationDate: Date
    var openedDate: Date?
    var afterOpenening: Date?
    var useByDate: Date?
}

struct ProductToCreate: ProductInfo {
    var name: String
    var tag: String?
    var openedDate: Date?
    var afterOpenening: Date?
    var useByDate: Date?
    var photo: Data?
    var isLiked: Bool
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
    case deleteError
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
                let openedDate = (data["opened"] as? Timestamp)?.dateValue()
                let afterOpeningDate = (data["after-opening"] as? Timestamp)?.dateValue()

                let product: Product = Product(
                    id: documentID,
                    name: name,
                    // TODO
                    photoUrl: nil,
                    tag: tag,
                    isLiked: isLiked,
                    expirationDate: getExpirationDate(useByDate: useByDate, afterOpeningDate: afterOpeningDate),
                    openedDate: openedDate,
                    afterOpenening: afterOpeningDate,
                    useByDate: useByDate
                )

                return product
            }

            completion(products, nil)
        }
    }

    func delete(id: String, completion: @escaping (ProductError?) -> Void) {
        let productsDB = Firestore.firestore().collection("products")

        productsDB.document(id).delete { (error) in
            if error != nil {
                completion(.deleteError)

                return
            }

            completion(nil)
        }
    }

    func like(id: String, completion: @escaping (ProductError?) -> Void) {
        let productsDB = Firestore.firestore().collection("products")

        productsDB.document(id).setData([ "liked": true ], merge: true) { (error) in
            if error != nil {
                completion(.unknownError)

                return
            }

            completion(nil)
        }
    }

    private func getApiDataFromProduct(product: ProductInfo) -> [String : Any] {
        // TODO добавить про картинку
        
        return [
            "name": product.name,
            "liked": product.isLiked,
            "tag": product.tag,
            "after-opening": product.afterOpenening,
            "use-by": product.useByDate,
            "opened": product.openedDate
        ]
    }
    
    func create(data: ProductToCreate, completion: @escaping (Product?, ProductError?) -> Void) {
        let productsDB = Firestore.firestore().collection("products")
        let documentRef = productsDB.document()

        documentRef.setData(getApiDataFromProduct(product: data)) { (error) in
            if error != nil {
                completion(nil, .unknownError)
            }
            
            let product = Product(
                id: documentRef.documentID,
                name: data.name,
                // TODO
                photoUrl: nil,
                tag: data.tag,
                isLiked: false,
                expirationDate: getExpirationDate(useByDate: data.useByDate, afterOpeningDate: data.afterOpenening),
                openedDate: data.openedDate,
                afterOpenening: data.afterOpenening,
                useByDate: data.useByDate
            )
            
            completion(product, nil)
        }
    }

    func update(data: Product, completion: @escaping (Product?, ProductError?) -> Void) {
        let productsDB = Firestore.firestore().collection("products")

        productsDB
            .document(data.id)
            .updateData(getApiDataFromProduct(product: data)) { (error) in
            if error != nil {
                completion(nil, .unknownError)

                return
            }

            completion(data, nil)
        }
    }
}
