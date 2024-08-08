import UIKit
import Alamofire

extension Search {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        private var searchResults: [MovieRandom] = []
        
        // MARK: - Subviews -
       
        private let searchTextField: UITextField = .init()
        private let collectionView = WatchListCollection()
       
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
            
            view.addView(searchTextField)
            view.addView(collectionView)
        }
        
        private func configureSubviews() {
            
            searchTextField.configureTextField(
                placeholder: .Localization.search,
                font: .interRegular(of: 14),
                icon: UIImage(systemName: "magnifyingglass"),
                iconColor: .Colors.Font.lightGray,
                backgroundColor: .Colors.Font.gray,
                cornerRadius: 12
            )
            
            hideKeyboardWhenTappedAround()
            
            collectionView.register(WatchListCell.self, forCellWithReuseIdentifier: WatchListCell.reuseId)
            collectionView.dataSource = self
            collectionView.delegate = self
        }
        
        private func layoutSubviews() {
           
            NSLayoutConstraint.activate([
                searchTextField.topAnchor.constraint(equalTo: safeArea.topAnchor),
                searchTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
                searchTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
                searchTextField.heightAnchor.constraint(equalToConstant: 42),
                
                collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
        private func setupActions() {
            searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }

        @objc private func textFieldDidChange(_ textField: UITextField) {
            guard let query = textField.text, !query.isEmpty else { return }
            performSearch(query: query)
        }

        private func performSearch(query: String) {
            searchResults.removeAll()
            collectionView.reloadData()
            
            NetworkManager.searchMoviesByName(movieName: query) { [weak self] result in
                switch result {
                case .success(let movieResponse):
                    self?.searchResults = movieResponse.docs ?? []
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                   
                    print("Error fetching movies: \(error)")
                }
            }
        }
    }
}

// MARK: - Extension View -

extension Search.View: SearchView { }

extension Search.View: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchListCell.reuseId, for: indexPath) as? WatchListCell else {
            fatalError("Unable to dequeue WatchListCell")
        }
        
        let movie = searchResults[indexPath.row]
        
        cell.filmNameLabel.text = movie.name
        cell.ratingLabel.text = movie.ratingMpaa
        
        if let genres = movie.genres {
            cell.genreLabel.text = genres.compactMap { $0.name }.joined(separator: ", ")
        } else {
            cell.genreLabel.text = "Unknown Genre"
        }
        cell.releaseDateLabel.text = "\(movie.year ?? 2007)"
        cell.movieLengthLabel.text = "\(movie.movieLength ?? 107) minutes"
        
        if let posterUrl = movie.poster?.previewUrl {
           
            cell.profileImageView.sd_setImage(with: URL(string: posterUrl), completed: nil)
        } else {
            cell.profileImageView.image = nil
        }
        
        return cell
    }
}
