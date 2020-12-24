import Foundation
import Firebase
import FirebaseStorage

protocol ProductInfo {
    var name: String { get }
    var tag: String? { get }
    var openedDate: Date? { get }
    var afterOpenening: Date? { get }
    var useByDate: Date? { get }
    var isLiked: Bool { get }
    var expirationDate: Date? { get }
}

struct Product: ProductInfo {
    var id: String
    var name: String
    var tag: String?
    var isLiked: Bool
    var expirationDate: Date?
    var openedDate: Date?
    var afterOpenening: Date?
    var useByDate: Date?
    var photoUrl: String?
}

struct ProductToCreate: ProductInfo {
    var name: String
    var tag: String?
    var openedDate: Date?
    var afterOpenening: Date?
    var useByDate: Date?
    var photo: Data?
    var isLiked: Bool
    var expirationDate: Date?
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
    func like(id: String, liked: Bool, completion: @escaping (ProductError?) -> Void)
    func create(data: ProductToCreate, completion: @escaping (Product?, ProductError?) -> Void)
    func update(data: Product, completion: @escaping (Product?, ProductError?) -> Void)
}

class ProductModel: ProductModelProtocol {
    private func getApiDataFromProduct(product: ProductInfo) -> [String: Any] {
        // TODO добавить про картинку

        return [
            "name": product.name,
            "liked": product.isLiked,
            "tag": product.tag,
            "after-opening": product.afterOpenening,
            "use-by": product.useByDate,
            "opened": product.openedDate,
            "expiration-date": product.expirationDate
        ]
    }

    private func getUserID() -> String? {
        guard let currentUser = Auth.auth().currentUser else {
            return nil
        }

        return currentUser.uid
    }

    func get(filters: ProductFilters, completion: @escaping ([Product]?, ProductError?) -> Void) {
        var productsRef = Firestore.firestore().collection("products")

        guard let userID = self.getUserID() else {
            return
        }

        // TODO сортировка?

        productsRef
            .whereField("userID", isEqualTo: userID)
            .getDocuments { (snapshot, error) in
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
                let expirationDate = (data["expiration-date"] as? Timestamp)?.dateValue() ?? Date()
                let afterOpeningDate = (data["after-opening"] as? Timestamp)?.dateValue()
                let photoURL = data["photo-url"] as? String

                let product: Product = Product(
                    id: documentID,
                    name: name,
                    tag: tag,
                    isLiked: isLiked,
                    expirationDate: expirationDate,
                    openedDate: openedDate,
                    afterOpenening: afterOpeningDate,
                    useByDate: useByDate,
                    photoUrl: photoURL
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

    func like(id: String, liked: Bool, completion: @escaping (ProductError?) -> Void) {
        let productsDB = Firestore.firestore().collection("products")

        productsDB.document(id).setData([ "liked": liked ], merge: true) { (error) in
            if error != nil {
                completion(.unknownError)
                return
            }

            completion(nil)
        }
    }

    func create(data: ProductToCreate, completion: @escaping (Product?, ProductError?) -> Void) {
        let productsDB = Firestore.firestore().collection("products")
        let documentRef = productsDB.document()

        documentRef.setData(getApiDataFromProduct(product: data)) { (error) in
            if error != nil {
                completion(nil, .unknownError)
                return
            }

            let product = Product(
                id: documentRef.documentID,
                name: data.name,
                tag: data.tag,
                isLiked: false,
                expirationDate: data.expirationDate,
                openedDate: data.openedDate,
                afterOpenening: data.afterOpenening,
                useByDate: data.useByDate,
                // TODO
                photoUrl: nil
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

    func uploadPhoto(photo: Data, completion: @escaping (String?, ProductError?) -> Void) {
        guard let userID = self.getUserID() else {
            completion(nil, .unknownError)
            return
        }
        let imageUUID = UUID().uuidString
        let imageRef = Storage.storage().reference()
            .child("photos")
            .child(userID)
            .child(imageUUID)

        imageRef.putData(photo, metadata: nil) { (metadata, error) in
            if error != nil, metadata == nil {
                completion(nil, .unknownError)
                return
            }

            imageRef.downloadURL { (url, _) in
                guard let downloadURL = url else {
                  completion(nil, .unknownError)
                  return
                }

                completion(downloadURL.absoluteString, nil)
            }
        }
    }

    func downloadPhoto(url: String, completion: @escaping (Data?, ProductError?) -> Void) {
        let storage = Storage.storage()
        let imageRef = storage.reference(forURL: url)

        // TODO max size?
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                completion(nil, .unknownError)
                return
            }

            guard let data = data else {
                completion(nil, .unknownError)
                return
            }

            completion(data, nil)
        }
    }
}
