import UIKit

protocol ClickableCell {
    func onCellClick()
}

protocol ConfigurableCell {
    func configure<T: Decodable>(with model: T)
}

class TableViewCell: UITableViewCell {

    static func dequeue(forTableView tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.nibName, for: indexPath) as? Self else {
            return UITableViewCell()
        }
        return cell
    }
}
