//
//  HistoryScrean.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 01.11.2022.
//

import UIKit

protocol HistoryManager: AnyObject {
    func getDay() -> Day
    func getDate() -> String
    func showTaskDifinition(index: Int)
    func deleteTask(index: Int)
}

class HistoryScreen: UIView {

//    MARK: - UIObjects
    
    var historyLabel: UILabel = {
        var timeTextLabel = UILabel()
        timeTextLabel.text = "Дата"
        timeTextLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeTextLabel
    }()
    
    private var viewForTimeReview: UIView = {
        var viewForTimeReview = UIView()
        viewForTimeReview.backgroundColor = .secondarySystemBackground
        viewForTimeReview.layer.cornerRadius = totalCornerRadius
        viewForTimeReview.translatesAutoresizingMaskIntoConstraints = false
        return viewForTimeReview
    }()
    
    private var totalTimeTextLabel: UILabel = {
        var totalTimeTextLabel = UILabel()
        totalTimeTextLabel.text = "Общее время"
        totalTimeTextLabel.textColor = .secondaryLabel
        totalTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        totalTimeTextLabel.textAlignment = .center
        totalTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeTextLabel
    }()
    
    var totalTimeDataLabel: UILabel = {
        var totalTimeDataLabel = UILabel()
        totalTimeDataLabel.text = "-"
        totalTimeDataLabel.font = .systemFont(ofSize: textSize1, weight: .regular)
        totalTimeDataLabel.textAlignment = .center
        totalTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeDataLabel
    }()
    
    private var stackForTextLabel: UIStackView = {
        var stackForTextLabel = UIStackView()
        stackForTextLabel.axis = .horizontal
        stackForTextLabel.distribution = .fillEqually
        stackForTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTextLabel
    }()
    
    private var workTimeTextLabel: UILabel = {
        var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = "Время работы"
        workTimeTextLabel.textColor = .secondaryLabel
        workTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
   
    private var breakTimeTextLabel: UILabel = {
        var breakTimeTextLabel = UILabel()
        breakTimeTextLabel.text = "Время отдыха"
        breakTimeTextLabel.textColor = .secondaryLabel
        breakTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        breakTimeTextLabel.textAlignment = .center
        breakTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeTextLabel
    }()
    
    private var stackForDataLabel: UIStackView = {
        var stackForTextLabel = UIStackView()
        stackForTextLabel.axis = .horizontal
        stackForTextLabel.distribution = .fillEqually
        stackForTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTextLabel
    }()
    
    var workTimeDataLabel: UILabel = {
        var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = "-"
        workTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    var breakTimeDataLabel: UILabel = {
        var breakTimeDataLabel = UILabel()
        breakTimeDataLabel.text = "-"
        breakTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        breakTimeDataLabel.textAlignment = .center
        breakTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeDataLabel
    }()
    
    lazy var tasksTableView: UITableView = {
        var tasksTableView = UITableView()
        tasksTableView.backgroundColor = .secondarySystemBackground
        tasksTableView.layer.cornerRadius = totalCornerRadius
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        tasksTableView.separatorInset = .zero
        return tasksTableView
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: HistoryManager?
    

//    MARK: - Layout
    
    private func layout() {
        
        [historyLabel, viewForTimeReview, tasksTableView].forEach { addSubview($0) }
        
        [totalTimeTextLabel, totalTimeDataLabel, stackForTextLabel, stackForDataLabel].forEach { viewForTimeReview.addSubview($0) }
        
        [workTimeTextLabel, breakTimeTextLabel].forEach { stackForTextLabel.addArrangedSubview($0) }
        [workTimeDataLabel, breakTimeDataLabel].forEach { stackForDataLabel.addArrangedSubview($0) }
        
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8
        
        NSLayoutConstraint.activate([
            historyLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            historyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            
            viewForTimeReview.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: safeIndent1),
            viewForTimeReview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: safeIndent1),
            viewForTimeReview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -safeIndent1),
            
            totalTimeTextLabel.topAnchor.constraint(equalTo: viewForTimeReview.topAnchor, constant: safeIndent1),
            totalTimeTextLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            totalTimeTextLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            
            totalTimeDataLabel.topAnchor.constraint(equalTo: totalTimeTextLabel.bottomAnchor),
            totalTimeDataLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            totalTimeDataLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            
            stackForTextLabel.topAnchor.constraint(equalTo: totalTimeDataLabel.bottomAnchor, constant: safeIndent1),
            stackForTextLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            stackForTextLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            
            stackForDataLabel.topAnchor.constraint(equalTo: stackForTextLabel.bottomAnchor),
            stackForDataLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            stackForDataLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            stackForDataLabel.bottomAnchor.constraint(equalTo: viewForTimeReview.bottomAnchor, constant: -safeIndent1),
            
            tasksTableView.topAnchor.constraint(equalTo: viewForTimeReview.bottomAnchor, constant: safeIndent1),
            tasksTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            tasksTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            tasksTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -safeIndent2)
        ])
    }

    
//    MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//    MARK: - Расширение UITableViewDataSource

extension HistoryScreen: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day = delegate?.getDay()
        return day?.tasks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
//        TODO: - разобраться с background
        cell.backgroundColor = .clear
        
        if let day = delegate?.getDay() {
            cell.pullCell(taskData: day.tasks[indexPath.row])
            return cell
        } else {
            return cell
        }
    }
}


//    MARK: - Расширение UITableViewDelegate

extension HistoryScreen: UITableViewDelegate {
    //    Возвращает динамическую высоту ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showTaskDifinition(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") {_,_,_ in

            self.delegate?.deleteTask(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeActions
    }
}
