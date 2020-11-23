//
//  MapCell.swift
//  theFork
//
//  Created by Damien on 20/11/2020.
//

import UIKit
import MapKit
protocol MapCellDelegate: class {
    func book()
    func didSelectCoordinates(_ location: CLLocationCoordinate2D)
}
class MapCell: BasicCell, MKMapViewDelegate {

    weak var delegate: MapCellDelegate?
    private let mapView : MKMapView = {
        return MKMapView()
    }()

    private let button : UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(rgb: 0x66914c, alphaVal: 1)
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.layer.cornerRadius = 20
        button.setTitle("Book a table", for: .normal)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
           contentView.backgroundColor = UIColor.orange
        addViews()
        mapView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.mapView.addGestureRecognizer(tapGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func  addViews() {
        super.addViews()
        contentView.addSubview(self.mapView)
        contentView.addSubview(self.button)
        self.mapView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300, enableInsets: true)

        self.button.anchor(top: nil, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 40, enableInsets: true)

        button.addTarget(self, action: #selector(book), for: .touchUpInside)
    }

    override func feedWithModel(viewModel: ModelProtocol?) {
        guard let model = viewModel as? RestaurantMapViewModel, let lat = model.gpsLat, let lon =  model.gpsLong  else {
            return
        }
       let ann = mapView.annotations.filter {
        $0.coordinate.latitude != lat || $0.coordinate.latitude != lon
        }
        if !ann.isEmpty {
            return
        }
        let annotation =  MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude:lat, longitude: lon)

        self.mapView.addAnnotation(annotation)
        let regionRadius: CLLocationDistance = 250
        let coordinateRegion = MKCoordinateRegion(center: annotation.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)

    }

    @objc func book() {
        self.delegate?.book()
    }

    @objc func tap() {
        let ann = mapView.annotations.first
        if let coordinate = ann?.coordinate {
            self.delegate?.didSelectCoordinates(coordinate)
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let coordinate = view.annotation?.coordinate {
            self.delegate?.didSelectCoordinates(coordinate)
        }
    }



    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard isUserInteractionEnabled else { return nil }
        guard !isHidden else { return nil }
        guard self.point(inside: point, with: event) else { return nil }
        if button.point(inside: convert(point, to: button), with: event) {
            return button
        }
        return super.hitTest(point, with: event)
    }

}
