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
    
//    l
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        headerViewSetUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        constrainSetUp()
       
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
    private func constrainSetUp() {
        
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(arrowLabel)

        // Add the stack view to your view hierarchy
        contentView.addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            // Constrain the stack view to the edges of its superview (or adjust the superview accordingly)
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])

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


