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
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchListCell.reuseId, for: indexPath) as! WatchListCell
        
        cell.ratingLabel.text = "9.5"
        cell.filmNameLabel.text = "SpiderMan"
        cell.genreLabel.text = "Action"
        cell.releaseDateLabel.text = "2019"
        cell.movieLengthLabel.text = "139 minutes"
        cell.profileImageView.image = UIImage(systemName: "bookmark")
       
        
        return cell
    }
}

