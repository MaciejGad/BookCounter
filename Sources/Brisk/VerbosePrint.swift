import Foundation

let verbose = isarg("v")
func verbosePrint(_ item: Any?) {
    if verbose {
        if let item = item {
            print(item)
        } else {
            print("nil")
        }
    }
}
