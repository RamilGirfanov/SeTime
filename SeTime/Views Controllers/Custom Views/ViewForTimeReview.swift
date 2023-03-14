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
    
    private var stackForTextLabel: UIStackView = {
        var stackForTextLabel = UIStackView()
        stackForTextLabel.axis = .horizontal
        stackForTextLabel.distribution = .fillEqually
        stackForTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTextLabel
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
   
    private var breakTimeTextLabel: UILabel = {
        var breakTimeTextLabel = UILabel()
        breakTimeTextLabel.text = NSLocalizedString("breakTime", comment: "")
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
        workTimeTextLabel.text = "00:00:00"
        workTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    var breakTimeDataLabel: UILabel = {
        var breakTimeDataLabel = UILabel()
        breakTimeDataLabel.text = "00:00:00"
        breakTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        breakTimeDataLabel.textAlignment = .center
        breakTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeDataLabel
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
        [totalTimeTextLabel, totalTimeDataLabel, leftFocusView, rightFocusView, stackForTextLabel, stackForDataLabel].forEach { addSubview($0) }
        
        [workTimeTextLabel, breakTimeTextLabel].forEach { stackForTextLabel.addArrangedSubview($0) }
        [workTimeDataLabel, breakTimeDataLabel].forEach { stackForDataLabel.addArrangedSubview($0) }

        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8

        NSLayoutConstraint.activate([
            totalTimeTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: safeIndent1),
            totalTimeTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            totalTimeTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            totalTimeDataLabel.topAnchor.constraint(equalTo: totalTimeTextLabel.bottomAnchor),
            totalTimeDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            totalTimeDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackForTextLabel.topAnchor.constraint(equalTo: totalTimeDataLabel.bottomAnchor, constant: safeIndent1),
            stackForTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackForTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackForDataLabel.topAnchor.constraint(equalTo: stackForTextLabel.bottomAnchor),
            stackForDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackForDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackForDataLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -safeIndent1),
            
            leftFocusView.topAnchor.constraint(equalTo: stackForTextLabel.topAnchor, constant: -safeIndent2),
            leftFocusView.leadingAnchor.constraint(equalTo: stackForTextLabel.leadingAnchor, constant: safeIndent2),
            leftFocusView.bottomAnchor.constraint(equalTo: stackForDataLabel.bottomAnchor, constant: safeIndent2),
            
            rightFocusView.topAnchor.constraint(equalTo: stackForTextLabel.topAnchor, constant: -safeIndent2),
            rightFocusView.leadingAnchor.constraint(equalTo: leftFocusView.trailingAnchor, constant: safeIndent1),
            rightFocusView.trailingAnchor.constraint(equalTo: stackForTextLabel.trailingAnchor, constant: -safeIndent2),
            rightFocusView.bottomAnchor.constraint(equalTo: stackForDataLabel.bottomAnchor, constant: safeIndent2),
            rightFocusView.widthAnchor.constraint(equalTo: leftFocusView.widthAnchor)
        ])
    }
}
