
import UserNotifications
import Foundation
import UIKit

enum Difficulty : Int,Codable{
    case easy = 0
    case medium = 1
    case hard = 2
}

struct ConstructorTask: Codable{
    var task: String
    var isCompleted: Bool
    var difficulty : Difficulty
}

extension Difficulty{
    func toString() -> String{
        switch self{
            case .easy:
                return "easy"
            case .medium:
                return "medium"
            case .hard:
                return "hard"
        }
    }
    
    func fromString(_ string: String) -> Difficulty{
        switch string{
        case "easy":
            return .easy
        case "medium":
            return .medium
        case "hard":
            return .hard
        default:
            return .easy
        }
    }
}
