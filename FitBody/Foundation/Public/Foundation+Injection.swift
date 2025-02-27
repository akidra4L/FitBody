import Resolver

extension Resolver {
    static func registerFoundationServices() {
        register { PropertyDateFormatterImpl() }
            .implements(PropertyDateFormatter.self)
            .scope(.shared)
    }
}
