# Blog App

A Flutter-based blogging application that allows users to create, share, and interact with blog posts. The app uses Supabase for backend services and follows clean architecture principles.

## Features

- User Authentication
- Create and publish blog posts
- Upload images for blog posts
- Add topics/tags to blogs
- Clean and intuitive UI
- Real-time updates

## Setup Instructions

### Prerequisites

1. Flutter SDK (latest version)
2. Dart SDK (latest version)
3. VS Code or Android Studio
4. Git
5. A Supabase account

### Installation Steps

1. Clone the repository

   ```bash
   git clone https://github.com/TusharGupta012735/BlogApp.git
   cd blog_app
   ```

2. Install dependencies

   ```bash
   flutter pub get
   ```

3. Supabase Setup

   - Create a new project in Supabase
   - Create the following tables in your Supabase database:
     - `users`
     - `blogs`
   - Set up Storage buckets for blog images

4. Create a `secrets.dart` file

   ```dart
   // lib/core/secrets/secrets.dart

   class Secrets {
     static const supabaseUrl = 'YOUR_SUPABASE_URL';
     static const supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
   }
   ```

   Replace `YOUR_SUPABASE_URL` and `YOUR_SUPABASE_ANON_KEY` with your actual Supabase credentials.

5. Run the app
   ```bash
   flutter run
   ```

### Database Schema

#### Users Table

```sql
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  profile_pic TEXT
);
```

#### Blogs Table

```sql
CREATE TABLE blogs (
  id TEXT PRIMARY KEY,
  poster_id TEXT REFERENCES users(id),
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  image_url TEXT NOT NULL,
  topics TEXT[] NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

#### Future Scope

1. Implement Logout functionality
2. Filter to sort the blogs by topic
3. Edit profile and theme using settings page
4. Make the blogs scrollable to navigate between one another
5. Improve UI
