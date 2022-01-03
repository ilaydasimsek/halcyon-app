import UIKit

extension UITableView {

    func registerNibCell(_ nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil),
                            forCellReuseIdentifier: nibName)
    }

    func setupDataProvider(_ dataProvider: TableViewDataProvider) {
        self.delegate = dataProvider
        self.dataSource = dataProvider
        self.prefetchDataSource = dataProvider
    }
}
