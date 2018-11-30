//
//  LoginViewController.swift
//  CivicConnect_Example
//
//  Created by Justin Guedes on 2018/09/06.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import QuartzCore

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
///////////////// How to Use ConnectButton ///////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
//////////////// STEP 1: Import CivicConnect /////////////////
//////////////////////////////////////////////////////////////
import CivicConnect
///////////////////////////////////////////////////////////////

class LoginViewController: UIViewController, ConnectDelegate {
    
    let iconView = IconView(title: "S")
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let scopeRequestLabel = UILabel()
    let scopeRequestButton = UIButton(type: .system)
    let statusLabel = UILabel()
    
    ///////////////////////////////////////////////////////////////
    //////////////// STEP 2: Create ConnectButton /////////////////
    ///////////////////////////////////////////////////////////////
    lazy var connectButton = ConnectButton(connect, delegate: self)
    ///////////////////////////////////////////////////////////////
    
    let createdLabel = UILabel()
    
    var scopeRequestType: ScopeRequestType = .basicSignup
    var tokenOnly: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupIconView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupScopeRequestLabel()
        setupScopeRequestButton()
        setupCreatedLabel()
        setupConnectButton()
        setupStatusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusLabel.text = ""
    }
    
    private func setupBackground() {
        let colorTop = UIColor(red: 23.0 / 255.0, green: 116.0 / 255.0, blue: 157.0 / 255.0, alpha: 0.75).cgColor
        let colorBottom = UIColor(red: 24.0 / 255.0, green: 198.0 / 255.0, blue: 99.0 / 255.0, alpha: 0.75).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.frame
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupIconView() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.layer.masksToBounds = false
        iconView.layer.shadowOffset = CGSize(width: -5, height: 5)
        iconView.layer.shadowRadius = 5
        iconView.layer.shadowOpacity = 0.5
        view.addSubview(iconView)
        iconView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconView.topAnchor.constraint(equalTo: view.topAnchor, constant: 96).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 96).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Welcome to Sample Connect"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 32).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "This is a sample app that demonstrates the CivicConnect library in action."
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }
    
    private func setupScopeRequestLabel() {
        scopeRequestLabel.translatesAutoresizingMaskIntoConstraints = false
        scopeRequestLabel.text = convertToString(from: scopeRequestType, tokenOnly: tokenOnly)
        scopeRequestLabel.font = UIFont.systemFont(ofSize: 10)
        scopeRequestLabel.textColor = .white
        scopeRequestLabel.textAlignment = .center
        scopeRequestLabel.numberOfLines = 0
        view.addSubview(scopeRequestLabel)
        scopeRequestLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16).isActive = true
        scopeRequestLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        scopeRequestLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }
    
    private func setupScopeRequestButton() {
        scopeRequestButton.translatesAutoresizingMaskIntoConstraints = false
        scopeRequestButton.setTitle("Settings", for: .normal)
        scopeRequestButton.setTitleColor(.white, for: .normal)
        scopeRequestButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        scopeRequestButton.titleLabel?.textAlignment = .center
        scopeRequestButton.titleLabel?.numberOfLines = 0
        scopeRequestButton.addTarget(self, action: #selector(LoginViewController.changeScopeRequestButtonTapped), for: .touchUpInside)
        view.addSubview(scopeRequestButton)
        scopeRequestButton.topAnchor.constraint(equalTo: scopeRequestLabel.bottomAnchor).isActive = true
        scopeRequestButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        scopeRequestButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
    }
    
    private func setupCreatedLabel() {
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        createdLabel.text = "Created by Civic Technologies."
        createdLabel.font = UIFont.systemFont(ofSize: 12)
        createdLabel.textColor = .white
        createdLabel.textAlignment = .center
        view.addSubview(createdLabel)
        createdLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        createdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        createdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////// STEP 3: Optionally set the title and type of scope request and add it to the view /////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    private func setupConnectButton() {
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        connectButton.setConnectTitle("Login with Civic")
        connectButton.setType(scopeRequestType)
        view.addSubview(connectButton)
        connectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        connectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        connectButton.bottomAnchor.constraint(equalTo: createdLabel.topAnchor, constant: -16).isActive = true
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    private func setupStatusLabel() {
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = UIFont.systemFont(ofSize: 12)
        statusLabel.textColor = .white
        statusLabel.textAlignment = .center
        view.addSubview(statusLabel)
        statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        statusLabel.bottomAnchor.constraint(equalTo: connectButton.topAnchor, constant: -16).isActive = true
    }
    
    @objc private func changeScopeRequestButtonTapped() {
        let selection = SelectScopeRequestViewController { newScopeRequestType, tokenOnly in
            self.scopeRequestType = newScopeRequestType
            self.tokenOnly = tokenOnly
            self.connectButton.setType(newScopeRequestType)
            self.scopeRequestLabel.text = self.convertToString(from: newScopeRequestType, tokenOnly: tokenOnly)
        }
        
        navigationController?.pushViewController(selection, animated: true)
    }
    
    private func convertToString(from scopeRequestType: ScopeRequestType, tokenOnly: Bool) -> String {
        var scopeRequestString: String
        switch scopeRequestType {
        case .basicSignup:
            scopeRequestString = "Basic Signup"
        case .anonymousLogin:
            scopeRequestString = "Anonymous Login"
        case .proofOfResidence:
            scopeRequestString = "Proof of Residence"
        case .proofOfIdentity:
            scopeRequestString = "Proof of Identity"
        case .proofOfAge:
            scopeRequestString = "Proof of Age"
        }

        if tokenOnly {
            scopeRequestString += " (Token Only)"
        }

        return scopeRequestString
    }
    
    ////////////////////////////////////////////////////////////////////////
    //////////////// STEP 4: Implement the ConnectDelegate /////////////////
    ////////////////////////////////////////////////////////////////////////
    func connectDidFailWithError(_ error: ConnectError) {
        statusLabel.text = error.message
    }
    
    func connectDidFinishWithUserData(_ userData: UserData) {
        statusLabel.text = "Successfully logged in!"
        let loggedInViewController = LoggedInViewController(userId: userData.userId, userInfo: userData.data)
        navigationController?.pushViewController(loggedInViewController, animated: true)
    }
    
    func connectDidChangeStatus(_ newStatus: ConnectStatus) {
        let status: String
        switch newStatus {
        case .fetchingScopeRequest:
            status = "...busy asking Civic for access..."
        case .launchingCivic:
            status = "...launching and waiting for Civic app..."
        case .pollingForUserData:
            status = "...waiting for data..."
        case .authorizing:
            status = "..authorizing user..."
        case .fetchingUserData:
            status = "...authorized and retrieving data..."
        }
        statusLabel.text = status
    }

    func connectShouldFetchUserData(withToken token: String) -> Bool {
        return !tokenOnly
    }
    ////////////////////////////////////////////////////////////////////////
    
}
