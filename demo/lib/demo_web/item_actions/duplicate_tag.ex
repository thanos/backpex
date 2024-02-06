defmodule DemoWeb.ItemActions.DuplicateTag do
    @moduledoc false

    use BackpexWeb, :item_action

    alias Demo.Repo

    @impl Backpex.ItemAction
    def icon(assigns) do
      ~H"""
      <Heroicons.document_duplicate class="h-5 w-5 cursor-pointer transition duration-75 hover:scale-110 hover:text-green-600" />
      """
    end

    @impl Backpex.ItemAction
    def fields do
      [
        name: %{
          module: Backpex.Fields.Text,
          label: "Name",
          searchable: true,
          placeholder: "Tag name"
        }
      ]

      # DemoWeb.TagLive.fields()
    end

    @impl Backpex.ItemAction
    def label(_assigns), do: "Duplicate"

    @impl Backpex.ItemAction
    def confirm(_assigns), do: "Please complete the form to duplicate the item."

    @impl Backpex.ItemAction
    def confirm_label(assigns), do: "Duplicate"

    @impl Backpex.ItemAction
    def cancel_label(assigns), do: "Cancel"

    @impl Backpex.ItemAction
    def changeset(item, change, target, assigns) do
      Demo.Tag.create_changeset(item, change)
    end

    @impl Backpex.ItemAction
    def init_change(assigns) do
      [item | _other] = assigns.selected_items

      item
    end

    @impl Backpex.ItemAction
    def handle(socket, [item | _items] = items, params) do
      result =
        %Demo.Tag{}
        |> Demo.Tag.create_changeset(params)
        |> Repo.insert()

      socket =
        case result do
          {:ok, created} ->
            put_flash(socket, :info, "Item has been duplicated.")

          _error ->
            put_flash(socket, :error, "Error while duplicating item.")
        end


      {:noreply, socket}
    end
end
