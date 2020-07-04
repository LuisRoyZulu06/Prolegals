defmodule Prolegals.Emails.Email do
  import Bamboo.Email
  alias Prolegals.Emails.Mailer
  # alias Bamboo.Attachment
  use Bamboo.Phoenix, view: ProlegalsWeb.EmailView
  alias Prolegals.Emails.Mailer
  alias Prolegals.Security
  alias Prolegals.Security.LogBook


  # def send_email_notification(attr) do
  #   Notifications.list_tbl_email_logs()
  #   |> Task.async_stream(&(email_alert(&1.email, attr) |> Mailer.deliver_now()),
  #     max_concurrency: 10,
  #     timeout: 30_000
  #   )
  #   |> Stream.run()
  # end  Prolegals.Emails.Email.password("coilardium")

  def password_alert(email, password) do
    password(email, password) |> Mailer.deliver_later()
  end

  def confirm_password_reset(token, email) do
    confirmation_token(token, email) |> Mailer.deliver_later()
  end

  def password(email, password) do
    new_email()
    |> from("johnmfula360@gmail.com")
    |> to("#{email}")
    |> put_html_layout({ProlegalsWeb.LayoutView, "email.html"})
    |> subject("Prolegals Password")
    |> assign(:password, password)
    |> render("password_content.html")
  end

  def confirmation_token(token, email) do
    new_email()
    |> from("johnmfula360@gmail.com")
    |> to("#{email}")
    |> put_html_layout({ProlegalsWeb.LayoutView, "email.html"})
    |> subject("Prolegals Password Reset")
    |> assign(:token, token)
    |> render("token_content.html")
  end

  def send_alert(recipient, messages) do
    new_email()
    |> from("johnmfula360@gmail.com")
    |> to(recipient)
    |> subject("Case in Prolegals")
    |> text_body(
      """
      Dear User, \r\n Kindly note that there is a pending case . \r\n
      #{messages}
      """
    )
    |> Mailer.deliver_later()
  end

  def send_check_out_alert(items, recipient) do
    new_email()
    |> from("johnmfula360@gmail.com")
    |> to(recipient)
    |> subject("Visitors Not Check Out ")
    # |> assign()
    |> render("send_checkout.html", items: items )
    # |> text_body(
    #   """

    #   """
    # )
    |> Mailer.deliver_later()
  end




end
