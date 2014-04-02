defrecord Stripe.InvoiceItem,
  id: nil,
  object: "invoiceitem",
  livemode: nil,
  amount: nil,
  currency: nil,
  customer: nil,
  date: nil,
  proration: nil,
  description: nil,
  invoice: nil,
  metadata: nil,
  subscription: nil do

  @type id           :: binary
  @type object       :: binary
  @type livemode     :: boolean
  @type amount       :: pos_integer
  @type currency     :: binary
  @type customer     :: binary
  @type date         :: {{1970..10000, 1..12, 1..31}, {0..23, 0..59, 0..59}}
  @type proration    :: boolean
  @type description  :: binary
  @type invoice      :: binary
  @type metadata     :: Keyword.t
  @type subscription :: binary

  record_type id: id,
              object: object,
              livemode: livemode,
              amount: amount,
              currency: currency,
              customer: customer,
              date: date,
              proration: proration,
              description: description,
              invoice: invoice,
              metadata: metadata,
              subscription: subscription

  @moduledoc """
  ## Attributes

  - `id` - `String`
  - `object` - `String`, value is "invoiceitem"
  - `livemode` - `Boolean`
  - `amount` - `Integer`
  - `currency` - `String`
  - `customer` - `String` 
  - `date` - `Tuple`
  - `proration` - `Boolean` - Whether or not the invoice item was created 
      automatically as a proration adjustment when the customer 
      switched plans
  - `description` - `String`
  - `invoice` - `String` 
  - `metadata` - `Keyword` - A set of key/value pairs that you can 
      attach to an invoice item object. It can be useful for storing 
      additional information about the invoice item in a structured format.
  - `subscription` - `String` - The subscription that this invoice item 
      has been created for, if any.
  """

  def from_keyword(data) do
    datetime = Stripe.Util.datetime_from_timestamp data[:date]
    Stripe.InvoiceItem.new(
      id: data[:id],
      object: data[:object],
      livemode: data[:livemode],
      amount: data[:amount],
      currency: data[:currency],
      customer: data[:customer],
      date: datetime,
      proration: data[:proration],
      description: data[:description],
      invoice: data[:invoice],
      metadata: data[:metadata],
      subscription: data[:subscription]
    )
  end
end