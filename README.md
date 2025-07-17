# Vinay BookMart Gutendex Books App

A Flutter application designed to explore and browse books from the Gutendex API, featuring a clean architecture, GetX for state management, and a responsive UI that adapts to different screen sizes.

## Features

*   **Category-based Browsing:** Users can select a book category/genre from a dedicated selection screen.
*   **Infinite Scrolling Book List:** Displays books for the selected category in a scrollable list, fetching more as the user scrolls.
*   **Search Functionality:** Allows users to search for books by title or author, while maintaining the active category filter.
*   **Book Details & Viewing:** Tapping on a book attempts to open its content in a web browser, prioritizing HTML, PDF, and TXT formats.
*   **Incompatible File Handling:** Automatically skips `.zip` files and displays an alert if no viewable version is available.
*   **Responsive UI:** Adapts layout for both mobile (list/grid view) and web (grid view) based on screen width.
*   **Custom Theming:** Implements a custom color scheme and typography using the Montserrat font.
*   **SVG Icons:** Uses SVG assets for category icons with a fallback mechanism.

## Architecture

This project follows a **Clean Architecture** approach to ensure separation of concerns, testability, and maintainability. It's divided into three main layers:

*   **Presentation Layer:**
    *   `lib/presentation/pages`: Contains the UI widgets and views (e.g., `CategorySelectionPage`, `BookListPage`).
    *   `lib/presentation/controllers`: Houses GetX controllers responsible for UI logic and state management.
    *   `lib/presentation/bindings`: GetX bindings for dependency injection.
    *   `lib/presentation/widgets`: Reusable UI components (e.g., `CategoryCard`, `BookItemCard`).

*   **Domain Layer:**
    *   `lib/domain/models`: Defines core data models (e.g., `Book`, `ApiResponse`).
    *   `lib/domain/repositories`: Abstract interfaces for data operations (e.g., `BookRepository`).
    *   `lib/domain/usecases`: Encapsulates application-specific business logic (e.g., `GetBooksUseCase`).

*   **Data Layer:**
    *   `lib/data/api`: Contains the API client for interacting with the Gutendex API (e.g., `GutendexApiClient`).
    *   `lib/data/repositories`: Concrete implementations of domain-layer repository interfaces (e.g., `BookRepositoryImpl`).

## State Management

**GetX** is used for efficient and reactive state management, dependency injection, and navigation.

## API Integration

The application interacts with the Gutendex API available at `http://skunkworks.ignitesol.com:8000/`. It queries the `/books` endpoint and handles various query parameters for filtering and pagination.

## Styling & Design

### Colors

*   **Primary:** `#5E56E7`
*   **Background Light:** `#F8F7FF`
*   **Grey Light:** `#F0F0F6`
*   **Grey Medium:** `#A0A0A0`
*   **Grey Dark:** `#333333`

Colors are defined in `lib/utils/app_colors.dart` and applied through a centralized `ThemeData` in `lib/utils/app_theme.dart`.

### Typography

Uses the **Montserrat** font family with the following specifications:

*   **Heading 1:** 48 px, Semi Bold
*   **Heading 2:** 30 px, Semi Bold
*   **Genre Card Text:** 20 px, Regular
*   **Body Text:** 16 px, Regular
*   **Search Box Text:** 16 px, Regular
*   **Book Name:** 12 px, Regular
*   **Book Author:** 12 px, Regular

Font styles are defined in `lib/utils/app_theme.dart` and applied using `Theme.of(context).textTheme`.

### Responsive Design

The application adapts its layout based on screen width:

*   **Category Selection Page:** Displays categories in a 2-column grid on larger screens and a vertical list on smaller screens.
*   **Book Listing Page:** Displays books in a dynamic grid layout, adjusting the number of columns based on screen width.

### Custom Components

*   **Category Card:** Features a white background, purple text/icons, a right arrow, specific dimensions (Height: 50px, Radius: 4px), and a custom box-shadow.
*   **Book Item Card:** Displays book covers, titles (uppercase), and authors with a specific size (Width: 114px, Height: 162px), radius (8px), and box-shadow.

### Icons & Assets

*   Utilizes `flutter_svg` for scalable vector graphics.
*   Category cards use specific SVG icons (e.g., `fiction.svg`) from `assets/images/`, with `default_book.svg` as a fallback.
*   A subtle `Pattern.svg` image is used as a background on the Category Selection Page.

## Getting Started

To run this project locally, ensure you have Flutter installed.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/vinayjswl170/BookMartDemoFlutter.git # Replace with your actual repo URL if different
    cd gutendex_books_app
    ```
2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Ensure assets are in place:**
    *   Place your font files (e.g., `Montserrat-Regular.ttf`, `Montserrat-Bold.ttf`) in `assets/fonts/`.
    *   Place your SVG category icons (e.g., `fiction.svg`, `drama.svg`, etc., and `default_book.svg`, `Pattern.svg`) in `assets/images/`.
4.  **Run the application:**
    ```bash
    flutter run
    ```

## Technologies Used

*   Flutter
*   Dart
*   GetX (State Management, Dependency Injection, Routing)
*   Dio (HTTP Client)
*   url_launcher (Launching URLs)
*   flutter_svg (SVG Rendering)
