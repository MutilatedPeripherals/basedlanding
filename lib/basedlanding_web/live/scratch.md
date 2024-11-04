```elixir
defmodule MyAppWeb.TimerLive do
use MyAppWeb, :live_view

@timer_interval 1000 # 1 second

def mount(_params, _session, socket) do
if connected?(socket) do
:timer.send_interval(@timer_interval, self(), :tick)
end

{:ok, assign(socket,
  counter: 0,
  current_time: Time.utc_now()
)}
end

def handle_info(:tick, socket) do
{:noreply, socket
|> update(:counter, &(&1 + 1))
|> assign(:current_time, Time.utc_now())}
end

def render(assigns) do
~H"""
<div>
<h1>Timer Example</h1>
<div>Counter: <%= @counter %></div>
<div>Current Time: <%= @current_time %></div>
</div>
"""
end
end
```