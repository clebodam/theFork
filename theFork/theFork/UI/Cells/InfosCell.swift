//
//  InfosCell.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import UIKit

class InfosCell: BasicCell {

    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
           contentView.backgroundColor = UIColor.yellow
        addViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func  addViews() {
        super.addViews()

    }
}
