import Foundation

protocol AuthorizedUserDataFetcher: AnyObject, Sendable {
    func fetch() async
}
