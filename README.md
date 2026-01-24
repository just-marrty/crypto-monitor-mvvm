# CryptoMonitor

A SwiftUI application for browsing and exploring cryptocurrencies with detailed information fetched from CoinPaprika API.

## Features

- Browse a list of cryptocurrencies with their basic information (name, price)
- Search functionality to filter cryptocurrencies by name
- Real-time search filtering with smooth animations
- Rank sorting toggle (ascending/descending) for cryptocurrency list
- Loading states and error handling with retry functionality
- Clean and modern UI with SwiftUI
- Detailed cryptocurrency view with comprehensive information
- Refresh functionality to reload cryptocurrency data
- Dark mode UI with custom color scheme

## Architecture

The project demonstrates modern SwiftUI patterns and MVVM architecture:

### Model

**Cryptocurrency** - Decodable model representing cryptocurrency data from API
- Includes id, name, symbol, rank, totalSupply, maxSupply
- Contains firstDataAt and lastUpdated timestamps
- Uses nested Quote struct with USD price information
- Maps JSON response with snake_case to camelCase conversion
- All properties use appropriate types (String, Int, Double, Decimal)
- firstDataAt is optional to handle missing values gracefully
- Conforms to Decodable and Hashable for JSON parsing and list operations

**Quote** - Nested struct representing price quotes
- Contains USD struct with price information
- Price stored as Decimal for precise financial calculations
- Conforms to Decodable and Hashable

### Constants
**Constants** - Centralized string constants for maintainability and localization

- Organizes all UI strings, error messages, and system image names in one place
- Categorized sections: Error messages, UI labels, search placeholders, navigation titles, currency codes, system images
- Improves code maintainability and makes future localization easier
- Eliminates hardcoded strings throughout the codebase
- Used across all views and view models for consistent text display

### Service

**FetchService** - Fetches and decodes cryptocurrency data from CoinPaprika API
- Uses URLSession with async/await for network requests
- Custom error handling with NetworkError enum (invalidURL, badResponse)
- Fetches data from CoinPaprika API tickers endpoint
- Uses JSONDecoder with convertFromSnakeCase strategy for automatic key conversion
- Returns array of Cryptocurrency objects

### ViewModel

**CryptocurrencyListViewModel** - Manages application state and business logic
- Uses @Observable macro for reactive UI updates
- @MainActor for thread-safe UI updates
- Dependency injection via initializer (receives FetchService)
- Search functionality with case-insensitive filtering
- Sorting functionality (rank ascending/descending toggle)
- Loading and error state management
- Maps Cryptocurrency models to CryptocurrencyViewModel for presentation

**CryptocurrencyViewModel** - Presentation model wrapping Cryptocurrency
- Conforms to Identifiable and Hashable for SwiftUI list support
- Provides computed properties for view display
- Handles optional cryptocurrency properties with default values ("N/A" for strings)
- Separates domain model from presentation concerns
- Extracts USD price as Decimal type

### Views

**CryptoccurencyMainView** - Main container with searchable cryptocurrency list and sorting
- Real-time search filtering with searchable modifier
- NavigationStack for navigation
- Loading, error, and content states with appropriate UI
- Refresh button in top-right toolbar for reloading data
- Sort button in top-left toolbar for rank sorting (ascending/descending)
- Displays cryptocurrency name and USD price in list view
- Custom tint color using .header color asset
- Fixed dark mode color scheme
- Loading, error, and content states with appropriate UI using Constants for all text
- All UI strings (loading, error messages, button labels) sourced from Constants

**CryptocurrencyDetailView** - Detailed view for individual cryptocurrency information
- Scrollable detail view showing all cryptocurrency properties
- Displays name, symbol, price, id, rank, total supply, max supply
- Shows formatted first data at and last updated timestamps
- Clean layout with dividers separating information sections
- Navigation title with cryptocurrency name
- Custom back button with dismiss functionality
- Consistent header styling with main view
- All labels and section headers use Constants for consistent text management

### Extensions

**DateTimeFormatter+Extensions** - Custom String extension for date formatting
- Provides `formattedDateTime()` method for formatting ISO8601 date strings
- Handles both standard and fractional seconds ISO8601 formats
- Converts dates to abbreviated date and shortened time format
- Falls back to original string if parsing fails

**CryptocurrencyViewModel+Extensions** - Sample data for SwiftUI previews
- Provides static sample cryptocurrency data for development and testing
- Used in SwiftUI previews for CryptocurrencyDetailView

## Dependency Injection

The project uses constructor-based dependency injection:

- CryptocurrencyListViewModel receives FetchService as a dependency through its initializer
- This allows for easy testing and swapping implementations
- FetchService is injected in CryptoccurencyMainView when creating the ViewModel
- Promotes loose coupling and testability

## State Management

- @State for local view state (search text, ViewModel instance, sorting toggle)
- @Observable macro for reactive ViewModel updates
- Reactive filtering with searchable modifier and computed properties
- State-based sorting with toggle mechanism

## Technologies

- **SwiftUI** - Modern declarative UI framework
- **Async/Await** - Asynchronous data fetching from API using modern Swift concurrency
- **REST API** - Integration with CoinPaprika API
- **NavigationStack** - Programmatic navigation
- **JSON Decoding** - Custom Decodable implementation with automatic snake_case conversion
- **Searchable** - Built-in search functionality with real-time filtering
- **Observable** - Using @Observable macro for reactive UI updates
- **Dependency Injection** - Constructor-based DI for testability and flexibility
- **Animation** - Smooth transitions with default SwiftUI animations
- **URLSession** - Modern async/await API for network requests
- **Swift Extensions** - Custom extensions for date formatting and sample data
- **Decimal** - Precise decimal type for financial calculations
- **Constants Pattern** - Centralized string management for maintainability

## Requirements

- iOS 18.0+
- Xcode 18.0+
- Swift 6+
- Internet connection for API access

## Credits

This application uses the [CoinPaprika API](https://docs.coinpaprika.com/) provided by CoinPaprika. The API provides access to real-time cryptocurrency market data, including prices, volume, market cap, and historical data.

The CoinPaprika API enables access to comprehensive cryptocurrency information, including ticker data, market statistics, and detailed coin information for thousands of cryptocurrencies.

For more information about the API and CoinPaprika's developer resources, visit [docs.coinpaprika.com](https://docs.coinpaprika.com/).
