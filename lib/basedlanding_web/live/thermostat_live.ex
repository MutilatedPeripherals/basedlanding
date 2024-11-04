defmodule BasedLandingWeb.ThermostatLive do
  use Phoenix.LiveView

  @timer_interval_1 1000
  @timer_interval_2 3000
  @timer_interval_3 6000

  def render(assigns) do
    ~H"""
    Counter 1: <%= @counter_1 %><br>
    Counter 2: <%= @counter_2 %><br>
    Counter 3: <%= @counter_3 %>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(@timer_interval_1, self(), :inc_counter_1)
      :timer.send_interval(@timer_interval_2, self(), :inc_counter_2)
      :timer.send_interval(@timer_interval_3, self(), :inc_counter_3)
    end

    {:ok, assign(socket, counter_1: 0, counter_2: 0, counter_3: 0)}
  end

  def handle_info(message, socket) do
    attribute_to_bump = case message do
      :inc_counter_1 -> :counter_1
      :inc_counter_2 -> :counter_2
      :inc_counter_3 -> :counter_3
    end
    {:noreply, update(socket, attribute_to_bump, &(&1 + 1))}
  end
end
