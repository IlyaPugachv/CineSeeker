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
        private let rating: UILabel = .init()
        
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
            blurView.contentView.addView(rating)
        }
        
        private func configureSubviews() {
            
            posterFilmImageView.image = presenter.image
            posterFilmImageView.contentMode = .scaleAspectFill
            
            nameMovieLabel.configureLabel(
                text: presenter.title,
                font: .interSemibold(of: 18),
                color: .white,
                alignment: .center
            )
            
            nameMovieLabel.numberOfLines = 0
            
            rating.configureLabel(
                text: "\(presenter.rating)",
                font: .interBold(of: 15),
                color: .Colors.orange,
                alignment: .center)
        }
        
        private func layoutSubviews() {
            
            NSLayoutConstraint.activate([
                
                posterFilmImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
                posterFilmImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                posterFilmImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                posterFilmImageView.heightAnchor.constraint(equalToConstant: 200),
                
                blurView.bottomAnchor.constraint(equalTo: posterFilmImageView.bottomAnchor),
                blurView.trailingAnchor.constraint(equalTo: posterFilmImageView.trailingAnchor, constant: -12),
                blurView.heightAnchor.constraint(equalToConstant: 24),
                blurView.widthAnchor.constraint(equalToConstant: 54),
                
                rating.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
                rating.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
                
                nameMovieLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -175),
                nameMovieLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
                nameMovieLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
                
            ])
        }
        
        private func setupActions() {
            
            
        }
    }
}

// MARK: - Extension View -

extension Detail.View: DetailView { }



