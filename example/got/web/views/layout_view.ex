defmodule GOT.LayoutView do
  use GOT.Web, :view

  def omise_public_key do
    Application.get_env(:omise, :public_key)
  end
end
