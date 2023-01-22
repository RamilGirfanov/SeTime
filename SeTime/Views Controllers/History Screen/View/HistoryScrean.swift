//
//  HistoryScrean.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 01.11.2022.
//

import UIKit

final class HistoryScreen: UIView {

//    MARK: - UIObjects
    
    var historyLabel: UILabel = {
        var timeTextLabel = UILabel()
        timeTextLabel.text = NSLocalizedString("date", comment: "")
        timeTextLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeTextLabel
    }()
    
    var viewForTimeReview: ViewForTimeReview = {
        var viewForTimeReview = ViewForTimeReview()
        viewForTimeReview.layer.cornerRadius = totalCornerRadius
        return viewForTimeReview
    }()
        
    lazy var tasksTableView: UITableView = {
        var tasksTableView = UITableView()
        tasksTableView.backgroundColor = .secondarySystemBackground
        tasksTableView.layer.cornerRadius = totalCornerRadius
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        tasksTableView.separatorInset = .zero
        return tasksTableView
    }()
    

//    MARK: - Layout
    
    private func layout() {
        
        [historyLabel, viewForTimeReview, tasksTableView].forEach { addSubview($0) }
    
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8
        
        NSLayoutConstraint.activate([
            historyLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            historyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            
            viewForTimeReview.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: safeIndent1),
            viewForTimeReview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: safeIndent1),
            viewForTimeReview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -safeIndent1),
            
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
