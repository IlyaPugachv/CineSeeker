import UIKit

extension Detail {
    class View: UIViewController, UICollectionViewDelegate {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews -
        
        private let mainScrollView: UIScrollView = .init()
        private let contentView: UIView = .init()
        
        private let posterFilmImageView: UIImageView = .init()
        private let nameMovieLabel: UILabel = .init()
        
        private let blurView: UIVisualEffectView = .init(effect: UIBlurEffect(style: .light))
        private let star: UIImageView = .init()
        private let ratingLabel: UILabel = .init()
        
        private let calendarStackView: UIStackView = .init()
        
        private let calendarImageView: UIImageView = .init()
        private let yearFilmLabel: UILabel = .init()
        
        private let stripeOne: UIView = .init()
        
        private let watchStackView: UIStackView = .init()
        
        private let watchImageView: UIImageView = .init()
        private let movieLengthLabel: UILabel = .init()
        
        private let stripeTwo: UIView = .init()
        
        private let actionStackView: UIStackView = .init()
        
        private let actionImageView: UIImageView = .init()
        private let genresFilmLabel: UILabel = .init()
        
        private let mainStackView: UIStackView = .init()
        
        private let customSegmentedControl = CustomSegmentedControl()
        private let aboutMovieLabel: UILabel = .init()
        
        // MARK: - Reviews Collection View -
        
        private let reviewsCollectionView = ReviewsCollectionView()
        
        // MARK: - Initializers -
        
        public init(with presenter: Presenter) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
            presenter.view = self
            self.hidesBottomBarWhenPushed = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        deinit { }
        
        // MARK: - Lifecycle -
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            setup()
            configureNavigation()
            customSegmentedControl.delegate = self
            change(to: 0)
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
        
        // MARK: - Methods -
        
        private func setup() {
            buildHierarchy()
            configureSubviews()
            layoutSubviews()
            setupActions()
        }
        
        private func configureNavigation() {
            let navBar = navigationController?.navigationBar
            navBar?.isTranslucent = false
            navBar?.tintColor = .white
            navBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.hidesBackButton = true
            
            if #available(iOS 15.0, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .Colors.Font.darkGray
                appearance.shadowColor = .clear
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                
                navBar?.standardAppearance = appearance
                navBar?.scrollEdgeAppearance = appearance
            } else {
                navBar?.barTintColor = .Colors.Font.darkGray
            }
        }
        
        private func buildHierarchy() {
            view.backgroundColor = .Colors.Font.darkGray
            
            view.addView(mainScrollView)
            mainScrollView.addView(contentView)
            
            contentView.addView(posterFilmImageView)
            contentView.addView(nameMovieLabel)
            posterFilmImageView.addView(blurView)
            blurView.contentView.addView(star)
            blurView.contentView.addView(ratingLabel)
            
            calendarStackView.addArrangedSubview(calendarImageView)
            calendarStackView.addArrangedSubview(yearFilmLabel)
            
            watchStackView.addArrangedSubview(watchImageView)
            watchStackView.addArrangedSubview(movieLengthLabel)
            
            actionStackView.addArrangedSubview(actionImageView)
            actionStackView.addArrangedSubview(genresFilmLabel)
            
            mainStackView.addArrangedSubview(calendarStackView)
            mainStackView.addArrangedSubview(stripeOne)
            mainStackView.addArrangedSubview(watchStackView)
            mainStackView.addArrangedSubview(stripeTwo)
            mainStackView.addArrangedSubview(actionStackView)
            
            contentView.addView(mainStackView)
            contentView.addView(customSegmentedControl)
            contentView.addView(aboutMovieLabel)
            contentView.addView(reviewsCollectionView)
        }
        
        private func configureSubviews() {
            
            mainScrollView.showsVerticalScrollIndicator = false
            
            posterFilmImageView.image = presenter.image
            
            nameMovieLabel.configureLabel(
                text: presenter.title,
                font: .interBold(of: 18),
                color: .white,
                alignment: .center
            )
            
            nameMovieLabel.numberOfLines = 0
            
            blurView.layer.cornerRadius = 8
            blurView.clipsToBounds = true
            
            ratingLabel.configureLabel(
                text: "\(presenter.rating)",
                font: .interBold(of: 12),
                color: .Colors.orange,
                alignment: .center
            )
            
            star.image = UIImage(systemName: "star")
            star.tintColor = .Colors.orange
            star.contentMode = .scaleAspectFit
            
            calendarImageView.configureImage(
                named: "CalendarBlank",
                tintColor: .Colors.Font.lightGray
            )
            
            yearFilmLabel.configureLabel(
                text: "\(presenter.year)",
                font: .interMedium(of: 12),
                color: .Colors.Font.lightGray
            )
            
            stripeOne.backgroundColor = .Colors.Font.lightGray
            stripeOne.widthAnchor.constraint(equalToConstant: 1).isActive = true
            stripeOne.heightAnchor.constraint(equalToConstant: 16).isActive = true
            
            calendarStackView.configureStackView(
                axis: .horizontal,
                spacing: 5,
                alignment: .center
            )
            
            watchImageView.configureImage(
                named: "MovieLength",
                tintColor: .Colors.Font.lightGray
            )
            
            movieLengthLabel.configureLabel(
                text: "\(presenter.movieLength) \(String.Localization.minutes)",
                font: .interMedium(of: 12),
                color: .Colors.Font.lightGray,
                numberOfLines: 1
            )
            
            stripeTwo.backgroundColor = .Colors.Font.lightGray
            stripeTwo.widthAnchor.constraint(equalToConstant: 1).isActive = true
            stripeTwo.heightAnchor.constraint(equalToConstant: 16).isActive = true
            
            watchStackView.configureStackView(
                axis: .horizontal,
                spacing: 5,
                alignment: .center
            )
            
            actionImageView.configureImage(
                named: "Genres",
                tintColor: .Colors.Font.lightGray
            )
            
            genresFilmLabel.configureLabel(
                text: presenter.genres,
                font: .interMedium(of: 12),
                color: .Colors.Font.lightGray,
                numberOfLines: 0
            )
            
            actionStackView.configureStackView(
                axis: .horizontal,
                spacing: 5,
                alignment: .center
            )
            
            mainStackView.configureStackView(
                axis: .horizontal,
                spacing: 10,
                alignment: .center,
                distribution: .equalCentering
            )
            
            customSegmentedControl.buttonTitles = ["About Movie", "Reviews", "Cast"]
            
            aboutMovieLabel.configureLabel(
                text: presenter.aboutMovie,
                font: .interRegular(of: 12),
                color: .white,
                numberOfLines: 0
            )
            
            reviewsCollectionView.dataSource = self
            reviewsCollectionView.delegate = self
            
            reviewsCollectionView.isHidden = true
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
                
                posterFilmImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                posterFilmImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                posterFilmImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                posterFilmImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
                
                blurView.bottomAnchor.constraint(equalTo: posterFilmImageView.bottomAnchor, constant: -8),
                blurView.trailingAnchor.constraint(equalTo: posterFilmImageView.trailingAnchor, constant: -8),
                blurView.heightAnchor.constraint(equalToConstant: 24),
                blurView.widthAnchor.constraint(equalToConstant: 54),
                
                star.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
                star.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 3),
                star.widthAnchor.constraint(equalToConstant: 16),
                star.heightAnchor.constraint(equalToConstant: 16),
                
                ratingLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
                ratingLabel.leadingAnchor.constraint(equalTo: star.trailingAnchor, constant: 3),
                ratingLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -3),
                
                nameMovieLabel.topAnchor.constraint(equalTo: posterFilmImageView.bottomAnchor, constant: 20),
                nameMovieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                nameMovieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                
                mainStackView.topAnchor.constraint(equalTo: nameMovieLabel.bottomAnchor, constant: 18),
                mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                mainStackView.heightAnchor.constraint(equalToConstant: 32),
                
                customSegmentedControl.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
                customSegmentedControl.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
                customSegmentedControl.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
                customSegmentedControl.heightAnchor.constraint(equalToConstant: 20),
                
                aboutMovieLabel.topAnchor.constraint(equalTo: customSegmentedControl.bottomAnchor, constant: 25),
                aboutMovieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                aboutMovieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                
                reviewsCollectionView.topAnchor.constraint(equalTo: customSegmentedControl.bottomAnchor, constant: 25),
                reviewsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                reviewsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                reviewsCollectionView.heightAnchor.constraint(equalToConstant: 200),
                reviewsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
        }
        
        private func setupActions() { }
    }
}

// MARK: - CustomSegmentedControlDelegate -

extension Detail.View: DetailView, CustomSegmentedControlDelegate {
    func change(to index: Int) {
        switch index {
        case 0:
            aboutMovieLabel.text = presenter.aboutMovie
            aboutMovieLabel.isHidden = false
            reviewsCollectionView.isHidden = true
            
        case 1:
            aboutMovieLabel.isHidden = true
            reviewsCollectionView.isHidden = false
            
            reviewsCollectionView.reloadData()
            
        case 2:
            aboutMovieLabel.isHidden = true
            reviewsCollectionView.isHidden = true
            
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout -

extension Detail.View: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource Methods -
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 5 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReviewsCell.reuseId,
            for: indexPath) as! ReviewsCell
        
        cell.profileImageView.image = UIImage(named: "photoUser")
        cell.usernameLabel.text = presenter.author
        cell.ratingLabel.text = "6.3"
        cell.commentLabel.text = presenter.review
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout Methods -
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 16 // Adjust width as needed
        let height: CGFloat = 150 // Adjust height as needed
        return CGSize(width: width, height: height)
    }
}

// MARK: - UIGestureRecognizerDelegate -

extension Detail.View: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

