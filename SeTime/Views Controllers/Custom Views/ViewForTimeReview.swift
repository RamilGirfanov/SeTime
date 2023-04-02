//
//  ViewForTimeReview.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 28.11.2022.
//

import UIKit

class ViewForTimeReview: UIView {
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UIObjects
    
    private var totalTimeTextLabel: UILabel = {
        var totalTimeTextLabel = UILabel()
        totalTimeTextLabel.text = NSLocalizedString("totalTime", comment: "")
        totalTimeTextLabel.textColor = .secondaryLabel
        totalTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        totalTimeTextLabel.textAlignment = .center
        totalTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeTextLabel
    }()
    
    var totalTimeDataLabel: UILabel = {
        var totalTimeDataLabel = UILabel()
        totalTimeDataLabel.text = "00:00:00"
        totalTimeDataLabel.font = .systemFont(ofSize: textSize1, weight: .regular)
        totalTimeDataLabel.textAlignment = .center
        totalTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeDataLabel
    }()
    
    private var stackForTotalTime: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var workTimeTextLabel: UILabel = {
        var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = NSLocalizedString("workTime", comment: "")
        workTimeTextLabel.textColor = .secondaryLabel
        workTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    var workTimeDataLabel: UILabel = {
        var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = "00:00:00"
        workTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    private var stackForWorkTime: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var breakTimeTextLabel: UILabel = {
        var breakTimeTextLabel = UILabel()
        breakTimeTextLabel.text = NSLocalizedString("breakTime", comment: "")
        breakTimeTextLabel.textColor = .secondaryLabel
        breakTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        breakTimeTextLabel.textAlignment = .center
        breakTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeTextLabel
    }()
    
    var breakTimeDataLabel: UILabel = {
        var breakTimeDataLabel = UILabel()
        breakTimeDataLabel.text = "00:00:00"
        breakTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        breakTimeDataLabel.textAlignment = .center
        breakTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeDataLabel
    }()
    
    private var stackForBreakTime: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var stackForWBTime: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let leftFocusView: UIView = {
        let leftFocusView = UIView()
        leftFocusView.backgroundColor = .tertiarySystemBackground
        leftFocusView.layer.cornerRadius = totalCornerRadius
        leftFocusView.translatesAutoresizingMaskIntoConstraints = false
        leftFocusView.isHidden = true
        return leftFocusView
    }()
    
    let rightFocusView: UIView = {
        let rightFocusView = UIView()
        rightFocusView.backgroundColor = .tertiarySystemBackground
        rightFocusView.layer.cornerRadius = totalCornerRadius
        rightFocusView.translatesAutoresizingMaskIntoConstraints = false
        rightFocusView.isHidden = true
        return rightFocusView
    }()
    
    
    // MARK: - Layout
    
    private func layout() {
        [stackForTotalTime, leftFocusView, rightFocusView, stackForWBTime].forEach { addSubview($0) }
        
        [totalTimeTextLabel, totalTimeDataLabel].forEach { stackForTotalTime.addArrangedSubview($0) }
        
        [stackForWorkTime, stackForBreakTime].forEach { stackForWBTime.addArrangedSubview($0) }
        
        [workTimeTextLabel, workTimeDataLabel].forEach { stackForWorkTime.addArrangedSubview($0) }
        
        [breakTimeTextLabel, breakTimeDataLabel].forEach { stackForBreakTime.addArrangedSubview($0) }
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8
        
        NSLayoutConstraint.activate([
            stackForTotalTime.topAnchor.constraint(equalTo: topAnchor, constant: safeIndent1),
            stackForTotalTime.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackForTotalTime.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackForWBTime.topAnchor.constraint(equalTo: stackForTotalTime.bottomAnchor, constant: safeIndent1),
            stackForWBTime.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackForWBTime.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackForWBTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -safeIndent1),
            
            leftFocusView.topAnchor.constraint(equalTo: stackForWorkTime.topAnchor, constant: -safeIndent2),
            leftFocusView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: safeIndent2),
            leftFocusView.bottomAnchor.constraint(equalTo: stackForWorkTime.bottomAnchor, constant: safeIndent2),
            
            rightFocusView.topAnchor.constraint(equalTo: stackForBreakTime.topAnchor, constant: -safeIndent2),
            rightFocusView.leadingAnchor.constraint(equalTo: leftFocusView.trailingAnchor, constant: safeIndent1),
            rightFocusView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -safeIndent2),
            rightFocusView.bottomAnchor.constraint(equalTo: stackForBreakTime.bottomAnchor, constant: safeIndent2),
            rightFocusView.widthAnchor.constraint(equalTo: leftFocusView.widthAnchor)
        ])
    }
}
