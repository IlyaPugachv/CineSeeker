import UIKit

final class FullListFilmsCollection: UICollectionView {
    
    // MARK: - Properties
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 145)
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
        register(FullListFilmsCell.self, forCellWithReuseIdentifier: FullListFilmsCell.reuseId)
    }
    
    private func configureAppearance() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: -3, bottom: 0, right: 19)
        backgroundColor = .Colors.Font.darkGray
    }
}



