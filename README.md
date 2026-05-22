# Clever Rails Hotwire Trial

A photo gallery app where authenticated users can browse and like photos — built with Rails, Hotwire, and no client-side framework.

## Stack

- **Ruby** 4.0.1 / **Rails** 8.1.3
- **SQLite** (development & test)
- **Hotwire** — Turbo Streams for like/unlike without page reload; Stimulus for optimistic UI
- **has_secure_password** for authentication (no Devise)
- **RSpec** for tests

## Setup

```bash
bundle install
bin/rails db:setup
bin/rails server
```

Then open http://localhost:3000 and sign in with one of the seeded accounts:

| Email | Password |
|-------|----------|
| alice@example.com | password |
| bob@example.com | letmein |

## Running tests

```bash
bundle exec rspec
```

## Features

- Sign in / sign out (session-based, no sign-up flow)
- Photo gallery — 10 photos seeded from Pexels
- Like / unlike photos via Turbo Streams (no page reload)
- Optimistic UI — star and count update instantly on click, reverts on error
- Mobile-responsive layout
