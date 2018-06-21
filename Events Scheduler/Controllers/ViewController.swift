//
//  ViewController.swift
//  Events Scheduler
//
//  Created by Gourav  Garg on 18/06/18.
//  Copyright © 2018 Gourav  Garg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    //private properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateCollectionView: UICollectionView!
    fileprivate let sectionInsets = 10
    fileprivate let itemsPerRow: CGFloat = 7
    fileprivate var currentDate = Date()
    fileprivate let pastMonths = -5
    fileprivate var pastDate: Date?
    fileprivate var listOfDates: [Date] = [Date]()
    fileprivate let dateformattter = DateFormatter()
    fileprivate var daysForWeek = 0
    fileprivate var preselectedDate: Date?
    fileprivate var selectedCell: DateCollectionViewCell?
    fileprivate var cellIndex: Int?
    fileprivate var photosCollection: PhotoCollection?
    fileprivate var indexPaths: [IndexPath] = [IndexPath]()
    fileprivate var preselectedIndex: IndexPath?
    //fileprivate var photoArray:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        equivalentWeeks()
        configureDateCollectionCell()
        getImages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dateCollectionView.allowsMultipleSelection = false
        preSelectDate()
        if let indexPath = preselectedIndex {
            collectionView(dateCollectionView, didSelectItemAt: indexPath)
            dateCollectionView.reloadData()
        }
    }
    
    func equivalentWeeks(){
        pastDate = Calendar.current.date(byAdding: .month, value: pastMonths, to: currentDate)
        var date = pastDate!
        dateformattter.dateFormat = "EE"
        let day = dateformattter.string(from: currentDate)
        switch day.lowercased() {
        case WeekDays.sun.rawValue:
            daysForWeek = 6
        case WeekDays.mon.rawValue:
            daysForWeek = 5
        case WeekDays.tue.rawValue:
            daysForWeek = 4
        case WeekDays.wed.rawValue:
            daysForWeek = 3
        case WeekDays.thu.rawValue:
            daysForWeek = 2
        case WeekDays.fri.rawValue:
            daysForWeek = 1
        case WeekDays.sat.rawValue:
            daysForWeek = 0
        default:
            daysForWeek = 0
        }
        
        currentDate = Calendar.current.date(byAdding: .day, value: daysForWeek, to: currentDate)!
        while date <= currentDate {
            listOfDates.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        listOfDates = listOfDates.reversed()
    }
    
    func configureDateCollectionCell() {
        dateCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        let width = dateCollectionView.frame.width / 7
        let height = dateCollectionView.frame.height
        let layout = dateCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
        dateCollectionView.isPagingEnabled = true
    }
}

//MARK: - Date Collection View DataSource Method
extension ViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as? DateCollectionViewCell {
            cell.transform = CGAffineTransform(scaleX: -1, y: 1)
            indexPaths.append(indexPath)
            dateformattter.dateFormat = "d"
            cell.dayLabel.text = dateformattter.string(from: listOfDates[indexPath.row])
            dateformattter.dateFormat = "EE"
            if dateformattter.string(from: listOfDates[indexPath.row]).lowercased() == WeekDays.sat.rawValue || dateformattter.string(from: listOfDates[indexPath.row]).lowercased() == WeekDays.sun.rawValue {
                cell.dayLabel.isEnabled = false
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell {
            cell.dayLabel.layer.masksToBounds = true
            cell.dayLabel.layer.cornerRadius = 19
            if cellIndex != nil {
                cell.dayLabel.backgroundColor = UIColor.green
            }
            cell.dayLabel.backgroundColor = UIColor.purple
            cell.dayLabel.textColor = UIColor.white
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DateCollectionViewCell {
            cell.dayLabel.layer.masksToBounds = false
            cell.dayLabel.layer.cornerRadius = 0
            cell.dayLabel.backgroundColor = UIColor.clear
            cell.dayLabel.textColor = UIColor.black
        }
    }
    
    func preSelectDate() {
        dateformattter.dateFormat = "EE"
        for index in indexPaths {
            if dateformattter.string(from: listOfDates[index.row]).lowercased() == WeekDays.wed.rawValue {
                cellIndex = index.row
                preselectedIndex?.row = cellIndex!
                break
            }
        }
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell {
            return cell
        }
        if photosCollection != nil {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell {
                if photosCollection != nil {
                    if let imageUrl = photosCollection?.photos?.photo?.first?.photoUrl {
                        let imageData = try! Data(contentsOf: imageUrl )
                        cell.imageFirstStudent.image = UIImage(data: imageData)
                    }
                }
            }
        }
        return UITableViewCell()
    }
    
    func getImages() {
        FlickrProvider.fetchFlickerPhotos { [weak self] (error, result) in
            if error == nil {
                self?.photosCollection = result
            }
            DispatchQueue.main.async(execute: {
                self?.tableView.reloadData()
            })
        }
    }
    
    /*if daysForWeek > 0 { //TODO
     cell.isUserInteractionEnabled = false
     cell.dayLabel.isEnabled = false
     daysForWeek = daysForWeek - 1
     }*/
    //if dateformattter.string(from: currentDate).lowercased() == "
}

enum WeekDays: String {
    case sun
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
}
