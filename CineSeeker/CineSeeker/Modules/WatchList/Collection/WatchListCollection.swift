import UIKit

final class WatchListCollection: UICollectionView {
    
    // MARK: - Properties
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 25
        layout.itemSize = CGSize(width: 307, height: 120)
        return layout
    }()
    
    // MARK: - Initializers

    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCollectionView() {
        registerCells()
        configureAppearance()
    }
    
    private func registerCells() {
        register(WatchListCell.self, forCellWithReuseIdentifier: WatchListCell.reuseId)
    }
    
    private func configureAppearance() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: -3, bottom: 0, right: 19)
        backgroundColor = .Colors.Font.darkGray
    }
}


