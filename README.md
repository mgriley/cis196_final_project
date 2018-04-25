# cis196_final_project
CIS 196 Final Project

Mote: A minimal note-taking app.

To open the website, go to https://mote-note-frontend.herokuapp.com

Overview:
The app is separated into an API and a website that calls the API. 

API:
The API uses Rails. The API endpoints accept parameters as JSON and response with JSON objects. The API is running at https://mote-note-frontend.herokuapp.com. It purely consists of API endpoints, so you won't see any views rendered if you open that address in your browser. The rails project is in notes_api.

Frontend:
The frontend is a single-page-application made with Vue.js. The Vue components call the Rails API and uses the response to construct the webpage. These components are in frontend/src. A build script compacts these .vue files into a directory containing only index.html, JS files, and CSS files. A Node.js server then serves these static files. I tried to have the Rails API serve the website, but this became too messy. The website is served on https://mote-note-frontend.herokuapp.com.

