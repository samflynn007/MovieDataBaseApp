//
//  HeaderView.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//
import UIKit
protocol HeaderDelegate {
    func callHeader(index: Int)
}

class HeaderView: UIView {
    
    var section: Int?
    var delegate: HeaderDelegate?
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: self.frame.origin.y,width: self.frame.width - 30, height: self.frame.height))
        button.backgroundColor = .systemRed
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(onClickHeader), for: .touchUpInside)
        return button
    }()
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onClickHeader() {
        if let index = section {
            delegate?.callHeader(index: index)
        }
    
    }
}
