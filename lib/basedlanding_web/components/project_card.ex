# lib/based_landing_web/components/project_card.ex
defmodule BasedLandingWeb.Components.ProjectCard do
  use Phoenix.Component

  # Define the attributes that your component accepts
  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :tech_stack, :list, default: []
  attr :image_url, :string, default: nil
  attr :github_url, :string, default: nil
  attr :live_url, :string, default: nil

  def project_card(assigns) do
    ~H"""
    <div class={[
      "group relative",
      "bg-gradient-to-r from-purple-600 via-pink-500 to-red-500",
      "rounded-lg shadow-[0_0_50px_rgba(255,0,0,0.5)]",
      "hover:shadow-[0_0_100px_rgba(255,0,255,0.8)]",
      "overflow-hidden",
      "animate-[pulse_1.5s_ease-in-out_infinite]",
      "hover:animate-[spin_3s_linear_infinite]",
      "transition-all duration-300"
    ]}>
      <div class="absolute inset-0 bg-black/20 backdrop-blur-sm"></div>

      <div class="relative p-6 z-10">
        <div class="absolute -inset-1 bg-gradient-to-r from-yellow-400 via-red-500 to-pink-500 blur-xl opacity-50 group-hover:opacity-75 animate-[spin_3s_linear_infinite] transition-all duration-300"></div>

        <h3 class="relative text-xl font-bold text-white mb-2 animate-[bounce_1s_ease-infinite] group-hover:scale-110 transition-transform">
          <%= @title %>
        </h3>

        <p class="relative text-white/90 mb-4 group-hover:animate-[pulse_1s_ease-infinite]">
          <%= @description %>
        </p>

        <div class="relative flex flex-wrap gap-2 mb-4">
          <%= for tech <- @tech_stack do %>
            <span class={[
              "px-3 py-1 bg-white/10 text-white rounded-full text-sm",
              "hover:bg-white/20",
              "animate-[wiggle_1s_ease-in-out_infinite]",
              "hover:animate-[chaos_2s_linear_infinite]",
              "transition-all duration-300",
              "scale-[1000.0]",
              "hover:z-50",
              "group-hover:translate-x-[random(100px)]",
              "group-hover:translate-y-[random(100px)]",
              "group-hover:rotate-[random(360deg)]"
            ]}>
              <%= tech %>
            </span>
          <% end %>
        </div>

        <div class="relative flex gap-4">
          <%= if @github_url do %>
            <a href={@github_url} class="text-white hover:text-yellow-300 transition-colors hover:animate-[spin_1s_linear_infinite]">
              <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0024 12c0-6.63-5.37-12-12-12z"/>
              </svg>
            </a>
          <% end %>
          <%= if @live_url do %>
            <a href={@live_url} class="text-white hover:text-yellow-300 transition-colors hover:animate-[spin_1s_linear_infinite]">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
              </svg>
            </a>
          <% end %>
        </div>
      </div>
    </div>
    """
  end
end
