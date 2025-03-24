import UIKit
import SnapKit
import MapKit

// MARK: - SearchViewDelegate

protocol SearchViewDelegate: AnyObject {
    func searchView(_ view: SearchView, didSelectMapItemWithID id: Hospital.ID)
}

// MARK: - SearchView

final class SearchView: UIView {
    typealias Delegate = SearchViewDelegate
    
    private lazy var mapView = makeMapView()
    private lazy var zoomButtonsView = SearchZoomButtonsView(with: self)
    
    private weak var delegate: Delegate?
    
    init(with delegate: Delegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func addAnnotations(with items: [HospitalMapItem]) {
        mapView.removeAnnotations(mapView.annotations)
        items.forEach { item in
            let annotation = SearchMapMarkerAnnotationView.PointAnnotation(
                with: item.id,
                and: CLLocationCoordinate2D(
                    latitude: item.address.latitude,
                    longitude: item.address.longitude
                )
            )
            mapView.addAnnotation(annotation)
        }
    }
    
    func unselectAnnotation() {
        let selectedAnnotations = mapView.selectedAnnotations
        for annotation in selectedAnnotations {
            mapView.deselectAnnotation(annotation, animated: true)
        }
    }
    
    private func setup() {
        [mapView, zoomButtonsView].forEach { addSubview($0) }
        backgroundColor = Colors.fillBackgroundPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        zoomButtonsView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func makeMapView() -> MKMapView {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 43.238949, longitude: 76.889709)
        let region = MKCoordinateRegion(
            center: centerCoordinate,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
        
        let view = MKMapView()
        view.delegate = self
        view.pointOfInterestFilter = .excludingAll
        view.setRegion(region, animated: false)
        view.register(
            SearchMapMarkerAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: SearchMapMarkerAnnotationView.reuseIdentifier
        )
        return view
    }
}

// MARK: - MKMapViewDelegate

extension SearchView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        guard let annotation = annotation as? SearchMapMarkerAnnotationView.PointAnnotation else {
            return nil
        }
        
        let annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: SearchMapMarkerAnnotationView.reuseIdentifier,
            for: annotation
        ) as? SearchMapMarkerAnnotationView
        annotationView?.annotation = annotation
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? SearchMapMarkerAnnotationView.PointAnnotation else {
            assertionFailure()
            return
        }
        
        delegate?.searchView(self, didSelectMapItemWithID: annotation.id)
    }
}

// MARK: - SearchZoomButtonsViewDelegate

extension SearchView: SearchZoomButtonsViewDelegate {
    func searchZoomButtonsView(
        _ view: SearchZoomButtonsView,
        didTapButtonWithKind kind: SearchZoomButtonsView.ZoomButton.ZoomKind
    ) {
        switch kind {
        case .plus:
            var region = mapView.region
            region.span.latitudeDelta /= 2.0
            region.span.longitudeDelta /= 2.0
            mapView.setRegion(region, animated: true)
        case .minus:
            var region = mapView.region
            region.span.latitudeDelta *= 2.0
            region.span.longitudeDelta *= 2.0
            mapView.setRegion(region, animated: true)
        }
    }
}
