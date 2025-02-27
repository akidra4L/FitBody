# FitBody - Comprehensive Rehabilitation Application

## Overview
FitBody is a mobile application designed to provide users with personalized rehabilitation programs, meal planning, and other essential features to support their recovery journey. The app focuses on delivering a seamless and engaging user experience by utilizing modern iOS technologies and frameworks.

## Technologies Used
### Frontend Technology – Swift (iOS)
FitBody is built as a native iOS application using Swift, ensuring high performance, smooth interactions, and seamless integration with Apple’s ecosystem.

### Libraries & Frameworks
- **SnapKit** – Used for declarative and efficient Auto Layout constraints.
- **Resolver** – Dependency injection framework for better modularity and maintainability.
- **Alamofire** – Simplifies networking and API requests.
- **Kingfisher** – Efficiently handles and caches image loading.
- **FloatingPanel** – Provides customizable and interactive panel UI components.

## Design Patterns
FitBody follows industry-standard design patterns to enhance scalability, maintainability, and code organization:
- **Coordinator + Router** – Used for navigation to decouple view controllers and manage flow efficiently.
- **Observer** – Enables event-driven programming by allowing objects to subscribe to state changes.
- **Delegate** – Facilitates communication between components without tight coupling.
- **Factory** – Simplifies object creation by centralizing instantiation logic.
- **Dependency Injection** – Enhances modularity and testability by injecting dependencies rather than hardcoding them.
- **MVC (Model-View-Controller)** – Provides a structured architecture to separate concerns between data, UI, and logic.

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/fitbody.git
   ```
2. Navigate to the project directory:
   ```sh
   cd fitbody
   ```
3. Install dependencies using CocoaPods or Swift Package Manager (SPM).
4. Open `FitBody.xcworkspace` in Xcode.
5. Build and run the project on a simulator or physical device.
