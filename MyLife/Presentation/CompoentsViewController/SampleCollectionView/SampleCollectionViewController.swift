import UIKit

protocol SectionConfiguration {
    // セクションのアイテム数
    var numberOfItems: Int { get }

    // レイアウトの生成
    func layoutSection(_ view: UIView) -> NSCollectionLayoutSection

    // セルの生成
    func configureCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
}

final class SampleCollectionViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var collectionViewLayout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { [weak self] section, _ in
            return self?.dataSource?.sections[section].layoutSection(self?.view ?? .init())
        }
    }()

    private var dataSource: SampleCollectionViewDataSource?

    override func viewDidLoad() {
        self.view.backgroundColor = .white

        self.view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        dataSource = SampleCollectionViewDataSource()
        dataSource?.configure(with: collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        dataSource?.setup(sections: [
            SampleAreaSection()
        ])
        collectionView.reloadData()
    }
}
