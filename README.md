# Order Management App

## Overview
A Flutter-based order management application that helps businesses track and manage their orders efficiently. The app provides a seamless experience for managing orders, from login to order tracking and status updates.

## Features

### Current Features

#### 1. Authentication
- Secure login system with email and password
- Input validation with error handling
- Persistent login using SharedPreferences
- Form validation with user-friendly error messages

#### 2. Order Management
- Comprehensive order listing with client details
- Real-time order status tracking
- Detailed order information view
- Status update functionality (Delivered/Cancelled)
- Mock API integration using Dio
- Local data persistence
- Order filtering and search functionality
- Bulk order status updates
- Order history tracking
- Export orders to PDF/Excel
- Order priority levels

#### 3. User Interface
- Responsive design for various screen sizes
- Adaptive UI components
- Clean and intuitive navigation
- Visual feedback for user actions


#### 4. Customer Management
- Customer profiles and history
- Contact information management
- Order preferences
- Customer feedback system


#### 5. Offline Support
- Offline order creation
- Data synchronization
- Conflict resolution
- Local caching improvements

## Technical Architecture

### State Management
- Bloc pattern with Cubit implementation
- Separate cubits for authentication and orders
- Clean state management architecture

### API Integration
- Dio for HTTP requests
- Mock API for development
- Error handling and retry mechanisms
- API response caching

### Local Storage
- SharedPreferences for user data
- Secure credential storage
- Order data persistence
- Cache management

### Clean Architecture
- Domain Layer
  - Entities
  - Repository interfaces
  - Use cases
- Data Layer
  - Data sources
  - Repository implementations
  - Models
- Presentation Layer
  - UI components
  - Cubits
  - State management

## Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio / VS Code
- Git

### Installation
1. Clone the repository
```bash
git clone https://github.com/OmarRamadan2000/order-management.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License
This project is licensed under the MIT License - see the LICENSE file for details

## Screen Shots
  <picture>
  <img alt="Shows an illustrated sun in light mode and a moon with stars in dark mode." src="https://github.com/user-attachments/assets/5298e47c-e674-4c0f-809c-6e4367300a90" width="280">
</picture>
<picture>
  <img alt="Shows an illustrated sun in light mode and a moon with stars in dark mode." src="https://github.com/user-attachments/assets/5099b605-e5f0-44fa-a8a0-9e8d80b09f4b" width="280">
</picture>
<picture>
  <img alt="Shows an illustrated sun in light mode and a moon with stars in dark mode." src="https://github.com/user-attachments/assets/5df93034-d195-4d3a-a7ad-351030090900" width="280">
</picture>
<picture>
  <img alt="Shows an illustrated sun in light mode and a moon with stars in dark mode." src="https://github.com/user-attachments/assets/cf7aa88c-a325-48d6-ba4e-b3e9c6789909" width="280">
</picture>
<picture>
  <img alt="Shows an illustrated sun in light mode and a moon with stars in dark mode." src="https://github.com/user-attachments/assets/bc1b01ba-1693-4c1f-bfa6-440674e1064b" width="280">
</picture>

