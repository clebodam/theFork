//
//  DiaporamaCell.swift
//  theFork
//
//  Created by Damien on 22/11/2020.
//

import UIKit

class ScrollingDiaporamaCell: BasicCell {
    private let itemImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.black
        contentView.isUserInteractionEnabled = false
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func  addViews() {
        contentView.addSubview(itemImage)
        itemImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor , paddingTop:0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height, enableInsets: true)
        contentView.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 0).isActive = true
    }
    
     func feedImageString(_ str: String?) {
        _ = itemImage.loadImageUsingCache(withUrl: str ?? "")
    }
}
