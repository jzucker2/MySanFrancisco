//
//  SpotAddViewController.swift
//  MySanFrancisco
//
//  Created by Jordan Zucker on 9/16/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

import UIKit
import CoreLocation

extension UISegmentedControl {
    var titleForSelectedSegmentIndex: String? {
        return titleForSegment(at: selectedSegmentIndex)!
    }
    var spotType: SpotAddViewController.SpotType? {
        guard let title = titleForSelectedSegmentIndex else {
            return nil
        }
        return SpotAddViewController.SpotType(rawValue: title)
    }
}

class SpotAddViewController: UIViewController, UITextFieldDelegate {
    
    static func createInNavigationController(coordinate: CLLocationCoordinate2D) -> UINavigationController {
        let addSpotViewController = SpotAddViewController(coordinate: coordinate)
        let navigationController = UINavigationController(rootViewController: addSpotViewController)
        navigationController.modalPresentationStyle = .overFullScreen
        return navigationController
    }
    
    private let coordinate: CLLocationCoordinate2D
    private let spotTypeSegmentedControl: UISegmentedControl
    private let stackView: UIStackView
    private let titleTextField: UITextField
    
    enum SpotType: String {
        case stairs = "Stairs"
        case popos = "POPOS"
        var type: Spot.Type {
            switch self {
            case .stairs:
                return Staircase.self
            case .popos:
                return Popos.self
            }
        }
        static var items: [String] {
            return [SpotType.stairs.rawValue, SpotType.popos.rawValue]
        }
    }
    
    required init(coordinate: CLLocationCoordinate2D) {
        let textField = UITextField(frame: .zero)
        let segmentedControl = UISegmentedControl(items: SpotType.items)
        self.stackView = UIStackView(arrangedSubviews: [segmentedControl, textField])
        self.titleTextField = textField
        self.spotTypeSegmentedControl = segmentedControl
        self.coordinate = coordinate
        super.init(nibName: nil, bundle: nil)
        titleTextField.placeholder = "Enter title ..."
        titleTextField.delegate = self
        spotTypeSegmentedControl.addTarget(self, action: #selector(self.spotTypeSegmentedControlValueChanged(sender:)), for: .valueChanged)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
    }
    
    override func loadView() {
        let bounds = UIScreen.main.bounds
        let mainView = UIView(frame: bounds)
        mainView.backgroundColor = UIColor.cyan
        let offset = UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height + 10.0
        stackView.frame = mainView.frame.offsetBy(dx: 0.0, dy: offset)
        mainView.addSubview(stackView)
        self.view = mainView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.spotTypeSegmentedControl.selectedSegmentIndex = 0
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add Spot"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelButtonPressed(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveButtonPressed(sender:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    func spotTypeSegmentedControlValueChanged(sender: UISegmentedControl) {
        
    }
    
    func cancelButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true)
    }
    
    func saveButtonPressed(sender: UIBarButtonItem) {
        UIApplication.persistentContainer.performBackgroundTask { (context) in
            guard let spotType = self.spotTypeSegmentedControl.spotType?.type else {
                fatalError("couldn't find a spot type")
            }
            let createdSpot = spotType.init(context: context)
            createdSpot.nickname = self.titleTextField.text!
            createdSpot.latitude = self.coordinate.latitude
            createdSpot.longitude = self.coordinate.longitude
            context.insert(createdSpot)
            do {
                try context.save()
                self.navigationController?.dismiss(animated: true)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
