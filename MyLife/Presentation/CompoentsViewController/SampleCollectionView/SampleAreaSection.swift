import UIKit

struct SampleAreaSection: SectionConfiguration {

    var numberOfItems: Int {
        3
    }

    func layoutSection(_ view: UIView) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        ))

        item.contentInsets = .init(top: 24, leading: 12, bottom: 0, trailing: 0)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .estimated(220 + 12),
            heightDimension: .estimated(287.79 + 24)
        ), subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 0)

        return section

    }

    func configureCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SampleCollectionViewCell.identifier,
            for: indexPath) as? SampleCollectionViewCell {
            cell.backgroundColor = .blue
            return cell
        }
        return UICollectionViewCell()
    }
}
