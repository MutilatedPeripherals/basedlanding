# Use an official Elixir image to build the release
FROM elixir:1.15 AS build

# Install build dependencies
RUN apt-get update && \
    apt-get install -y inotify-tools npm

# Set the working directory
WORKDIR /app

# Install Hex and Rebar for dependencies
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy mix files and install dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod

# Copy the rest of the application code
COPY . .

# Compile assets if any (assuming assets are in `assets` directory)
RUN mix assets.deploy

# Compile and build a release
RUN MIX_ENV=prod mix release

# Create a runtime image for the release
FROM elixir:1.15-slim

# Set environment variables
ENV LANG=C.UTF-8 \
    REPLACE_OS_VARS=true \
    MIX_ENV=prod

# Set the working directory
WORKDIR /app

# Copy the release from the build stage
COPY --from=build /app/_build/prod/rel/basedlanding .  

# Expose the port the app runs on
EXPOSE 4000

# Start the release
CMD ["./bin/basedlanding", "start"]
