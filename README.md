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

  mix phx.gen.html Accounts User users first_name:string last_name:string <-- full_name or split?????
  mix phx.gen.context Accounts Credential credentials email:string:unique user_id:references:users

  mix phx.gen.html CMS Post posts title:string content:text views:integer slug:string:unique excerpt:text --web CMS
  mix phx.gen.context CMS Author authors bio:text role:string user_id:references:users:unique
  mix phx.gen.html CMS Tag tags title:string slug:string:unique --web CMS
  mix phx.gen.html CMS Media images url:string --web CMS
  mix phx.gen.html CMS Media videos url:string --web CMS
