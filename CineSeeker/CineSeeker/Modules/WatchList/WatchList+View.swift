import UIKit

extension WatchList {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews -
        
        private let watchListCollection = WatchListCollection()
        private let noMovieView = NoMovieView()
        
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
            updateViewVisibility()
            watchListCollection.reloadData()
        }
        
        // MARK: - Methods -
        
        private func setup() {
            buildHierarchy()
            configureSubviews()
            layoutSubviews()
        }
        
        private func buildHierarchy() {
            view.backgroundColor = .Colors.Font.darkGray
            view.addView(watchListCollection)
            view.addView(noMovieView)
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
                watchListCollection.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                
                noMovieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                noMovieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                noMovieView.widthAnchor.constraint(equalTo: view.widthAnchor),
                noMovieView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        }
        
        private func updateViewVisibility() {
            let hasMovies = !BookmarkManager.shared.getBookmarkedMovies().isEmpty
            watchListCollection.isHidden = !hasMovies
            noMovieView.isHidden = hasMovies
        }
        
        @objc
        private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
            guard let cell = gesture.view as? UICollectionViewCell else { return }
            guard let indexPath = watchListCollection.indexPath(for: cell) else { return }
            
            let translation = gesture.translation(in: cell)
            
            switch gesture.state {
            case .changed:
                if translation.x < 0 {
                    cell.transform = CGAffineTransform(translationX: translation.x, y: 0)
                }
                
            case .ended:
                let screenWidth = UIScreen.main.bounds.width
                if abs(translation.x) > screenWidth / 2 {
                    showConfirmationAlert(
                        title: "Confirm Deletion",
                        message: "Are you sure you want to delete this item?",
                        yesButtonTitle: "Yes",
                        noButtonTitle: "No",
                        yesCompletion: {
                            UIView.animate(withDuration: 0.3, animations: {
                                cell.transform = CGAffineTransform(translationX: -screenWidth, y: 0)
                            }) { _ in
                                self.handleSwipeToDelete(for: indexPath)
                            }
                        },
                        noCompletion: {
                            UIView.animate(withDuration: 0.3, animations: {
                                cell.transform = .identity
                            })
                        }
                    )
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        cell.transform = .identity
                    })
                }
                
            default:
                break
            }
        }
        
        private func handleSwipeToDelete(for indexPath: IndexPath) {
            let bookmarkedMovies = BookmarkManager.shared.getBookmarkedMovies()
            let movieToDelete = bookmarkedMovies[indexPath.row]
            
            BookmarkManager.shared.removeBookmark(movieTitle: movieToDelete.title)
            
            watchListCollection.performBatchUpdates({
                watchListCollection.deleteItems(at: [indexPath])
            }, completion: { _ in
                self.updateViewVisibility()
            })
        }
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
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        cell.addGestureRecognizer(panGesture)
        
        return cell
    }
}
