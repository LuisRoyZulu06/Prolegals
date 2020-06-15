defmodule Prolegals.LitigationTest do
  use Prolegals.DataCase

  alias Prolegals.Litigation

  describe "li_tbl_contacts" do
    alias Prolegals.Litigation.Contacts

    @valid_attrs %{"bus_category,": "some bus_category,", "city,": "some city,", "company_name,": "some company_name,", "compnay_rep,": "some compnay_rep,", "contact_type,": "some contact_type,", country: "some country", "email,": "some email,", "fax,": "some fax,", "id_no,": "some id_no,", "id_type,": "some id_type,", "job_title,": "some job_title,", "name,": "some name,", "phone,": "some phone,", "tel,": "some tel,"}
    @update_attrs %{"bus_category,": "some updated bus_category,", "city,": "some updated city,", "company_name,": "some updated company_name,", "compnay_rep,": "some updated compnay_rep,", "contact_type,": "some updated contact_type,", country: "some updated country", "email,": "some updated email,", "fax,": "some updated fax,", "id_no,": "some updated id_no,", "id_type,": "some updated id_type,", "job_title,": "some updated job_title,", "name,": "some updated name,", "phone,": "some updated phone,", "tel,": "some updated tel,"}
    @invalid_attrs %{"bus_category,": nil, "city,": nil, "company_name,": nil, "compnay_rep,": nil, "contact_type,": nil, country: nil, "email,": nil, "fax,": nil, "id_no,": nil, "id_type,": nil, "job_title,": nil, "name,": nil, "phone,": nil, "tel,": nil}

    def contacts_fixture(attrs \\ %{}) do
      {:ok, contacts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Litigation.create_contacts()

      contacts
    end

    test "list_li_tbl_contacts/0 returns all li_tbl_contacts" do
      contacts = contacts_fixture()
      assert Litigation.list_li_tbl_contacts() == [contacts]
    end

    test "get_contacts!/1 returns the contacts with given id" do
      contacts = contacts_fixture()
      assert Litigation.get_contacts!(contacts.id) == contacts
    end

    test "create_contacts/1 with valid data creates a contacts" do
      assert {:ok, %Contacts{} = contacts} = Litigation.create_contacts(@valid_attrs)
      assert contacts.bus_category, == "some bus_category,"
      assert contacts.city, == "some city,"
      assert contacts.company_name, == "some company_name,"
      assert contacts.compnay_rep, == "some compnay_rep,"
      assert contacts.contact_type, == "some contact_type,"
      assert contacts.country == "some country"
      assert contacts.email, == "some email,"
      assert contacts.fax, == "some fax,"
      assert contacts.id_no, == "some id_no,"
      assert contacts.id_type, == "some id_type,"
      assert contacts.job_title, == "some job_title,"
      assert contacts.name, == "some name,"
      assert contacts.phone, == "some phone,"
      assert contacts.tel, == "some tel,"
    end

    test "create_contacts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Litigation.create_contacts(@invalid_attrs)
    end

    test "update_contacts/2 with valid data updates the contacts" do
      contacts = contacts_fixture()
      assert {:ok, %Contacts{} = contacts} = Litigation.update_contacts(contacts, @update_attrs)
      assert contacts.bus_category, == "some updated bus_category,"
      assert contacts.city, == "some updated city,"
      assert contacts.company_name, == "some updated company_name,"
      assert contacts.compnay_rep, == "some updated compnay_rep,"
      assert contacts.contact_type, == "some updated contact_type,"
      assert contacts.country == "some updated country"
      assert contacts.email, == "some updated email,"
      assert contacts.fax, == "some updated fax,"
      assert contacts.id_no, == "some updated id_no,"
      assert contacts.id_type, == "some updated id_type,"
      assert contacts.job_title, == "some updated job_title,"
      assert contacts.name, == "some updated name,"
      assert contacts.phone, == "some updated phone,"
      assert contacts.tel, == "some updated tel,"
    end

    test "update_contacts/2 with invalid data returns error changeset" do
      contacts = contacts_fixture()
      assert {:error, %Ecto.Changeset{}} = Litigation.update_contacts(contacts, @invalid_attrs)
      assert contacts == Litigation.get_contacts!(contacts.id)
    end

    test "delete_contacts/1 deletes the contacts" do
      contacts = contacts_fixture()
      assert {:ok, %Contacts{}} = Litigation.delete_contacts(contacts)
      assert_raise Ecto.NoResultsError, fn -> Litigation.get_contacts!(contacts.id) end
    end

    test "change_contacts/1 returns a contacts changeset" do
      contacts = contacts_fixture()
      assert %Ecto.Changeset{} = Litigation.change_contacts(contacts)
    end
  end

  describe "li_tbl_contacts" do
    alias Prolegals.Litigation.Contacts

    @valid_attrs %{bus_category: "some bus_category", city: "some city", company_name: "some company_name", compnay_rep: "some compnay_rep", contact_type: "some contact_type", country: "some country", email: "some email", fax: "some fax", id_no: "some id_no", id_type: "some id_type", job_title: "some job_title", name: "some name", phone: "some phone", tel: "some tel"}
    @update_attrs %{bus_category: "some updated bus_category", city: "some updated city", company_name: "some updated company_name", compnay_rep: "some updated compnay_rep", contact_type: "some updated contact_type", country: "some updated country", email: "some updated email", fax: "some updated fax", id_no: "some updated id_no", id_type: "some updated id_type", job_title: "some updated job_title", name: "some updated name", phone: "some updated phone", tel: "some updated tel"}
    @invalid_attrs %{bus_category: nil, city: nil, company_name: nil, compnay_rep: nil, contact_type: nil, country: nil, email: nil, fax: nil, id_no: nil, id_type: nil, job_title: nil, name: nil, phone: nil, tel: nil}

    def contacts_fixture(attrs \\ %{}) do
      {:ok, contacts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Litigation.create_contacts()

      contacts
    end

    test "list_li_tbl_contacts/0 returns all li_tbl_contacts" do
      contacts = contacts_fixture()
      assert Litigation.list_li_tbl_contacts() == [contacts]
    end

    test "get_contacts!/1 returns the contacts with given id" do
      contacts = contacts_fixture()
      assert Litigation.get_contacts!(contacts.id) == contacts
    end

    test "create_contacts/1 with valid data creates a contacts" do
      assert {:ok, %Contacts{} = contacts} = Litigation.create_contacts(@valid_attrs)
      assert contacts.bus_category == "some bus_category"
      assert contacts.city == "some city"
      assert contacts.company_name == "some company_name"
      assert contacts.compnay_rep == "some compnay_rep"
      assert contacts.contact_type == "some contact_type"
      assert contacts.country == "some country"
      assert contacts.email == "some email"
      assert contacts.fax == "some fax"
      assert contacts.id_no == "some id_no"
      assert contacts.id_type == "some id_type"
      assert contacts.job_title == "some job_title"
      assert contacts.name == "some name"
      assert contacts.phone == "some phone"
      assert contacts.tel == "some tel"
    end

    test "create_contacts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Litigation.create_contacts(@invalid_attrs)
    end

    test "update_contacts/2 with valid data updates the contacts" do
      contacts = contacts_fixture()
      assert {:ok, %Contacts{} = contacts} = Litigation.update_contacts(contacts, @update_attrs)
      assert contacts.bus_category == "some updated bus_category"
      assert contacts.city == "some updated city"
      assert contacts.company_name == "some updated company_name"
      assert contacts.compnay_rep == "some updated compnay_rep"
      assert contacts.contact_type == "some updated contact_type"
      assert contacts.country == "some updated country"
      assert contacts.email == "some updated email"
      assert contacts.fax == "some updated fax"
      assert contacts.id_no == "some updated id_no"
      assert contacts.id_type == "some updated id_type"
      assert contacts.job_title == "some updated job_title"
      assert contacts.name == "some updated name"
      assert contacts.phone == "some updated phone"
      assert contacts.tel == "some updated tel"
    end

    test "update_contacts/2 with invalid data returns error changeset" do
      contacts = contacts_fixture()
      assert {:error, %Ecto.Changeset{}} = Litigation.update_contacts(contacts, @invalid_attrs)
      assert contacts == Litigation.get_contacts!(contacts.id)
    end

    test "delete_contacts/1 deletes the contacts" do
      contacts = contacts_fixture()
      assert {:ok, %Contacts{}} = Litigation.delete_contacts(contacts)
      assert_raise Ecto.NoResultsError, fn -> Litigation.get_contacts!(contacts.id) end
    end

    test "change_contacts/1 returns a contacts changeset" do
      contacts = contacts_fixture()
      assert %Ecto.Changeset{} = Litigation.change_contacts(contacts)
    end
  end
end
