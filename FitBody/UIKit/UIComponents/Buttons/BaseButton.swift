import UIKit

open class BaseButton: UIButton, LoadableButton {
    public enum Size {
        case small
        case medium
        case large
        case largeFixed
    }

    override public var intrinsicContentSize: CGSize { makeIntrinsicContentSize(for: size) }

    public var isLoading = false { didSet { configureLoadingState(with: oldValue, and: isLoading) } }
    public var isActiveChevron = false { didSet { configureChevron(with: oldValue, and: isActiveChevron) } }

    public var backgroundColors: [State.RawValue: UIColor] = [:] { didSet { setNeedsUpdateConfiguration() } }
    public var imageColors: [State.RawValue: UIColor] = [:] { didSet { setNeedsUpdateConfiguration() } }
    public var strokeColors: [State.RawValue: UIColor] = [:] { didSet { setNeedsUpdateConfiguration() } }
    public var strokeWidths: [State.RawValue: CGFloat] = [:] { didSet { setNeedsUpdateConfiguration() } }
    public var subtitles: [State.RawValue: String] = [:] { didSet { setNeedsUpdateConfiguration() } }
    public var subtitleColors: [State.RawValue: UIColor] = [:] { didSet { setNeedsUpdateConfiguration() } }
    public var titleColors: [State.RawValue: UIColor] = [:] { didSet { setNeedsUpdateConfiguration() } }
    private var titles: [State.RawValue: String] = [:] { didSet { setNeedsUpdateConfiguration() } }

    private(set) lazy var activityIndicatorView = makeActivityIndicatorView()

    public let size: Size

    public init(size: Size) {
        self.size = size
        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        nil
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        activityIndicatorView.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }

    @available(*, unavailable)
    override public func setImage(_ image: UIImage?, for state: UIControl.State) {}

    public func setImage(_ image: UIImage?, with imagePlacement: NSDirectionalRectEdge = .leading) {
        configuration?.image = image
        configuration?.imagePlacement = imagePlacement
    }

    override public func setTitle(_ title: String?, for state: State) {
        titles[state.rawValue] = title
    }

    override public func setTitleColor(_ color: UIColor?, for state: State) {
        titleColors[state.rawValue] = color
    }

    private func configureChevron(with oldValue: Bool, and newValue: Bool) {
        guard oldValue != newValue else {
            return
        }

        configuration?.image = newValue ? UIImage(systemName: "chevron.right") : nil
        configuration?.imagePlacement = newValue ? .trailing : .leading
    }

    private func configureLoadingState(with oldValue: Bool, and newValue: Bool) {
        guard oldValue != newValue else {
            return
        }

        activityIndicatorView.isHidden = !newValue
        newValue ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        imageView?.layer.transform = newValue
            ? CATransform3DMakeScale(0.0, 0.0, 0.0)
            : CATransform3DIdentity
        isUserInteractionEnabled = !newValue

        setNeedsUpdateConfiguration()
    }

    private func setup() {
        addSubview(activityIndicatorView)

        setupConfiguration()
        setupConfigurationUpdateHandler()
    }

    private func setupConfiguration() {
        var configuration = Configuration.filled()
        configuration.background.cornerRadius = intrinsicContentSize.height / 2
        configuration.contentInsets = makeContentInsets()
        configuration.imagePadding = makeImagePadding()
        configuration.titleAlignment = .center
        configuration.titlePadding = 0
        self.configuration = configuration
    }

    private func setupConfigurationUpdateHandler() {
        configurationUpdateHandler = { [weak self] button in
            guard
                let self,
                var configuration = button.configuration
            else {
                assertionFailure()
                return
            }

            let state = button.state.rawValue
            let normalState = State.normal.rawValue

            let backgroundColor = backgroundColors[state] ?? backgroundColors[normalState] ?? .clear
            let imageColor = imageColors[state] ?? imageColors[normalState]
            let strokeColor = strokeColors[state] ?? strokeColors[normalState] ?? .clear
            let strokeWidth = strokeWidths[state] ?? strokeWidths[normalState] ?? 0
            let subtitle = subtitles[state] ?? subtitles[normalState]
            let subtitleColor = subtitleColors[state] ?? subtitleColors[normalState]
            let title = titles[state] ?? titles[normalState]
            let titleColor = titleColors[state] ?? titleColors[normalState]

            configuration.background.backgroundColor = backgroundColor
            configuration.background.strokeColor = strokeColor
            configuration.background.strokeWidth = strokeWidth
            configuration.imageColorTransformer = .init { [isLoading] incoming in
                (isLoading ? .clear : imageColor) ?? incoming
            }
            configuration.subtitle = subtitle
            configuration.subtitleTextAttributesTransformer = .init { [isLoading] incoming in
                var updated = incoming
                updated.font = Fonts.headline5
                updated.foregroundColor = isLoading ? .clear : subtitleColor
                return updated
            }
            configuration.title = title
            configuration.titleTextAttributesTransformer = .init { [isLoading, size] incoming in
                var updated = incoming
                updated.font = (size == .small) ? Fonts.title6 : Fonts.title3
                updated.foregroundColor = isLoading ? .clear : titleColor
                return updated
            }
            button.configuration = configuration
        }
    }

    private func makeActivityIndicatorView() -> ActivityIndicatorView {
        let view =
            switch size {
            case .small:
                ActivityIndicatorView(size: .extraSmall, color: Colors.fillInput)
            case .medium:
                ActivityIndicatorView(size: .small, color: Colors.fillInput)
            case .large, .largeFixed:
                ActivityIndicatorView(size: .medium, color: Colors.fillInput)
            }
        view.isUserInteractionEnabled = false
        return view
    }

    private func makeContentInsets() -> NSDirectionalEdgeInsets {
        let inset = makeImagePadding() / 2

        return switch size {
        case .small:
            isActiveChevron
                ? NSDirectionalEdgeInsets(top: 0, leading: 16 + inset, bottom: 0, trailing: 16 + inset)
                : NSDirectionalEdgeInsets(top: 0, leading: 16 - inset, bottom: 0, trailing: 16 - inset)
        case .medium:
            isActiveChevron
                ? NSDirectionalEdgeInsets(top: 0, leading: 24 + inset, bottom: 0, trailing: 24 + inset)
                : NSDirectionalEdgeInsets(top: 0, leading: 24 - inset, bottom: 0, trailing: 24 - inset)
        case .large:
            isActiveChevron
                ? NSDirectionalEdgeInsets(top: 0, leading: 40 + inset, bottom: 0, trailing: 40 + inset)
                : NSDirectionalEdgeInsets(top: 0, leading: 40 - inset, bottom: 0, trailing: 40 - inset)
        case .largeFixed:
            isActiveChevron
                ? NSDirectionalEdgeInsets(top: 0, leading: 20 + inset, bottom: 0, trailing: 20 + inset)
                : NSDirectionalEdgeInsets(top: 0, leading: 20 - inset, bottom: 0, trailing: 20 - inset)
        }
    }

    private func makeImagePadding() -> CGFloat {
        switch size {
        case .small:
            4
        case .medium:
            6
        case .large, .largeFixed:
            8
        }
    }

    private func makeIntrinsicContentSize(for size: Size) -> CGSize {
        switch size {
        case .small:
            CGSize(width: super.intrinsicContentSize.width, height: 32)
        case .medium:
            CGSize(width: super.intrinsicContentSize.width, height: 36)
        case .large, .largeFixed:
            CGSize(width: super.intrinsicContentSize.width, height: 48)
        }
    }
}
