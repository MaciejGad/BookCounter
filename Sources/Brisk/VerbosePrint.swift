import Foundation

func verbosePrint(_ item: Any?) {
    if Brisk.verbose {
        if let item = item {
            print(item)
        } else {
            print("nil")
        }
    }
}
