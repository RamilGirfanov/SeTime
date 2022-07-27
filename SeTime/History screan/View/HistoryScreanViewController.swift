//
//  HistoryScreanViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit

class HistoryScreanViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        setupData()
        
    }
    
  
    //    MARK: - UIObjects

    lazy var historyLabel: UILabel = {
        lazy var timeTextLabel = UILabel()
        timeTextLabel.text = "Дата"
        timeTextLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeTextLabel
    }()

    lazy var viewForTimeReview: UIView = {
        lazy var viewForTimeReview = UIView()
        viewForTimeReview.backgroundColor = .systemGray6
        viewForTimeReview.layer.cornerRadius = totalCornerRadius
        viewForTimeReview.translatesAutoresizingMaskIntoConstraints = false
        return viewForTimeReview
    }()
    
    lazy var workTimeTextLabel: UILabel = {
        lazy var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = "Время работы"
        workTimeTextLabel.textColor = .systemGray
        workTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    lazy var workTimeDataLabel: UILabel = {
        lazy var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = "0c"
        workTimeTextLabel.font = .systemFont(ofSize: textSize1, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    lazy var stackForTextLabel: UIStackView = {
        lazy var stackForTextLabel = UIStackView()
        stackForTextLabel.axis = .horizontal
        stackForTextLabel.distribution = .fillEqually
        stackForTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTextLabel
    }()
    
    lazy var totalTimeTextLabel: UILabel = {
        lazy var totalTimeTextLabel = UILabel()
        totalTimeTextLabel.text = "Общее время"
        totalTimeTextLabel.textColor = .systemGray
        totalTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        totalTimeTextLabel.textAlignment = .center
        totalTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeTextLabel
    }()
    
    lazy var breakTimeTextLabel: UILabel = {
        lazy var breakTimeTextLabel = UILabel()
        breakTimeTextLabel.text = "Время отдыха"
        breakTimeTextLabel.textColor = .systemGray
        breakTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        breakTimeTextLabel.textAlignment = .center
        breakTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeTextLabel
    }()
    
    lazy var stackForDataLabel: UIStackView = {
        lazy var stackForTextLabel = UIStackView()
        stackForTextLabel.axis = .horizontal
        stackForTextLabel.distribution = .fillEqually
        stackForTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTextLabel
    }()
    
    lazy var totalTimeDataLabel: UILabel = {
        lazy var totalTimeDataLabel = UILabel()
        totalTimeDataLabel.text = "0с"
        totalTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        totalTimeDataLabel.textAlignment = .center
        totalTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeDataLabel
    }()
    
    lazy var breakTimeDataLabel: UILabel = {
        lazy var breakTimeDataLabel = UILabel()
        breakTimeDataLabel.text = "0с"
        breakTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        breakTimeDataLabel.textAlignment = .center
        breakTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeDataLabel
    }()
    
    lazy var tasksTableView: UITableView = {
        lazy var tasksTableView = UITableView()
        tasksTableView.backgroundColor = .systemGray6
        tasksTableView.layer.cornerRadius = totalCornerRadius
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        return tasksTableView
    }()
    
    //    MARK: - Layout
    
    private func layout() {
        
        [historyLabel, viewForTimeReview, tasksTableView].forEach { view.addSubview($0) }
        
        [workTimeTextLabel, workTimeDataLabel, stackForTextLabel, stackForDataLabel].forEach { viewForTimeReview.addSubview($0) }
        
        [totalTimeTextLabel, breakTimeTextLabel].forEach { stackForTextLabel.addArrangedSubview($0) }
        [totalTimeDataLabel, breakTimeDataLabel].forEach { stackForDataLabel.addArrangedSubview($0) }
                                
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8
        
        NSLayoutConstraint.activate([
            historyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            historyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            
            viewForTimeReview.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: safeIndent1),
            viewForTimeReview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: safeIndent1),
            viewForTimeReview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -safeIndent1),
            
            workTimeTextLabel.topAnchor.constraint(equalTo: viewForTimeReview.topAnchor, constant: safeIndent1),
            workTimeTextLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            workTimeTextLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            
            workTimeDataLabel.topAnchor.constraint(equalTo: workTimeTextLabel.bottomAnchor),
            workTimeDataLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            workTimeDataLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            
            stackForTextLabel.topAnchor.constraint(equalTo: workTimeDataLabel.bottomAnchor, constant: safeIndent1),
            stackForTextLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            stackForTextLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            
            stackForDataLabel.topAnchor.constraint(equalTo: stackForTextLabel.bottomAnchor),
            stackForDataLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            stackForDataLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            stackForDataLabel.bottomAnchor.constraint(equalTo: viewForTimeReview.bottomAnchor, constant: -safeIndent1),

            tasksTableView.topAnchor.constraint(equalTo: viewForTimeReview.bottomAnchor, constant: safeIndent2),
            tasksTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            tasksTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            tasksTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -safeIndent2)
        ])
        
    }
    
}
