import UIKit

extension Home {
    class View: UIViewController {
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        private let topLabel: UILabel = .init()
        private let searchTextField: UITextField = .init()
        private let topFilmsCollectionView = TopFilmsCollectionView()
        
        var movies: [MovieRandom] = []
        
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
                topFilmsCollectionView.widthAnchor.constraint(equalToConstant: 144)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopFilmsCell.reuseId, for: indexPath) as? TopFilmsCell else {
            fatalError("Unable to dequeue TopFilmsCell")
        }
        
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TopFilmsCell,
              let image = cell.posterImageView.image else {
            return
        }
        
        let movie = movies[indexPath.item]
        
        presenter.showFilmDetail(
            imageMovie: image, 
            nameMovie: movie.name ?? .Localization.errorGettingTheMovieName,
            rating: movie.rating?.imdb ?? 0.0
        )
    }
}
