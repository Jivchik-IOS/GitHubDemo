
import Foundation

protocol TasksViewModelProtocol {
    var toDoItems: [ConstructorTask] { get set }
    func addTask(newItem: String, isCompleted: Bool, difficulty: Difficulty)
    func removeItem(at index: Int)
    func changeState(at item: Int) -> Bool
    func checkDifficulty(at item: Int) -> Difficulty
    func moveItem(from indexF: Int, to indexT: Int)
    func requestForNotification()
    func getTasksCount() -> Int
    func getTask(at index: Int) -> ConstructorTask
}
