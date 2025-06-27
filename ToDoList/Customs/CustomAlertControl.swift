

import UIKit

class CustomAlertControl: UIView {

    //MARK: - Outlets
    
    @IBOutlet var taskField: UITextField!
    
    @IBOutlet var difficultSelect: UISegmentedControl!
    
    @IBOutlet var addTaskButton: UIButton!
    
    //MARK: - Actions
    
    @IBAction func reverseButton(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    
}
