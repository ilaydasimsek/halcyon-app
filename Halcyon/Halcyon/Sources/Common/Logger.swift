import OSLog

class CustomLogger {
    static private let logger = Logger()

    /**
     Captures errors seen during the execution of your code. If an activity object exists, the system captures information for the related process chain.
     */
    static func logError(_ message: OSLogMessage) {
        logger.error(message)
    }

    /**
     Captures verbose information during development that is useful only for debugging your code.
     */
    static func debugLog(_ message: OSLogMessage) {
        logger.debug(message)
    }
}
