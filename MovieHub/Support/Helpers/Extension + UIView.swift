import UIKit

extension UIView {
    func addAllViews(_ views: UIView...) {
        views.forEach { addSubview($0)}
    }
}
