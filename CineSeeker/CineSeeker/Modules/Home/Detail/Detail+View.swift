import UIKit

extension Detail {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews -
       
        private let posterFilmImageView: UIImageView = .init()
       
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
            view.backgroundColor = .Colors.darkGray
            view.addView(posterFilmImageView)
        }
        
        private func configureSubviews() {
            
            posterFilmImageView.image = presenter.image
            posterFilmImageView.contentMode = .scaleAspectFill
        }
        
        private func layoutSubviews() {
            
            NSLayoutConstraint.activate([
            
                posterFilmImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
                posterFilmImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                posterFilmImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                posterFilmImageView.heightAnchor.constraint(equalToConstant: 210),
                posterFilmImageView.widthAnchor.constraint(equalToConstant: 375)
            
            
            
            
            
            ])

        }
        
        private func setupActions() {

        
        }
    }
}

// MARK: - Extension View -

extension Detail.View: DetailView { }



