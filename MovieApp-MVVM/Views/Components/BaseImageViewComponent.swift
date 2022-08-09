//
//  BaseImageViewComponent.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 09/08/2022.
//

import UIKit

class BaseImageViewComponent: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        image  = UIImage(named: "placeholder")
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.masksToBounds = true
    }
}
