//
//  Utilities.swift
//  MySanFrancisco
//
//  Created by Jordan Zucker on 9/16/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIApplication {
    static var persistentContainer: NSPersistentContainer {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        return appDelegate.persistentContainer
    }
}

extension UIViewController {
    var viewContext: NSManagedObjectContext {
        //        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        //            fatalError()
        //        }
        //        return appDelegate.persistentContainer.viewContext
        return UIApplication.persistentContainer.viewContext
    }
}

extension UIControl {
    func removeAllTargets() {
        self.allTargets.forEach { (target) in
            self.removeTarget(target, action: nil, for: .allEvents)
        }
    }
}

extension UIView {
    static func reuseIdentifier() -> String {
        //        return String(describing: type(of: self))
        return NSStringFromClass(self)
    }
}

extension NSFetchedResultsController {
    var isEmpty: Bool {
        guard let currentSections = self.sections else {
            return true
        }
        guard currentSections.count > 0 else {
            return true
        }
        for sectionInfo in currentSections {
            if sectionInfo.numberOfObjects > 0 {
                return false
            }
        }
        return true
    }
}

extension UIView {
    
    var hasConstraints: Bool {
        let hasHorizontalConstraints = !self.constraintsAffectingLayout(for: .horizontal).isEmpty
        let hasVerticalConstraints = !self.constraintsAffectingLayout(for: .vertical).isEmpty
        return hasHorizontalConstraints || hasVerticalConstraints
    }
    
    func forceAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

protocol UserFacingError: LocalizedError, CustomNSError {
    /// Title for the UIAlertController
    var alertTitle: String { get }
    var alertMessage: String { get }
}

extension UserFacingError {
    public static var errorDomain: String {
        return "PhotoUploader"
    }
    public var errorCode: Int {
        return 100
    }
    public var errorUserInfo: [String : Any] {
        return ["description": errorDescription!]
    }
    
    public var errorDescription: String? {
        return alertMessage
    }
}

extension UIAlertController {
    static func alertController(error: UserFacingError, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let title = error.alertTitle
        let message = error.alertMessage
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        return alertController
    }
}
