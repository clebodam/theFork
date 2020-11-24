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
        addViews()
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func  addViews() {
       // fatalError("must be overriden")
    }

    func feedWithModel( viewModel: ModelProtocol?) {
        fatalError("must be overriden")
    }
}
