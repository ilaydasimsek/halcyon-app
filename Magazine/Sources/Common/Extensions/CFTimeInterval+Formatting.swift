import Foundation

extension CFTimeInterval {
    var formattedTimeString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        let formattedString = formatter.string(from: self)
        return formattedString ?? String(self)
    }
}
