import Foundation

protocol UserProfileModulesFactory: AnyObject {
    func makeUserProfile() -> Presentable & UserProfileViewOutput
}

extension ModulesFactory: UserProfileModulesFactory {
    func makeUserProfile() -> Presentable & UserProfileViewOutput {
        UserProfileViewController()
    }
}
