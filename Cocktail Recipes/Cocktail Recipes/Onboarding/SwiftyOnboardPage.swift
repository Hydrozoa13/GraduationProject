//
//  customPageView.swift
//  SwiftyOnboard
//
//  Created by Jay on 3/25/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

open class SwiftyOnboardPage: UIView {
    
    public var title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = #colorLiteral(red: 0.5386385322, green: 0.6859211922, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    public var subTitle: UILabel = {
        let label = UILabel()
        label.text = "Sub Title"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    public var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp() {
        
        let margin = self.layoutMarginsGuide
        
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 10).isActive = true
        title.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -10).isActive = true
        title.topAnchor.constraint(equalTo: margin.topAnchor, constant: 50).isActive = true
        title.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 30).isActive = true
        imageView.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -30).isActive = true
        imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.5).isActive = true
        
        self.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 30).isActive = true
        subTitle.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -30).isActive = true
        subTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        subTitle.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
