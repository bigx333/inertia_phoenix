defmodule InertiaPhoenix.Controller do

  def render_inertia(%{assigns: %{inertia_request: inertia_request}} = conn, component, assigns) when inertia_request == true do
    IO.puts("x-intertia is true")
    Phoenix.Controller.json(conn, page_json(conn, component, assigns))
  end

  def render_inertia(conn, component, assigns) do
    IO.puts("regular render")
    assigns = [{:component, component} | assigns]
    conn
    |> Phoenix.Controller.put_view(InertiaPhoenix.View)
    |> Phoenix.Controller.render("inertia.html", assigns)
  end

  defp page_json(conn, component, assigns) do
    assigns_map = Enum.into(assigns, %{})
    %{
      component: component,
      props: assigns_map.props,
      url: conn.request_path,
      version: "1.0"
    }
  end

end
