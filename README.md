# Blog

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## TODO
- Testing
- Liveview markdown editor
- Admin panel nav is-active
- App css
- Admin form validation css. Use LiveViews for validation?
- Set Timezone data in ecto
- Finish sitemap setup
- Add Post type for text,image,video?
- Image/Video upload via Arc? or just host somewhere manually?
  ```
  mix phx.gen.html CMS Media images url:string --web CMS
  mix phx.gen.html CMS Media videos url:string --web CMS
  ```
- Featured post boolean property
- Turbolinks (https://github.com/kagux/turbolinks_plug)
- Configure OTP login
