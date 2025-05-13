#!/bin/bash

# Set the database name
DB_NAME="contacts.db"

# Create the contacts table if it doesn't already exist
sqlite3 $DB_NAME "CREATE TABLE IF NOT EXISTS contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT,
    phone TEXT
);"

# Display menu options
echo "Choose an action:"
echo "1. Add Contact"
echo "2. View All Contacts"
echo "3. Delete Contact"
echo "4. Search Contact"

# Get user's choice
read -p "Enter option (1/2/3/4): " choice

# Decide what to do
case $choice in
    1)
        read -p "Enter name: " name
        read -p "Enter email: " email
        read -p "Enter phone number: " phone
        sqlite3 $DB_NAME "INSERT INTO contacts(name, email, phone) VALUES ('$name', '$email', '$phone');"
        echo "Contact added!"
        ;;
    2)
        echo "Contacts:"
        sqlite3 $DB_NAME "SELECT * FROM contacts;"
        ;;
    3)
        read -p "Enter name of contact to delete: " delname
        sqlite3 $DB_NAME "DELETE FROM contacts WHERE name='$delname';"
        echo "Contact deleted (if found)."
        ;;
    4)
        read -p "Enter name to search: " search_term
        echo "Search results:"
        sqlite3 $DB_NAME "SELECT * FROM contacts WHERE name LIKE '%$search_term%';"
        ;;
    *)
        echo "Invalid choice."
        ;;
esac
