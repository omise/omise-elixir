defmodule Omise.Schedule do
  @moduledoc ~S"""
  Provides Schedule API interfaces.

  <https://www.omise.co/schedules-api>
  """

  import Omise.HTTP

  defstruct [
    object:                "schedule",
    id:                    nil,
    livemode:              nil,
    location:              nil,
    status:                nil,
    deleted:               nil,
    every:                 nil,
    period:                nil,
    on:                    nil,
    in_words:              nil,
    start_date:            nil,
    end_date:              nil,
    charge:                %{},
    occurrences:           %Omise.List{data: [%Omise.Occurrence{}]},
    next_occurrence_dates: nil,
    created:               nil,
  ]

  @type t :: %__MODULE__{
    object:                String.t,
    id:                    String.t,
    livemode:              boolean,
    location:              String.t,
    status:                String.t,
    deleted:               boolean,
    every:                 integer,
    period:                String.t,
    on:                    map,
    in_words:              String.t,
    start_date:            String.t,
    end_date:              String.t,
    charge:                map,
    occurrences:           Omise.List.t,
    next_occurrence_dates: list,
    created:               String.t,
  }

  @endpoint "schedules"

  @doc ~S"""
  List all schedules.

  Returns `{:ok, schedules}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Schedule.list(limit: 10)

  """
  @spec list(Keyword.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%__MODULE__{}]})
    get(@endpoint, params, opts)
  end

  @doc ~S"""
  List all occurrences of a schedule.

  Returns `{:ok, occurrences}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Schedule.list_occurrences("schd_test_584yqgiuavbzrfng7mv")

  """
  @spec list_occurrences(String.t, Keyword.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list_occurrences(id, params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%Omise.Occurrence{}]})
    get("#{@endpoint}/#{id}/occurrences", params, opts)
  end

  @doc ~S"""
  Retrieve a schedule.

  ## Examples

      Omise.Schedule.retrieve("schd_test_5850ga4l8a6r6bgj4oj")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{@endpoint}/#{id}", [], opts)
  end

  @doc ~S"""
  Create a schedule.

  Returns `{:ok, schedule}` if the request is successful, `{:error, error}` otherwise.

  ## Request Parameters:
    * `every` - How often the schedule runs. E.g.: Every `3` weeks.
    * `period` - `day`, `week` or `month`. E.g.: Every 3 `week`s.
    * `on` - This hash keys depend on the period.
    * `start_date` - (optional) When the schedule should start, in ISO 8601 format (YYYY-MM-DD). Defaults to today.
    * `end_date` - When the schedule should end, in ISO 8601 format (YYYY-MM-DD).
    * `capture` - (optional) Whether or not you want the charge to be captured right away, when not specified it is set to true.
    * `charge` - A charge hash.

  ## Examples

      # Charge a specific customer card every 2 days
      Omise.Schedule.create(
        every: 2,
        period: "day",
        start_date: "2017-06-5",
        end_date: "2018-05-01",
        charge: [
          customer: "cust_test_55c6cjwyr9kl4rt4jso",
          amount: 199_00,
          description: "Membership fee",
        ]
      )

      # Charge every Monday and Friday
      Omise.Schedule.create(
        every: 1,
        period: "week",
        on: [
          weekdays: ["monday", "friday"]
        ],
        start_date: "2017-06-5",
        end_date: "2018-05-01",
        charge: [
          customer: "cust_test_55c6cjwyr9kl4rt4jso",
          amount: 199_00,
          description: "Membership fee",
        ]
      )

      # Charge on the 1st, 10th and 15th every 3 months
      Omise.Schedule.create(
        every: 3,
        period: "month",
        on: [
          days_of_month: [1, 10, 15]
        ],
        start_date: "2017-06-5",
        end_date: "2018-05-01",
        charge: [
          customer: "cust_test_55c6cjwyr9kl4rt4jso",
          amount: 199_00,
          description: "Membership fee",
        ]
      )

      # Charge on the 2nd Monday every month
      Omise.Schedule.create(
        every: 1,
        period: "month",
        on: [
          weekday_of_month: "second_monday"
        ],
        start_date: "2017-06-5",
        end_date: "2018-05-01",
        charge: [
          customer: "cust_test_55c6cjwyr9kl4rt4jso",
          amount: 199_00,
          description: "Membership fee",
        ]
      )

  """
  @spec create(Keyword.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def create(params, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    post(@endpoint, params, opts)
  end

  @doc ~S"""
  Destroy a schedule.

  Returns `{:ok, schedule}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Schedule.destroy("schd_test_584yqgiuavbzrfng7mv")

  """
  @spec destroy(String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def destroy(id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    delete("#{@endpoint}/#{id}", opts)
  end
end
