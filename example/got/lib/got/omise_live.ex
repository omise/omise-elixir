defmodule GOT.OmiseLive do
  def create_charge(params) do
    Omise.Charges.create(
      currency: "thb",
      amount: params[:amount],
      description: params[:description],
      card: params[:card]
    )
  end
end
