# Game Catalogue Service - Communication Contract

## Overview
The Game Catalogue Service is a RESTful API microservice that provides access to a comprehensive database of video games. It offers endpoints for searching games, retrieving curated game lists, and browsing games by genre.

**Base URL**: `http://localhost:8000`

## Running the Service

```bash
# First create and activate your venv
pip install -r requirements
# cd into project directory
uvicorn main:app --reload
```

The service will start on `http://localhost:8000` by default.

---

## API Endpoints

### 1. Get Game by ID
**Endpoint**: `GET /games/id/{game_id}`

**Description**: Retrieve detailed information about a specific game by its ID.

**Parameters**:
- `game_id` (path parameter, integer): The unique identifier of the game

**Example Request**:
```python
import requests

response = requests.get("http://localhost:8000/games/id/1245620")
game_data = response.json()
print(game_data)
```

**Example Response**:
```json
{
  "id": 1245620,
  "title": "Elden Ring",
  "description": "A fantasy action RPG set in the Lands Between...",
  "releaseYear": 2022,
  "imageUrl": "https://example.com/elden-ring.jpg",
  "developer": "FromSoftware",
  "publisher": "Bandai Namco",
  "platform": ["PC", "PlayStation", "Xbox"],
  "price": 59.99,
  "website": "https://eldenring.com",
  "genres": ["Action", "RPG"],
  "tags": ["Souls-like", "Open World"],
  "screenshots": ["url1", "url2"],
  "metacriticScore": 96,
  "steamRating": 92
}
```

---

### 2. Search Games by Title
**Endpoint**: `GET /games/search/{title}`

**Description**: Search for games by title. Returns up to 8 games that match the search query, with exact matches prioritized.

**Parameters**:
- `title` (path parameter, string): The search query for game title

**Example Request**:
```python
import requests

response = requests.get("http://localhost:8000/games/search/zelda")
search_results = response.json()
print(search_results)
```

**Example Response**:
```json
{
  "searched": [
    {
      "id": 123,
      "title": "The Legend of Zelda: Breath of the Wild",
      "description": "...",
      "releaseYear": 2017,
      "genres": ["Action", "Adventure"],
      "price": 59.99,
      ...
    },
    {
      "id": 456,
      "title": "The Legend of Zelda: Tears of the Kingdom",
      ...
    }
  ]
}
```

---

### 3. Get Available Lists
**Endpoint**: `GET /games/lists`

**Description**: Retrieve a list of all available curated game lists with their endpoints.

**Example Request**:
```python
import requests

response = requests.get("http://localhost:8000/games/lists")
available_lists = response.json()
print(available_lists)
```

**Example Response**:
```json
{
  "availableLists": [
    {"name": "trending", "endpoint": "/games/lists/trending"},
    {"name": "featured", "endpoint": "/games/lists/featured"},
    {"name": "top", "endpoint": "/games/lists/top"},
    {"name": "staff-picks", "endpoint": "/games/lists/staff-picks"}
  ]
}
```

---

### 4. Get Trending Games
**Endpoint**: `GET /games/lists/trending`

**Description**: Retrieve the top 10 trending games based on a composite score considering Metacritic ratings, Steam ratings, release year, and price.

**Example Request**:
```python
import requests

response = requests.get("http://localhost:8000/games/lists/trending")
trending_games = response.json()
print(trending_games)
```

**Example Response**:
```json
{
  "trendingGames": [
    {
      "id": 1234,
      "title": "Game Title",
      "description": "...",
      ...
    },
    ...
  ]
}
```

---

### 5. Get Featured Games
**Endpoint**: `GET /games/lists/featured`

**Description**: Retrieve a curated list of featured games.

**Example Request**:
```python
import requests

response = requests.get("http://localhost:8000/games/lists/featured")
featured_games = response.json()
print(featured_games)
```

**Example Response**:
```json
{
  "featured": [
    {
      "id": 1245620,
      "title": "Elden Ring",
      ...
    },
    ...
  ]
}
```

---

### 6. Get Top Games
**Endpoint**: `GET /games/lists/top`

**Description**: Retrieve the top 10 games ranked by Metacritic score.

**Example Request**:
```python
import requests

response = requests.get("http://localhost:8000/games/lists/top")
top_games = response.json()
print(top_games)
```

**Example Response**:
```json
{
  "topGames": [
    {
      "id": 789,
      "title": "The Best Game Ever",
      "metacriticScore": 98,
      ...
    },
    ...
  ]
}
```

---

### 7. Get Staff Picks
**Endpoint**: `GET /games/lists/staff-picks`

**Description**: Retrieve a curated list of games recommended by staff.

**Example Request**:
```python
import requests

response = requests.get("http://localhost:8000/games/lists/staff-picks")
staff_picks = response.json()
print(staff_picks)
```

**Example Response**:
```json
{
  "staffPicks": [
    {
      "id": 311210,
      "title": "Call of Duty: Black Ops III",
      ...
    },
    ...
  ]
}
```

---

### 8. Get All Genres
**Endpoint**: `GET /games/genres`

**Description**: Retrieve a list of all unique game genres available in the database.

**Example Request**:
```python
import requests

response = requests.get("http://localhost:8000/games/genres")
genres = response.json()
print(genres)
```

**Example Response**:
```json
{
  "genres": [
    "Action",
    "Adventure",
    "FPS",
    "Horror",
    "Indie",
    "MMORPG",
    "Puzzle",
    "RPG",
    "Simulation",
    "Strategy"
  ]
}
```

---

### 9. Get Games by Genre
**Endpoint**: `GET /games/genres/{genre}?skip={skip}&limit={limit}`

**Description**: Retrieve games filtered by a specific genre with pagination support.

**Parameters**:
- `genre` (path parameter, string): The genre to filter by
- `skip` (query parameter, integer, optional): Number of items to skip (default: 0)
- `limit` (query parameter, integer, optional): Number of items to return (default: 10, max: 100)

**Example Request**:
```python
import requests

# Get the first 10 RPG games
response = requests.get("http://localhost:8000/games/genres/RPG?skip=0&limit=10")
genre_games = response.json()
print(genre_games)
```

**Example Response**:
```json
{
  "genre": "RPG",
  "games": [
    {
      "id": 123,
      "title": "Final Fantasy XIV",
      "genres": ["RPG", "MMORPG"],
      ...
    },
    ...
  ],
  "total": 45,
  "skip": 0,
  "limit": 10
}
```

---

## How to REQUEST Data

### Using Python with `requests` library:
```python
import requests

# Make a GET request to any endpoint
response = requests.get("http://localhost:8000/games/search/minecraft")

# Check if request was successful
if response.status_code == 200:
    data = response.json()
    print(data)
else:
    print(f"Error: {response.status_code}")
```

### Using JavaScript with `fetch`:
```javascript
// Make a GET request to any endpoint
fetch('http://localhost:8000/games/lists/trending')
  .then(response => response.json())
  .then(data => {
    console.log(data);
  })
  .catch(error => {
    console.error('Error:', error);
  });
```

### Using cURL:
```bash
curl http://localhost:8000/games/id/1245620
```

---

## How to RECEIVE Data

All endpoints return JSON-formatted data. The HTTP response will include:

**HTTP Status Codes**:
- `200 OK`: Request successful, data returned in response body
- `404 Not Found`: Resource not found (e.g., invalid game ID)
- `422 Unprocessable Entity`: Invalid request parameters

**Response Format**: All responses are JSON objects. Parse the JSON response to access the data.

**Example in Python**:
```python
import requests
import json

# Send request
response = requests.get("http://localhost:8000/games/genres/Action")

# Receive and parse JSON data
if response.status_code == 200:
    data = response.json()  # Automatically parses JSON

    # Access the data
    genre_name = data["genre"]
    games_list = data["games"]
    total_count = data["total"]

    # Process each game
    for game in games_list:
        print(f"Title: {game['title']}")
        print(f"Price: ${game['price']}")
        print(f"Rating: {game['metacriticScore']}")
```

**Example in JavaScript**:
```javascript
// Send request and receive data
fetch('http://localhost:8000/games/lists/top')
  .then(response => {
    if (response.ok) {
      return response.json();  // Parse JSON
    }
    throw new Error('Network response was not ok');
  })
  .then(data => {
    // Access the data
    const topGames = data.topGames;

    // Process each game
    topGames.forEach(game => {
      console.log(`Title: ${game.title}`);
      console.log(`Score: ${game.metacriticScore}`);
    });
  })
  .catch(error => {
    console.error('Error:', error);
  });
```

---

## Data Model

Each game object contains the following fields:

| Field | Type | Description |
|-------|------|-------------|
| `id` | integer | Unique game identifier |
| `title` | string | Game title |
| `description` | string | Game description |
| `releaseYear` | integer | Year of release |
| `imageUrl` | string | URL to game cover image |
| `developer` | string | Game developer |
| `publisher` | string | Game publisher |
| `platform` | array | Platforms available (e.g., ["PC", "PlayStation"]) |
| `price` | float | Price in USD |
| `website` | string | Official game website |
| `genres` | array | Game genres (e.g., ["Action", "RPG"]) |
| `tags` | array | Game tags/themes |
| `screenshots` | array | URLs to game screenshots |
| `metacriticScore` | integer | Metacritic rating (0-100) |
| `steamRating` | integer | Steam user rating (0-100) |

---