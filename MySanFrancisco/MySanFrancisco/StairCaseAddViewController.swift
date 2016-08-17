//
//  StairCaseAddViewController.swift
//  MySanFrancisco
//
//  Created by Jordan Zucker on 8/16/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

import UIKit
import CoreLocation

class StairCaseAddViewController: UIViewController, UITextFieldDelegate {
    
    private let formalNameTextField: UITextField
    private let nicknameTextField: UITextField
    private let saveButton: UIButton
    private var coordinate: CLLocationCoordinate2D
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        self.formalNameTextField = UITextField(frame: .zero)
//        self.nicknameTextField = UITextField(frame: .zero)
//        self.saveButton = UIButton(type: .system)
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
    
    required init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.formalNameTextField = UITextField(frame: .zero)
        self.nicknameTextField = UITextField(frame: .zero)
        self.saveButton = UIButton(type: .system)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let bounds = UIScreen.main.bounds
        let mainView = UIView(frame: bounds)
        mainView.backgroundColor = UIColor.cyan
        mainView.addSubview(formalNameTextField)
        mainView.addSubview(nicknameTextField)
        mainView.addSubview(saveButton)
        self.view = mainView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        formalNameTextField.delegate = self
        formalNameTextField.borderStyle = .line
        nicknameTextField.delegate = self
        nicknameTextField.borderStyle = .line
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(self.saveButtonPressed(sender:)), for: .touchUpInside)
        
        formalNameTextField.translatesAutoresizingMaskIntoConstraints = false
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        let formalNameTextFieldHorizontalConstraint = NSLayoutConstraint(item: formalNameTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let nicknameTextFieldHorizontalConstraint = NSLayoutConstraint(item: nicknameTextField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let formalTextFieldWidthConstraint = NSLayoutConstraint(item: formalNameTextField, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.95, constant: 0.0)
        let nicknameTextFieldWidthConstraint = NSLayoutConstraint(item: nicknameTextField, attribute: .width, relatedBy: .equal, toItem: formalNameTextField, attribute: .width, multiplier: 1.0, constant: 0.0)
        let saveButtonHorizontalConstraint = NSLayoutConstraint(item: saveButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([formalNameTextFieldHorizontalConstraint, formalTextFieldWidthConstraint, nicknameTextFieldHorizontalConstraint, saveButtonHorizontalConstraint, nicknameTextFieldWidthConstraint])
        let views = [
            "formal": formalNameTextField,
            "nickname": nicknameTextField,
            "saveButton": saveButton,
        ]
        let metrics = [
            "topPadding": 25,
            "spacer": 15,
            "standardHeight": 75,
        ]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-topPadding-[formal(standardHeight)]-spacer-[nickname(standardHeight)]-spacer-[saveButton(standardHeight)]", options: [], metrics: metrics, views: views)
        NSLayoutConstraint.activate(verticalConstraints)
        self.view.setNeedsUpdateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    func saveButtonPressed(sender: UIButton) {
        print(#function)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
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
