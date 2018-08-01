//
//  AppUpdateHelper.swift
//

import UIKit

private struct AppUpdateHelperConstants {
    
    static let kUpdateAppAlertNoThanksPressed = "kUpdateAppAlertNoThanksPressed"
    static let kUpdateAppAlertLaterPressed = "kUpdateAppAlertLaterPressed"
    static let kUpdateAppAlertLastDate = "kUpdateAppAlertLastDate"
    static let kUpdateAppAlertLastBuildNumber = "kUpdateAppAlertLastBuildNumber"
    static let kCachedRecommendedBuildNumber = "kCachedRecommendedBuildNumber"
    
    static let appStoreBaseLink = "itms-apps://itunes.apple.com/app/id%@?mt=8"
}

class AppUpdateHelper: NSObject {
    
    private static let minValidBuildNumber = 1550 // example
    private static let minRecommendedAppVersioniOS = 1555 // example
    private static let itunesId = "00000000" // example

    static private(set) var lastBuildNumber = UserDefaults.standard.integer(forKey: AppUpdateHelperConstants.kUpdateAppAlertLastBuildNumber) {
        didSet {
            UserDefaults.standard.set(lastBuildNumber, forKey: AppUpdateHelperConstants.kUpdateAppAlertLastBuildNumber)
            UserDefaults.standard.synchronize()
        }
    }
    
    static private(set) var alertLastDate = UserDefaults.standard.object(forKey: AppUpdateHelperConstants.kUpdateAppAlertLastDate) {
        didSet {
            UserDefaults.standard.set(alertLastDate, forKey: AppUpdateHelperConstants.kUpdateAppAlertLastDate)
            UserDefaults.standard.synchronize()
        }
    }
    
    static private(set) var cachedRecommendedBuildNumber = UserDefaults.standard.integer(forKey: AppUpdateHelperConstants.kCachedRecommendedBuildNumber) {
        didSet {
            UserDefaults.standard.set(cachedRecommendedBuildNumber, forKey: AppUpdateHelperConstants.kCachedRecommendedBuildNumber)
            UserDefaults.standard.synchronize()
        }
    }

    static func checkAppUpdateRequired() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            let buildNumber = SettingsInfoHelper.buildNumber()
            let rootController = UIApplication.shared.keyWindow?.rootViewController
            if let rootViewController = rootController, rootController?.presentedViewController == nil {
                if buildNumber < minValidBuildNumber {
                    showAppUpdateRequiredAlert(viewController: rootViewController)
                }
                if buildNumber < minRecommendedAppVersioniOS {
                   showAppUpdateRecommendAlert(viewController: rootViewController)
                }
            }
        }
    }
    
    static func showAppUpdateRequiredAlert(viewController: UIViewController) {
        viewController.showAppUpdateRequiredAlert {
            openItunes(with: itunesId)
        }
    }
    
    static func showAppUpdateRecommendAlert(viewController: UIViewController) {
        let buildNumber = SettingsInfoHelper.buildNumber()
        cleanLastBuildNumberIfNeeded()
        if lastBuildNumber != buildNumber {
            if isTimeToUpdateAlert() {
                viewController.showAppUpdateRecommendAlert { (action) in
                    switch action {
                        case .later:
                            alertLastDate = Date()
                        break
                        case .noThanks:
                            lastBuildNumber = SettingsInfoHelper.buildNumber()
                        break
                        case .updateNow:
                            openItunes(with: itunesId)
                        break
                    }
                }
            }
        }
    }
    
    // MARK: helpers
    
    private static func isTimeToUpdateAlert() -> Bool {
        var dateInterval = Date().timeIntervalSince1970
        var isTimeToUpdate = false
        if let alertDate = alertLastDate as? Date {
            dateInterval = dateInterval - alertDate.timeIntervalSince1970
            dateInterval = dateInterval / 3600
            if dateInterval >= 24 {
                isTimeToUpdate = true
                alertLastDate = Date()
            }
        } else {
            isTimeToUpdate = true
        }
        return isTimeToUpdate
    }
    
    private static func cleanLastBuildNumberIfNeeded() {
        if cachedRecommendedBuildNumber != minRecommendedAppVersioniOS {
            cachedRecommendedBuildNumber = minRecommendedAppVersioniOS
            lastBuildNumber = 0
        }
    }
}

extension AppUpdateHelper {
    
    static func openItunes(with appId: String) {
        let urlString = String(format: AppUpdateHelperConstants.appStoreBaseLink, appId)
        guard let appStoreUrl = URL(string: urlString) else { return }
        UIApplication.shared.open(appStoreUrl)
    }
    
}
