//
//  CalendarViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 24.06.2022.
//

import UIKit

class CalendarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    
//    MARK: - UIObjects

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
          
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var calendarLabel: UILabel = {
        lazy var timeTextLabel = UILabel()
        timeTextLabel.text = "Выбор даты"
        timeTextLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeTextLabel
    }()

    
//    MARK: - Настройка констрейнтов

    private func layout() {
        [calendarLabel, collectionView].forEach { view.addSubview($0) }
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8
        
        NSLayoutConstraint.activate([
            calendarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            calendarLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            
//            ДОБАВИТЬ ХЕДЕР
            
            collectionView.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: safeIndent2),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: safeIndent1)
//            ЗАДАТЬ ВЫСОТУ
            
//            ДОБАВИТЬ ФУТЕР
            
        ])
    }
    
    
//    MARK: - Логика
    
    private let selectedDate: Date
    private var baseDate: Date {
      didSet {
        days = generateDaysInMonth(for: baseDate)
        collectionView.reloadData()
        headerView.baseDate = baseDate
      }
    }

    private lazy var days = generateDaysInMonth(for: baseDate)

    private var numberOfWeeksInBaseDate: Int {
      calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }

    private let selectedDateChanged: ((Date) -> Void)
    private let calendar = Calendar(identifier: .gregorian)

    private lazy var dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "d"
      return dateFormatter
    }()

    // MARK: - Initializers

    init(baseDate: Date, selectedDateChanged: @escaping ((Date) -> Void)) {
      self.selectedDate = baseDate
      self.baseDate = baseDate
      self.selectedDateChanged = selectedDateChanged

      super.init(nibName: nil, bundle: nil)

      modalPresentationStyle = .overCurrentContext
      modalTransitionStyle = .crossDissolve
      definesPresentationContext = true
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: - Расширение

extension CalendarViewController {
    
    func monthMetadata(for baseDate: Date) throws -> MonthMetaData {
        
        guard let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: baseDate)?.count,
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.month, .year], from: baseDate))
        else {
            throw CalendarDataError.metadataGeneration
        }
        
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        return MonthMetaData(
            numberOfDays: numberOfDaysInMonth,
            firstDay: firstDayOfMonth,
            firstDayWeekday: firstDayWeekday)
    }
    
    enum CalendarDataError: Error {
      case metadataGeneration
    }
    
    
    func generateDaysInMonth(for baseDate: Date) -> [CalendarDay] {
        
        guard let metadata = try? monthMetadata(for: baseDate) else {
          fatalError("An error occurred when generating the metadata for \(baseDate)")
        }

        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        
        let days: [CalendarDay] = (1..<(numberOfDaysInMonth + offsetInInitialRow))
           .map { day in
             let isWithinDisplayedMonth = day >= offsetInInitialRow
             let dayOffset =
               isWithinDisplayedMonth ?
               day - offsetInInitialRow :
               -(offsetInInitialRow - day)
             
             return generateDay(
               offsetBy: dayOffset,
               for: firstDayOfMonth,
               isWithinDisplayedMonth: isWithinDisplayedMonth)
           }
        return days
    }
    
    func generateDay(
      offsetBy dayOffset: Int,
      for baseDate: Date,
      isWithinDisplayedMonth: Bool
    ) -> CalendarDay {
      let date = calendar.date(
        byAdding: .day,
        value: dayOffset,
        to: baseDate)
        ?? baseDate

      return CalendarDay(
        date: date,
        number: dateFormatter.string(from: date),
        isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
        isWithinDisplayedMonth: isWithinDisplayedMonth
      )
    }
}
