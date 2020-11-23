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
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressImage)
        contentView.addSubview(addressLabel)
        contentView.addSubview(foodImage)
        contentView.addSubview(foodLabel)
        contentView.addSubview(cashImage)
        contentView.addSubview(cashLabel)
        contentView.addSubview(averrageContainer)
        nameLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right:contentView.rightAnchor, paddingTop:10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        addressImage.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right:nil, paddingTop:10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30, enableInsets: true)
        addressLabel.anchor(top: nil, left: addressImage.rightAnchor, bottom: nil, right: contentView.rightAnchor,centerY: addressImage.centerYAnchor, paddingTop:0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        foodImage.anchor(top: addressImage.bottomAnchor, left: addressImage.leftAnchor, bottom: nil, right:nil, paddingTop:10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30, enableInsets: true)
        foodLabel.anchor(top: nil, left: foodImage.rightAnchor, bottom: nil, right: contentView.rightAnchor,centerY: foodImage.centerYAnchor, paddingTop:0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        cashImage.anchor(top: foodImage.bottomAnchor, left: foodImage.leftAnchor, bottom: nil, right:nil, paddingTop:10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30, enableInsets: true)

        cashLabel.anchor(top: nil, left: cashImage.rightAnchor, bottom: nil, right: contentView.rightAnchor,centerY: cashImage.centerYAnchor, paddingTop:0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        averrageContainer.anchor(top: cashLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height:0, enableInsets: true)
        contentView.bottomAnchor.constraint(equalTo: averrageContainer.bottomAnchor, constant: 0).isActive = true
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

        self.separator.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: nil, centerY: centerYAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 2, height: 0, enableInsets: true)

        self.averrageView.anchor(top:  topAnchor, left: leftAnchor, bottom: bottomAnchor, right:  self.separator.leftAnchor , paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.size.width / 2, height: 0, enableInsets: true)

        self.tripView.anchor(top:  topAnchor, left: separator.rightAnchor, bottom: self.averrageView.bottomAnchor, right:  rightAnchor , paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.size.width / 2, height: 0, enableInsets: true)

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
        self.countLabel.anchor(top:  self.averrageLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor , paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        self.imageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil ,centerY: self.averrageLabel.centerYAnchor ,paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 30, height: 30, enableInsets: true)
        self.averrageLabel.anchor(top: topAnchor, left: self.imageView.rightAnchor, bottom: nil, right: rightAnchor , paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
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

        self.countLabel.anchor(top:  self.averrageLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor , paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: true)
        self.imageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil ,centerY: self.averrageLabel.centerYAnchor ,paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 30, height: 30, enableInsets: true)

        self.dotImage1.anchor(top: nil, left: imageView.rightAnchor, bottom: nil, right: nil ,centerY: self.imageView.centerYAnchor ,paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 20, height: 20, enableInsets: true)

        self.dotImage2.anchor(top: dotImage1.topAnchor, left: dotImage1.rightAnchor, bottom: nil, right: nil ,centerY: self.dotImage1.centerYAnchor ,paddingTop: 0, paddingLeft: 3, paddingBottom: 0, paddingRight: 0, width: 20, height: 20, enableInsets: true)

        self.dotImage3.anchor(top: dotImage2.topAnchor, left: dotImage2.rightAnchor, bottom: nil, right: nil ,centerY: self.dotImage2.centerYAnchor ,paddingTop: 0, paddingLeft: 3, paddingBottom: 0, paddingRight: 0, width: 20, height: 20, enableInsets: true)

        self.dotImage4.anchor(top: dotImage3.topAnchor, left: dotImage3.rightAnchor, bottom: nil, right: nil ,centerY: self.dotImage3.centerYAnchor ,paddingTop: 0, paddingLeft: 3, paddingBottom: 0, paddingRight: 0, width: 20, height: 20, enableInsets: true)

        self.dotImage5.anchor(top: dotImage4.topAnchor, left: dotImage4.rightAnchor, bottom: nil, right: nil ,centerY: self.dotImage4.centerYAnchor ,paddingTop: 0, paddingLeft: 3, paddingBottom: 0, paddingRight: 0, width: 20, height: 20, enableInsets: true)

        self.averrageLabel.anchor(top: topAnchor, left: self.imageView.rightAnchor, bottom: nil, right: rightAnchor , paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: true)
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

