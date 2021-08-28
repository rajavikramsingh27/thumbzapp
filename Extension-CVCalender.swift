//
//  Extension-CVCalender.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 22/10/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit
import CVCalendar



// MARK: - CVCalendarViewDelegate & CVCalendarMenuViewDelegate

//extension CV_Calender_ViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
//
//    // MARK: Required methods
//
//    func presentationMode() -> CalendarMode { return .monthView }
//
//    func firstWeekday() -> Weekday { return .sunday }
//
//    // MARK: Optional methods
//
//    func calendar() -> Calendar? { return currentCalendar }
//
//    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
//        return weekday == .sunday ? UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0) : UIColor.white
//    }
//
//    func shouldShowWeekdaysOut() -> Bool { return shouldShowDaysOut }
//
//    // Defaults to true
//    func shouldAnimateResizing() -> Bool { return true }
//
//    private func shouldSelectDayView(dayView: DayView) -> Bool {
//        return arc4random_uniform(3) == 0 ? true : false
//    }
//
//    func shouldAutoSelectDayOnMonthChange() -> Bool { return false }
//
//    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
//        selectedDay = dayView
//    }
//
//    func shouldSelectRange() -> Bool { return true }
//
//    func didSelectRange(from startDayView: DayView, to endDayView: DayView) {
//        print("RANGE SELECTED: \(startDayView.date.commonDescription) to \(endDayView.date.commonDescription)")
//    }
//
//    func presentedDateUpdated(_ date: CVDate) {
//        if monthLabel.text != date.globalDescription && self.animationFinished {
//            let updatedMonthLabel = UILabel()
//            updatedMonthLabel.textColor = monthLabel.textColor
//            updatedMonthLabel.font = monthLabel.font
//            updatedMonthLabel.textAlignment = .center
//            updatedMonthLabel.text = date.globalDescription
//            updatedMonthLabel.sizeToFit()
//            updatedMonthLabel.alpha = 0
//            updatedMonthLabel.center = self.monthLabel.center
//
//            let offset = CGFloat(48)
//            updatedMonthLabel.transform = CGAffineTransform(translationX: 0, y: offset)
//            updatedMonthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
//
//            UIView.animate(withDuration: 0.35, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//                self.animationFinished = false
//                self.monthLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
//                self.monthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
//                self.monthLabel.alpha = 0
//
//                updatedMonthLabel.alpha = 1
//                updatedMonthLabel.transform = CGAffineTransform.identity
//
//            }) { _ in
//
//                self.animationFinished = true
//                self.monthLabel.frame = updatedMonthLabel.frame
//                self.monthLabel.text = updatedMonthLabel.text
//                self.monthLabel.transform = CGAffineTransform.identity
//                self.monthLabel.alpha = 1
//                updatedMonthLabel.removeFromSuperview()
//            }
//
//            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
//        }
//    }
//
//    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool { return true }
//
//    func weekdaySymbolType() -> WeekdaySymbolType { return .short }
//
//    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
//        return { UIBezierPath(rect: CGRect(x: 0, y: 0, width: $0.width, height: $0.height)) }
//    }
//
//    func shouldShowCustomSingleSelection() -> Bool { return false }
//
//    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
//        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
//        circleView.fillColor = .colorFromCode(0xCCCCCC)
//        return circleView
//    }
//
//    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
//        if (dayView.isCurrentDay) {
//            return true
//        }
//        return false
//    }
//
//    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
//
//        dayView.setNeedsLayout()
//        dayView.layoutIfNeeded()
//
//        let π = Double.pi
//
//        let ringLayer = CAShapeLayer()
//        let ringLineWidth: CGFloat = 4.0
//        let ringLineColour = UIColor.blue
//
//        let newView = UIView(frame: dayView.frame)
//
//        let diameter = (min(newView.bounds.width, newView.bounds.height))
//        let radius = diameter / 2.0 - ringLineWidth
//
//        newView.layer.addSublayer(ringLayer)
//
//        ringLayer.fillColor = nil
//        ringLayer.lineWidth = ringLineWidth
//        ringLayer.strokeColor = ringLineColour.cgColor
//
//        let centrePoint = CGPoint(x: newView.bounds.width/2.0, y: newView.bounds.height/2.0)
//        let startAngle = CGFloat(-π/2.0)
//        let endAngle = CGFloat(π * 2.0) + startAngle
//        let ringPath = UIBezierPath(arcCenter: centrePoint,
//                                    radius: radius,
//                                    startAngle: startAngle,
//                                    endAngle: endAngle,
//                                    clockwise: true)
//
//        ringLayer.path = ringPath.cgPath
//        ringLayer.frame = newView.layer.bounds
//
//        return newView
//    }
//
//    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
//        guard let currentCalendar = currentCalendar else { return false }
//
//        var components = Manager.componentsForDate(Foundation.Date(), calendar: currentCalendar)
//
//        /* For consistency, always show supplementaryView on the 3rd, 13th and 23rd of the current month/year.  This is to check that these expected calendar days are "circled". There was a bug that was circling the wrong dates. A fix was put in for #408 #411.
//
//         Other month and years show random days being circled as was done previously in the Demo code.
//         */
//        var shouldDisplay = false
//        if dayView.date.year == components.year &&
//            dayView.date.month == components.month {
//
//            if (dayView.date.day == 3 || dayView.date.day == 13 || dayView.date.day == 23)  {
//                print("Circle should appear on " + dayView.date.commonDescription)
//                shouldDisplay = true
//            }
//        } else if (Int(arc4random_uniform(3)) == 1) {
//            shouldDisplay = true
//        }
//
//        return shouldDisplay
//    }
//
//    func dayOfWeekTextColor() -> UIColor { return .white }
//
//    func dayOfWeekBackGroundColor() -> UIColor { return .orange }
//
//    func disableScrollingBeforeDate() -> Date { return Date() }
//
//    func maxSelectableRange() -> Int { return 14 }
//
//    func earliestSelectableDate() -> Date { return Date() }
//
//    func latestSelectableDate() -> Date {
//        var dayComponents = DateComponents()
//        dayComponents.day = 70
//        let calendar = Calendar(identifier: .gregorian)
//        if let lastDate = calendar.date(byAdding: dayComponents, to: Date()) {
//            return lastDate
//        }
//
//        return Date()
//    }
//}
//
