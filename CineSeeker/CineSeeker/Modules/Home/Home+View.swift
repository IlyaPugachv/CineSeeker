import UIKit

extension Home {
    class View: UIViewController {
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        private let topLabel: UILabel = .init()
        private let searchTextField: UITextField = .init()
        private let topFilmsCollectionView = TopFilmsCollectionView()
        private let customSegmentedControl = CustomSegmentedControl()
        private let fullListFilmsCollection = FullListFilmsCollection()
        
        var movies: [MovieRandom] = []
        
        var review: [ReviewModel] = []
        
        public init(with presenter: Presenter) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
            presenter.view = self
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        deinit { }
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            
            topFilmsCollectionView.dataSource = self
            topFilmsCollectionView.delegate = self
            
            fullListFilmsCollection.dataSource = self
            fullListFilmsCollection.delegate = self
            
            fetchMovies()
            setup()
        }
        
        private func setup() {
            buildHierarchy()
            configureSubviews()
            layoutSubviews()
            setupActions()
        }
        
        private func buildHierarchy() {
            view.backgroundColor = .Colors.Font.darkGray
            view.addView(topLabel)
            view.addView(searchTextField)
            view.addView(topFilmsCollectionView)
            view.addView(customSegmentedControl)
            view.addView(fullListFilmsCollection)
        }
        
        private func configureSubviews() {
            topLabel.configureLabel(
                text: .Localization.whatDoYouWanToWatch,
                font: .interSemibold(of: 18),
                color: .white,
                alignment: .left
            )
            
            searchTextField.configureTextField(
                placeholder: .Localization.search,
                font: .interRegular(of: 14),
                icon: UIImage(systemName: "magnifyingglass"),
                iconColor: .Colors.Font.lightGray,
                backgroundColor: .Colors.Font.gray,
                cornerRadius: 12
            )
            
            customSegmentedControl.buttonTitles = ["Now playing", "Upcoming", "Top rated", "Popular"]

            hideKeyboardWhenTappedAround()
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                topLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
                topLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
                
                searchTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
                searchTextField.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
                searchTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                searchTextField.widthAnchor.constraint(equalToConstant: 327),
                searchTextField.heightAnchor.constraint(equalToConstant: 42),
                
                topFilmsCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 30),
                topFilmsCollectionView.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor),
                topFilmsCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                topFilmsCollectionView.heightAnchor.constraint(equalToConstant: 210),
                topFilmsCollectionView.widthAnchor.constraint(equalToConstant: 144),
                
                customSegmentedControl.topAnchor.constraint(equalTo: topFilmsCollectionView.bottomAnchor, constant: 50),
                customSegmentedControl.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
                customSegmentedControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                customSegmentedControl.heightAnchor.constraint(equalToConstant: 20),
                
                fullListFilmsCollection.topAnchor.constraint(equalTo: customSegmentedControl.bottomAnchor, constant: 30),
                fullListFilmsCollection.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor),
                fullListFilmsCollection.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                fullListFilmsCollection.heightAnchor.constraint(equalToConstant: 220),
                fullListFilmsCollection.widthAnchor.constraint(equalToConstant: 100),
            ])
        }
        
        private func setupActions() {  }
        
        private func fetchMovies() {
            NetworkManager.getCollectionsFilms { result in
                switch result {
                case .success(let results):
                    if let docs = results.docs {
                        self.movies = docs
                    }
                    DispatchQueue.main.async {
                        self.topFilmsCollectionView.reloadData()
                    }
                case .failure(let error):
                    print("Ошибка при загрузке данных: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension Home.View: HomeView, UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if collectionView == topFilmsCollectionView {
            return 1
        } else if collectionView == fullListFilmsCollection {
            return 3
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if collectionView == topFilmsCollectionView {
            return movies.count
        } else if collectionView == fullListFilmsCollection {
            return 10
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topFilmsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFilmsCell.reuseId, for: indexPath) as? TopFilmsCell else {
                fatalError("Unable to dequeue TopFilmsCell")
            }
            let movie = movies[indexPath.item]
            cell.configure(with: movie)
            return cell
        } else if collectionView == fullListFilmsCollection {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FullListFilmsCell.reuseId, for: indexPath) as? FullListFilmsCell else {
                fatalError("Unable to dequeue FullListFilmsCell")
            }
//            let movie = movies[indexPath.item]
//            cell.configure(with: movie)
            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topFilmsCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? TopFilmsCell,
                  let image = cell.posterImageView.image else {
                return
            }
            
            let movie = movies[indexPath.item]
            
            NetworkManager.getReviewsForMovie(movieId: movie.id ?? 0) { result in
                switch result {
                case .success(let reviewModel):
                    let reviews = reviewModel.docs?.compactMap { $0.review }.joined(separator: "\n\n") ?? "No reviews available"
                    let author = reviewModel.docs?.compactMap { $0.author }.joined(separator: "\n\n") ?? "No author available"
                    let genres = movie.genres?.compactMap { $0.name }.joined(separator: ", ") ?? ""
                    
                    DispatchQueue.main.async {
                        self.presenter.showFilmDetail(
                            imageMovie: image,
                            nameMovie: movie.name ?? .Localization.errorGettingTheMovieName,
                            rating: movie.rating?.imdb ?? 0.0,
                            year: movie.year ?? 2024,
                            movieLength: movie.movieLength ?? 100,
                            genres: genres,
                            aboutMovie: movie.description ?? .Localization.errorWhenGettingTheMovieDescription,
                            autor: author,
                            review: reviews
                        )
                    }
                case .failure(let error):
                    print("Error fetching reviews: \(error.localizedDescription)")
                }
            }
        } else if collectionView == fullListFilmsCollection {
           
        }
    }
}
