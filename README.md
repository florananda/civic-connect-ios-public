# iOS Civic App Connect

[![CircleCI](https://circleci.com/gh/civicteam/civic-connect-ios-public.svg?style=svg&circle-token=c354636aa17d0a8e4d67046086a0071f2bda1172)](https://circleci.com/gh/civicteam/civic-connect-ios-public)

[![Version](https://img.shields.io/cocoapods/v/CivicConnect.svg?style=flat)](https://cocoapods.org/pods/CivicConnect)		
[![License](https://img.shields.io/cocoapods/l/CivicConnect.svg?style=flat)](https://cocoapods.org/pods/CivicConnect)		
[![Platform](https://img.shields.io/cocoapods/p/CivicConnect.svg?style=flat)](https://cocoapods.org/pods/CivicConnect)

Civic App Connect is a library that allows a third party to connect with the Civic Secure Identity iOS app.

## Introduction

This library allows you to connect to the Civic Secure Identity iOS application using the integration portal API. In order to use this library you will need to register yourself on the [Integration Portal](https://integrate.civic.com/login). Once registered you'll be able to provide the necessary information to the library to be able to connect your own iOS application to the Civic Secure Identity iOS application. The library also provides a Civic styled button that can be customized for your needs, or you could rather initiate the flow in any way you see fit for your application.

## Requirements

- iOS 8.0+
- Xcode 10+
- Swift 4+

## Installation

### Cocoapods

Civic App Connect is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CivicConnect'
```

### Carthage

To integrate Civic App Connect into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github "civicteam/civic-connect-ios-public"
```

Run `carthage update` to build the framework and drag the built CivicConnect.framework into your Xcode project.

## Getting Started

### Sample App

To run the example project, clone the repo, and run `pod install`. Open up `CivicConnect.xcworkspace` with Xcode, in the `Info.plist` you will need to provide your  `CivicApplicationIdentifier` and `CivicSecret` and run the `CivicConnect-Example` scheme. The sample project contains documented code to illustrate how to use the library.

### Usage

This library is supported for both Objective-C and Swift and therefore each code snippet will contain its corresponding Objective-C and Swift section.

#### Initialization

Before being able to use the library, you will need to initialize it with the correct fields These values can be found on the [Integration Portal](https://integrate.civic.com/login) when you have registered your application. Initializing the library requires the following fields:

| Name | Required | Description |
| ---- | -------- | ----------- |
| Application Identifier | Yes | Identifier used to identify the third party. |
| Mobile Application Identifier | Yes | Identifier used by the mobile app. |
| Secret | No | Secret provided to the partner via the Integration Portal. Optional if you just require the JWT token. |
| Redirect Scheme | No | Scheme used to open the third party app. (This requires the third party to add a `URL Types` scheme in the `Info.plist` file. |

##### Swift
```swift
let connect = Connect(applicationIdentifier: <INSERT APPLICATION IDENTIFIER HERE>, 
                      mobileApplicationIdentifier: <INSERT MOBILE APPLICATION IDENTIFIER HERE>, 
                      secret: <INSERT SECRET HERE>,
                      redirectScheme: <INSERT REDIRECT SCHEME HERE>)
```

##### Objective-C
```objc
CCConnect *connect = [[CCConnect alloc] initWithApplicationIdentifier:<INSERT APPLICATION IDENTIFIER HERE>
                                          mobileApplicationIdentifier:<INSERT MOBILE APPLICATION IDENTIFIER HERE>
                                                               secret:<INSERT SECRET HERE>
                                                       redirectScheme:<INSERT REDIRECT SCHEME HERE>];
```

A convenient way to initialize the library is to load the fields via the `Info.plist`:

##### Swift
```swift
let connect = try Connect.initialize(withBundle: Bundle.main, secret: <INSERT SECRET HERE>)
```

##### Objective-C
```objc
NSError *error;
NSBundle *bundle = [NSBundle mainBundle];
CCConnect *connect = [CCConnect initializeWithBundle:bundle secret:<INSERT SECRET HERE> error:&error];
```

The library will look through the `Info.plist` to find the following fields:

| Name | Type | Required |
| ---- | ---- | -------- |
| CFBundleIdentifier (Bundle Identifier - By default this should already exist) | `String` | Yes |
| CivicApplicationIdentifier | `String` | Yes |
| CivicSecret *deprecated | `String` | Yes |
| CivicRedirectScheme | `String` | No |

Please note: `CivicRedirectScheme` requires you to add a `URL Type` to the `Info.plist` with an identifier and at least one scheme. The scheme needs to be equal to the `CivicRedirectScheme` field.

Loading the fields from the `Info.plist` can throw the following errors if it cannot find the particular field:

| Error | Status Code | Message |
| ----- | ----------- | ------- |
| cannotFindApplicationId | 901 | Cannot find application ID. Make sure you have 'CivicApplicationIdentifier' somewhere in your Info.plist. |
| cannotFindBundleId | 902 | Cannot find bundle ID. Make sure you have 'CFBundleIdentifier' somewhere in your Info.plist. |
| cannotFindSecret | 903 | Cannot find secret. Make sure you have 'CivicSecret' somewhere in your Info.plist. |
| redirectSchemeMismatch | 904 | Cannot find a matching URL scheme for 'CivicRedirectScheme'. Please ensure 'CivicRedirectScheme' matches one of the 'CFBundleURLTypes' 'CFBundleURLSchemes'. |

#### Connecting

Once you have an initialized instance of the `Connect` class, you'll be able to start the connection between your application and Civic. To initiate a flow, you can use the `Connect.connect(withType:delegate:)` method:

##### Swift
```swift
connect.connect(withType: .basic, delegate: self)
```

##### Objective-C
```objc
[connect connectWithType:CCScopeRequestTypeBasic delegate:self];
```

To determine what type to use, you'll need to know what information you require. The following table shows what information the types provide:

| Scope Request Type | Description |
| ------------------ | ----------- |
| `ScopeRequestType.basicSignup` | Includes basic information such as `email` and `phone number`. |
| `ScopeRequestType.anonymousLogin` | Only includes the user ID. |
| `ScopeRequestType.proofOfResidence` | Includes the basic information, `identity document` and `residential documents` of the user. |
| `ScopeRequestType.proofOfIdentity` | Includes basic information such as `email` and `phone number` as well as information on an `identity document`. |
| `ScopeRequestType.proofOfAge` | Includes the age of the user. |

The delegate is the way the library communicates back to the partner via the following methods:

| Method | Description |
| ------ | ----------- |
| `func connectDidFailWithError(_ error: ConnectError)` | This method is fired off when an error occurs inside the `ConnectSession` due to service errors, session errors, etc. |
| `func connectDidFinishWithUserId(_ userId: String, andUserInfo userInfo: [UserInfo])` | This method is fired off when the `ConnectSession` has retrieved the user data from the servers. |
| `func connectDidChangeStatus(_ newStatus: ConnectStatus)` | This method is fired off when the state of the `ConnectSession` changes. It provides an easy way to know what is happening in the background. |
| `func connectShouldFetchUserData(withToken token: String) -> Bool` | This method is fired off when the `ConnectSession` receives the JWT token from the server. At this point we ask the delegate whether we should continue to fetch the user data using the JWT token. Returning true will allow the `ConnectSession` to retrieve the user data, while false ends the session. For Swift this method is implmemented by default and returns true through the use of extensions. |

After connecting with Civic, a `ConnectSession` is created to handle the connection between the partner app and Civic. Once the `ConnectSession` is created, you have two ways of handling the session. Either handling the `URL` that was used to open the partner app via the `Connect.handle(url:)` method or by calling the `Connect.startPollingForUserData()` method. These methods will be described below.

#### Handling `URL`

Handling a `URL` will allow the library to determine whether the Civic application opened up/redirected to the partner application and start retrieving the user data. In order for this feature to work, you must setup a `URL Type` with a `URL Scheme` in the `Info.plist`. (See the example project to see how this is done) 

A convenient place to handle the `URL` is in the `AppDelegate` on the `func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool` method as follows:

##### Swift
```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    return connect.handle(url: url)
}
```

##### Objective-C
```objc
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    return [connect handleUrl:url];
}
```

Internally this will check if the `URL` was initiated from the Civic application. You can manually check the `URL` via `Connect.canHandle(url:)`. If the session can handle the `URL` then it will call `Connect.startPollingForUserData()` internally.

#### Start Polling For User Data

If you do not choose to handle the `URL` method or you would prefer not to use the redirect mechanism, you can rather choose to start polling for the user data manually. When calling this method, it will initiate a timer that contantly checks when the Civic application has finished the flow.

##### Swift
```swift
connect.startPollingForUserData()
```

##### Objective-C
```swift
[connect startPollingForUserData];
```

#### Stop Polling For User Data

At anytime the session is started, you can call `Connect.stopPollingForUserData()` to invalidate the timer.

##### Swift
```swift
connect.stopPollingForUserData()
```

##### Objective-C
```objc
[connect stopPollingForUserData];
```

#### Reset

You can reset the status of the of `Connect` instance by calling the `Connect.reset()` function.

##### Swift
```swift
connect.reset()
```

##### Objective-C
```objc
[connect reset];
```

#### Connect Button

If you would like a Civic styled button, you can use the `ConnectButton` class which is just a subclass of `UIButton`. In order to create one, you will need to provide a `Connect` instance, a `ConnectDelegate` and optionally the `ScopeRequestType`:

##### Swift
```swift
let connectButton = ConnectButton(<INSERT CONNECT HERE>, 
                                  type: <INSERT SCOPE REQUEST TYPE HERE (DEFAULTS TO .basic)>, 
                                  delegate: <INSERT CONNECT DELEGATE HERE>)
```

##### Objective-C
```objc
CCConnectButton *connectButton = [[CCConnectButton alloc] initWithConnect:<INSERT CONNECT HERE>
                                                                     type:<INSERT SCOPE REQUEST TYPE HERE>
                                                                 delegate:<INSERT CONNECT DELEGATE HERE>];
```

Once created, you can customize the title and image of the button:

##### Swift
```swift
connectButton.setConnectTitle(<INSERT TITLE HERE>, image: <INSERT IMAGE HERE>)
connectButton.setConnectTitle(<INSERT TITLE HERE>)
```

##### Objective-C
```objc
[connectButton setConnectTitle:<INSERT TITLE HERE> image:<INSERT IMAGE HERE>];
[connectButton setConnectTitle:<INSERT TITLE HERE>];
```

The scope request type can also be changed at anytime:

##### Swift
```swift
connectButton.setType(<INSERT SCOPE REQUEST TYPE HERE>)
```

##### Objective-C
```objc
[connectButton setType:<INSERT SCOPE REQUEST TYPE HERE>];
```

Anytime the `ConnectButton` is tapped, it will start connecting with the Civic application and display a loading indicator on the button. The loading indicator will disappear once the session has received either an error or success response.

#### Errors

The following table shows the potential errors that can occur via the library:

| Error | Status Code | Message |
| ----- | ----------- | ------- |
| cannotFindApplicationId | 901 | Cannot find application ID. Make sure you have 'CivicApplicationIdentifier' somewhere in your Info.plist. |
| cannotFindBundleId | 902 | Cannot find bundle ID. Make sure you have 'CFBundleIdentifier' somewhere in your Info.plist. |
| cannotFindSecret | 903 | Cannot find secret. Make sure you have 'CivicSecret' somewhere in your Info.plist. |
| redirectSchemeMismatch | 904 | Cannot find a matching URL scheme for 'CivicRedirectScheme'. Please ensure 'CivicRedirectScheme' matches one of the 'CFBundleURLTypes' 'CFBundleURLSchemes'. |
| cannotParseResponse | 911 | Cannot parse response from server. |
| cannotParseResponseData | 912 | Cannot parse response data from server. |
| invalidUrl | 913 | Invalid url. |
| invalidRequest | 914 | Invalid request. |
| invalidSession | 921 | Invalid session. |
| mobileUpgrade | 922 | Mobile upgrade required. |
| userCancelled | 923 | User cancelled scope request. |
| verifyError | 924 | Error occurred during verification. |
| userDataNotAvailable | 202 | User data is still not available. Try poll again later. |
| scopeRequestTimeOut | 925 | Scope request timed out. |
| verificationFailed | 931 | Failed to verify the response. |
| decryptionFailed | 932 | Failed to decrypt response data. |
| secretNotFound | 933 | Cannot find secret. Please ensure you provide the library with a valid secret. |
| decodingFailed | 997 | Failed to decode the json to an object. |
| authenticationUnknownError | 998 | Unknown authentication error. |
| unknown | 999 | Unknown error. |

The following table shows the potential errors that can occur via the server api:

| Error | Status Code | Message |
| ----- | ----------- | ------- |
| badRequest | 400 | Check the response ‘message’ field for details. |
| unauthorized | 401 | Authentication failed. |
| methodNotAllowed | 405 | You tried to access an invalid method. |
| insufficientFunds | 409 | Unauthorized: Insufficient funds. |
| tooManyRequests | 429 | Your request was throttled by our gateway. |
| internalServer | 500 | We had a problem with our server. Try again later. |
| timeOut | 504 | Endpoint Request Timed-out Exception. |

## FAQ

### What do we use for the redirect scheme?

You can use any unique scheme that is valid for your app.

### How do we get the `UIImage` from the `UserInfo`?

Some `UserInfo` objects have a value encoded in base 64, an example would be for the `documents.genericId.image` `UserInfo` object, we would decode to an `UIImage` with the following code snippet:

```swift
func decodeBase64ToImage(_ userInfo: UserInfo) -> UIImage? {
    guard let data = Data(base64Encoded: userInfo.value, options: .ignoreUnknownCharacters) else {
    return nil
    }

    return UIImage(data: data)
}
```

### What does it mean when I get `Unauthorized: no platforms found for provided app_id`?

It means you have supplied the incorrect Application Identifier. Please ensure you have the correct App ID from the [Integration Portal](https://integrate.civic.com/login) under the configured application.

### What does it mean when I get `Unauthorized: mobileId not found in partner platform list`?

It means you have not supplied the correct Bundle ID or have not configured your mobile application on the [Integration Portal](https://integrate.civic.com/login).

### How do I just retrieve the JWT token so that I can handle the user data on my side?

In order to retrieve the JWT token only, in your implementation for the `ConnectDelegate`, implement the `func connectShouldFetchUserData(withToken token: String) -> Bool` function and return false. The `token` provided in that function is the JWT token and can be handled by whichever way needed.

## Author

See also the list of [contributors](https://github.com/civicteam/ios-civic-connect/contributors) who participated in this project.

## Contribution

Find contributing guidelines in the [CONTRIBUTING](CONTRIBUTING.md) file.

## License

Civic App Connect is available under the MIT license. See the [LICENSE](LICENSE.md) file for more info.
