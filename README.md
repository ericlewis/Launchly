# Launchly

LaunchDarkly with SwiftUI!

## Project Structure

### Extensions
- Contains the code for injecting a given `LDClient` into a given subtree 

### Models
- Contains the code that interacts with the `LDClient`, uses an `ObservedObject` paradigm

### Property Wrappers
- The property wrappers to be used within the SwiftUI code
    - @ObservedFlag: this listens to a boolean based variation that will react depending on the `LDClient` configuration injected via `environment`
