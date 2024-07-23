import UIKit

extension Detail {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews -
        
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
            view.addView(posterFilmImageView)
            view.addView(nameMovieLabel)
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
            
            view.addView(mainStackView)
        }
        
        private func configureSubviews() {
            posterFilmImageView.image = presenter.image
            posterFilmImageView.contentMode = .scaleAspectFill
            posterFilmImageView.clipsToBounds = true
            
            nameMovieLabel.configureLabel(
                text: presenter.title,
                font: .interSemibold(of: 18),
                color: .white,
                alignment: .center
            )
            
            nameMovieLabel.numberOfLines = 0
            
            blurView.layer.cornerRadius = 8
            blurView.clipsToBounds = true
            
            ratingLabel.configureLabel(
                text: "\(presenter.rating)",
                font: .interSemibold(of: 12),
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
        }
        
        private func layoutSubviews() {
            
            NSLayoutConstraint.activate([
                posterFilmImageView.topAnchor.constraint(equalTo: view.topAnchor),
                posterFilmImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                posterFilmImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
                nameMovieLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                nameMovieLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                
                mainStackView.topAnchor.constraint(equalTo: nameMovieLabel.bottomAnchor, constant: 18),
                mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25),
                mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -25),
                mainStackView.heightAnchor.constraint(equalToConstant: 32)
            ])
        }
        
        private func setupActions() { }
    }
}

// MARK: - Extension View -

extension Detail.View: DetailView { }
