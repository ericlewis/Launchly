## Example

This is an entire SwiftUI application utiliziting Launchly with default settings.

```swift
import SwiftUI
import Launchly
import LaunchDarkly

struct Constants {
    static let launchDarklyKey = "#YOUR_MOBILE_KEY#"
}

struct Flags {
    static let test = "test"
}

struct ContentView: View {
    @ObservedVariation(Flags.test, defaultValue: false) var flag
    
    var body: some View {
        Text(flag == true ? "true" : "false")
    }
}

@main
struct LaunchlyApp: App {
    init() {
        LDClient.start(config: LDConfig(mobileKey: Constants.launchDarklyKey))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

## Project Structure

### Extensions
- Contains the code for injecting a given `LDClient` into a given subtree 

### Models
- Contains the code that interacts with the `LDClient`, uses an `ObservedObject` paradigm

### Property Wrappers
- The property wrappers to be used within the SwiftUI code
    - @ObservedFlag: this listens to a boolean based variation that will react depending on the `LDClient` configuration injected via `environment`
