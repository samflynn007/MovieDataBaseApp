//
//  HeaderView.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//
import UIKit


protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
     let titleLabel = UILabel()
     let arrowLabel = UILabel()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        headerViewSetUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        visualConstrainSetUp()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func headerViewSetUp() {
        contentView.backgroundColor = UIColor(named: Colors.primeColor)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowLabel)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader)))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func visualConstrainSetUp() {
        let views = [
            "titleLabel" : titleLabel,
            "arrowLabel" : arrowLabel,
        ]

        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-20-[titleLabel]-[arrowLabel]-20-|",
            options: [],
            metrics: nil,
            views: views
        ))
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[titleLabel]-|",
            options: [],
            metrics: nil,
            views: views
        ))
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[arrowLabel]-|",
            options: [],
            metrics: nil,
            views: views
        ))
    }
    
@objc func tapHeader(gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSection(header: self, section: cell.section)
    }
    func setCollapsed(collapsed: Bool) {
        arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
    }
}


