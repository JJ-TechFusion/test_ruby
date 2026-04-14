# Ruby REST API

A simple REST API built with Sinatra.

## Features

- `GET /health` - Health check endpoint
- `GET /items` - List all items
- `POST /items` - Create a new item
- `GET /items/:id` - Get item by ID

## Setup

1. Install dependencies:
```bash
bundle install
```

2. Run the server:
```bash
ruby app.rb
```

Or with Puma:
```bash
bundle exec puma
```

## Testing

```bash
bundle exec rspec
```

## Deployment

Set the `PORT` environment variable and run:
```bash
bundle exec puma -p $PORT
```

## Example Usage

```bash
# Health check
curl http://localhost:4567/health

# Create an item
curl -X POST http://localhost:4567/items \
  -H "Content-Type: application/json" \
  -d '{"name": "widget"}'

# List all items
curl http://localhost:4567/items

# Get item by ID
curl http://localhost:4567/items/1
```
