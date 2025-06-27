
import UIKit
import Foundation

final class TasksViewModel : TasksViewModelProtocol{
    func getTasksCount() -> Int {
        return toDoItems.count
    }
    
    func getTask(at index: Int) -> ConstructorTask {
        return toDoItems[index]
    }
    
    var toDoItems: [ConstructorTask]{
        set{
            do{
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: "DataKey")
            } catch{
                print("Данные не сохранены")
            }
        }
        
        get{
            if let data = UserDefaults.standard.data(forKey: "DataKey") {
                do {
                    let decoder = JSONDecoder()
                    return try decoder.decode([ConstructorTask].self, from: data)
                
                } catch {
                    print("Ошибка при загрузке: \(error)")
                    return []
                }
            } else {
                return []
            }
        }
    }

    func addTask(newItem: String, isCompleted: Bool = false,difficulty: Difficulty = .easy){
        toDoItems.append(ConstructorTask(task: newItem, isCompleted: isCompleted, difficulty: difficulty))
        setBadge()
    }

    func removeItem(at index:Int){
        toDoItems.remove(at: index)
        setBadge()
    }


    func changeState(at item: Int) -> Bool{
        toDoItems[item].isCompleted = !toDoItems[item].isCompleted
        setBadge()
        return toDoItems[item].isCompleted
    }

    func checkDifficulty(at item:Int) -> Difficulty{
        return toDoItems[item].difficulty
    }

    func moveItem(from indexF: Int, to indexT: Int){
        let from = toDoItems[indexF]
        toDoItems.remove(at: indexF)
        toDoItems.insert(from, at: indexT)
    }


    func requestForNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
            if !isEnabled{
                print("Согласие не дано")
            }else{
                print("Согласие получено")
            }
        }
    }

    private func setBadge(){
        var totalBadgeNumber = 0
        for item in toDoItems{
            if !item.isCompleted{
                totalBadgeNumber += 1
            }
        }
        UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
    }
}
