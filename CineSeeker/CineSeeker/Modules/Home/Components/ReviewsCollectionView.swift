import UIKit

// MARK: - ReviewsCollectionView -

class ReviewsCollectionView: UICollectionView {

    // MARK: - Initializers -

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods -

    private func configureCollectionView() {
        self.backgroundColor = .clear
        self.register(ReviewsCell.self, forCellWithReuseIdentifier: ReviewsCell.reuseId)
        self.showsVerticalScrollIndicator = false
    }
}

