
import UIKit

class TableViewController: UITableViewController {

    private var viewModel = TasksViewModel()
    
    @objc func addButtonTapped(){
        let selectedIndex = customAlertView.difficultSelect.selectedSegmentIndex
        let selectedDifficulty = Difficulty(rawValue: selectedIndex) ?? .easy
        viewModel.addTask(newItem: customAlertView.taskField.text!, difficulty: selectedDifficulty)
        tableView.reloadData()
        customAlertView.removeFromSuperview()
        }
    
    private var customAlertView: CustomAlertControl!
//MARK: - Actions
    
    @IBAction func editButton(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    func setAlert(){
        customAlertView = Bundle.main.loadNibNamed("CustomAlertControl", owner: self, options: nil)?.first as? CustomAlertControl
        view.addSubview(customAlertView)
    }
    
    @IBAction func pushAddAction(_ sender: Any){
        
        setAlert()
        customAlertView.addTaskButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        tableView.reloadData()

    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .separator
        navigationController?.navigationBar.tintColor = .orange
    }

    
    //MARK: - TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTasksCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let task = viewModel.getTask(at: indexPath.row)
        cell.textLabel?.text = task.task
        
        if task.isCompleted{
            cell.imageView?.image = .check
        }else{
            cell.imageView?.image = .checkmarkFalse
        }
        
        switch viewModel.checkDifficulty(at: indexPath.row) {
        case .easy:
            cell.backgroundColor = .systemGreen.withAlphaComponent(0.2)
            cell.textLabel?.textColor = .systemGreen
        case .medium:
            cell.backgroundColor = .systemOrange.withAlphaComponent(0.2)
            cell.textLabel?.textColor = .systemOrange
        case .hard:
            cell.backgroundColor = .systemRed.withAlphaComponent(0.2)
            cell.textLabel?.textColor = .systemRed
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            viewModel.removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if viewModel.changeState(at: indexPath.row){
            tableView.cellForRow(at: indexPath)?.imageView?.image = .check
        }else{
            tableView.cellForRow(at: indexPath)?.imageView?.image = .checkmarkFalse
        }
    
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing{
            return .none
        }else{
            return .delete
        }
        
    }
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
}

