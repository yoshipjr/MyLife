import UIKit

enum DebugMenu: Int, CaseIterable {
    case webView = 0
    case UIParts
    case swiftUI

    var contents: (title: String, description: String, url: URL) {
        switch self {
            case .webView:
                return (title: "webView", description: "webViewの表示", url: URL(string: "emptyUrl")!)

            case .UIParts:
                return (title: "UIparts", description: "UIKitでのUIpartsの表示", url: URL(string: "emptyUrl")!)

            case .swiftUI:
                return (title: "SwiftUI", description: "SwiftUIでのUIpartsの表示", url: URL(string: "emptyUrl")!)
        }
    }
}

final class DebugViewController: UIViewController {

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
        self.title = "デバッグ画面"
        self.view.addSubview(tableView)
        self.setupLayoutConstraint()
    }

    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension DebugViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DebugMenu.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: DebugListViewCell.identifier, for: indexPath) as? DebugListViewCell
        else  {
            return UITableViewCell()
        }
        cell.textLabel?.text = DebugMenu.allCases[indexPath.row].contents.title
        cell.detailTextLabel?.text = DebugMenu.allCases[indexPath.row].contents.description
        cell.imageView?.image = ImageResource.Menu.menuIcon
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension DebugViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case DebugMenu.webView.rawValue:
                // TODO: webViewControllerの作成
                break

            case DebugMenu.UIParts.rawValue:
                let vc = UIPartsViewController()
                self.navigationController?.pushViewController(vc, animated: true)

            case DebugMenu.swiftUI.rawValue:
                break
                
            default:
                break
        }
    }
}
