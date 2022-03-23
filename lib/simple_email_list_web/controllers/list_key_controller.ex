defmodule SimpleEmailListWeb.ListKeyController do
  use SimpleEmailListWeb, :controller

  alias SimpleEmailList.Signups

  plug :authorize_action

  def create(conn, %{"list_id" => list_id}) do
    case Signups.create_list_key(list_id) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Key created successfully.")
        |> redirect(to: Routes.list_path(conn, :show, list_id))

      {:error, _} ->
        conn
        |> put_flash(:danger, "Error creating key.")
        |> redirect(to: Routes.list_path(conn, :show, list_id))
    end
  end

  def delete(conn, %{"list_id" => list_id, "id" => id}) do
    list_key = Signups.get_list_key!(list_id, id)
    {:ok, _list_key} = Signups.delete_list_key(list_key)

    conn
    |> put_flash(:info, "Key deleted successfully.")
    |> redirect(to: Routes.list_path(conn, :show, list_id))
  end

  def show(conn, %{"list_id" => list_id, "id" => id}) do
    list_key = Signups.get_list_key!(list_id, id)
    list = Signups.get_list!(list_id)

    render(conn, "show.html",
      code_snippet: code_snippet(list_key.client_code),
      list_id: list_id,
      client_code: list_key.client_code,
      list_name: list.name
    )
  end

  defp authorize_action(conn, _params) do
    list = Signups.get_list!(conn.params["list_id"])

    if list.user_id != conn.assigns[:current_user].id do
      conn
      |> put_flash(:error, "Unauthorized")
      |> redirect(to: Routes.list_path(conn, :index))
      |> halt()
    end

    conn
  end

  defp code_snippet(list_key) do
    """
    <script>
      function createSignup() {
        const url = "https://list.firstprinciplesdevelopment.com/api/v1/signups/create";
        const client_code = "#{list_key}";

        var email_elem = document.getElementById("email-input");
        var email_error_msg = document.getElementById("email-input-error");
        var msg = document.getElementById("signup-message");

        // clear messages
        email_error_msg.innerText = "";
        msg.innerHTML = "";

        // post body data
        const data = {
          client_code: client_code,
          signup: {
            email: email_elem.value,
          },
        };

        // build request options
        const options = {
          method: "POST",
          body: JSON.stringify(data),
          headers: {
            "Content-Type": "application/json",
          },
        };

        // send POST request
        fetch(url, options)
          .then((res) => res.json())
          .then((res) => {
            if (res.errors) {
              if (res.errors.email || res.errors.name) {
                email_error_msg.innerHTML = res.errors?.email
                  ? res.errors.email[0]
                  : "";
              } else {
                // show a failure message
                msg.innerText = "Something went wrong.";
                console.log(res.errors);
              }
            } else if (res.data) {
              // clear inputs
              email_elem.value = "";
              // show a success message
              msg.innerText = "Thanks!";
            }
          });
      }
    </script>

    <style>
      .card {
        background-image: linear-gradient(#5862eb, #e775e7);
        padding: 25px;
        border-radius: 5px;
        box-shadow: 2px 2px 2px #0e0814;
        min-height: 95px;
      }

      .flex {
        display: flex;
      }

      .error-message {
        color: red;
        font-size: small;
        font-weight: 700;
      }

      .form-input {
        border-radius: 5px;
        padding: 8px;
        border: solid #3c30e7 2px;
      }

      .input-group {
        margin: 6px;
      }

      .form-button {
        color: white;
        background-color: #084aff;
        border: solid #084aff 2px;
        border-radius: 5px;
        padding: 8px 2px 8px 2px;
      }

      .form-button:hover {
        border-color: #5448f8;
      }

      .form-button:active {
        background-color: #5448f8;
      }
    </style>

    <div class="card">
      <div class="flex">
        <div class="input-group">
          <input
            id="email-input"
            class="form-input"
            id="email"
            name="email"
            placeholder="Email"
          />
          <div id="email-input-error" class="error-message"></div>
        </div>

        <div class="input-group">
          <button class="form-button" type="button" onclick="createSignup()">
            Sign&nbsp;Up
          </button>
        </div>
      </div>
      <div id="signup-message" class="input-group"></div>
    </div>
    """
  end
end
