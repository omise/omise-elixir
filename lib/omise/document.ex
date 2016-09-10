defmodule Omise.Document do
  @moduledoc """
  Provides Document API interfaces.

  https://www.omise.co/documents-api
  """

  defstruct [
    object:   "document",
    id:       nil,
    livemode: nil,
    location: nil,
    filename: nil
  ]

  @type t :: %__MODULE__{
    object:   String.t,
    id:       String.t,
    livemode: boolean,
    location: String.t,
    filename: String.t
  }

  @endpoint "documents"

  @doc """
  List all disputes documents.

  Returns `{:ok, documents}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Document.list("dspt_test_53f77r87n5czrdwldvz")

      Omise.Document.list("dspt_test_53f77r87n5czrdwldvz", offset: 2)

  """
  @spec list(String.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(dispute_id, params \\ []) do
    Omise.HTTP.make_request(:get, "disputes/#{dispute_id}/#{@endpoint}", params: params, as: %Omise.List{data: [%__MODULE__{}]})
  end

  @doc """
  Retrieve a document.

  Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Document.retrieve("dspt_test_51yfnnpsxajeybpytm4", "docu_test_55a1e900ys2srz0xu2r")

  """
  @spec retrieve(String.t, String.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def retrieve(dispute_id, document_id) do
    Omise.HTTP.make_request(:get, "disputes/#{dispute_id}/#{@endpoint}/#{document_id}", as: %__MODULE__{})
  end

  @doc """
  Upload a document.

  Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

  Request Parameter:
    * `file` - (required) The file to upload. Valid files include PNG and JPG images and PDF files. The uploaded file should also includes metadata such as filename and content type.

  ## Examples

      Omise.Document.create("dspt_test_4zgf15h89w8t775kcm8", file: "pictures/screenshot.jpg")

  """
  @spec create(String.t, Keyword.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def create(dispute_id, params) do
    Omise.HTTP.make_request(:post, "disputes/#{dispute_id}/#{@endpoint}", body: {:multipart, params}, as: %__MODULE__{})
  end

  @doc """
  Destroy a document.

  Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Document.destroy("dspt_test_4zgf15h89w8t775kcm8", "docu_test_55a1e900ys2srz0xu2r")

  """
  @spec destroy(String.t, String.t) :: {:ok, __MODULE__.t} | {:error, Omise.Error.t}
  def destroy(dispute_id, document_id) do
    Omise.HTTP.make_request(:delete, "disputes/#{dispute_id}/#{@endpoint}/#{document_id}", as: %__MODULE__{})
  end
end
