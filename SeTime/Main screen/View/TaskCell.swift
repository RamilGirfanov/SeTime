//
//  TaskCell.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 19.06.2022.
//

/// В этом файле:
/// - создается ячейка для UITableView
/// - нстраивается внешний вид ячейки
/// - кнопкам добавляются методы из расшитения для ячейки
/// - создаются объекты для управления таймером и архивом задач


import UIKit

class TaskCell: UITableViewCell {

    //    MARK: - Инициализатор

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Создание и настройка объектов для кастомизации ячейки

//    private lazy var view: UIView = {
//        lazy var view = UIView()
//        view.backgroundColor = .systemGray6
//        view.layer.cornerRadius = totalCornerRadius
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    private lazy var taskText: UITextView = {
//        lazy var taskText = UITextView()
//        taskText.backgroundColor = .systemGray6
//        taskText.layer.cornerRadius = totalCornerRadius
//        taskText.translatesAutoresizingMaskIntoConstraints = false
//        return taskText
//    }()
//
//    lazy var timeLabel: UILabel = {
//        lazy var timeLabel = UILabel()
//        timeLabel.text = "0c"
//        timeLabel.textAlignment = .center
//        timeLabel.translatesAutoresizingMaskIntoConstraints = false
//        return timeLabel
//    }()
//
//    lazy var startButton: UIButton = {
//        lazy var startButton = UIButton()
//        startButton.setTitle("Старт", for: .normal)
//        startButton.setTitleColor(.black, for: .normal)
//        startButton.backgroundColor = mainColorTheme
//        startButton.layer.cornerRadius = totalCornerRadius
//        startButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
//        startButton.translatesAutoresizingMaskIntoConstraints = false
//        startButton.addTarget(self, action: #selector(startTap), for: .touchUpInside)
//        return startButton
//    }()
//
//    @objc func startTap() {
//        startTaskTimer()
//        pauseButton.isHidden = false
//    }
//
//    lazy var pauseButton: UIButton = {
//        lazy var pauseButton = UIButton()
//        pauseButton.setTitle("Стоп", for: .normal)
//        pauseButton.setTitleColor(.black, for: .normal)
//        pauseButton.backgroundColor = mainColorTheme
//        pauseButton.layer.cornerRadius = totalCornerRadius
//        pauseButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
//        pauseButton.isHidden = true
//        pauseButton.translatesAutoresizingMaskIntoConstraints = false
//        pauseButton.addTarget(self, action: #selector(pauseTap), for: .touchUpInside)
//        return pauseButton
//    }()
//
//    @objc func pauseTap() {
//        stopTaskTimer()
//    }

    
    lazy var taskName: UILabel = {
        lazy var taskName = UILabel()
        taskName.translatesAutoresizingMaskIntoConstraints = false
        return taskName
    }()
    
    lazy var taskDuration: UILabel = {
        lazy var taskDuration = UILabel()
        taskDuration.textAlignment = .center
        taskDuration.translatesAutoresizingMaskIntoConstraints = false
        return taskDuration
    }()
    
    lazy var taskStartAndStop: UILabel = {
        lazy var taskStartAndStop = UILabel()
        taskStartAndStop.textAlignment = .center
        taskStartAndStop.translatesAutoresizingMaskIntoConstraints = false
        return taskStartAndStop
    }()
    
    lazy var stackForTaskTime: UIStackView = {
        lazy var stackForTaskLabel = UIStackView()
        stackForTaskLabel.axis = .vertical
        stackForTaskLabel.distribution = .fillEqually
        stackForTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTaskLabel
    }()
    
    
    //    MARK: - Расстановка объектов в ячейке

    private func layout() {
        [taskName, taskDuration, taskStartAndStop, stackForTaskTime].forEach { contentView.addSubview($0) }
        [taskDuration, taskStartAndStop].forEach { stackForTaskTime.addArrangedSubview($0) }

        
        let safeIndent: CGFloat = 8
        
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: contentView.topAnchor),
            taskName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent),
            taskName.trailingAnchor.constraint(equalTo: stackForTaskTime.leadingAnchor, constant: -safeIndent),
            taskName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackForTaskTime.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackForTaskTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent),
            stackForTaskTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
        
    //    MARK: - Заполнение ячеек данными
    
    func pullCell(taskData: Task) {
        taskName.text = taskData.taskName
        
        if taskData.duration < 60 {
            taskDuration.text = "\(taskData.duration)с"
        } else if taskData.duration < 3600 {
            taskDuration.text = "\(taskData.duration / 60)м \(taskData.duration % 60)с"
        } else {
            taskDuration.text = "\(taskData.duration / 3600)ч \((taskData.duration % 3600) / 60)м"
        }
        
        taskStartAndStop.text = "\(taskData.startTime) - \(taskData.stopTime)"

    }
    
////    MARK: - Для работы со временем задачи
//
////    Для обращения в массив с задачами в дне
//    lazy var numberOfCell = 0
//
//    lazy var taskTimer = Timer()
//    lazy var taskTime = 0
//
}
