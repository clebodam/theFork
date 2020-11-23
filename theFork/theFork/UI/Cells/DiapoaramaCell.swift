//
//  DiapoaramaCell.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import UIKit

protocol DiapoaramaCellDelegate: class {
    func showDiaporama()
}
class DiapoaramaCell: BasicCell {

    weak var delegate: DiapoaramaCellDelegate?
    var model : RestaurantDiaporamaViewModel?
    private let itemImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()


    private let separator : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private let secondImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .left
        imgView.clipsToBounds = true
        return imgView
    }()


    private let moreButton : UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.isUserInteractionEnabled = false

        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func  addViews() {
        contentView.addSubview(itemImage)
        contentView.addSubview(separator)
        contentView.addSubview(secondImage)
        contentView.addSubview(moreButton)

        moreButton.anchor(top: nil, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right:nil, paddingTop:0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 150, height: 0, enableInsets: true)
        contentView.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 0).isActive = true
        separator.anchor(top: contentView.topAnchor, left: itemImage.rightAnchor, bottom: itemImage.bottomAnchor, right:nil, paddingTop:0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 5, height: 0, enableInsets: true)
        secondImage.anchor(top: contentView.topAnchor, left: separator.rightAnchor, bottom: itemImage.bottomAnchor, right: contentView.rightAnchor, paddingTop:0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        contentView.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 0).isActive = true
        
        itemImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil , paddingTop:0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.size.width * 0.858, height: 250, enableInsets: true)
        contentView.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 0).isActive = true
        moreButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    override func feedWithModel(viewModel: ModelProtocol?) {
        guard let model = viewModel as? RestaurantDiaporamaViewModel else {
            return
        }
        self.model = model
        self.moreButton.isHidden = !model.showMore()
        self.moreButton.setTitle(model.getTitle(), for: .normal)
        _ = itemImage.loadImageUsingCache(withUrl: model.picsDiaporama?.first ?? "")
        if model.showMore() {
            _ = secondImage.loadImageUsingCache(withUrl: model.picsDiaporama?[1] ?? "")
        } else {
            itemImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop:0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 250, enableInsets: true)
            contentView.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 0).isActive = true

        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard isUserInteractionEnabled else { return nil }
        guard !isHidden else { return nil }
        guard self.point(inside: point, with: event) else { return nil }
        if moreButton.point(inside: convert(point, to: moreButton), with: event) {
            return moreButton
        }
        return super.hitTest(point, with: event)
    }


    @objc func buttonAction() {
        guard let delegate = delegate else {
            return
        }
        delegate.showDiaporama()
    }
}
