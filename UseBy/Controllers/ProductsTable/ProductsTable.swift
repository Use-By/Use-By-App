import Foundation
import UIKit
import SnapKit
import MessageUI

protocol ProductsViewControllerDelegate: AnyObject {
    func getData() -> [Product]
    func didTapDeleteButton(id: String)
    func didTapLikeButton(id: String)
}

class ProductsTableViewController: UIViewController {
    struct UIConstants {
        static let labelToTableMargin: CGFloat = 15
    }

    weak var delegate: ProductsViewControllerDelegate?
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(ProductsTableCell.self, forCellReuseIdentifier: "ProductsTableCell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.allowsSelection = true
        return tableView
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
        setCountLabel()
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

    func setCountLabel() {
        let count = self.delegate?.getData().count ?? 0
        productsCountLabel.text = "products-count".pluralizeString(count: count)
        productsCountLabel.font = Fonts.mainText
        productsCountLabel.textAlignment = .center
        productsCountLabel.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(view)
            make.centerX.equalTo(view)
            make.top.equalTo(view)
        }
    }

    func reloadTable() {
        self.tableView.reloadData()
        setCountLabel()
    }
}

extension ProductsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = self.delegate?.getData() {
            let product = data[indexPath.row]
            present(EditProductViewController(product: product), animated: true, completion: nil)
        }
    }
}

extension ProductsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegate?.getData().count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableCell",
                                                       for: indexPath) as? ProductsTableCell else {
            return UITableViewCell()
        }

        if let data = self.delegate?.getData() {
            cell.fillCell(product: data[indexPath.row])
            cell.delegate = self
        }

        return cell
    }
}

extension ProductsTableViewController: ProductsTableCellDelegate {
    func didTapDeleteButton(id: String) {
        self.delegate?.didTapDeleteButton(id: id)
    }

    func didTapLikeButton(id: String) {
        self.delegate?.didTapLikeButton(id: id)
    }
}
