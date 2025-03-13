# Go Router Example

A Flutter application demonstrating advanced routing capabilities using Go Router, including nested routes, shell routes, and deep linking.

## Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Routing System](#routing-system)
  - [Route Constants](#route-constants)
  - [Router Configuration](#router-configuration)
  - [Navigation Types](#navigation-types)
  - [Shell Routes](#shell-routes)
  - [Nested Routes](#nested-routes)
- [Deep Linking](#deep-linking)
  - [URL Scheme Configuration](#url-scheme-configuration)
  - [Deep Link Routes](#deep-link-routes)
  - [Dynamic Links Implementation](#dynamic-links-implementation)
  - [Testing Deep Links](#testing-deep-links)
- [Custom Codecs](#custom-codecs)
  - [The Problem](#the-problem)
  - [The Solution](#the-solution)
  - [Implementation](#implementation)
- [State Management with Routes](#state-management-with-routes)
- [Error Handling](#error-handling)
- [Best Practices](#best-practices)
- [References](#references)

## Features

- **Declarative Routing**: Define your routes in a structured, type-safe way
- **Nested Routes**: Create hierarchical route structures
- **Shell Routes**: Maintain state across multiple routes
- **Deep Linking**: Launch the app directly to specific screens from external links
- **Custom Transitions**: Define custom animations for route transitions
- **Type-Safe Parameters**: Pass complex objects between routes with custom codecs
- **Error Handling**: Gracefully handle navigation errors

## Project Structure

The routing system is organized as follows:

```
lib/
├── core/
│   ├── router/
│   │   ├── app_models_codec.dart     # Custom codec for serializing complex objects
│   │   ├── route_constants.dart      # Route path and name constants
│   │   └── router.dart               # Main router configuration
│   ├── models/
│   │   └── micro_app_model.dart      # Example model passed between routes
│   └── constants/
│       └── app_model_codec_constants.dart # Constants for codec types
└── screens/
    ├── home_screen.dart              # Main screen with navigation examples
    ├── campaign_screen.dart          # Example screen with deep link support
    └── ...                           # Other screen implementations
```

## Routing System

### Route Constants

All routes are defined in `route_constants.dart` to maintain consistency and avoid hardcoded strings:

```dart
class RouteConstants {
  static const path = _Path();  // Path patterns for route definitions
  static const route = _Route(); // Full route paths for navigation
}
```

### Router Configuration

The main router is configured in `router.dart`:

```dart
final GoRouter router = GoRouter(
  initialLocation: RouteConstants.route.home,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  extraCodec: const AppModelsCodec(), // Custom codec for complex objects
  routes: [
    // Route definitions...
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
```

### Navigation Types

The app demonstrates different navigation methods:

```dart
// Push a new screen onto the stack
context.push(RouteConstants.route.wallet);

// Replace the current screen
context.go(RouteConstants.route.settings);

// Navigate with parameters
context.go(
  RouteConstants.route.profile,
  extra: 'Username',
);
```

### Shell Routes

Shell routes maintain state across multiple child routes:

```dart
ShellRoute(
  builder: (_, __, Widget child) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: child,
    );
  },
  routes: [
    // Child routes that share the CounterCubit state
  ],
)
```

### Nested Routes

Routes can be nested to create hierarchical navigation:

```dart
GoRoute(
  path: RouteConstants.path.microApp,
  builder: (_, __) => const MicroAppScreen(),
  routes: [
    GoRoute(
      path: RouteConstants.path.shopMicroApp,
      builder: (_, GoRouterState state) => ShopMicroAppScreen(
        microApp: state.extra as MicroAppModel,
      ),
    ),
  ],
),
```

## Deep Linking

Deep linking allows users to open the app directly to a specific screen from external sources.

### URL Scheme Configuration

#### Android (AndroidManifest.xml)

```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="gorouter" android:host="example.com" />
</intent-filter>
```

#### iOS (Info.plist)

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>com.example.goRouterExample</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>gorouter</string>
        </array>
    </dict>
</array>
```

### Deep Link Routes

Deep link routes are defined at the top level of the router configuration:

```dart
GoRoute(
  path: RouteConstants.path.vehicleDeepLink, // '/vehicle/:id'
  redirect: (BuildContext context, GoRouterState state) {
    final id = state.pathParameters['id'];
    return '${RouteConstants.route.vehicleList}/$id';
  },
),
GoRoute(
  path: RouteConstants.path.campaignDetail, // '/campaign/:campaignId'
  redirect: (BuildContext context, GoRouterState state) {
    final campaignId = state.pathParameters['campaignId'];
    final source = state.uri.queryParameters['source'] ?? 'deeplink';
    return '${RouteConstants.route.campaign}?id=$campaignId&source=$source';
  },
),
```

### Dynamic Links Implementation

The application implements dynamic links to navigate to specific screens with parameters. There are several examples in the `home_screen.dart` file:

#### Basic Dynamic Link

```dart
ElevatedButton(
  onPressed: () {
    final uri = Uri.parse(
      'gorouter://example.com/home/counter/child',
    );

    if (uri.scheme == 'gorouter') {
      context.go(uri.path);
    }
  },
  child: const Text('Dynamic Link for Counter Child'),
),
```

#### Dynamic Link with Query Parameters

```dart
ElevatedButton(
  onPressed: () {
    final uri = Uri.parse(
      'gorouter://example.com/home/vehicle-list/1',
    );

    if (uri.scheme == 'gorouter') {
      context.go(
        uri.path,
        extra: {'queryParams': uri.queryParameters},
      );
    }
  },
  child: const Text('Dynamic Link for Vehicle List'),
),
```

#### Complex Dynamic Link with Multiple Query Parameters

```dart
ElevatedButton(
  onPressed: () {
    final uri = Uri.parse(
      'gorouter://example.com/home/micro-app/shop?title=Shop&image=https://toggprodcdn.blob.core.windows.net/images/micro_app_icons_v2/Toggcare.jpg&link=/home/micro-app/shop',
    );

    context.go(
      uri.path,
      extra: {'queryParams': uri.queryParameters},
    );
  },
  child: const Text('Dynamic Link for Shop Micro App'),
),
```

> **Note**: Avoid using `extra` and `queryParams` together unless absolutely necessary. Otherwise, some additional logic might be required in the router configuration.

When implementing dynamic links, consider these best practices:

1. **Validate the URI scheme** before navigation to ensure it matches your app's scheme
2. **Extract path parameters** from the URI path for route-specific identifiers
3. **Handle query parameters** by passing them as part of the `extra` parameter
4. **Implement proper error handling** for malformed URIs or missing parameters

### Testing Deep Links

Deep links can be tested using:

#### Android

```bash
adb shell am start -a android.intent.action.VIEW -d "gorouter://example.com/vehicle/1"
```

#### iOS Simulator

```bash
xcrun simctl openurl booted "gorouter://example.com/vehicle/1"
```

#### In-App Testing

The app includes a test button that simulates deep link navigation:

```dart
ElevatedButton(
  onPressed: () {
    final uri = Uri.parse('gorouter://example.com/vehicle/1');
    if (uri.scheme == 'gorouter') {
      context.go(uri.path, extra: {'queryParams': uri.queryParameters});
    }
  },
  child: const Text('This is a dynamic link for testing purposes.'),
)
```

## Custom Codecs

### The Problem

When passing complex objects (like custom model classes) between routes using the `extra` parameter, Go Router needs to serialize and deserialize these objects. Without a custom codec, you'll see warnings like:

```
An extra with complex data type MicroAppModel is provided without a codec. 
Consider provide a codec to GoRouter to prevent extra being dropped during serialization.
```

### The Solution

We implemented a custom codec (`AppModelsCodec`) that handles serialization and deserialization of our model classes.

### Implementation

```dart
class AppModelsCodec extends Codec<Object?, Object?> {
  const AppModelsCodec();

  @override
  Converter<Object?, Object?> get encoder => const _AppModelsEncoder();

  @override
  Converter<Object?, Object?> get decoder => const _AppModelsDecoder();
}

class _AppModelsEncoder extends Converter<Object?, Object?> {
  @override
  Object? convert(Object? input) {
    if (input is MicroAppModel) {
      return {
        'type': AppModelCodecConstants.microAppModel,
        'data': {
          'title': input.title,
          'image': input.image,
          'link': input.link,
        },
      };
    }
    // Handle other types...
    return input;
  }
}

class _AppModelsDecoder extends Converter<Object?, Object?> {
  @override
  Object? convert(Object? input) {
    if (input is Map) {
      final type = input['type'];
      final data = input['data'];

      if (type == AppModelCodecConstants.microAppModel && data is Map) {
        return MicroAppModel(
          title: data['title'] as String?,
          image: data['image'] as String?,
          link: data['link'] as String?,
        );
      }
      // Handle other types...
    }
    return input;
  }
}
```

## State Management with Routes

The app demonstrates how to combine state management (using BlocProvider) with routing:

```dart
ShellRoute(
  builder: (_, __, Widget child) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: child,
    );
  },
  routes: [
    // Routes that share the CounterCubit state
  ],
)
```

## Error Handling

The router includes an error handler for routes that don't match any defined patterns:

```dart
errorBuilder: (context, state) => const NotFoundScreen(),
```

## Best Practices

1. **Use Route Constants**: Define all routes in a central location to avoid hardcoded strings
2. **Type Safety**: Use custom codecs to safely pass complex objects between routes
3. **Nested Navigation**: Use nested routes for related screens
4. **State Preservation**: Use ShellRoute to maintain state across related screens
5. **Deep Link Testing**: Test deep links using ADB or Simulator commands
6. **Error Handling**: Always provide an error handler for undefined routes
7. **Query Parameters**: Use query parameters for optional data in deep links
8. **Custom Transitions**: Define custom transitions for a better user experience
9. **Dynamic Links**: When implementing dynamic links, always validate the URI scheme before navigation and handle query parameters appropriately.
10. **Navigation Methods**: Use `context.go()` for replacing the current screen and `context.push()` for adding a new screen to the navigation stack.
11. **Parameter Handling**: Be cautious when using both `extra` and `queryParams` together as it may require additional logic in the router configuration.

## References

- [Go Router Documentation](https://pub.dev/documentation/go_router/latest/topics/Get%20started-topic.html)
- [Flutter Navigation with GoRouter: go vs push](https://codewithandrea.com/articles/flutter-navigation-gorouter-go-vs-push/)
- [Flutter Go Router: The Crucial Guide](https://medium.com/@vimehraa29/flutter-go-router-the-crucial-guide-41dc615045bb)
- [Flutter Go Router Guide](https://blog.codemagic.io/flutter-go-router-guide/)

---

This example project demonstrates advanced routing techniques using Go Router in Flutter. For more information, refer to the [Go Router documentation](https://pub.dev/packages/go_router).
