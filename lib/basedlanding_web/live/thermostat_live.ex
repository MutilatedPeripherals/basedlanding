defmodule BasedLandingWeb.ThermostatLive do
  use Phoenix.LiveView
  alias BasedLandingWeb.Components.ProjectCard

  @timer_interval_1 1000
  @timer_interval_2 3000
  @timer_interval_3 6000


  @projects [
    %{
      title: "BasedChat",
      description: "Real-time chat application built with Phoenix LiveView and Presence",
      tech_stack: ["Elixir", "Phoenix", "LiveView", "Tailwind", "PostgreSQL"],
      image_url: "/images/based-chat.jpg",  # Add your images to /priv/static/images/
      github_url: "https://github.com/basedsolutions/based-chat",
      live_url: "https://chat.basedsolutions.com"
    },
    %{
      title: "BasedCommerce",
      description: "Modern e-commerce platform with real-time inventory management",
      tech_stack: ["Elixir", "Phoenix", "GraphQL", "React", "PostgreSQL"],
      image_url: "/images/based-commerce.jpg",
      github_url: "https://github.com/basedsolutions/based-commerce",
      live_url: "https://commerce.basedsolutions.com"
    },
    %{
      title: "BasedAnalytics",
      description: "Privacy-focused analytics platform for web applications",
      tech_stack: ["Elixir", "Phoenix", "ClickHouse", "Chart.js", "Redis"],
      image_url: "/images/based-analytics.jpg",
      github_url: "https://github.com/basedsolutions/based-analytics",
      live_url: "https://analytics.basedsolutions.com"
    }
  ]

 def render(assigns) do
    ~H"""
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 p-6">
      <%= if @counter_1 > 0 do %>
      <ProjectCard.project_card
          title={Enum.at(@projects, 0).title}
          description={Enum.at(@projects, 0).description}
          tech_stack={Enum.at(@projects, 0).tech_stack}
          image_url={Enum.at(@projects, 0).image_url}
          github_url={Enum.at(@projects, 0).github_url}
          live_url={Enum.at(@projects, 0).live_url}
        />
      <% end %>

      <%= if @counter_2 > 0 do %>
      <ProjectCard.project_card
          title={Enum.at(@projects, 1).title}
          description={Enum.at(@projects, 1).description}
          tech_stack={Enum.at(@projects, 1).tech_stack}
          image_url={Enum.at(@projects, 1).image_url}
          github_url={Enum.at(@projects, 1).github_url}
          live_url={Enum.at(@projects, 1).live_url}
        />
      <% end %>

      <%= if @counter_3 > 0 do %>
      <ProjectCard.project_card
          title={Enum.at(@projects, 2).title}
          description={Enum.at(@projects, 2).description}
          tech_stack={Enum.at(@projects, 2).tech_stack}
          image_url={Enum.at(@projects, 2).image_url}
          github_url={Enum.at(@projects, 2).github_url}
          live_url={Enum.at(@projects, 2).live_url}
        />
      <% end %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(@timer_interval_1, self(), :inc_counter_1)
      :timer.send_interval(@timer_interval_2, self(), :inc_counter_2)
      :timer.send_interval(@timer_interval_3, self(), :inc_counter_3)
    end

    {:ok,
     socket
     |> assign(counter_1: 0, counter_2: 0, counter_3: 0)
     |> assign(:projects, @projects)}  # Add this line
  end

  def handle_info(message, socket) do
    attribute_to_bump = case message do
      :inc_counter_1 -> :counter_1
      :inc_counter_2 -> :counter_2
      :inc_counter_3 -> :counter_3
    end
    {:noreply, update(socket, attribute_to_bump, &(&1 + 1))}
    # &(&1 + 1) == fn x -> x + 1 end
  end
end
