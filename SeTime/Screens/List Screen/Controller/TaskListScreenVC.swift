//
//  TaskListScreenVC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 22.01.2023.
//

import UIKit

protocol StartTasksProtocol: AnyObject {
    func startTask(name: String, definition: String)
}

class TaskListScreenVC: UIViewController {
    
    // MARK: - Экземпляр TaskListScreen
    
    lazy var taskListScreen: TaskListScreen = {
        let taskListScreen = TaskListScreen()
        taskListScreen.delegate = self
        taskListScreen.tasksTableView.dataSource = self
        taskListScreen.tasksTableView.delegate = self
        taskListScreen.tasksTableView.dragDelegate = self
        taskListScreen.tasksTableView.dropDelegate = self
        return taskListScreen
    }()
    
    // MARK: - Массив задач
    
    var tasks: [TaskList] = []
    
    private func setupData() {
        tasks = RealmManager.shared.getTaskList()
    }
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = taskListScreen
        setupData()
        taskListScreen.tasksTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Delegate
    
    weak var delegate: StartTasksProtocol?
}

// MARK: - UITableViewDataSource

extension TaskListScreenVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskListCell.identifier, for: indexPath) as? TaskListCell
        
        guard let tableViewCell = cell else { return UITableViewCell() }
        
        tableViewCell.pullCell(taskData: tasks[indexPath.row])
        
        return tableViewCell
    }
}

// MARK: - UITableViewDelegate

extension TaskListScreenVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTaskDifinition(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") {_, _, _ in
            self.deleteTask(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let start = UIContextualAction(style: .normal, title: "") {_, _, completionHandler in
            self.startTask(index: indexPath.row)
            completionHandler(true)
        }
        start.backgroundColor = mainColorTheme
        start.image = UIImage(systemName: "play.fill")
        let swipeActions = UISwipeActionsConfiguration(actions: [start])
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let elementToMove = tasks[fromIndexPath.row]
        tasks.remove(at: fromIndexPath.row)
        tasks.insert(elementToMove, at: to.row)
        
        RealmManager.shared.updateSortTasksList(tasks: tasks)
        tasks = RealmManager.shared.getTaskList()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - UITableViewDragDelegate

extension TaskListScreenVC: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

// MARK: - UITableViewDropDelegate

extension TaskListScreenVC: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
}

// MARK: - Протокол делегата TaskListScreen

extension TaskListScreenVC: TaskListProtocol {
    func addTask() {
        let taskAddVC = AddTaskScreenVC()
        taskAddVC.delegate = self
        present(taskAddVC, animated: true)
    }
}

// MARK: - Расширение функционала для TableView TaskListScreen

extension TaskListScreenVC {
    func showTaskDifinition(index: Int) {
        let definitionTaskVC = DefinitionTaskScreenVC()
        definitionTaskVC.taskIndex = index
        definitionTaskVC.name = tasks[index].name
        definitionTaskVC.definition = tasks[index].definition
        definitionTaskVC.delegate = self
        present(definitionTaskVC, animated: true)
    }
    
    func startTask(index: Int) {
        let task = tasks[index]
        
        delegate?.startTask(name: task.name, definition: task.definition)
        
        RealmManager.shared.deleteTaskList(index: index)
        tasks = RealmManager.shared.getTaskList()
        taskListScreen.tasksTableView.reloadData()
    }
    
    func deleteTask(index: Int) {
        RealmManager.shared.deleteTaskList(index: index)
        tasks = RealmManager.shared.getTaskList()
        taskListScreen.tasksTableView.reloadData()
    }
}
