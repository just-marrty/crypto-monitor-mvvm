# CryptoMonitor

A SwiftUI application for browsing and exploring cryptocurrencies with detailed information fetched from CoinPaprika API.

## Features

- Browse a list of cryptocurrencies with their basic information (name, price)
- Search functionality to filter cryptocurrencies by name
- Real-time search filtering with smooth animations
- Light and dark mode toggle with persistent preference
- Rank sorting toggle (ascending/descending) for cryptocurrency list
- Loading states and error handling with retry functionality
- Clean and modern UI with SwiftUI
- Detailed cryptocurrency view with comprehensive information
- Refresh functionality to reload cryptocurrency data

## Architecture

The project demonstrates modern SwiftUI patterns and MVVM architecture:

### Model

**Cryptocurrency** - Decodable model representing cryptocurrency data from API
- Includes id, name, symbol, rank, totalSupply, maxSupply
- Contains firstDateAt and lastUpdated timestamps
- Uses nested Quote struct for price information
- Maps JSON response with snake_case to camelCase conversion
- All properties use appropriate types (String, Int, Double)
- firstDateAt is optional to handle missing values gracefully
- Conforms to Decodable and Hashable for JSON parsing and list operations

**Quote** - Nested struct representing price quotes
- Contains price information for different currencies
- Stored in dictionary keyed by currency code (e.g., "USD")
- Conforms to Decodable and Hashable

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
- Handles optional cryptocurrency properties with default values ("N/A" for strings, 0.0 for price)
- Separates domain model from presentation concerns
- Extracts USD price from quotes dictionary

### Views

**ContentView** - Main container with searchable cryptocurrency list, dark mode toggle, and sorting
- Uses @AppStorage for persistent dark mode preference
- Real-time search filtering with searchable modifier
- NavigationStack for navigation
- Loading, error, and content states with appropriate UI
- Toolbar buttons for theme switching and rank sorting
- Displays cryptocurrency name and USD price in list view
- Refresh button in bottom toolbar
- Custom header color with toolbarBackground modifier

**CryptocurrencyDetailView** - Detailed view for individual cryptocurrency information
- Scrollable detail view showing all cryptocurrency properties
- Displays name, symbol, price, id, rank, total supply
- Shows first date and last updated timestamps
- Clean layout with dividers separating information sections
- Navigation title with cryptocurrency name
- Custom back button with dismiss functionality
- Consistent header styling with main view

## Dependency Injection

The project uses constructor-based dependency injection:

- CryptocurrencyListViewModel receives FetchService as a dependency through its initializer
- This allows for easy testing and swapping implementations
- FetchService is injected in ContentView when creating the ViewModel
- Promotes loose coupling and testability

## State Management

- @State for local view state (search text, ViewModel instance, sorting toggle)
- @AppStorage for persistent dark mode preference
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
- **AppStorage** - Persistent user preferences for theme
- **Observable** - Using @Observable macro for reactive UI updates
- **Dependency Injection** - Constructor-based DI for testability and flexibility
- **Animation** - Smooth transitions with default SwiftUI animations
- **URLSession** - Modern async/await API for network requests

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- Internet connection for API access

## Credits

This application uses the [CoinPaprika API](https://docs.coinpaprika.com/) provided by CoinPaprika. The API provides access to real-time cryptocurrency market data, including prices, volume, market cap, and historical data.

The CoinPaprika API enables access to comprehensive cryptocurrency information, including ticker data, market statistics, and detailed coin information for thousands of cryptocurrencies.

For more information about the API and CoinPaprika's developer resources, visit [docs.coinpaprika.com](https://docs.coinpaprika.com/).
