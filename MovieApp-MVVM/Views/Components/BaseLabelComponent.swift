//
//  BaseLabelComponent.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 09/08/2022.
//

import UIKit

class BaseLabelComponent: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        text = "placeholder text"
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: 17)
        textAlignment = .left
        numberOfLines = .zero
        textColor = .red
    }
    
}
