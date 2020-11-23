//
//  BasicCell.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import UIKit

class BasicCell: UICollectionViewCell, ReuseIdentifierProtocol {

    // MARK: - INIT
    var viewModel: ModelProtocol?
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
           contentView.translatesAutoresizingMaskIntoConstraints = false
           contentView.backgroundColor = UIColor.blue
        addViews()
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    let label: UILabel = {
            let label = UILabel()
            label.backgroundColor = .yellow
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "irfvhrbvfvhbvhfbvhfbvhfvhbvfhbvhjdbvjebvehfbvhjfbvhfbvhfbvhfbvhfbvhfbvhfbvhbvhfbvhfbvhfbvhfbvhfbvhfbvhfbvhrfbvhrbfvhfbvhrbfvhrbfvhrfbvhrbvhbvhfbvhbvhfbvhfrbvhbvhrbvhbvhrbvhbvhvhbvfhbvhjdbvjebvehfbvhjfbvhfbvhfbvhfbvhfbvhfbvhfbvhbvhfbvhfbvhfbvhfbvhfbvhfbvhfbvhrfbvhrbfvhfbvhrbfvhrbfvhrfbvhrbvhbvhfbvhbvhfbvhfrbvhbvhrbvhbvhrbvhbvh"
            return label
        }()

        let customView: UIView = {
            let customView = UIView()
            customView.backgroundColor = .green
            customView.translatesAutoresizingMaskIntoConstraints = false
            return customView
        }()
    
    func  addViews() {
        contentView.addSubview(label)
           label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
           label.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
           label.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

           contentView.addSubview(customView)
           customView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
           customView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
           customView.heightAnchor.constraint(equalToConstant: 100).isActive = true
           customView.widthAnchor.constraint(equalToConstant: 100).isActive = true

               contentView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: 0).isActive = true

    }

    func feedWithModel( viewModel: ModelProtocol?) {
        self.viewModel = viewModel
    }
}
