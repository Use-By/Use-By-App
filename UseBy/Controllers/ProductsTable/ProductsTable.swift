import Foundation
import UIKit
import SnapKit
import MessageUI

class ProductsTableViewController: UIViewController {
    struct UIConstants {
        static let labelToTableMargin: CGFloat = 15
    }

    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(ProductsTableCell.self, forCellReuseIdentifier: "ProductsTableCell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return tableView
    }()

    private let productsData: [Product] = {
        let formatter = DateFormatter()

        let product = Product(
            name: "Chanel Les Beiges",
            tag: "Makeup",
            isLiked: false,
            expirationDate: Date()
        )

        print(product.expirationDate)
        return [product]
    }()

    private let productsCountLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.mainBGColor

        configureProductsCountLabel()
        configureTable()
    }

    func configureProductsCountLabel() {
        view.addSubview(productsCountLabel)
        productsCountLabel.text = String(format: "products-count".localized, productsData.count)
        productsCountLabel.font = Fonts.mainText
        productsCountLabel.textAlignment = .center
        productsCountLabel.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(view)
            make.centerX.equalTo(view)
            make.top.equalTo(view)
        }
    }

    func configureTable() {
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(productsCountLabel.snp.bottom).offset(UIConstants.labelToTableMargin)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
}

extension ProductsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Отображать модалку изменения продукта
    }
}

extension ProductsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableCell",
                                                       for: indexPath) as? ProductsTableCell else {
            return UITableViewCell()
        }

        cell.fillCell(product: productsData[indexPath.row])

        return cell
    }
}
