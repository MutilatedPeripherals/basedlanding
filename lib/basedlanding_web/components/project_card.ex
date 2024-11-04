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
    <div class="animate-[bounce_1s_ease-in-out_1] bg-white rounded-lg shadow-lg overflow-hidden">
      <%!-- <%= if @image_url do %>
        <img src={@image_url} alt={@title} class="w-full h-48 object-cover"/>
      <% end %> --%>
      <div class="p-6">
        <h3 class="text-xl font-bold text-gray-900 mb-2"><%= @title %></h3>
        <p class="text-gray-600 mb-4"><%= @description %></p>

        <div class="flex flex-wrap gap-2 mb-4">
          <%= for tech <- @tech_stack do %>
            <span class="px-3 py-1 bg-gray-100 text-gray-700 rounded-full text-sm">
              <%= tech %>
            </span>
          <% end %>
        </div>

        <div class="flex gap-4">
          <%= if @github_url do %>
            <a href={@github_url} class="text-gray-600 hover:text-gray-900 transition-colors">
              <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0024 12c0-6.63-5.37-12-12-12z"/>
              </svg>
            </a>
          <% end %>
          <%= if @live_url do %>
            <a href={@live_url} class="text-gray-600 hover:text-gray-900 transition-colors">
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
