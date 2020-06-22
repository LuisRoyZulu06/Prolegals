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

  describe "li_tbl_case" do
    alias Prolegals.Litigation.Cases

    @valid_attrs %{case_description: "some case_description", case_name: "some case_name", case_no: "some case_no", case_status: "some case_status", client: "some client", date_case_opened: "some date_case_opened", incident_date: "some incident_date", practice_area: "some practice_area", staff: "some staff"}
    @update_attrs %{case_description: "some updated case_description", case_name: "some updated case_name", case_no: "some updated case_no", case_status: "some updated case_status", client: "some updated client", date_case_opened: "some updated date_case_opened", incident_date: "some updated incident_date", practice_area: "some updated practice_area", staff: "some updated staff"}
    @invalid_attrs %{case_description: nil, case_name: nil, case_no: nil, case_status: nil, client: nil, date_case_opened: nil, incident_date: nil, practice_area: nil, staff: nil}

    def cases_fixture(attrs \\ %{}) do
      {:ok, cases} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Litigation.create_cases()

      cases
    end

    test "list_li_tbl_case/0 returns all li_tbl_case" do
      cases = cases_fixture()
      assert Litigation.list_li_tbl_case() == [cases]
    end

    test "get_cases!/1 returns the cases with given id" do
      cases = cases_fixture()
      assert Litigation.get_cases!(cases.id) == cases
    end

    test "create_cases/1 with valid data creates a cases" do
      assert {:ok, %Cases{} = cases} = Litigation.create_cases(@valid_attrs)
      assert cases.case_description == "some case_description"
      assert cases.case_name == "some case_name"
      assert cases.case_no == "some case_no"
      assert cases.case_status == "some case_status"
      assert cases.client == "some client"
      assert cases.date_case_opened == "some date_case_opened"
      assert cases.incident_date == "some incident_date"
      assert cases.practice_area == "some practice_area"
      assert cases.staff == "some staff"
    end

    test "create_cases/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Litigation.create_cases(@invalid_attrs)
    end

    test "update_cases/2 with valid data updates the cases" do
      cases = cases_fixture()
      assert {:ok, %Cases{} = cases} = Litigation.update_cases(cases, @update_attrs)
      assert cases.case_description == "some updated case_description"
      assert cases.case_name == "some updated case_name"
      assert cases.case_no == "some updated case_no"
      assert cases.case_status == "some updated case_status"
      assert cases.client == "some updated client"
      assert cases.date_case_opened == "some updated date_case_opened"
      assert cases.incident_date == "some updated incident_date"
      assert cases.practice_area == "some updated practice_area"
      assert cases.staff == "some updated staff"
    end

    test "update_cases/2 with invalid data returns error changeset" do
      cases = cases_fixture()
      assert {:error, %Ecto.Changeset{}} = Litigation.update_cases(cases, @invalid_attrs)
      assert cases == Litigation.get_cases!(cases.id)
    end

    test "delete_cases/1 deletes the cases" do
      cases = cases_fixture()
      assert {:ok, %Cases{}} = Litigation.delete_cases(cases)
      assert_raise Ecto.NoResultsError, fn -> Litigation.get_cases!(cases.id) end
    end

    test "change_cases/1 returns a cases changeset" do
      cases = cases_fixture()
      assert %Ecto.Changeset{} = Litigation.change_cases(cases)
    end
  end

  describe "li_tbl_tasks" do
    alias Prolegals.Litigation.Events

    @valid_attrs %{case: "some case", details: "some details", end_date: "some end_date", end_time: "some end_time", location: "some location", start_date: "some start_date", start_time: "some start_time", visibility: "some visibility"}
    @update_attrs %{case: "some updated case", details: "some updated details", end_date: "some updated end_date", end_time: "some updated end_time", location: "some updated location", start_date: "some updated start_date", start_time: "some updated start_time", visibility: "some updated visibility"}
    @invalid_attrs %{case: nil, details: nil, end_date: nil, end_time: nil, location: nil, start_date: nil, start_time: nil, visibility: nil}

    def events_fixture(attrs \\ %{}) do
      {:ok, events} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Litigation.create_events()

      events
    end

    test "list_li_tbl_tasks/0 returns all li_tbl_tasks" do
      events = events_fixture()
      assert Litigation.list_li_tbl_tasks() == [events]
    end

    test "get_events!/1 returns the events with given id" do
      events = events_fixture()
      assert Litigation.get_events!(events.id) == events
    end

    test "create_events/1 with valid data creates a events" do
      assert {:ok, %Events{} = events} = Litigation.create_events(@valid_attrs)
      assert events.case == "some case"
      assert events.details == "some details"
      assert events.end_date == "some end_date"
      assert events.end_time == "some end_time"
      assert events.location == "some location"
      assert events.start_date == "some start_date"
      assert events.start_time == "some start_time"
      assert events.visibility == "some visibility"
    end

    test "create_events/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Litigation.create_events(@invalid_attrs)
    end

    test "update_events/2 with valid data updates the events" do
      events = events_fixture()
      assert {:ok, %Events{} = events} = Litigation.update_events(events, @update_attrs)
      assert events.case == "some updated case"
      assert events.details == "some updated details"
      assert events.end_date == "some updated end_date"
      assert events.end_time == "some updated end_time"
      assert events.location == "some updated location"
      assert events.start_date == "some updated start_date"
      assert events.start_time == "some updated start_time"
      assert events.visibility == "some updated visibility"
    end

    test "update_events/2 with invalid data returns error changeset" do
      events = events_fixture()
      assert {:error, %Ecto.Changeset{}} = Litigation.update_events(events, @invalid_attrs)
      assert events == Litigation.get_events!(events.id)
    end

    test "delete_events/1 deletes the events" do
      events = events_fixture()
      assert {:ok, %Events{}} = Litigation.delete_events(events)
      assert_raise Ecto.NoResultsError, fn -> Litigation.get_events!(events.id) end
    end

    test "change_events/1 returns a events changeset" do
      events = events_fixture()
      assert %Ecto.Changeset{} = Litigation.change_events(events)
    end
  end

  describe "li_tbl_case_types" do
    alias Prolegals.Litigation.CaseType

    @valid_attrs %{category: "some category", description: "some description"}
    @update_attrs %{category: "some updated category", description: "some updated description"}
    @invalid_attrs %{category: nil, description: nil}

    def case_type_fixture(attrs \\ %{}) do
      {:ok, case_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Litigation.create_case_type()

      case_type
    end

    test "list_li_tbl_case_types/0 returns all li_tbl_case_types" do
      case_type = case_type_fixture()
      assert Litigation.list_li_tbl_case_types() == [case_type]
    end

    test "get_case_type!/1 returns the case_type with given id" do
      case_type = case_type_fixture()
      assert Litigation.get_case_type!(case_type.id) == case_type
    end

    test "create_case_type/1 with valid data creates a case_type" do
      assert {:ok, %CaseType{} = case_type} = Litigation.create_case_type(@valid_attrs)
      assert case_type.category == "some category"
      assert case_type.description == "some description"
    end

    test "create_case_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Litigation.create_case_type(@invalid_attrs)
    end

    test "update_case_type/2 with valid data updates the case_type" do
      case_type = case_type_fixture()
      assert {:ok, %CaseType{} = case_type} = Litigation.update_case_type(case_type, @update_attrs)
      assert case_type.category == "some updated category"
      assert case_type.description == "some updated description"
    end

    test "update_case_type/2 with invalid data returns error changeset" do
      case_type = case_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Litigation.update_case_type(case_type, @invalid_attrs)
      assert case_type == Litigation.get_case_type!(case_type.id)
    end

    test "delete_case_type/1 deletes the case_type" do
      case_type = case_type_fixture()
      assert {:ok, %CaseType{}} = Litigation.delete_case_type(case_type)
      assert_raise Ecto.NoResultsError, fn -> Litigation.get_case_type!(case_type.id) end
    end

    test "change_case_type/1 returns a case_type changeset" do
      case_type = case_type_fixture()
      assert %Ecto.Changeset{} = Litigation.change_case_type(case_type)
    end
  end

  describe "li_tbl_business_categories" do
    alias Prolegals.Litigation.BusinessCategory

    @valid_attrs %{business_nature: "some business_nature", business_type: "some business_type"}
    @update_attrs %{business_nature: "some updated business_nature", business_type: "some updated business_type"}
    @invalid_attrs %{business_nature: nil, business_type: nil}

    def business_category_fixture(attrs \\ %{}) do
      {:ok, business_category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Litigation.create_business_category()

      business_category
    end

    test "list_li_tbl_business_categories/0 returns all li_tbl_business_categories" do
      business_category = business_category_fixture()
      assert Litigation.list_li_tbl_business_categories() == [business_category]
    end

    test "get_business_category!/1 returns the business_category with given id" do
      business_category = business_category_fixture()
      assert Litigation.get_business_category!(business_category.id) == business_category
    end

    test "create_business_category/1 with valid data creates a business_category" do
      assert {:ok, %BusinessCategory{} = business_category} = Litigation.create_business_category(@valid_attrs)
      assert business_category.business_nature == "some business_nature"
      assert business_category.business_type == "some business_type"
    end

    test "create_business_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Litigation.create_business_category(@invalid_attrs)
    end

    test "update_business_category/2 with valid data updates the business_category" do
      business_category = business_category_fixture()
      assert {:ok, %BusinessCategory{} = business_category} = Litigation.update_business_category(business_category, @update_attrs)
      assert business_category.business_nature == "some updated business_nature"
      assert business_category.business_type == "some updated business_type"
    end

    test "update_business_category/2 with invalid data returns error changeset" do
      business_category = business_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Litigation.update_business_category(business_category, @invalid_attrs)
      assert business_category == Litigation.get_business_category!(business_category.id)
    end

    test "delete_business_category/1 deletes the business_category" do
      business_category = business_category_fixture()
      assert {:ok, %BusinessCategory{}} = Litigation.delete_business_category(business_category)
      assert_raise Ecto.NoResultsError, fn -> Litigation.get_business_category!(business_category.id) end
    end

    test "change_business_category/1 returns a business_category changeset" do
      business_category = business_category_fixture()
      assert %Ecto.Changeset{} = Litigation.change_business_category(business_category)
    end
  end
end
