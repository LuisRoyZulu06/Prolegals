defmodule Prolegals.ClientTest do
  use Prolegals.DataCase

  alias Prolegals.Client

  describe "cl_tbl_messages" do
    alias Prolegals.Client.Messages

    @valid_attrs %{case_link: "some case_link", messages: "some messages", recipient: "some recipient", sender: "some sender", status: "some status", subject: "some subject"}
    @update_attrs %{case_link: "some updated case_link", messages: "some updated messages", recipient: "some updated recipient", sender: "some updated sender", status: "some updated status", subject: "some updated subject"}
    @invalid_attrs %{case_link: nil, messages: nil, recipient: nil, sender: nil, status: nil, subject: nil}

    def messages_fixture(attrs \\ %{}) do
      {:ok, messages} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Client.create_messages()

      messages
    end

    test "list_cl_tbl_messages/0 returns all cl_tbl_messages" do
      messages = messages_fixture()
      assert Client.list_cl_tbl_messages() == [messages]
    end

    test "get_messages!/1 returns the messages with given id" do
      messages = messages_fixture()
      assert Client.get_messages!(messages.id) == messages
    end

    test "create_messages/1 with valid data creates a messages" do
      assert {:ok, %Messages{} = messages} = Client.create_messages(@valid_attrs)
      assert messages.case_link == "some case_link"
      assert messages.messages == "some messages"
      assert messages.recipient == "some recipient"
      assert messages.sender == "some sender"
      assert messages.status == "some status"
      assert messages.subject == "some subject"
    end

    test "create_messages/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Client.create_messages(@invalid_attrs)
    end

    test "update_messages/2 with valid data updates the messages" do
      messages = messages_fixture()
      assert {:ok, %Messages{} = messages} = Client.update_messages(messages, @update_attrs)
      assert messages.case_link == "some updated case_link"
      assert messages.messages == "some updated messages"
      assert messages.recipient == "some updated recipient"
      assert messages.sender == "some updated sender"
      assert messages.status == "some updated status"
      assert messages.subject == "some updated subject"
    end

    test "update_messages/2 with invalid data returns error changeset" do
      messages = messages_fixture()
      assert {:error, %Ecto.Changeset{}} = Client.update_messages(messages, @invalid_attrs)
      assert messages == Client.get_messages!(messages.id)
    end

    test "delete_messages/1 deletes the messages" do
      messages = messages_fixture()
      assert {:ok, %Messages{}} = Client.delete_messages(messages)
      assert_raise Ecto.NoResultsError, fn -> Client.get_messages!(messages.id) end
    end

    test "change_messages/1 returns a messages changeset" do
      messages = messages_fixture()
      assert %Ecto.Changeset{} = Client.change_messages(messages)
    end
  end

  describe "cl_tbl_documents" do
    alias Prolegals.Client.Documents

    @valid_attrs %{description: "some description", document: "some document", document_filename: "some document_filename", mobile: "some mobile", sender: "some sender"}
    @update_attrs %{description: "some updated description", document: "some updated document", document_filename: "some updated document_filename", mobile: "some updated mobile", sender: "some updated sender"}
    @invalid_attrs %{description: nil, document: nil, document_filename: nil, mobile: nil, sender: nil}

    def documents_fixture(attrs \\ %{}) do
      {:ok, documents} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Client.create_documents()

      documents
    end

    test "list_cl_tbl_documents/0 returns all cl_tbl_documents" do
      documents = documents_fixture()
      assert Client.list_cl_tbl_documents() == [documents]
    end

    test "get_documents!/1 returns the documents with given id" do
      documents = documents_fixture()
      assert Client.get_documents!(documents.id) == documents
    end

    test "create_documents/1 with valid data creates a documents" do
      assert {:ok, %Documents{} = documents} = Client.create_documents(@valid_attrs)
      assert documents.description == "some description"
      assert documents.document == "some document"
      assert documents.document_filename == "some document_filename"
      assert documents.mobile == "some mobile"
      assert documents.sender == "some sender"
    end

    test "create_documents/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Client.create_documents(@invalid_attrs)
    end

    test "update_documents/2 with valid data updates the documents" do
      documents = documents_fixture()
      assert {:ok, %Documents{} = documents} = Client.update_documents(documents, @update_attrs)
      assert documents.description == "some updated description"
      assert documents.document == "some updated document"
      assert documents.document_filename == "some updated document_filename"
      assert documents.mobile == "some updated mobile"
      assert documents.sender == "some updated sender"
    end

    test "update_documents/2 with invalid data returns error changeset" do
      documents = documents_fixture()
      assert {:error, %Ecto.Changeset{}} = Client.update_documents(documents, @invalid_attrs)
      assert documents == Client.get_documents!(documents.id)
    end

    test "delete_documents/1 deletes the documents" do
      documents = documents_fixture()
      assert {:ok, %Documents{}} = Client.delete_documents(documents)
      assert_raise Ecto.NoResultsError, fn -> Client.get_documents!(documents.id) end
    end

    test "change_documents/1 returns a documents changeset" do
      documents = documents_fixture()
      assert %Ecto.Changeset{} = Client.change_documents(documents)
    end
  end
end
