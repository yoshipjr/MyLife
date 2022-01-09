import UIKit

final class SampleCollectionViewDataSource: NSObject {

    private(set) var sections: [SectionConfiguration] = []

    func configure(
        with collectionView: UICollectionView
    ) {
        collectionView.register(SampleCollectionViewCell.self, forCellWithReuseIdentifier: SampleCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func setup(sections: [SectionConfiguration]) {
        self.sections = sections
    }
}

extension SampleCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
}

extension SampleCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }


}
