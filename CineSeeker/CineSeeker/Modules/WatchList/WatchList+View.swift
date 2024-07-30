import UIKit

extension WatchList {
    class View: UIViewController {

        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews -
       
        private let watchListCollection = WatchListCollection()
        
        // MARK: - Initializers -
        
        public init(with presenter: Presenter) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
            
            presenter.view = self
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        deinit { }
        
        // MARK: - Lifecycle -
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            setup()
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            watchListCollection.reloadData()
        }
        
        // MARK: - Methods -
        
        private func setup() {
            buildHierarchy()
            configureSubviews()
            layoutSubviews()
            setupActions()
        }
        
        private func buildHierarchy() {
            view.backgroundColor = .Colors.Font.darkGray
            
            view.addView(watchListCollection)
        }
        
        private func configureSubviews() {
            watchListCollection.delegate = self
            watchListCollection.dataSource = self
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                watchListCollection.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
                watchListCollection.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                watchListCollection.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                watchListCollection.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            ])
        }
        
        private func setupActions() { }
    }
}

// MARK: - Extension View -

extension WatchList.View: WatchListView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BookmarkManager.shared.getBookmarkedMovies().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchListCell.reuseId, for: indexPath) as! WatchListCell
        
        let bookmarkedMovies = BookmarkManager.shared.getBookmarkedMovies()
        let movie = bookmarkedMovies[indexPath.row]
        
        cell.ratingLabel.text = "\(movie.rating)"
        cell.filmNameLabel.text = movie.title
        cell.genreLabel.text = movie.genre
        cell.releaseDateLabel.text = "\(movie.releaseDate)"
        cell.movieLengthLabel.text = "\(movie.movieLength) minutes"
        if let imageData = movie.posterImageData {
            cell.profileImageView.image = UIImage(data: imageData)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, performPrimaryActionForItemAt indexPath: IndexPath) {
      
        var bookmarkedMovies = BookmarkManager.shared.getBookmarkedMovies()
        let movieToDelete = bookmarkedMovies[indexPath.row]
        BookmarkManager.shared.removeBookmark(movieTitle: movieToDelete.title)
        
        collectionView.deleteItems(at: [indexPath])
    }
}

