# Launchly

An easy to use [LaunchDarkly](https://launchdarkly.com) framework for SwiftUI. Supports iOS 13+, macOS 10.15+, watchOS 6+.

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
    @Environment(\.launchDarklyClient) var client
    @ObservedVariation(Flags.test, defaultValue: false) var flag
    
    private func trackView() {
        try? client.track(key: "Viewed")
    }
    
    var body: some View {
        Text(flag == true ? "true" : "false")
            .onAppear(perform: trackView)
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
- Contains the code that interacts with the `LDClient`, backing up the Property Wrappers.

## Property Wrappers
- The property wrappers to be used within the SwiftUI code
    - @ObservedFlag: monitor variations that will react depending on the `LDClient` configuration injected via `environment`.
    - @ObservedStatus: monitor the LaunchDarkly SDK connection status. 
    
# License
Copyright (c) 2020 Eric Lewis

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
OR OTHER DEALINGS IN THE SOFTWARE.

