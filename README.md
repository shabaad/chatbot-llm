# Flutter Chatbot LLM with AI-Powered Chat

## Overview

This is a chat application built in Flutter that allows users to log in using phone OTP via Supabase Authentication and chat with an AI-powered Large Language Model (LLM) using Cohere. The app provides a seamless user experience for real-time chat and stores message history for users.

APK File
The release APK of the application can be downloaded from the following link: Download APK

## Features

- **OTP Authentication**: Users can log in using their phone number with OTP verification via Supabase.
- **Real-time Chat**: Engage in conversations with the LLM that generates responses to user messages.
- **Message History**: Users can view their past conversations stored in the Supabase database.
- **Error Handling**: Provides user-friendly error messages for failed logins and message sending.
- **Logging**: Simple console logging for important actions within the app.

## Tech Stack

- **Frontend**: Flutter
- **Backend**: Supabase (for authentication and data storage)
- **LLM Provider**: Cohere (for generating chat responses)

## Installation

To run this project locally, follow these steps:

1. **Clone the Repository**

git clone https://github.com/shabaad/chatbot_llm.git

Install Dependencies Ensure you have Flutter installed on your machine. Then, run the following command to get the dependencies:

flutter pub get


Setup Supabase

Create a Supabase project at Supabase.
Set up authentication and configure the database to store chat history.
Add your Supabase URL and API Key to your Flutter project in a .env file or directly in the code (make sure to keep your keys secure).


Setup Cohere

Sign up for an account at Cohere.
Obtain your API key and configure it in your project.


Run the App Use the following command to run the app on your emulator or physical device:

flutter run


Usage : 

Login:
Open the app and enter your phone number to receive an OTP.
Enter the OTP to log in to the application.
Chat

Once logged in, you can start chatting with the AI.
Type your messages and view the AI's responses in real-time.


Message History:
Users can access previous conversations when they return to the app.
Error Handling
The app displays error messages for login failures (e.g., invalid OTP) and message sending issues.
Ensure you have a stable internet connection for both authentication and chat functionalities.

Logging:
Console logs are added for the following actions:

Login success and failure
Messages sent and received


Conclusion
This project demonstrates the ability to create a chat application using Flutter, integrating authentication, real-time chat functionality, and an AI model for responses. It serves as a good example of modern mobile app development practices and effective use of third-party services.

Acknowledgments
Supabase for backend services
Cohere for LLM capabilities
Flutter community for the extensive resources and packages available