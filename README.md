## **Movies Application**

The Movies application is a Petal stack project that provides information about new and old movies. This README file provides an overview of the application and instructions on how to set it up and run it successfully.

## Prerequisites

Before running the Movies application, make sure you have the following prerequisites installed on your system:

- Elixir (version 1.14 or later)
- Phoenix framework (version 1.7 or later)

## Setup

Follow the steps below to set up the Movies application:

1. Clone the repository: <br/>
   `git clone <repository-url>`<br/>
2. Rename the `.env.example` file to `.env`: <br/>
   `mv .env.example .env`<br/>
3. Update the `.env` file with the required credentials for your application. Make sure to provide the correct values for each environment variable. <br/>
4. Source the `.env` file to load the environment variables at runtime:<br/>
   `source .env`<br/>
5. Install dependencies:<br/>
   `mix deps.get`<br/>
6. Start the Phoenix server:<br/>
   `mix phx.server`
7. Access the Movies application in your browser at `http://localhost:4000`.

## Live Demo

A live demo is hosted [here](https://restless-butterfly-3393.fly.dev/) on fly.io

## Usage

The Movies application provides information about both new and old movies. You can search for movies, view details about each movie, and see ratings and release dates.

## Credits

The Movies application uses data from the TMDB (The Movie Database) API. Make sure to obtain an API key/token from TMDB and update the `.env` file with your TMDB API key/token.

## License

The Movies application is open-source software licensed under the [MIT license](LICENSE).
