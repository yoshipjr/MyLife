import UIKit

enum UIParts: Int, CaseIterable {
    case indentLabel = 0
    case button
    case collectionView
    case pinterest

    var contents: (title: String, description: String, url: URL) {
        switch self {
            case .indentLabel:
                return (title: "IndentLabel", description: "中身によって大きさの変わるLabel", url: URL(string: "emptyUrl")!)

            case .button:
                return (title: "Button", description: "標準ボタンの表示", url: URL(string: "emptyUrl")!)
            case .collectionView:
                return (title: "collectionView", description: "compositionalLayoutで実装", url: URL(string: "emptyUrl")!)

            case .pinterest:
                return (title: "collectionView", description: "pinterestっぽいUIで実装", url: URL(string: "emptyUrl")!)
        }
    }
}

final class UIPartsViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DebugListViewCell.self, forCellReuseIdentifier: DebugListViewCell.identifier)
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    private func setupLayout() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension UIPartsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UIParts.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: DebugListViewCell.identifier, for: indexPath ) as? DebugListViewCell
        else { return UITableViewCell() }

        cell.textLabel?.text = UIParts.allCases[indexPath.row].contents.title
        cell.detailTextLabel?.text = UIParts.allCases[indexPath.row].contents.description
        cell.imageView?.image = ImageResource.Menu.menuIcon
        cell.accessoryType = .disclosureIndicator
        return cell

    }
}

extension UIPartsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch UIParts(rawValue: indexPath.row) {
            case .indentLabel:
                let component = IndentLabel(insets: UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))
                component.numberOfLines = 0
                component.text = "testtestesttesttesttestestse"
                let vc = ComponentContainerViewController(
                    component: component,
                    componentWidth: self.view.frame.size.width,
                    componentHeight: 300
                )
                self.navigationController?.pushViewController(vc, animated: true)

            case .button:
                break

            case .collectionView:
                let vc = SampleCollectionViewController()
                self.navigationController?.pushViewController(vc, animated: true)

            case .pinterest:
                break
                
            case .none:
                break
        }
    }
}
