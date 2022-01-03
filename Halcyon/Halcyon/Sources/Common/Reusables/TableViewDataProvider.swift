import UIKit

protocol TableViewProviderDelegate: AnyObject {
    var dataCount: Int { get }
    var canLoadMore: Bool { get }
    var cellHeight: CGFloat? { get }

    func loadMore()
    func itemAt(indexPath: IndexPath) -> UITableViewCell
    func onCellClick(at indexPath: IndexPath)
}

extension TableViewProviderDelegate {
    var cellHeight: CGFloat? {
        return nil
    }

    func loadMore() { }
}

class TableViewDataProvider: NSObject {
    weak var delegate: TableViewProviderDelegate?
    private var currentPage = 0
    private let fetchMoreLimit = 3

    init(delegate: TableViewProviderDelegate) {
        self.delegate = delegate
    }
}

extension TableViewDataProvider: UITableViewDataSource, UITableViewDataSourcePrefetching {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.dataCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegate?.itemAt(indexPath: indexPath) ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let delegate = delegate else { return }

        let containsLastCell = indexPaths.reduce(false, {$0 || $1.row >= delegate.dataCount - 1})
        if delegate.canLoadMore && containsLastCell {
            delegate.loadMore()
        }
    }
}

extension TableViewDataProvider: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onCellClick(at: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return delegate?.cellHeight ?? UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return delegate?.cellHeight ?? UITableView.automaticDimension
    }
}
