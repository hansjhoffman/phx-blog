# Blog

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Context commands
  https://hexdocs.pm/phoenix/contexts.html

  ```
  mix phx.gen.html Accounts User users handle:string
  mix phx.gen.context Accounts Credential credentials password_hash:string user_id:references:users

  mix phx.gen.html CMS Post posts title:string content:text views:integer slug:string:unique excerpt:text --web CMS
  mix phx.gen.context CMS Author authors bio:text user_id:references:users:unique
  mix phx.gen.html CMS Tag tags title:string slug:string:unique --web CMS
  mix phx.gen.html CMS Media images url:string --web CMS
  mix phx.gen.html CMS Media videos url:string --web CMS
  ```

## TODO
- Refactor tags to use slugs instead of id
- Logout functionality
- Fix issue: (Phoenix.Router.NoRouteError) no route found for GET /icons/icon-144x144.png
- Mix credo
- Image/Video upload via Arc? or just host somewhere?
- Post views
- Post status
- Featured post boolean property
- Testing
- Admin css
- Liveview markdown editor
- App css
- Turbolinks (https://github.com/kagux/turbolinks_plug) or ETS (https://alchemist.camp/episodes/ets-cache)
