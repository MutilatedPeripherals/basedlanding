defmodule BasedLandingWeb.ErrorJSONTest do
  use BasedLandingWeb.ConnCase, async: true

  test "renders 404" do
    assert BasedLandingWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert BasedLandingWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
