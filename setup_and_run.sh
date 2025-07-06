#!/bin/bash

# FlickTV Setup and Run Script
echo "🎬 Setting up FlickTV..."
echo "========================"

# Install dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully!"
    
    # Run the app
    echo "🚀 Starting FlickTV..."
    flutter run
else
    echo "❌ Failed to install dependencies!"
    echo "Please check your Flutter installation and try again."
    exit 1
fi 