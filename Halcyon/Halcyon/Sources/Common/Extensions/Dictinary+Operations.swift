import Foundation

extension Dictionary {
    mutating func merge(dict: [Key: Value]) -> [Key: Value] {
        var currentDict = self
        for (k, v) in dict {
            currentDict.updateValue(v, forKey: k)
        }
        return currentDict
    }
}
