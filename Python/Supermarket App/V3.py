import os
import json

# Constants
DATA_FILE = "inventory_data.json"

# Load existing data from a file if it exists
if os.path.exists(DATA_FILE):
    with open(DATA_FILE, "r") as file:
        items = json.load(file)
else:
    items = []

def save_data():
    # Save data to a file
    with open(DATA_FILE, "w") as file:
        json.dump(items, file)

def display_menu():
    print("<------ Welcome to the Supermarket ------>\n"
          "1. View items\n"
          "2. Add items\n"
          "3. Purchase items\n"
          "4. Search items\n"
          "5. Edit items\n"
          "6. Exit the app")

def get_numeric_input(prompt):
    while True:
        try:
            return int(input(prompt))
        except ValueError:
            print("Invalid input. Please enter a valid number.")

def get_float_input(prompt):
    while True:
        try:
            return float(input(prompt))
        except ValueError:
            print("Invalid input. Please enter a valid number.")

def view_items():
    print("---- View Items ----")
    print(f"The number of items in the inventory is: {len(items)}")
    if items:
        print("Here are all the items available at the moment")
        for item in items:
            print(f"Name: {item['name']}, Quantity: {item['quantity']}, Price: {item['price']}")

def add_items():
    print("---- Add Items ----")
    item_name = input("Item name: ")

    existing_item = next((item for item in items if item["name"].lower() == item_name.lower()), None)
    if existing_item:
        print("Item with the same name already exists. Adding quantity instead.")
        quantity_to_add = get_numeric_input("Enter the quantity to add: ")
        existing_item["quantity"] += quantity_to_add
    else:
        item = {"name": item_name}
        item["quantity"] = get_numeric_input("Item quantity: ")
        item["price"] = get_float_input("Enter the price: ")

        items.append(item)
        print("Item has been successfully added.")
        save_data()

def purchase_items():
    print("---- Purchase Items ----")
    purchase_item = input("Which item would you like to purchase? Enter name: ")
    purchase_quantity = get_numeric_input("Enter the quantity needed: ")

    for item in items:
        if purchase_item.lower() == item["name"].lower():
            if item["quantity"] != 0:
                if purchase_quantity <= item["quantity"]:
                    total_price = item["price"] * purchase_quantity
                    print(f"Pay {total_price} at checkout counter")
                    item["quantity"] -= purchase_quantity
                    print(f"Remaining quantity for {item['name']}: {item['quantity']}")
                    save_data()
                else:
                    print("Insufficient quantity available!")
            else:
                print("Item out of stock")
                save_data()

def search_items():
    print("---- Search Items ----")
    find_item = input("Enter the item name to search in the inventory: ")
    found_items = [item for item in items if item["name"].lower() == find_item.lower()]
    if found_items:
        for found_item in found_items:
            print(f"Name: {found_item['name']}, Quantity: {found_item['quantity']}, Price: {found_item['price']}")
    else:
        print("Item not found")

def edit_items():
    print("---- Edit Items ----")
    item_name = input("Enter the name of the item to be edited: ")
    found_item = next((item for item in items if item["name"].lower() == item_name.lower()), None)
    if found_item:
        print(f"Current details for {item_name}:")
        print(f"Name: {found_item['name']}, Quantity: {found_item['quantity']}, Price: {found_item['price']}")
        found_item["quantity"] = get_numeric_input("Enter the new quantity: ")
        found_item["price"] = get_float_input("Enter the new price: ")
        print(f"Updated details for {item_name}: {found_item}")
        save_data()
    else:
        print("Item not found")

while True:
    display_menu()
    choice = input("Enter the number of your choice: ")

    if not choice.isdigit():
        print("Invalid input. Please enter a number.")
        continue

    choice = int(choice)

    if choice == 1:
        view_items()
    elif choice == 2:
        add_items()
    elif choice == 3:
        purchase_items()
    elif choice == 4:
        search_items()
    elif choice == 5:
        edit_items()
    elif choice == 6:
        print("Exiting the app. Thank you!")
        break
    else:
        print("Invalid option. Please enter a valid choice.")
