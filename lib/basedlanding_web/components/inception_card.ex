defmodule BasedLandingWeb.Components.InceptionCard do
  use Phoenix.Component

  attr :depth, :integer, default: 0
  attr :max_depth, :integer, default: 5
  attr :scale, :float, default: 0.92
  attr :rotation, :integer, default: 8
  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :tech_stack, :list, default: []
  attr :image_url, :string, default: nil
  attr :github_url, :string, default: nil
  attr :live_url, :string, default: nil

  def inception_card(assigns) do
    ~H"""
    <div class="relative perspective-1000">
      <div class={"absolute top-0 left-0 w-full transform transition-all duration-700 hover:duration-300"}
           style={"transform:
             scale(#{:math.pow(@scale, @depth)})
             rotate(#{@rotation * @depth}deg)
             translateZ(#{@depth * 50}px)
             #{if rem(@depth, 2) == 0, do: "rotateY(#{@depth * 5}deg)", else: "rotateX(#{@depth * 5}deg)"};
             top: #{@depth * 15}px;
             left: #{@depth * 15}px;
             filter: hue-rotate(#{@depth * 30}deg) drop-shadow(0 0 #{5 + @depth * 2}px rgba(#{rem(@depth * 100, 255)}, #{rem(@depth * 50, 255)}, 255, 0.5));"}>
        <div class="bg-white/80 backdrop-blur-sm rounded-lg overflow-hidden border-2 border-gray-200
                    animate-pulse hover:animate-none
                    hover:border-indigo-500/50 hover:shadow-2xl hover:shadow-indigo-500/50
                    transition-all duration-300 group
                    hover:scale-105 hover:-translate-y-1
                    dark:bg-gray-800/80 dark:border-gray-700">
          <div class="absolute inset-0 bg-gradient-to-r from-cyan-500/30 to-purple-500/30 opacity-0 group-hover:opacity-100 transition-opacity"></div>

          <div class="p-6 relative z-10">
            <h3 class="text-xl font-bold text-gray-900 mb-2 group-hover:text-indigo-600 transition-colors
                       dark:text-white dark:group-hover:text-indigo-400
                       [text-shadow:_0_0_10px_rgb(99_102_241_/_50%)]">
              <%= @title %>
            </h3>

            <p class="text-gray-600 mb-4 dark:text-gray-300 group-hover:text-gray-800 dark:group-hover:text-gray-200">
              <%= @description %>
            </p>

            <div class="flex flex-wrap gap-2 mb-4">
              <%= for tech <- @tech_stack do %>
                <span class="px-3 py-1 bg-gray-100/80 text-gray-700 rounded-full text-sm
                           hover:scale-110 hover:rotate-3 transition-all duration-300
                           hover:bg-indigo-100 hover:text-indigo-700
                           dark:bg-gray-700/80 dark:text-gray-300">
                  <%= tech %>
                </span>
              <% end %>
            </div>

            <div class="flex gap-4">
              <%= if @github_url do %>
                <a href={@github_url}
                   class="text-gray-600 hover:text-indigo-600 transition-all duration-300
                          hover:scale-125 hover:rotate-12 hover:[filter:drop-shadow(0_0_10px_rgb(99_102_241_/_50%))]">
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
      </div>

      <%= if @depth < @max_depth do %>
        <.inception_card {assigns} depth={@depth + 1} />
      <% end %>
    </div>
    """
  end
end
