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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Создание и настройка объектов для кастомизации ячейки

//    private lazy var view: UIView = {
//        lazy var contentView = UIView()
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        return contentView
//    }()
    
    private lazy var taskText: UITextView = {
        lazy var taskText = UITextView()
        taskText.layer.cornerRadius = totalCornerRadius
        taskText.translatesAutoresizingMaskIntoConstraints = false
        return taskText
    }()
    
    private lazy var timeLabel: UILabel = {
        lazy var timeLabel = UILabel()
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
        return startButton
    }()
    
    private lazy var pauseButton: UIButton = {
        lazy var pauseButton = UIButton()
        pauseButton.setTitle("Стоп", for: .normal)
        pauseButton.setTitleColor(.black, for: .normal)
        pauseButton.backgroundColor = .systemYellow
        pauseButton.layer.cornerRadius = totalCornerRadius
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        return pauseButton
    }()
    
    //    MARK: - Обработка нажатий

    
    
    //    MARK: - Расстановка объектов в ячейке

    private func layout() {
        [taskText, timeLabel, startButton, pauseButton].forEach { contentView.addSubview($0) }
        
        let safeIndent: CGFloat = 8
        
        NSLayoutConstraint.activate([
            taskText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeIndent),
            taskText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent),
            taskText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -safeIndent),
            
            startButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            startButton.widthAnchor.constraint(equalToConstant: totalWidthForTasksButtons),
            startButton.leadingAnchor.constraint(equalTo: taskText.trailingAnchor, constant: safeIndent),
            startButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent),
            startButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -safeIndent),
            
            pauseButton.topAnchor.constraint(equalTo: startButton.topAnchor),
            pauseButton.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            pauseButton.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            pauseButton.bottomAnchor.constraint(equalTo: startButton.bottomAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeIndent),
            timeLabel.leadingAnchor.constraint(equalTo: taskText.trailingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -safeIndent)
        ])
        
        contentView.layer.cornerRadius = totalCornerRadius
    }
    
    //    MARK: - Заполнение ячеек данными

    
    
    //    MARK: - Делегат


}
