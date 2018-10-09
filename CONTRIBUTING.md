# Contributing to iOS Civic Connect
Thank you for contributing to this project.

## Introduction
This project provides a way for a partner app to integrate with the Civic Identity ecosystem. It contains a library that helps the partner app obtain information about a user with the users consent using the Civic Secure Identity iOS Application. This project also contains a sample app that shows how to use the library.

Note: If you integrate this library into your app, you need to obtain an application identifier and secret from the [Civic Integration Portal](https://integrate.civic.com) as well as fill in your iOS app bundle ID in order for us to whitelist the app and give it access to the APIs.

## Questions
If you have questions about this project, consult the [Civic Help Center](https://support.civic.com).

## Issues
Log issues on this git repo. Please provide as much information as possible about the issue. If you have a fix for the issue please make a pull request.

## Features
Please discuss feature requests with us first as we can't guarantee that a pull request for a feature will be included.

## Getting started
This repo is built using Xcode and Cocoapods. You will need to obtain an application identifier and secret from the [Civic Integration Portal](https://integrate.civic.com) as well as fill in the bundle ID for your iOS app. In your Info.plist you will supply the application identifier under `CivicApplicationIdentifier` and secret under `CivicSecret`.

