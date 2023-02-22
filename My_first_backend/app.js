// initialize and declare express with name 'app'
const express = require("express");
const basicAuth = require('express-basic-auth');
const app = express();

// song list
const songs= ["Accidents Will Happen", "All By Myself",
"All I Do Is Dream of You", "All of Me", "All of You", "Anything", "Anything Goes",
"Available", "Black", "Blue Skies", "Buds Won't Bud", "California", "Collegiate",
"California", "Charmaine", "Could 'Ja?", "Cycles", "Daybreak", "Desafinado", "My way"];

// wives
wives = "Nancy Barbato, Ava Gardner, Mia Farrow, Barbara Marx"

// birthday
birth_day = "December 12, 1915";

// birth city
birth_city = "Hoboken, New Jersey, U.S."

// picture url
url = "https://en.wikipedia.org/wiki/Frank_Sinatra#/media/File:Frank_Sinatra2,_Pal_Joey.jpg"

// **Routes**
// get random song on homepage route '/'.
app.get("/", (request, response) => {
    response.send(songs[Math.floor(Math.random() * 21)]);
});
// get birthday
app.get("/birth_date", (req, res) => {
  res.send(birth_day);
});
// get birth city
app.get("/birth_city", (req, res) => {
  res.send(birth_city);
});
// get wives
app.get("/wives", (req, res) => {
  res.send(wives);
});
// get picture
app.get("/picture", (req, res) => {
  res.redirect('https://en.wikipedia.org/wiki/Frank_Sinatra#/media/File:Frank_Sinatra2,_Pal_Joey.jpg');
});
// public / unprotected
app.get("/public", (req, res) => {
  res.send("Everybody can see this page.");
});
// protected Route. Basic auth only works on this route
app.get("/protected", basicAuth({
  users: { 'admin': 'admin' },
  unauthorizedResponse: (req) => {
    return `401 Not authorized.`
  }
}), (req, res) => {
  res.send("Welcome, authenticated client");
});




app.listen(8080, "0.0.0.0", () => {
    console.log("Listening on the port 8080...");
});
