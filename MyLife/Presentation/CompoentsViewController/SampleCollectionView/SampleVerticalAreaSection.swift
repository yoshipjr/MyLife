import UIKit

struct SampleVerticalAreaSection: SectionConfiguration {
    var numberOfItems: Int {
        3
    }

    func layoutSection(_ view: UIView) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize:
                    .init(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(250)
                    )
        )
        item.contentInsets = .init(top: 24, leading: 12, bottom: 0, trailing: 0)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(10)
        ), subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 24, leading: 0, bottom: 24, trailing: 0)
        section.interGroupSpacing = 16

        let footerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(48)
        )

        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerItemSize,
            elementKind: ElementKind.footer.type,
            alignment: .bottom
        )

        section.boundarySupplementaryItems = [footerItem]

        return section
    }

    func configureCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCollectionViewCell.identifier, for: indexPath) as? SampleCollectionViewCell {
            cell.backgroundColor = .red
            cell.configure(text: "vertrical")
            return cell
        }
        return UICollectionViewCell()
    }
}
