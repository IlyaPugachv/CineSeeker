import UIKit

extension Home {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews -
       
        private let topLabel: UILabel = .init()
       
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
            view.addView(topLabel)
        }
        
        private func configureSubviews() {
            
            topLabel.configureLabel(
                text: .Localization.whatDoYouWanToWatch, 
                font: .interSemibold(of: 18),
                color: .white,
                alignment: .left)

        }
        
        private func layoutSubviews() {

            NSLayoutConstraint.activate([
            
                topLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
                topLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
                topLabel.widthAnchor.constraint(equalToConstant: 317),
                topLabel.heightAnchor.constraint(equalToConstant: 27),
            
            ])
            
        }
        
        private func setupActions() {

        
        }
    }
}

// MARK: - Extension View -

extension Home.View: HomeView { }

