import Foundation
import PythonKit

struct Initializer {
        static var isInitialized = false

        static func setup() {
                if !isInitialized {
                        let sys = Python.import("sys")
                        let bundlePath = Bundle.main.resourcePath!
                        sys.path.append(bundlePath)
                        isInitialized = true
                }
        }

        static func runSearchScript (sketchPath: String, startPath: String) -> String {
                setup()
                let module = Python.import("run_search")
                let result = module.format_results(sketchPath, startPath)
                let strResult = Python.str(result)
                return String(strResult) ?? "Error"
        }
}
