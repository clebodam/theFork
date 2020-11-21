//
//  ButtonCell.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import UIKit

class ButtonCell: BasicCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
           contentView.backgroundColor = UIColor.purple
        addViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func  addViews() {
        super.addViews()

    }
}
