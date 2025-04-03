# order_management

Features Implementation
1. Login Screen:
   * Email and password fields with input validation
   * Local storage of login information using SharedPreferences
   * Form validation with error messages
2. Orders Screen:
   * Displays a list of orders with client name, address, and status
   * Order data is fetched from a mock API (Dio) or local JSON file
   * "Details" button to view full order information
3. Order Details Screen:
   * View complete order information
   * Buttons to update status to "Delivered" or "Cancelled"
   * Real-time status updates with visual feedback
Technical Requirements Implementation
1. State Management:
   * Used Bloc pattern with Cubit for state management
   * Separate cubits for auth and orders features
2. API Requests:
   * Implemented Dio for API requests
   * Mocked API for development purposes
3. Local Storage:
   * Used SharedPreferences for storing login info and order data
4. Responsive Design:
   * Implemented responsive layouts with adaptive UI components
   * Proper padding and spacing for different screen sizes
5. Clean Architecture:
   * Organized code with modular file structure
   * Separation of concerns:
      * Domain: Entities, repositories interfaces, use cases
      * Data: Data sources, repository implementations, models
      * Presentation: UI, cubits, state management
## Screen Shots
  <picture>
  <img alt="Shows an illustrated sun in light mode and a moon with stars in dark mode." src="https://github.com/user-attachments/assets/5298e47c-e674-4c0f-809c-6e4367300a90" width="280">
</picture>
<picture>
  <img alt="Shows an illustrated sun in light mode and a moon with stars in dark mode." src="https://github.com/user-attachments/assets/18cdbbd8-946b-4dbe-95c3-a63bf409cded" width="280">
</picture>
<picture>
  <img alt="Shows an illustrated sun in light mode and a moon with stars in dark mode." src="https://github.com/user-attachments/assets/13350606-ee85-48be-9a8d-dbb9868ae472" width="280">
</picture>
