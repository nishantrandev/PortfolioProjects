# Supermarket Inventory Management System

## Introduction

The Supermarket Inventory Management System is a Python-based command-line application designed to manage inventory in a supermarket. It provides essential functionalities such as viewing, adding, purchasing, searching, and editing items. The application uses a JSON file, "inventory_data.json," for persistent data storage.

## Features

1. **View Items:**
   - Displays the current items in the inventory along with their quantities and prices.

2. **Add Items:**
   - Allows users to add new items to the inventory, specifying the name, quantity, and price.
   - If an item with the same name exists, the quantity is updated instead.

3. **Purchase Items:**
   - Enables users to purchase items by specifying the item name and quantity needed.
   - Calculates the total price and updates the inventory quantity accordingly.

4. **Search Items:**
   - Allows users to search for items in the inventory based on the item name.
   - Displays details such as name, quantity, and price for the found items.

5. **Edit Items:**
   - Permits users to edit the quantity and price of existing items in the inventory.

6. **Exit the App:**
   - Allows users to exit the application.

## Implementation

- The application uses a JSON file, "inventory_data.json," to persistently store and retrieve data.
- Functions such as `view_items()`, `add_items()`, `purchase_items()`, `search_items()`, and `edit_items()` handle specific functionalities.
- User inputs are validated to ensure the correctness of numeric entries.

## How to Use

1. Run the Python script.
2. Choose options from the displayed menu by entering the corresponding number.
3. Follow the prompts to perform various actions such as viewing, adding, purchasing, searching, and editing items.

## Conclusion

The Supermarket Inventory Management System provides a simple yet effective solution for managing inventory in a supermarket. It offers essential functionalities to view, add, purchase, search, and edit items, contributing to efficient inventory management.

*Note: Ensure that the "inventory_data.json" file is in the same directory as the Python script for persistent data storage.*