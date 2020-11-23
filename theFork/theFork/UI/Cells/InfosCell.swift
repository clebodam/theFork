//
//  InfosCell.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import UIKit
// MARK: - FACTORY METHODS
func createIcomeView(_ name: String, backGroundColor: UIColor = .white) -> UIImageView {
    let imgView = UIImageView()
    imgView.backgroundColor = backGroundColor
    let image =  UIImage(named:name)?.withInset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
    imgView.image = image
    imgView.layer.cornerRadius = 5
    imgView.contentMode = .scaleAspectFit
    imgView.clipsToBounds = true
    return imgView
}

func createLabel() -> UILabel {
    let label = UILabel()
    label.backgroundColor = .white
    label.numberOfLines = 0
    return label
}

// MARK: - CELL
class InfosCell: BasicCell {

    private let nameLabel : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()

    private let addressLabel : UILabel = {
        return createLabel()
    }()

    private let shadowView : UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.cornerRadius = 10
        v.layer.shadowOpacity = 0.3
        v.layer.shadowOffset = CGSize(width: 0,height: 10)
        v.layer.shadowRadius = 3
        return v
    }()

    private let addressImage : UIImageView = {
        return createIcomeView("location", backGroundColor:  UIColor(rgb: 0xeef8e8, alphaVal: 1))
    }()

    private let foodLabel : UILabel = {
        return createLabel()
    }()

    private let foodImage : UIImageView = {
        return createIcomeView("food", backGroundColor:  UIColor(rgb: 0xeef8e8, alphaVal: 1))
    }()

    private let cashLabel : UILabel = {
        return createLabel()
    }()

    private let cashImage : UIImageView = {
        return createIcomeView("cash", backGroundColor:  UIColor(rgb: 0xeef8e8, alphaVal: 1))
    }()

    private let averrageContainer: AverageContainerView = {
        let container = AverageContainerView()
        return container
    }()

    override func  addViews() {
        contentView.addSubview(shadowView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressImage)
        contentView.addSubview(addressLabel)
        contentView.addSubview(foodImage)
        contentView.addSubview(foodLabel)
        contentView.addSubview(cashImage)
        contentView.addSubview(cashLabel)
        contentView.addSubview(averrageContainer)

        nameLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                         right: contentView.rightAnchor,
                         paddingTop:10,
                         paddingLeft: 10)
        addressImage.anchor(top: nameLabel.bottomAnchor,
                            left: nameLabel.leftAnchor,
                            paddingTop:10,
                            width: 30,
                            height: 30)
        addressLabel.anchor(left: addressImage.rightAnchor,
                            right: contentView.rightAnchor,
                            centerY: addressImage.centerYAnchor,
                            paddingLeft: 10)
        foodImage.anchor(top: addressImage.bottomAnchor,
                         left: addressImage.leftAnchor,
                         paddingTop:10,
                         width: 30,
                         height: 30)
        foodLabel.anchor(left: foodImage.rightAnchor,
                         right: contentView.rightAnchor,
                         centerY: foodImage.centerYAnchor,
                         paddingLeft: 10)
        cashImage.anchor(top: foodImage.bottomAnchor,
                         left: foodImage.leftAnchor,
                         paddingTop:10,
                         width: 30,
                         height: 30)
        cashLabel.anchor(left: cashImage.rightAnchor,
                         right: contentView.rightAnchor,
                         centerY: cashImage.centerYAnchor,
                         paddingLeft: 10)
        averrageContainer.anchor(top: cashLabel.bottomAnchor,
                                 left: contentView.leftAnchor,
                                 right: contentView.rightAnchor,
                                 paddingTop: 10)
        shadowView.anchor(top: contentView.topAnchor,
                          left: contentView.leftAnchor,
                          bottom: averrageContainer.bottomAnchor,
                          right:contentView.rightAnchor)

        contentView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: 20).isActive = true
    }

    override func feedWithModel(viewModel: ModelProtocol?) {
        guard let model = viewModel as? RestaurantInfosViewModel else {
            return
        }
        self.nameLabel.text = model.name
        self.addressLabel.text =  model.getFullAddress()
        self.foodLabel.text = model.speciality ?? ""
        self.cashLabel.text = "Average price \(model.cardPrice ?? 0) \(model.currencyCode ?? "")"
        self.averrageContainer.feedWithModel(viewModel: model)
    }
}
// MARK: - INFOS CONTAINER
class AverageContainerView: UIView {

    private let averrageView : AverageView = {
        return AverageView()
    }()

    private let tripView : TripAdvisorView = {
        return TripAdvisorView()
    }()

    private let separator : UIView = {
        let sep = UIView()
        sep.backgroundColor = .gray
        return sep
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.separator)
        addSubview(self.averrageView)
        addSubview(self.tripView)
        self.separator.anchor(top: topAnchor,
                              bottom: bottomAnchor,
                              centerY: centerYAnchor,
                              paddingTop: 10,
                              paddingBottom: 10,
                              width: 2)
        self.averrageView.anchor(top: topAnchor,
                                 left: leftAnchor,
                                 bottom: bottomAnchor,
                                 right: self.separator.leftAnchor ,
                                 paddingTop: 10,
                                 paddingBottom: 10,
                                 width: UIScreen.main.bounds.size.width / 2)
        self.tripView.anchor(top:  topAnchor,
                             left: separator.rightAnchor,
                             bottom: self.averrageView.bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 10,
                             paddingLeft: 10)
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    convenience init(_ average: Double) {
        self.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func feedWithModel(viewModel: ModelProtocol?) {
        guard let model = viewModel as? RestaurantInfosViewModel else {
            return
        }

        self.averrageView.feedWithModel(viewModel: model)
        self.tripView.feedWithModel(viewModel: model)
    }
}
// MARK: - AVERAGE CONTAINER
class AverageView: UIView {

    private var imageView : UIImageView = {
        return createIcomeView("tf-logo")
    }()

    private let averrageLabel : UILabel = {
        return createLabel()
    }()

    private let countLabel : UILabel = {
        let label = createLabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.imageView)
        addSubview(self.averrageLabel)
        addSubview(self.countLabel)
        self.countLabel.anchor(top:  self.averrageLabel.bottomAnchor,
                               left: leftAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor ,
                               paddingTop: 10,
                               paddingBottom: 10)

        self.imageView.anchor( left: leftAnchor,
                               centerY: self.averrageLabel.centerYAnchor,
                               paddingLeft: 20,
                               width: 30,
                               height: 30)

        self.averrageLabel.anchor(top: topAnchor,
                                  left: self.imageView.rightAnchor,
                                  right: rightAnchor,
                                  paddingLeft: 10)
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func feedWithModel(viewModel: ModelProtocol?) {
        guard let model = viewModel as? RestaurantInfosViewModel else {
            return
        }

        self.averrageLabel.attributedText = model.averrageAttributedString()
        self.countLabel.text = model.forkReviewString()

    }
}

// MARK: - TRIPADVISOR CONTAINER
class TripAdvisorView: UIView {
    private var imageView : UIImageView = {
        return createIcomeView("ta-logo")
    }()

    private var dotImage1 = UIImageView()
    private var dotImage2 = UIImageView()
    private var dotImage3 = UIImageView()
    private var dotImage4 = UIImageView()
    private var dotImage5 = UIImageView()

    private var dotImages = [UIImageView]()
    private let averrageLabel : UILabel = {
        let label = createLabel()
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()

    private let countLabel : UILabel = {
        let label = createLabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        dotImages = [dotImage1, dotImage2, dotImage3, dotImage4, dotImage5]
        addSubview(self.imageView)
        addSubview(self.averrageLabel)
        addSubview(self.countLabel)

        addSubview(self.dotImage1)
        addSubview(self.dotImage2)
        addSubview(self.dotImage3)
        addSubview(self.dotImage4)
        addSubview(self.dotImage5)

        self.countLabel.anchor(top:  self.averrageLabel.bottomAnchor,
                               left: leftAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor ,
                               paddingTop: 10,
                               paddingBottom: 10)

        self.imageView.anchor(left: leftAnchor,
                              centerY: self.averrageLabel.centerYAnchor,
                              paddingLeft: 10,
                              width: 30,
                              height: 30)

        self.dotImage1.anchor(left: imageView.rightAnchor,
                              centerY: self.imageView.centerYAnchor,
                              paddingLeft: 10,
                              width: 20,
                              height: 20)

        self.dotImage2.anchor(top: dotImage1.topAnchor,
                              left: dotImage1.rightAnchor,
                              centerY: self.dotImage1.centerYAnchor,
                              paddingLeft: 3,
                              width: 20,
                              height: 20)

        self.dotImage3.anchor(top: dotImage2.topAnchor,
                              left: dotImage2.rightAnchor,
                              centerY: self.dotImage2.centerYAnchor ,
                              paddingLeft: 3,
                              width: 20,
                              height: 20)

        self.dotImage4.anchor(top: dotImage3.topAnchor,
                              left: dotImage3.rightAnchor,
                              centerY: self.dotImage3.centerYAnchor,
                              paddingLeft: 3,
                              width: 20,
                              height: 20)

        self.dotImage5.anchor(top: dotImage4.topAnchor,
                              left: dotImage4.rightAnchor,
                              centerY: self.dotImage4.centerYAnchor,
                              paddingLeft: 3,
                              width: 20, height: 20)

        self.averrageLabel.anchor(top: topAnchor,
                                  left: self.imageView.rightAnchor,
                                  right: rightAnchor,
                                  paddingLeft: 10)
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func feedWithModel(viewModel: ModelProtocol?) {
        guard let model = viewModel as? RestaurantInfosViewModel else {
            return
        }
        for (index, item) in dotImages.enumerated() {
            item.image = UIImage(named: "ta-bubbles-empty")
            let rate = model.tripadvisorAvgRate ?? 0.0
            if rate >= Float(index + 1) {
                item.image = UIImage(named: "ta-bubbles-full")
            }
        }
        self.averrageLabel.attributedText = model.averrageAttributedString()
        self.countLabel.text = model.tripAdvisorReviewString()
    }

}

