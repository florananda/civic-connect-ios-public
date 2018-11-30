//
//  SelectScopeRequestViewController.swift
//  CivicConnect_Example
//
//  Created by Justin Guedes on 2018/09/20.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import CivicConnect

class SelectScopeRequestViewController: UIViewController {

    struct ScopeRequestData {
        let type: ScopeRequestType
        
        var text: String {
            switch type {
            case .basicSignup:
                return "Basic Signup (.basicSignup)"
            case .anonymousLogin:
                return "Anonymous Login (.anonymousLogin)"
            case .proofOfResidence:
                return "Proof of Residence (.proofOfResidence)"
            case .proofOfIdentity:
                return "Proof of Identity (.proofOfIdentity)"
            case .proofOfAge:
                return "Proof of Age (.proofOfAge)"
            }
        }
        
        var detail: String {
            switch type {
            case .basicSignup:
                return "Provides the basic information such as email and mobile number."
            case .anonymousLogin:
                return "Provides only the user ID."
            case .proofOfResidence:
                return "Provides the basic information, identity document as well as a residential document."
            case .proofOfIdentity:
                return "Provides the basic information as well as an identity document."
            case .proofOfAge:
                return "Provides the age of the user."
            }
        }
    }
    
    private let scopeRequests: [ScopeRequestData] = [ScopeRequestData(type: .basicSignup),
                                                     ScopeRequestData(type: .anonymousLogin),
                                                     ScopeRequestData(type: .proofOfResidence),
                                                     ScopeRequestData(type: .proofOfIdentity),
                                                     ScopeRequestData(type: .proofOfAge)]
    private let callback: (ScopeRequestType, Bool) -> Void
    
    private let titleLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let tokenOnlyLabel = UILabel()
    private let tokenSwitch = UISwitch()
    
    init(callback: @escaping (ScopeRequestType, Bool) -> Void) {
        self.callback = callback
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        view.backgroundColor = .white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "SELECT ONE"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        tokenOnlyLabel.translatesAutoresizingMaskIntoConstraints = false
        tokenOnlyLabel.text = "Only retrieve JWT token?"
        tokenOnlyLabel.font = UIFont.boldSystemFont(ofSize: 16)
        tokenOnlyLabel.textColor = .white
        view.addSubview(tokenOnlyLabel)
        tokenOnlyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        tokenOnlyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        tokenOnlyLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tokenOnlyLabel.bottomAnchor, constant: -32).isActive = true

        tokenSwitch.translatesAutoresizingMaskIntoConstraints = false
        tokenSwitch.isOn = false
        tokenSwitch.onTintColor = .white
        view.addSubview(tokenSwitch)
        tokenSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        tokenSwitch.centerYAnchor.constraint(equalTo: tokenOnlyLabel.centerYAnchor).isActive = true
    }
    
    private func setupBackground() {
        let colorTop = UIColor(red: 23.0 / 255.0, green: 116.0 / 255.0, blue: 157.0 / 255.0, alpha: 0.75).cgColor
        let colorBottom = UIColor(red: 24.0 / 255.0, green: 198.0 / 255.0, blue: 99.0 / 255.0, alpha: 0.75).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

}

extension SelectScopeRequestViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scopeRequests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SubtitleCell
        let scopeRequestData = scopeRequests[indexPath.row]
        cell.setTitle(scopeRequestData.text)
        cell.setSubtitle(scopeRequestData.detail)
        return cell
    }
    
}

extension SelectScopeRequestViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scopeRequest = scopeRequests[indexPath.row]
        callback(scopeRequest.type, tokenSwitch.isOn)
        navigationController?.popViewController(animated: true)
    }

}
