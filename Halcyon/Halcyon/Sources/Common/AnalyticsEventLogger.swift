import FirebaseAnalytics

class AnalyticsEventLogger {

    static func login() {
        FirebaseAnalytics.Analytics.logEvent(AnalyticsEventLogin, parameters: [:])
    }

    static func register() {
        FirebaseAnalytics.Analytics.logEvent(AnalyticsEventSignUp, parameters: [:])
    }
}

