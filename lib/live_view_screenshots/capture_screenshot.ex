defmodule LiveViewScreenshots.CaptureScreenshot do
  @moduledoc """
  Functionality to capture LiveView screenshots for debugging.
  """
  alias LiveViewScreenshots.Server

  @doc """
  Captures a screenshot of a LiveView under test.

  ## Examples

      defmodule MyAppWeb.PageLiveTest do
        use MyAppWeb, :live_view
        import LiveViewScreenshots.CaptureScreenshot

        test "a thousand words", %{conn: conn} end
          {:ok, view, _} = live(conn, "/")
          assert render(view) =~ "Welcome to Phoenix!"

          capture_screenshot(view, "screenshot.png")
        end
      end
  """
  def capture_screenshot(view_or_element, path) do
    capture_screenshot(LiveViewScreenshots, view_or_element, path)
  end

  @doc """
  See `capture_screenshot/2` for options.
  """
  def capture_screenshot(server, view_or_element, path) when is_atom(server) do
    Phoenix.LiveViewTest.open_browser(
      view_or_element,
      &Server.capture_screenshot(server, path, &1, [])
    )
  end
end