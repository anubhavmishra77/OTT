#!/bin/bash

# FlickTV APK Build Script
# This script builds the Flutter app for Android release

echo "🎬 Building FlickTV APK..."
echo "=========================="

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build APK
echo "🔨 Building APK..."
flutter build apk --release

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    echo "📱 APK location: build/app/outputs/flutter-apk/app-release.apk"
    echo "📊 APK size: $(du -h build/app/outputs/flutter-apk/app-release.apk | cut -f1)"
    echo ""
    echo "🎉 FlickTV APK is ready for installation!"
    echo "📋 To install: adb install build/app/outputs/flutter-apk/app-release.apk"
else
    echo "❌ Build failed!"
    echo "Please check the error messages above."
    exit 1
fi 