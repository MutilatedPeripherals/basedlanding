# lib/based_landing_web/live/melt_gpu_live.ex
defmodule BasedLandingWeb.MeltGpuLive do
  use BasedLandingWeb, :live_view

  # Update every 16ms (60fps) - RIP GPU
  @tick_rate 16
  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(@tick_rate, self(), :tick)
    end

    # Initialize particles
    particles = for _i <- 1..50 do
      %{
        x: :rand.uniform(100),
        y: :rand.uniform(100),
        size: :rand.uniform(10) + 5,
        hue: :rand.uniform(360),
        rotation: :rand.uniform(360)
      }
    end

    {:ok, assign(socket, %{
      background_pos: 0,
      mouse_x: 50,
      mouse_y: 50,
      time: 0,
      blur_intensity: 0,
      tick_rate: @tick_rate,
      particles: particles
    })}
  end

  def handle_info(:tick, socket) do
    # Update background position and time
    socket = socket
    |> update(:time, &(&1 + 1))
    |> update(:background_pos, &(rem(&1 + 1, 360)))

    {:noreply, socket}
  end

  def handle_event("mousemove", %{"clientX" => x, "clientY" => y}, socket) do
    # Get window dimensions from the event or use viewport size
    viewport_width = 1920  # You might want to make this dynamic
    viewport_height = 1080 # You might want to make this dynamic

    x_percent = x * 100 / viewport_width
    y_percent = y * 100 / viewport_height

    {:noreply, assign(socket, mouse_x: x_percent, mouse_y: y_percent)}
  end

  def render(assigns) do
    ~H"""
    <div class="relative w-screen h-screen overflow-hidden"
         phx-window-mousemove="mousemove">

      <!-- Psychedelic background with multiple animated gradients -->
      <div class="absolute inset-0 transition-all duration-100"
           style={"background:
             linear-gradient(#{@background_pos}deg,
               rgba(255,0,255,0.5),
               rgba(0,255,255,0.5)),
             radial-gradient(circle at #{@mouse_x}% #{@mouse_y}%,
               hsl(#{rem(@time, 360)}, 70%, 50%),
               hsl(#{rem(@time + 120, 360)}, 70%, 50%));
             filter: blur(#{@blur_intensity}px) contrast(150%) brightness(150%);
             transform: scale(1.1);"}>
      </div>

      <!-- MAXIMUM PARTICLES -->
      <%= for particle <- @particles do %>
        <div class="absolute rounded-full animate-pulse"
             style={"left: #{particle.x}%;
                    top: #{particle.y}%;
                    width: #{particle.size}px;
                    height: #{particle.size}px;
                    background: hsl(#{particle.hue}, 70%, 50%);
                    box-shadow: 0 0 #{particle.size * 2}px hsl(#{particle.hue}, 70%, 50%);
                    transform: rotate(#{particle.rotation}deg) scale(#{1 + :math.sin(@time / 1000) * 0.2});
                    transition: all #{@tick_rate}ms linear;"}>
        </div>
      <% end %>

      <!-- Title with text distortion effect -->
      <div class="absolute inset-0 flex flex-col items-center justify-center">
        <h1 class="text-8xl font-bold text-white mix-blend-overlay"
            style={"text-shadow:
                   3px 3px 0 #ff0000,
                   -3px -3px 0 #00ff00,
                   6px 6px 0 #0000ff;
                   animation: textDistort #{@tick_rate}ms infinite;
                   transform: scale(#{1 + :math.sin(@time / 500) * 0.1})
                            rotate(#{:math.sin(@time / 1000) * 5}deg);"}>
          Based Solutions
        </h1>

        <!-- Your thermostat component with added chaos -->
        <div class="mt-8 transform transition-transform duration-100"
             style={"transform: rotate(#{:math.sin(@time / 800) * 10}deg)
                    scale(#{1 + :math.sin(@time / 600) * 0.2});"}>
          <%= live_render(@socket, BasedLandingWeb.ThermostatLive) %>
        </div>
      </div>

      <!-- CSS Animations -->
      <style>
        @keyframes textDistort {
          0% { filter: hue-rotate(0deg) saturate(100%); }
          50% { filter: hue-rotate(180deg) saturate(200%); }
          100% { filter: hue-rotate(360deg) saturate(100%); }
        }

        /* Force hardware acceleration */
        * {
          backface-visibility: hidden;
          perspective: 1000;
          transform-style: preserve-3d;
          will-change: transform, opacity, filter, background, box-shadow;
        }
      </style>
    </div>
    """
  end
end
