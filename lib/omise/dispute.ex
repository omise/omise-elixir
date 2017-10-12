defmodule Omise.Dispute do
  @moduledoc ~S"""
  Provides Dispute API interfaces.

  <https://www.omise.co/disputes-api>
  """

  # use Omise.Document, resource: "disputes"

  use Omise.HTTPClient, endpoint: "disputes"

  @doc ~S"""
  List all disputes.

  Returns `{:ok, disputes}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:
    * `offset` - (optional, default: 0) The offset of the first record returned.
    * `limit` - (optional, default: 20, maximum: 100) The maximum amount of records returned.
    * `from` - (optional, default: 1970-01-01T00:00:00Z, format: ISO 8601) The UTC date and time limiting the beginning of returned records.
    * `to` - (optional, default: current UTC Datetime, format: ISO 8601) The UTC date and time limiting the end of returned records.

  ## Examples
      # List all disputes
      Omise.Dispute.list

      # List all open disputes
      Omise.Dispute.list(status: "open")

      # List all pending disputes
      Omise.Dispute.list(status: "pending")

      # List all closed disputes
      Omise.Dispute.list(status: "closed")

  """
  @spec list(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def list(params \\ [], options \\ []) do
    status = params[:status] || ""
    get("#{@endpoint}/#{status}", params, options)
  end

  @doc ~S"""
  Retrieve a dispute.

  Returns `{:ok, dispute}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Dispute.retrieve("dspt_test_51yfnnpsxajeybpytm4")

  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve(id, options \\ []) do
    get("#{@endpoint}/#{id}", [], options)
  end

  @doc ~S"""
  Update a dispute.

  Returns `{:ok, dispute}` if the request is successful, `{:error, error}` otherwise.

  Request Parameter:
    * `message` - The new dispute message.

  ## Examples

      Omise.Dispute.update("dspt_test_4zgf15h89w8t775kcm8", message: "Shut up and dance with me!")

  """
  @spec update(String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def update(id, params, options \\ []) do
    put("#{@endpoint}/#{id}", params, options)
  end

  @doc ~S"""
  Search all the disputes.

  Returns `{:ok, disputes}` if the request is successful, `{:error, error}` otherwise.

  ## Query Parameters:

      <https://www.omise.co/search-query-and-filters>

  ## Examples

      Omise.Dispute.search(filters: [status: "pending"])

      Omise.Dispute.search(query: "dspt_5089off452g5m5te7xs")

  """
  @spec search(Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def search(params \\ [], options \\ []) do
    Omise.Search.execute("dispute", params, options)
  end

  @doc ~S"""
  List all dispute documents.

  Returns `{:ok, documents}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Dispute.list_documents("dspt_5089off452g5m5te7xs")

  """
  @spec list_documents(String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def list_documents(id, params \\ [], options \\ []) do
    get("#{@endpoint}/#{id}/documents", params, options)
  end

  @doc ~S"""
  Retrieve a dispute document.

  Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Dispute.retrieve_document("dspt_test_55aj9q9iipt3tcdwb5r", "docu_test_55alwcu1phxmsxx3y9p")

  """
  @spec retrieve_document(String.t, String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def retrieve_document(id, document_id, options \\ []) do
    get("#{@endpoint}/#{id}/documents/#{document_id}", [], options)
  end

  @doc ~S"""
  Upload a document.

  Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

  Request Parameter:
    * `file` - (required) The file to upload. Valid files include PNG and JPG images and PDF files. The uploaded file should also includes metadata such as filename and content type.

  ## Examples

      Omise.Dispute.upload_document("dspt_test_4zgf15h89w8t775kcm8", file: "rick-and-morty.jpg")

  """
  @spec upload_document(String.t, Keyword.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def upload_document(id, params \\ [], options \\ []) do
    post("#{@endpoint}/#{id}/documents", {:multipart, params}, options)
  end

  @doc ~S"""
  Destroy a document.

  Returns `{:ok, document}` if the request is successful, `{:error, error}` otherwise.

  ## Examples

      Omise.Dispute.destroy_document("dspt_test_4zgf15h89w8t775kcm8", "docu_test_55alwcu1phxmsxx3y9p")

  """
  @spec destroy_document(String.t, String.t, Keyword.t) :: {:ok, struct} | {:error, Omise.Error.t}
  def destroy_document(id, document_id, options \\ []) do
    delete("#{@endpoint}/#{id}/documents/#{document_id}", options)
  end
end
