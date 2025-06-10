import SwiftUI

struct ContentView: View {
    
    @State var tasksList : [TasksModel] = [
        TasksModel(task: "Walk the dog", priority: .optional, doneTask: true),
        TasksModel(task: "Get Groceries", priority: .urgent, doneTask: false),
        TasksModel(task: "Draw something", priority: .normal, doneTask: false),
    ]
    @State var editTask = false
    @State var toEditTask : TasksModel?
    @State var showAddTaskModal : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack{
                List {
                    ForEach($tasksList) { $task in
                        HStack(spacing: 10){
                            Image(systemName: task.doneTask == false ? "circle" : "checkmark.circle" )
                            
                            Text("\(task.task)")
                            Spacer()
                            Text("\(task.priority.title)")
                                .padding(7)
                                .font(.system(size: 15,weight: .bold))
                                .foregroundStyle(task.priority.color)
                                .background(task.priority.color.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                        }
                        .onTapGesture {
                            task.doneTask.toggle()
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button("Edit") {
                                toEditTask = task
                                editTask = true
                            }
                            .tint(.blue)
                        }
                        
                    }
                    .onDelete(perform: deleteTheData)
                    .listRowSeparator(.hidden)
                    
                }
                
                
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem {
                    Button {
                        showAddTaskModal = true
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundStyle(.black)
                            .frame(width: 22, height: 22)
                    }

                }
                
            }
            .sheet(isPresented: $showAddTaskModal) {
                TaskModalView( tasks: $tasksList)
            }
            .sheet(item: $toEditTask) { task in
                TaskModalView( tasks: $tasksList, editTask: task)
            }
        }
        
    }
    
    func deleteTheData(at offset : IndexSet){
        tasksList.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
