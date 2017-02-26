defmodule Omise.Document do
  @moduledoc ~S"""
  Provides Document API interfaces.

  https://www.omise.co/documents-api
  """

  import Omise.HTTP

  defstruct [
    object:   "document",
    id:       nil,
    livemode: nil,
    location: nil,
    filename: nil,
    deleted:  nil
  ]

  @type t :: %__MODULE__{
    object:   String.t,
    id:       String.t,
    livemode: boolean,
    location: String.t,
    filename: String.t,
    deleted:  boolean
  }

  @endpoint "documents"

  defmacro __using__(opts) do
    quote do
      @resource unquote(opts)[:resource] || raise "document expects :resource to be given"
      @document unquote(__MODULE__)

      @doc ~S"""
      List all documents.

      Returns `{:ok, documents}` if the request is successful, `{:error, error}` otherwise.

      ## Query Parameters:
        * `offset` - (optional, default: 0) The offset of the first record returned.
        * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
        * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
        * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

      """
      @spec list_documents(String.t, Keyword.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
      def list_documents(resource_id, params \\ [], opts \\ []) do
        @document.list(resource_path(resource_id), params, opts)
      end

      @doc ~S"""
      Retrieve a document.

      Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

      """
      @spec retrieve_document(String.t, String.t, Keyword.t) :: {:ok, @document.t} | {:error, Omise.Error.t}
      def retrieve_document(resource_id, document_id, opts \\ []) do
        @document.retrieve(resource_path(resource_id), document_id, opts)
      end

      @doc ~S"""
      Upload a document.

      Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

      Request Parameter:
        * `file` - (required) The file to upload. Valid files include PNG and JPG images and PDF files. The uploaded file should also includes metadata such as filename and content type.

      """
      @spec upload_document(String.t, Keyword.t, Keyword.t) :: {:ok, @document.t} | {:error, Omise.Error.t}
      def upload_document(resource_id, params, opts \\ []) do
        @document.create(resource_path(resource_id), params, opts)
      end

      @doc ~S"""
      Destroy a document.

      Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

      """
      @spec destroy_document(String.t, String.t, Keyword.t) :: {:ok, @document.t} | {:error, Omise.Error.t}
      def destroy_document(resource_id, document_id, opts \\ []) do
        @document.destroy(resource_path(resource_id), document_id, opts)
      end

      defp resource_path(id) do
        "#{@resource}/#{id}"
      end
    end
  end

  @doc ~S"""
  List all documents.

  Returns `{:ok, documents}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples

      Omise.Document.list("disputes/dspt_test_53f77r87n5czrdwldvz")

      Omise.Document.list("disputes/dspt_test_53f77r87n5czrdwldvz", offset: 2)

  """
  @spec list(String.t, Keyword.t, Keyword.t) :: {:ok, Omise.List.t} | {:error, Omise.Error.t}
  def list(path, params \\ [], opts \\ []) do
    opts = Keyword.merge(opts, as: %Omise.List{data: [%__MODULE__{}]})
    get("#{path}/#{@endpoint}", params, opts)
  end

  @doc ~S"""
  Retrieve a document.

  Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Document.retrieve("disputes/dspt_test_51yfnnpsxajeybpytm4", "docu_test_55a1e900ys2srz0xu2r")

  """
  @spec retrieve(String.t, String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def retrieve(path, id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    get("#{path}/#{@endpoint}/#{id}", [], opts)
  end

  @doc ~S"""
  Upload a document.

  Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

  Request Parameter:
    * `file` - (required) The file to upload. Valid files include PNG and JPG images and PDF files. The uploaded file should also includes metadata such as filename and content type.

  ## Examples

      Omise.Document.create("disputes/dspt_test_4zgf15h89w8t775kcm8", file: "pictures/screenshot.jpg")

  """
  @spec create(String.t, Keyword.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def create(path, params, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    post("#{path}/#{@endpoint}", params, opts)
  end

  @doc ~S"""
  Destroy a document.

  Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Document.destroy("disputes/dspt_test_4zgf15h89w8t775kcm8", "docu_test_55a1e900ys2srz0xu2r")

  """
  @spec destroy(String.t, String.t, Keyword.t) :: {:ok, t} | {:error, Omise.Error.t}
  def destroy(path, id, opts \\ []) do
    opts = Keyword.merge(opts, as: %__MODULE__{})
    delete("#{path}/#{@endpoint}/#{id}", opts)
  end
end
