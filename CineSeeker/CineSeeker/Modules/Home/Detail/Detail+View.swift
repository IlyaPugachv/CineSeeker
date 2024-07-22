import UIKit

extension Detail {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        
        // MARK: - Subviews -
        
        private let posterFilmImageView: UIImageView = .init()
        private let nameMovieLabel: UILabel = .init()
        
        private let blurView: UIVisualEffectView = .init(effect: UIBlurEffect(style: .light))
        private let star: UIImageView = .init()
        private let ratingLabel: UILabel = .init()
        
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
            ])
        }
        
        private func setupActions() { }
    }
}

// MARK: - Extension View -

extension Detail.View: DetailView { }
