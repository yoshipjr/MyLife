import UIKit

protocol SectionConfiguration {
    // セクションのアイテム数
    var numberOfItems: Int { get }

    // レイアウトの生成
    func layoutSection(_ view: UIView) -> NSCollectionLayoutSection

    // セルの生成
    func configureCell(_ view: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
}

final class SampleCollectionViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }()

    private lazy var collectionViewLayout: UICollectionViewLayout = {
        return UICollectionViewCompositionalLayout { [weak self] section, _ in
            return self?.dataSource?.sections[section].layoutSection(self?.view ?? .init())
        }
    }()

    private var dataSource: SampleCollectionViewDataSource?

    override func viewDidLoad() {
        self.view.backgroundColor = .white
    }
}
