import UIKit

extension Search {
    class View: UIViewController {
        
        // MARK: - Properties -
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews -
       
        private let searchTextField: UITextField = .init()
       
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

        }
        
        private func layoutSubviews() {
            
            NSLayoutConstraint.activate([
                
                searchTextField.topAnchor.constraint(equalTo: safeArea.topAnchor),
                searchTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
                searchTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
                searchTextField.widthAnchor.constraint(equalToConstant: 327),
                searchTextField.heightAnchor.constraint(equalToConstant: 42),
                
            ])

        }
        
        private func setupActions() {

        
        }
    }
}

// MARK: - Extension View -

extension Search.View: SearchView { }


