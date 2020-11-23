//
//  MapCell.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import UIKit
import MapKit
class MapCell: BasicCell {

    private let mapView : MKMapView = {
        return MKMapView()
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
           contentView.backgroundColor = UIColor.orange
        addViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func  addViews() {
        super.addViews()
        contentView.addSubview(self.mapView)
        self.mapView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300, enableInsets: true)

    }
}
