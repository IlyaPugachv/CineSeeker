import UIKit

extension Home {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews -
        
        private let mainScrollView: UIScrollView = .init()
        private let contentView: UIView = .init()
        
        private let topLabel: UILabel = .init()
        private let searchTextField: UITextField = .init()
        
        private var selectedSegmentIndex: Int = 0 {
                   didSet {
                       updateCollectionData(for: selectedSegmentIndex)
                   }
               }
  
        private let topFilmsCollectionView = TopFilmsCollectionView()
        private let customSegmentedControl = CustomSegmentedControl()
        private let fullListFilmsCollection = FullListFilmsCollection()
        
        var topMovies: [MovieRandom] = []
        var bestMovies: [MovieRandom] = []
        
        var review: [ReviewModel] = []
        
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
            
            topFilmsCollectionView.dataSource = self
            topFilmsCollectionView.delegate = self
            
            fullListFilmsCollection.dataSource = self
            fullListFilmsCollection.delegate = self
            
            selectedSegmentIndex = 0
            
            fetchAllMovies()
            fetchNowPlayingMovies()
            
            setup()
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
            
            view.addView(mainScrollView)
            mainScrollView.addView(contentView)
            
            contentView.addView(topLabel)
            contentView.addView(searchTextField)
            contentView.addView(topFilmsCollectionView)
            contentView.addView(customSegmentedControl)
            contentView.addView(fullListFilmsCollection)
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
            customSegmentedControl.delegate = self

            hideKeyboardWhenTappedAround()
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                
                mainScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                mainScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                mainScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                mainScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                
                contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor),
                
                topLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                topLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                
                searchTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
                searchTextField.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
                searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                searchTextField.widthAnchor.constraint(equalToConstant: 327),
                searchTextField.heightAnchor.constraint(equalToConstant: 42),
                
                topFilmsCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 30),
                topFilmsCollectionView.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor),
                topFilmsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                topFilmsCollectionView.heightAnchor.constraint(equalToConstant: 210),
                topFilmsCollectionView.widthAnchor.constraint(equalToConstant: 144),
                
                customSegmentedControl.topAnchor.constraint(equalTo: topFilmsCollectionView.bottomAnchor, constant: 50),
                customSegmentedControl.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
                customSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                customSegmentedControl.heightAnchor.constraint(equalToConstant: 20),
                
                fullListFilmsCollection.topAnchor.constraint(equalTo: customSegmentedControl.bottomAnchor, constant: 30),
                fullListFilmsCollection.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor),
                fullListFilmsCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                fullListFilmsCollection.heightAnchor.constraint(equalToConstant: 245),
                fullListFilmsCollection.widthAnchor.constraint(equalToConstant: 100),
                
                fullListFilmsCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
        }
        
        private func setupActions() {  }
        
        private func updateCollectionData(for index: Int) {
            switch index {
            case 0:
                fetchNowPlayingMovies()
            case 1:
                fetchUpcomingMovies()
            case 2:
                fetchTopRatedMovies()
            case 3:
                fetchPopularMovies()
            default:
                break
            }
        }
        
        private func fetchAllMovies() {
            NetworkManager.fetchRandomMovies { result in
                switch result {
                case .success(let results):
                    if let docs = results.docs {
                        self.topMovies = docs
                    }
                    DispatchQueue.main.async {
                        self.topFilmsCollectionView.reloadData()
                    }
                case .failure(let error):
                    print("Ошибка при загрузке данных: \(error.localizedDescription)")
                }
            }
        }
        
        private func fetchNowPlayingMovies() {
            NetworkManager.fetchPopularMovies { result in
                switch result {
                case .success(let results):
                    self.bestMovies = results.docs ?? []
                    DispatchQueue.main.async {
                        self.fullListFilmsCollection.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching now playing movies: \(error.localizedDescription)")
                }
            }
        }
        
        private func fetchUpcomingMovies() {
            NetworkManager.fetchUpcomingMovies { result in
                switch result {
                case .success(let results):
                    self.bestMovies = results.docs ?? []
                    DispatchQueue.main.async {
                        self.fullListFilmsCollection.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching upcoming movies: \(error.localizedDescription)")
                }
            }
        }
        
        private func fetchTopRatedMovies() {
            NetworkManager.fetchTopRatedMovies { result in
                switch result {
                case .success(let results):
                    self.bestMovies = results.docs ?? []
                    DispatchQueue.main.async {
                        self.fullListFilmsCollection.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching top rated movies: \(error.localizedDescription)")
                }
            }
        }
        
        private func fetchPopularMovies() {
            NetworkManager.fetchNowPlayingMovies { result in
                switch result {
                case .success(let results):
                    self.bestMovies = results.docs ?? []
                    DispatchQueue.main.async {
                        self.fullListFilmsCollection.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching popular movies: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension Home.View: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        selectedSegmentIndex = index
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
            return topMovies.count
        } else if collectionView == fullListFilmsCollection {
            return bestMovies.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topFilmsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFilmsCell.reuseId, for: indexPath) as? TopFilmsCell else {
                fatalError("Unable to dequeue TopFilmsCell")
            }
            let movie = topMovies[indexPath.item]
            cell.configure(with: movie)
            return cell
        } else if collectionView == fullListFilmsCollection {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FullListFilmsCell.reuseId, for: indexPath) as? FullListFilmsCell else {
                fatalError("Unable to dequeue FullListFilmsCell")
            }
            let movie = bestMovies[indexPath.item]
            cell.configure(with: movie)
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
            
            let movie = topMovies[indexPath.item]
            
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
