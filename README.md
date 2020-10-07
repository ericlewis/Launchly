# Launchly

An easy to use [LaunchDarkly](https://launchdarkly.com) framework for SwiftUI. Supports iOS 13, macOS 10.15.

# Example

This is an entire SwiftUI application utilizing Launchly with default settings.

```swift
import SwiftUI
import Launchly
import LaunchDarkly

let launchDarklyKey = "#YOUR_MOBILE_KEY#"

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
        LDClient.start(config: LDConfig(mobileKey: launchDarklyKey))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

# Project Structure

## Extensions
- Contains the code for injecting a given `LDClient` into Environment.

## Models
- Contains the code that interacts with the `LDClient`.

## Property Wrappers
- The property wrappers to be used within the SwiftUI code
    - @ObservedFlag: this listens to a boolean based variation that will react depending on the `LDClient` configuration injected via `environment`
    
# License
MIT
