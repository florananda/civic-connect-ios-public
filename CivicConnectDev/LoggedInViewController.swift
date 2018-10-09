//
//  LoggedInViewController.swift
//  CivicConnect_Example
//
//  Created by Justin Guedes on 2018/09/07.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CivicConnect

class LoggedInViewController: UIViewController {
    
    let userId: String
    let userInfo: [UserInfo]
    
    let loggedInLabel = UILabel()
    let userInfoTableView = UITableView(frame: .zero, style: .plain)
    let logoutButton = UIButton(type: .system)
    
    struct SubtitleCellData {
        let text: String
        let detail: String?
        let image: UIImage?
    }
    
    private lazy var sections: [[SubtitleCellData]] = {
        let images = userInfo.compactMap { (info) -> SubtitleCellData? in
            guard let image = decodeBase64ToImage(info.value) else {
                return nil
            }
            return SubtitleCellData(text: info.label, detail: .none, image: image)
        }
        
        let excludingImages = userInfo.compactMap { (info) -> SubtitleCellData? in
            guard !images.contains(where: { $0.text == info.label }) else {
                return nil
            }
            return SubtitleCellData(text: info.label, detail: info.value, image: .none)
        }
        
        return [[SubtitleCellData(text: "user.id", detail: userId, image: .none)],
                images,
                excludingImages]
    }()
    
    func decodeBase64ToImage(_ base64Encoded: String) -> UIImage? {
        guard let data = Data(base64Encoded: base64Encoded, options: .ignoreUnknownCharacters) else {
            return nil
        }
        
        return UIImage(data: data)
    }
    
    init(userId: String, userInfo: [UserInfo]) {
        self.userId = userId
        self.userInfo = userInfo
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        
        loggedInLabel.translatesAutoresizingMaskIntoConstraints = false
        loggedInLabel.text = "LOGGED IN"
        loggedInLabel.font = UIFont.boldSystemFont(ofSize: 32)
        loggedInLabel.textColor = .white
        view.addSubview(loggedInLabel)
        loggedInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        loggedInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        loggedInLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        userInfoTableView.translatesAutoresizingMaskIntoConstraints = false
        userInfoTableView.register(SubtitleCell.self, forCellReuseIdentifier: "Cell")
        userInfoTableView.dataSource = self
        userInfoTableView.backgroundColor = .clear
        userInfoTableView.separatorStyle = .none
        view.addSubview(userInfoTableView)
        userInfoTableView.topAnchor.constraint(equalTo: loggedInLabel.bottomAnchor, constant: 32).isActive = true
        userInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        userInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("LOGOUT", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.addTarget(self, action: #selector(LoggedInViewController.logoutButtonTapped), for: .touchUpInside)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        logoutButton.backgroundColor = .white
        logoutButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        view.addSubview(logoutButton)
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        userInfoTableView.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -32).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logoutButton.layer.cornerRadius = logoutButton.frame.height / 2
    }
    
    private func setupBackground() {
        let colorTop = UIColor(red: 23.0 / 255.0, green: 116.0 / 255.0, blue: 157.0 / 255.0, alpha: 0.75).cgColor
        let colorBottom = UIColor(red: 24.0 / 255.0, green: 198.0 / 255.0, blue: 99.0 / 255.0, alpha: 0.75).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.frame
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.backgroundColor = .white
    }
    
    @objc func logoutButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension LoggedInViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SubtitleCell
        let subtitleData = sections[indexPath.section][indexPath.row]
        cell.setTitle(subtitleData.text)
        cell.setSubtitle(subtitleData.detail)
        cell.setImage(subtitleData.image)
        return cell
    }
    
}

class SubtitleCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let subtitleImageView = UIImageView()
    
    func setTitle(_ title: String?) {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .white
    }
    
    func setSubtitle(_ subtitle: String?) {
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0
    }
    
    func setImage(_ image: UIImage?) {
        subtitleImageView.image = image
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        subtitleImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleImageView)
        subtitleImageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor).isActive = true
        subtitleImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subtitleImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subtitleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        subtitleImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 256).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
