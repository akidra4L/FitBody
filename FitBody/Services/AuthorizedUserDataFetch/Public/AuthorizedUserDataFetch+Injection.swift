import Resolver

extension Resolver {
    static func registerAuthorizedUserDataFetch() {
        register { AuthorizedUserDataFetcherImpl() }
            .implements(AuthorizedUserDataFetcher.self)
            .scope(.shared)
    }
}
