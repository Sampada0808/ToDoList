import Foundation

struct TasksModel : Identifiable, Equatable{
    let id = UUID()
    var task : String
    var priority : TaskPriority
    var doneTask : Bool
}
