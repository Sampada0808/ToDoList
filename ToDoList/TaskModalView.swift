import SwiftUI

struct TaskModalView: View {
    @State var  task : String = ""
    @State var priority : TaskPriority = .normal
    @State var showAlert : Bool = false
    @Binding var tasks : [TasksModel]
    var editTask : TasksModel?
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    #if os(iOS)
    fileprivate var iosLayout : some View {
        VStack(alignment: .leading) {
            if horizontalSizeClass == .regular && verticalSizeClass == .compact || horizontalSizeClass == .compact && verticalSizeClass == .compact {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .font(.system(size: 15, weight: .semibold))
                            .frame(width: 20,height: 20)
                            .foregroundStyle(.black)
                    }
                }
            }
            
            if UIDevice.isIPad {
                Spacer()
            }
            Text("Task Title")
                .if(UIDevice.isIPad, transform: { view in
                    view.font(.system(size: 30, weight: .semibold))
                })
                .if(UIDevice.isIPhone, transform: { view in
                    view.font(.system(size: 20, weight: .bold))
                })
            TextField("Do grocery Shopping", text: $task)
                .keyboardType(.asciiCapable)
                .textFieldStyle(.roundedBorder)
                .if(UIDevice.isIPad, transform: { view in
                    view.font(.system(size: 30, weight: .semibold))
                })
                .if(UIDevice.isIPhone, transform: { view in
                    view.font(.system(size: 30, weight: .bold))
                })
            Text("Priority")
                .if(UIDevice.isIPad, transform: { view in
                    view.font(.system(size: 30, weight: .semibold))
                })
                .if(UIDevice.isIPhone, transform: { view in
                    view.font(.system(size: 20, weight: .bold))
                })
            Picker("Priority", selection: $priority) {
                Text("\(TaskPriority.urgent.title)").tag(TaskPriority.urgent)
                
                Text("\(TaskPriority.normal.title)").tag(TaskPriority.normal)
                Text("\(TaskPriority.optional.title)").tag(TaskPriority.optional)
            }
            
            Button {
                if task.isEmpty {
                    showAlert = true
                }else{
                    addTask()
                }
                
            } label: {
                Text(editTask != nil ? "Update Task" : "Add Task")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.top, 20)

            Spacer()
        }
        .onAppear {
            if let editTask = editTask {
                self.task = editTask.task
                self.priority = editTask.priority
            }
        }
        .padding(20)
        .alert("Invalid", isPresented: $showAlert) {
            
        } message: {
            Text("Please Enter some task")
        }
    }
    #endif
    
    #if os(macOS)
    fileprivate var macLayout : some View {
        VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .font(.system(size: 15, weight: .semibold))
                            .frame(width: 20,height: 20)
                            .foregroundStyle(.black)
                    }
                }
                .buttonStyle(.plain)
            
            Text("Task Title")
                .font(.system(size: 20, weight: .bold))
            TextField("Do grocery Shopping", text: $task)
                .textFieldStyle(.roundedBorder)
                .font(.system(size: 15, weight: .semibold))
            Text("Priority")
                .font(.system(size: 20, weight: .semibold))
            Picker("Priority", selection: $priority) {
                Text("\(TaskPriority.urgent.title)").tag(TaskPriority.urgent)
                
                Text("\(TaskPriority.normal.title)").tag(TaskPriority.normal)
                Text("\(TaskPriority.optional.title)").tag(TaskPriority.optional)
            }
            
            Button {
                if task.isEmpty {
                    showAlert = true
                }else{
                    addTask()
                }
                
            } label: {
                Text(editTask != nil ? "Update Task" : "Add Task")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
            .padding(.top, 20)

            Spacer()
        }
        .frame(width: 350)
        .onAppear {
            if let editTask = editTask {
                self.task = editTask.task
                self.priority = editTask.priority
            }
        }
        .padding(20)
        .alert("Invalid", isPresented: $showAlert) {
            
        } message: {
            Text("Please Enter some task")
        }
    }
    #endif
    var body: some View {
        #if os(iOS)
        iosLayout
        #elseif os(macOS)
        macLayout
        #endif

    }
    
    func addTask(){
        if let editTask = editTask , let index = tasks.firstIndex(where: { $0.id == editTask.id }){
            tasks[index].task = task
            tasks[index].priority = priority
            
        }else{
            let task = TasksModel(task: task, priority: priority, doneTask: false)
            tasks.append(task)
        }
        dismiss()
        
    }
}

#Preview {
    TaskModalView(tasks: .constant([]))
}
