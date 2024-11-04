# Based Solutions Landing Page


### Install the tools

1. Elixir & Erlang: 
    ```bash
    # Ubuntu
    sudo apt install erlang-dev elixir

    # Fedora
    sudo dnf install erlang elixir
    ```
2. Hex Package Manager: 
    ```bash
    mix local.hex
    ```
3. Phoenix: 
    ```bash
    mix archive.install hex phx_new
    ```
4. inotify-tools (for hot reloading): 
    ```bash
    # Ubuntu
    sudo apt-get install inotify-tools

    # Fedora
    sudo dnf install inotify-tools
    ```

### Install project deps & run the app

```
mix deps.get
```

```
mix phx.server
```

### For deployment:

```bash
export SECRET_KEY_BASE=$(openssl rand -base64 48)

docker compose up --build
```

### References: 
- https://elixir-lang.org/install.html#gnulinux
- https://hexdocs.pm/phoenix/installation.html
- https://github.com/inotify-tools/inotify-tools/wiki