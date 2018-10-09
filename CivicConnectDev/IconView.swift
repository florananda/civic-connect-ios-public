//
//  IconView.swift
//  CivicConnect_Example
//
//  Created by Justin Guedes on 2018/09/07.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class IconView: UIView {
    
    let label = UILabel()
    let labelView = UIView()
    let labelViewGradientLayer = CAGradientLayer()
    
    init(title: String) {
        super.init(frame: .zero)
        backgroundColor = .white
        setupLabelGradientLayer()
        setupLabelView()
        setupLabel(withTitle: title)
        labelView.mask = label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 5
        label.frame = labelView.bounds
        labelViewGradientLayer.frame = labelView.frame
    }
    
    private func setupLabelGradientLayer() {
        let colorTop = UIColor(red: 23.0 / 255.0, green: 116.0 / 255.0, blue: 157.0 / 255.0, alpha: 0.75).cgColor
        let colorBottom = UIColor(red: 24.0 / 255.0, green: 198.0 / 255.0, blue: 99.0 / 255.0, alpha: 0.75).cgColor
        
        labelViewGradientLayer.colors = [colorTop, colorBottom]
        labelViewGradientLayer.locations = [0.0, 1.0]
        labelViewGradientLayer.frame = labelView.frame
    }
    
    private func setupLabelView() {
        labelView.layer.insertSublayer(labelViewGradientLayer, at: 0)
        addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        labelView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        labelView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        labelView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupLabel(withTitle title: String) {
        label.text = title
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 64)
        labelView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: labelView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: labelView.centerYAnchor).isActive = true
    }
    
}
