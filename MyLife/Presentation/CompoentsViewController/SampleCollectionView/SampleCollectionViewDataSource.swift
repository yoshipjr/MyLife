import UIKit

final class SampleCollectionViewDataSource: NSObject {

    private(set) var sections: [SectionConfiguration] = []

    func configure(
        with collectionView: UICollectionView
    ) {
        collectionView.register(SampleCollectionViewCell.self, forCellWithReuseIdentifier: SampleCollectionViewCell.identifier)
        collectionView.register(SampleHeader.self, forSupplementaryViewOfKind: ElementKind.header.type, withReuseIdentifier: SampleHeader.identifier)
        collectionView.register(SampleFooter.self, forSupplementaryViewOfKind: ElementKind.footer.type, withReuseIdentifier: SampleFooter.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func setup(sections: [SectionConfiguration]) {
        self.sections = sections
    }
}

extension SampleCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = sections[indexPath.row].configureCell(collectionView, at: indexPath)

        switch cell {
            case is SampleCollectionViewCell:
                break

            default:
                break
        }
    }
}

extension SampleCollectionViewDataSource: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        sections[section].numberOfItems
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = sections[indexPath.section].configureCell(collectionView, at: indexPath)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard
                    let header =
                        collectionView.dequeueReusableSupplementaryView(
                            ofKind: ElementKind.header.type,
                            withReuseIdentifier: SampleHeader.identifier, for: indexPath
                        ) as? SampleHeader
                else { return UICollectionReusableView() }
                header.update(hasSubTitle: true)
                return header
            case UICollectionView.elementKindSectionFooter:
                guard
                    let footer = collectionView.dequeueReusableSupplementaryView(
                        ofKind: ElementKind.footer.type,
                        withReuseIdentifier: SampleFooter.identifier,
                        for: indexPath) as? SampleFooter
                else {
                        return UICollectionReusableView()
                    }
                return footer
            default:
                return UICollectionReusableView()
        }
    }
}
