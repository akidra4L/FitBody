import Resolver

final class AuthorizedUserDataFetcherImpl: AuthorizedUserDataFetcher {
    private let dependencyContainer = DependencyContainer()
    
    func fetch() async {
        async let userProfile = dependencyContainer.userProfileProvider.get()
        
        _ = await (
            try? userProfile
        )
    }
}

// MARK: - AuthorizedUserDataFetcherImpl.DependencyContainer

extension AuthorizedUserDataFetcherImpl {
    private struct DependencyContainer: Sendable {
        let userProfileProvider = Resolver.resolve(UserProfileProvider.self)
    }
}
