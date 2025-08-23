# Speedometer SwiftUI App

This repository contains a simple yet elegant iOS application built with SwiftUI that demonstrates a custom, interactive speedometer component. Users can input a numerical value, and the speedometer's needle and progress arc animate smoothly to reflect the new value.

## Features

-   **Interactive Speedometer Dial:** A visually appealing and custom-built speedometer dial.
-   **Smooth Animations:** The needle, progress arc, and value display update with fluid `easeInOut` animations.
-   **User Input:** A dedicated text field allows users to set a custom value for the speedometer.
-   **Input Validation:** The app handles invalid input gracefully, prompting the user to enter a valid non-negative number.
-   **Dynamic Value Mapping:** The input value is mathematically mapped to a corresponding angle on the dial using linear interpolation for accurate needle placement.
-   **Haptic Feedback:** Provides tactile feedback upon successfully setting a new value.
-   **Modular Code:** The UI is broken down into reusable components (`SpeedometerView`, `SpeedometerDial`, `SpeedometerInput`) for better organization and maintainability.

## Project Structure

The project is organized into logical groups to separate concerns:

-   **`Views/`**: Contains the main SwiftUI views.
    -   `SpeedometerView.swift`: The main container view that orchestrates the speedometer dial and the input controls. It holds the application's state and logic.
    -   **`SubViews/`**: Contains reusable components used within `SpeedometerView`.
        -   `SpeedometerDial.swift`: Renders the entire speedometer UI, including the background, progress bar, labels, and the animated needle.
        -   `SpeedometerInput.swift`: Encapsulates the `TextField` for user input, the "SET" button, and error message display.
-   **`Utils/`**: Utility files and extensions.
    -   `AppColors.swift`: Defines custom colors used throughout the application.
-   **`Assets.xcassets`**: Manages all the visual assets, including the app icon and custom images (`radialCircle`, `innerEllipse`) used for the speedometer's background.

## How It Works

The core logic resides in `SpeedometerView.swift`.

1.  **State Management:** The view uses `@State` properties to manage the current `value`, the needle's `angle`, the user's `inputValue`, and any potential `error` messages.
2.  **Value Input:** The user enters a number into the `TextField` provided by `SpeedometerInput`.
3.  **Handling Input:** Tapping the "SET" button triggers the `handleSet()` function. This function validates the input, clamps the value to a maximum of 150,000, and updates the `value` state variable.
4.  **Angle Calculation:** A private function, `angleForValue()`, is called to convert the numerical `value` into a rotation angle for the needle. It interpolates between predefined points (`labelPoints`) to ensure the needle's position accurately reflects the value on the non-linear scale.
5.  **UI Updates:** Changes to the `@State` properties `value` and `angle` automatically trigger a re-render of the `SpeedometerDial` view. The `.animation()` modifiers on the needle and progress arc ensure these changes are animated smoothly.

## How to Run the Project

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/NaikUrRehman/Speedometer.git
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd Speedometer/speedometer\ task
    ```
3.  **Open the Xcode project:**
    ```bash
    open "speedometer task.xcodeproj"
    ```
4.  **Run the application:**
    -   Select an iOS Simulator (e.g., iPhone 15 Pro) from the scheme menu.
    -   Click the **Run** button (or press `Cmd+R`).
