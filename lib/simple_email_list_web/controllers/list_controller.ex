defmodule SimpleEmailListWeb.ListController do
  use SimpleEmailListWeb, :controller

  alias SimpleEmailList.Signups
  alias SimpleEmailList.Signups.List
  alias SimpleEmailList.Signups.ListKey

  plug :authorize_action when action in [:show, :edit, :update, :delete]

  def index(conn, _params) do
    lists = Signups.list_lists(conn.assigns[:current_user])
    render(conn, "index.html", lists: lists)
  end

  def new(conn, _params) do
    changeset = Signups.change_list(%List{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"list" => list_params}) do
    case Signups.create_list(conn.assigns[:current_user], list_params) do
      {:ok, list} ->
        conn
        |> put_flash(:info, "List created successfully.")
        |> redirect(to: Routes.list_path(conn, :show, list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Signups.get_list!(id)
    list_keys = Signups.list_list_keys(id)
    signups = Signups.list_signups(id)
    changeset = Signups.change_list_key(%ListKey{})

    render(conn, "show.html",
      list: list,
      list_id: id,
      list_keys: list_keys,
      signups: signups,
      list_key_changeset: changeset,
      code_snippet: code_snippet()
    )
  end

  def edit(conn, %{"id" => id}) do
    list = Signups.get_list!(id)
    changeset = Signups.change_list(list)
    render(conn, "edit.html", list: list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Signups.get_list!(id)

    case Signups.update_list(list, list_params) do
      {:ok, list} ->
        conn
        |> put_flash(:info, "List updated successfully.")
        |> redirect(to: Routes.list_path(conn, :show, list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", list: list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Signups.get_list!(id)
    {:ok, _list} = Signups.delete_list(list)

    conn
    |> put_flash(:info, "List deleted successfully.")
    |> redirect(to: Routes.list_path(conn, :index))
  end

  defp authorize_action(conn, _params) do
    list = Signups.get_list!(conn.params["id"])

    if list.user_id != conn.assigns[:current_user].id do
      conn
      |> put_flash(:error, "Unauthorized")
      |> redirect(to: Routes.list_path(conn, :index))
      |> halt()
    end

    conn
  end

  defp code_snippet() do
    """
    <script>
      function createSignup() {
        const url = "https://list.firstprinciplesdevelopment.com/api/v1/signups/create";
        const client_code = "436dfce7-0ea3-4884-a156-7193f8098aad";

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
