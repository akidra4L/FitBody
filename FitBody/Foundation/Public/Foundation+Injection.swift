import Resolver

extension Resolver {
    static func registerFoundationServices() {
        register { PropertyDateFormatterImpl() }
            .implements(PropertyDateFormatter.self)
            .scope(.shared)
        
        register { PropertyNumberFormatterImpl() }
            .implements(PropertyNumberFormatter.self)
            .scope(.shared)
        
        register { RatingFormatterImpl() }
            .implements(RatingFormatter.self)
            .scope(.shared)
    }
}
