import UIKit

struct WatchList { }

protocol WatchListView: ViewDelegate { }

func showConfirmationAlert(title: String, message: String, yesButtonTitle: String, noButtonTitle: String, yesCompletion: @escaping () -> Void, noCompletion: @escaping () -> Void) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let yesAction = UIAlertAction(title: yesButtonTitle, style: .default) { _ in
        DispatchQueue.main.async {
            yesCompletion()
        }
    }
    alertController.addAction(yesAction)
    
    let noAction = UIAlertAction(title: noButtonTitle, style: .cancel) { _ in
        DispatchQueue.main.async {
            noCompletion()
        }
    }
    alertController.addAction(noAction)
    
    if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
        rootViewController.present(alertController, animated: true, completion: nil)
    }
}
