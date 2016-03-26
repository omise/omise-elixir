defmodule GOT.PageView do
  use GOT.Web, :view

  def year_range do
    {{year, _, _}, _} = :calendar.local_time
    year..(year + 10)
  end

  def noble_houses do
    ["House Stark": "house_stark",
     "House Targaryen": "house_targaryen",
     "House Lanister": "house_lanister"]
  end

  def amounts do
    ["500 BTH": 500_00, "1,000 BTH": 1000_00, "5,000 BTH": 5000_00]
  end
end
