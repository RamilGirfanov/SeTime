//
//  TaskCell.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 19.06.2022.
//

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

    private lazy var view: UIView = {
        lazy var view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = totalCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var taskText: UITextView = {
        lazy var taskText = UITextView()
        taskText.layer.cornerRadius = totalCornerRadius
        taskText.translatesAutoresizingMaskIntoConstraints = false
        return taskText
    }()
    
    lazy var timeLabel: UILabel = {
        lazy var timeLabel = UILabel()
        timeLabel.text = "0c"
        timeLabel.textAlignment = .center
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    private lazy var startButton: UIButton = {
        lazy var startButton = UIButton()
        startButton.setTitle("Старт", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = .systemYellow
        startButton.layer.cornerRadius = totalCornerRadius
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startTap), for: .touchUpInside)
        return startButton
    }()
    
    @objc func startTap() {
        startTaskTimer()
        pauseButton.isHidden = false
    }
    
    private lazy var pauseButton: UIButton = {
        lazy var pauseButton = UIButton()
        pauseButton.setTitle("Стоп", for: .normal)
        pauseButton.setTitleColor(.black, for: .normal)
        pauseButton.backgroundColor = .systemYellow
        pauseButton.layer.cornerRadius = totalCornerRadius
        pauseButton.isHidden = true
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.addTarget(self, action: #selector(pauseTap), for: .touchUpInside)
        return pauseButton
    }()
    
    @objc func pauseTap() {
        stopTaskTimer()
        pauseButton.isHidden = true
    }

    //    MARK: - Расстановка объектов в ячейке

    private func layout() {
        [view, taskText, timeLabel, startButton, pauseButton].forEach { contentView.addSubview($0) }
        
        let safeIndent: CGFloat = 8
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeIndent / 2),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -safeIndent / 2),
            
            taskText.topAnchor.constraint(equalTo: view.topAnchor, constant: safeIndent),
            taskText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: safeIndent),
            taskText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -safeIndent),
            
            startButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            startButton.widthAnchor.constraint(equalToConstant: totalWidthForTasksButtons),
            startButton.leadingAnchor.constraint(equalTo: taskText.trailingAnchor, constant: safeIndent),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -safeIndent),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -safeIndent),
            
            pauseButton.topAnchor.constraint(equalTo: startButton.topAnchor),
            pauseButton.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            pauseButton.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            pauseButton.bottomAnchor.constraint(equalTo: startButton.bottomAnchor),
            
            timeLabel.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: safeIndent),
            timeLabel.leadingAnchor.constraint(equalTo: taskText.trailingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -safeIndent)
        ])
        
    }
    
    //    MARK: - Заполнение ячеек данными
    
    func pullCell(taskData: (task: String, lasting: Int)) {
        taskText.text = taskData.task
        timeLabel.text = String(taskData.lasting)
        
        if taskData.lasting < 60 {
            timeLabel.text = "\(taskData.lasting)с"
        } else if taskData.lasting < 3600 {
            timeLabel.text = "\(taskData.lasting / 60)м \(taskData.lasting % 60)с"
        } else {
            timeLabel.text = "\(taskData.lasting / 3600)ч \((taskData.lasting % 3600) / 60)м"
        }
    }
    
//    MARK: - Для работы со временем задачи
    
//    Для обращения в массив с задачами в дне
    lazy var numberOfCell = 0

    lazy var taskTimer = Timer()
    lazy var taskTime = 0
    
}
