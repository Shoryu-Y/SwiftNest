import Charcoal
import UIKit

public final class CharcomponentViewController: UIViewController {
    public static let storyboard = UIStoryboard(name: "CharcomponentViewController", bundle: .module)
        .instantiateInitialViewController(creator: { coder in
            CharcomponentViewController.init(coder: coder)
        })!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
