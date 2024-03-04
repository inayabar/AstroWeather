# AstroWeather - iOS Coding Challenge

### Author: Iñaki Yabar Bilbao (inayabarb@gmail.com)

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Instructions](#instructions)
  - [Running the Project](#running-the-project)
  - [Running the Test Suite](#running-the-test-suite)


## Overview

This repo contains code related to AstroPay iOS Senior Developer Code Challenge, creating a simple Weather client that shows the current weather
data using Open Weather Map.

## Architecture 

### UI Framework
As requested, the app is built using **SwiftUI**. Some takeaways of my experience using it:
- SwiftUI's declarative syntax allows for quick prototyping, making development smoother. 
- Previews are incredibly powerful, and I used the Preview Content folder to create mocks, as Xcode treats this asset catalog differently from the app's main asset catalog. Xcode will not include any assets included here in release builds.
- AstroPay supports iOS 14 or later, which allows to use SwiftUI 2.0. I found various APIs I wanted to use in the project were unavailable in this version, such as using UIVisualEffectView .ultraThinMaterial, or using the `.task` modifier instead of `.onAppear`. 

### Design patterns
In terms of architectural design pattern, I decided to use **MVVM**, to promote a clear separation of concerns, centralizing business logic in the view model. MVVM is well-suited for use with SwiftUI because it aligns well with SwiftUI's data-driven and declarative programming model. ViewModels can publish ObservableObjects that SwiftUI views can observe and react to, enabling a reactive and responsive UI, while keeping the Views free of business logic. I found that this pattern also really helped with testing.

### Concurrency 
To handle asyncronous tasks this project utilizes async-await (Swift concurrency, presented in Swift 5.5), because it reduces the amount of boilerplate code required to manage asynchronous tasks. Instead of dealing with callbacks and nested closures, async-await code looks like a sequence of synchronous statements. 

### Dependency Injection
The whole project utilizes constructor injection, where dependencies are injected through the class constructor. Whenever a class has a dependency, a Protocol is added to abstract this class from the actual implementation (Check LocationManagerProtocol protocol, which abstracts the CoreLocation's framework CLLocationManager). This allows for loosely coupled code and largely improves testability. 

### Network Layer
The project implements a basic network layer, which allows for remote data fetching. NetworkService is the main component, which recieves a NetworkRequest to fetch, comprised of an URLRequest (the url we want to fetch) and a generic type we want to parse the response to. This network layer utilizes URLSession internally, and handles all errors (url creation, network issues, decoding errors, etc). This project only uses HTTP GET requests, but NetworkService can be easily extended to support other request types.

### User Defaults
The app utilizes user defaults to store and remember the last location the user viewed. This was achieved using the @AppStorage annotation which greatly simplifies accessing UserDefaults stored data.

### Localization
AstroWeather supports localization by using XCode String Catalogs, and replacing hardcoded string values with `LocalizedStringKey(someText)`. Information from OpenWeatherApi is also fetched using the correct locale. Supported languages are English and Spanish(default)

### UI Design
The app is heavily inspired by Apple's Weather app. The main structure is a TabView with horizontal scroll, where each page represents a location's weather. A specific background image is selected, depending on the weather conditions and if it's daytime or nighttime. I didn't have access to high-quality images so I decided to generate them using AI. A simple win for this project would be to optimize this images, or even better, to create dynamic animations instead of using static images.

## Instructions

### Running the Project

Requirements:
- iOS 14+
- Working Xcode 15 installation (This project uses #Preview macro)

Steps:
1. **Clone the Repository:** ```git clone https://github.com/inayabar/AstroWeather```
2. **Open the Project:**
- Open Xcode and select 'Open Existing Project'
- Navigate to the project directory.
- Open the `.xcodeproj` file.
3. **Select a Simulator:**
- Choose a simulator or connect a physical device with iOS 14 or later.

4. **Build and Run:**
- Press the play button (▶️) in Xcode to build and run the app on the selected device.

### Running the Test Suite

1. **Select a Testing Scheme:**
- Make sure the testing scheme is set to the app's target and not a specific file or class.

2. **Run Tests:**
- Navigate to the Product menu.
- Select "Test" or use the shortcut (⌘U) to run the test suite.


## Screenshots
<img width="263" alt="Screenshot 2024-03-03 at 13 48 35" src="https://github.com/inayabar/AstroWeather/assets/21232834/91471594-e75e-4125-881d-e4947c8d1d22">
<img width="267" alt="Screenshot 2024-03-03 at 13 47 46" src="https://github.com/inayabar/AstroWeather/assets/21232834/8a6413cf-47bb-41bd-9676-5fb9978a1407">
<img width="273" alt="Screenshot 2024-03-03 at 13 47 37" src="https://github.com/inayabar/AstroWeather/assets/21232834/17279066-fab8-4923-bf28-7de2f930c703">
