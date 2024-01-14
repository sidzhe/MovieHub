import UIKit

extension UIStackView {
    func addAllViews(_ views: UIStackView...) {
        views.forEach { addArrangedSubview($0)}
    }
}
