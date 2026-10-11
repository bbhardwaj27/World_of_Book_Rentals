# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Rails 6.1 app (Ruby 3.0.3, PostgreSQL) generated from the Le Wagon `rails-templates`. Users list books for rent and leave reviews on them. Frontend is server-rendered ERB with Bootstrap 5 + Simple Form, JS bundled by Webpacker 5 (Stimulus, Turbolinks, Rails UJS).

## Commands

```bash
bundle install && yarn install
bin/rails db:create db:migrate db:seed   # seeds wipe Users/Books/Reviews first, then recreate
bin/rails server                          # Procfile runs puma via config/puma.rb
bin/webpack-dev-server                    # optional, live JS recompilation

bin/rails test                                         # all tests (Minitest)
bin/rails test test/models/book_test.rb                # one file
bin/rails test test/controllers/reviews_controller_test.rb:4   # one test by line

rubocop    # config in .rubocop.yml (max line 120; excludes bin, db, config, test); gem is not in the Gemfile
```

### Local setup on newer macOS (clang 21+)

Ruby 3.0.3 doesn't build with the stock flags. Install it with rbenv like this:

```bash
RUBY_CFLAGS="-Wno-error=implicit-function-declaration -Wno-default-const-init-field-unsafe" \
RUBY_CONFIGURE_OPTS="--with-out-ext=bigdecimal --with-libyaml-dir=$(brew --prefix libyaml)" \
rbenv install 3.0.3
```

Without the warning flag, `socket` (and so `openssl`/`net/http`) silently fails to build. The bundled `bigdecimal` doesn't compile at all, so the Gemfile lists the `bigdecimal` gem explicitly. `nio4r` was bumped to 2.7.x for the same compiler reason. If `bin/rails` hangs, Spring is to blame: prefix commands with `DISABLE_SPRING=1`. Webpacker 5 (Webpack 4) fails on Node 17+ with `error:0308010C:digital envelope routines::unsupported`; prefix `bin/webpack` / `bin/webpack-dev-server` with `NODE_OPTIONS=--openssl-legacy-provider`.

## Architecture

- **Auth**: Devise on `User`. `ApplicationController` has a global `before_action :authenticate_user!`; only `PagesController#home` (the root) skips it. Any new public page needs an explicit `skip_before_action`.
- **Data model** (see `db/schema.rb`): `User` → has books (`books.user_id`) and reviews; `Book` `has_many :reviews, dependent: :destroy`; `Review` belongs to `user` and `book` (with `rating`, `comment`). `List` exists in the schema but is basically unused and its association is broken (`belongs_to :books`).
- **Routes**: reviews are nested under books (`/books/:book_id/reviews/...`). `ReviewsController#show` works as the "write a review" page for a book (it builds a new `Review`), and `create` redirects back to `book_path`. The "Add a Review" link in `books/show` calls `book_review_path(@book)` without a review id, so Rails fills `:id` from the current request (the book's id). `show` ignores `params[:id]`. `routes.rb` also declares top-level `resources :reviews` with reviews nested inside reviews; nothing uses those routes, and most of their actions (like `index`) don't exist in the controller.
- **Book images**: `books.image` is a plain string holding the filename of an image in `app/assets/images/` (set by `db/seeds.rb`) and is rendered with `image_tag`. Views fall back to `happy.jpg` when it is blank. The `cloudinary` gem is installed but not wired up, and `book_params` does not permit `:image`.
- **Styles**: `app/assets/stylesheets/application.scss` imports `config/` (fonts, colors, Bootstrap variables), then Bootstrap and Font Awesome, then the `components/` and `pages/` partials through their `_index.scss` files. Add new partials to the matching `_index.scss`.
- **Light/dark theme**: `components/_theme.scss` defines `--theme-*` CSS variables for both themes, keyed on `data-theme` on `<html>`. An inline script in the layout `<head>` sets that attribute, and the navbar switch (`theme_controller.js`) toggles it and saves it to `localStorage`. Use the variables rather than hard-coded colors in new styles. Bootstrap 5.1 has no built-in color modes, so Bootstrap components that hard-code light colors need dark overrides in `_theme.scss`.

## Known quirks

- `ReviewsController#create` assigns a random user (`User.all.sample`), not `current_user`, and it logs a lot of debug output.
- `BooksController#list` is broken (`Book.find(all)`) and has no route.
- `BooksController#create` calls `save!`, so a validation failure raises an error instead of rendering `new`.
- Most tests are empty generator stubs, some for controllers that don't exist (`BookRentals`, `Lists`). `reviews_controller_test.rb` points to routes that don't exist (`reviews_create_url`), so it fails.
