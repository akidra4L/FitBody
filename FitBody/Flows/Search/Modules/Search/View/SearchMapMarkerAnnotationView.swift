import UIKit
import MapKit

// MARK: - SearchMapMarkerAnnotationView

final class SearchMapMarkerAnnotationView: MKMarkerAnnotationView {
    static let reuseIdentifier = "hospitalPin"

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        nil
    }

    private func setup() {
        canShowCallout = true
        glyphImage = Icons.pin32x32
        markerTintColor = Colors.fillPrimary
    }
}

// MARK: - SearchMapMarkerAnnotationView.PointAnnotation

extension SearchMapMarkerAnnotationView {
    final class PointAnnotation: MKPointAnnotation {
        let id: Int
        
        init(with id: Int, and coordinate: CLLocationCoordinate2D) {
            self.id = id
            super.init()
            self.coordinate = coordinate
        }
    }
}
