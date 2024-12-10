# orientation_state

A Flutter plugin of detect screen orientation lock switch status.
!!You need to define manual permission to change system settings

## Getting Started

```dart
import 'package:orientation_state/orientation_state.dart';

isDeviceOrientationLocked = await _OrientationStateCheckerPlugin.isDeviceOrientationLocked();

await _OrientationStateCheckerPlugin.setOrientationState(true);
await _OrientationStateCheckerPlugin.setOrientationState(false);
```

