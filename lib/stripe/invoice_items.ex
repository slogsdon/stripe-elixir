defmodule Stripe.InvoiceItems do
  @moduledoc """
  Invoice Items

  Sometimes you want to add a charge or credit to a customer but only 
  actually charge the customer's card at the end of a regular billing 
  cycle. This is useful for combining several charges to minimize 
  per-transaction fees or having Stripe tabulate your usage-based 
  billing totals.
  """

  @endpoint "invoiceitems"

  @doc """
  Returns a list of your invoice items. Invoice Items are returned sorted 
  by creation date, with the most recently created invoice items appearing 
  first.

  ## Arguments

  - `created` - `String` | `Keyword` - (optional) - A filter on the list 
      based on the object created field. The value can be a string with 
      an exact UTC timestamp, or it can be a dictionary with the 
      following options:
      - `gt` - `String` - (optional) - Return values where the created 
          field is after this timestamp.
      - `gte` - `String` - (optional) - Return values where the created 
          field is after or equal to this timestamp.
      - `lt` - `String` - (optional) - Return values where the created 
          field is before this timestamp.
      - `lte` - `String` - (optional) - Return values where the created 
          field is before or equal to this timestamp.
  - `customer` - `String` - (optional) - The identifier of the customer 
      whose invoice items to return. If none is provided, all invoice 
      items will be returned.
  - `limit` - `Integer` - (optional), default is 10 - A limit on the number 
      of objects to be returned. Limit can range between 1 and 100 items.
  - `offset` - `Integer` - (optional), default is 0 - An offset into the 
      list of returned items. The API will return the requested number of 
      items starting at that offset.
  - `starting_after` - `String` - (optional) - A "cursor" for use in 
      pagination. starting_after is an object id that defines your place 
      in the list. For instance, if you make a list request and receive 
      100 objects, ending with obj_foo, your subsequent call can include 
      `starting_after=obj_foo` in order to fetch the next page of the list.
  
  ## Returns

  A dictionary with a data property that contains an array of up to limit 
  invoice items, starting after invoice item starting_after. Each entry in 
  the array is a separate invoice item object. If no more invoice items 
  are available, the resulting array will be empty. This request should 
  never return an error.

  You can optionally request that the response include the total count of 
  all invoice items that match your filters. To do so, specify 
  `include[]=total_count` in your request.
  """
  def list do
    obj = Stripe.make_request :get, @endpoint
    if obj[:data] do
      Enum.map obj[:data], &Stripe.InvoiceItem.from_keyword(&1)
    else
      []
    end
  end

  @doc """
  Adds an arbitrary charge or credit to the customer's upcoming invoice.

  ## Arguments
  
  - `customer` - `String` - (required) - The ID of the customer who will  
      be billed when this invoice item is billed.
  - `amount` - `Integer` - (required) - The integer amount in cents of 
      the charge to be applied to the upcoming invoice. If you want to 
      apply a credit to the customer's account, pass a negative amount.
  - `currency` - `String` - (required) - 3-letter ISO code for currency.
  - `invoice` - `String` - (optional) - The ID of an existing invoice to  
      add this invoice item to. When left blank, the invoice item will be 
      added to the next upcoming scheduled invoice. Use this when adding 
      invoice items in response to an invoice.created webhook. You 
      cannot add an invoice item to an invoice that has already been 
      paid or closed.
  - `subscription` - `String` - (optional) - The ID of a subscription to 
      add this invoice item to. When left blank, the invoice item will be 
      added to the next upcoming scheduled invoice. When set, scheduled 
      invoices for subscriptions other than the specified subscription 
      will ignore the invoice item. Use this when you want to express 
      that an invoice item has been accrued within the context of a 
      particular subscription.
  - `description` - `String` - (optional), default is `null` - An arbitrary  
      string which you can attach to the invoice item. The description is 
      displayed in the invoice for easy tracking.
  - `metadata` - `Keyword` - (optional), default is `[]` - A set of 
      key/value pairs that you can attach to an invoice item object. It can 
      be useful for storing additional information about the invoice item in 
      a structured format.
  
  ## Returns
  
  The created invoice item object is returned if successful. Otherwise, 
  this call returns an error.
  """
  def create(params) do
    obj = Stripe.make_request :post, @endpoint, params
    Stripe.InvoiceItem.from_keyword obj
  end

  @doc """
  Retrieves the invoice item with the given ID.

  ## Arguments
  
  - `id` - `String` - (required) - The ID of the desired invoice item.
  
  ## Returns
  
  Returns an invoice item if a valid invoice item ID was provided. Returns 
  an error otherwise.
  """
  def retrieve(id) do
    obj = Stripe.make_request :get, @endpoint <> "/#{id}"
    Stripe.InvoiceItem.from_keyword obj
  end

  @doc """
  Updates the amount or description of an invoice item on an upcoming invoice. 
  Updating an invoice item is only possible before the invoice it's attached 
  to is closed.

  ## Arguments

  - `amount` - `Integer` - (required) - The integer amount in cents of 
      the charge to be applied to the upcoming invoice. If you want to 
      apply a credit to the customer's account, pass a negative amount.
  - `description` - `String` - (optional), default is `null` - An arbitrary  
      string which you can attach to the invoice item. The description is 
      displayed in the invoice for easy tracking.
  - `metadata` - `Keyword` - (optional), default is `[]` - A set of 
      key/value pairs that you can attach to an invoice item object. It can 
      be useful for storing additional information about the invoice item in 
      a structured format.

  ## Returns

  The updated invoice item object is returned upon success. Otherwise, this 
  call returns an error.
  """
  def update(params) do
    obj = Stripe.make_request :post, @endpoint <> "/#{params[:id]}", params
    Stripe.InvoiceItem.from_keyword obj
  end

  @doc """
  Removes an invoice item from the upcoming invoice. Removing an invoice 
  item is only possible before the invoice it's attached to is closed.

  ## Arguments
  
  - `id` - `String` - (required) - The ID of the desired invoice item.
  
  ## Returns

  An object with the deleted invoice item's ID and a deleted flag upon 
  success. This call returns an error otherwise, such as when the invoice 
  item has already been deleted.
  """
  def delete(id) do
    Stripe.make_request :delete, @endpoint <> "/#{id}"
  end
end
