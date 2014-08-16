defmodule Stripe.Customer do
  @moduledoc """
  ## Attributes

  - `id` - `String`
  - `object` - `String` - value is "customer"
  - `livemode` - `Boolean`
  - `cards` - `List`
  - `created` - `Tuple`
  - `account_balance` - `Integer` - Current balance, if any, being stored on the 
      customer’s account. If negative, the customer has credit to apply to the 
      next invoice. If positive, the customer has an amount owed that will be 
      added to the next invoice. The balance does not refer to any unpaid 
      invoices; it solely takes into account amounts that have yet to be 
      successfully applied to any invoice. This balance is only taken into 
      account for recurring charges.
  - `currency` - `String` - The currency the customer can be charged in for 
      recurring billing purposes (subscriptions, invoices, invoice items).
  - `default_card` - `String` - ID of the default credit card attached to the 
      customer
  - `delinquent` - `Boolean` - Whether or not the latest charge for the 
      customer’s latest invoice has failed
  - `description` - `String`
  - `discount` - `Stripe.Discount` - Describes the current discount active on 
      the customer, if there is one.
  - `email` - `String`
  - `metadata` - `Keyword` - Keyword A set of key/value pairs that you can 
      attach to a charge object. It can be useful for storing additional 
      information about the charge in a structured format.
  - `subscriptions` - `List` - The customer’s current subscriptions, if any
  """

  defstruct id: nil,
            object: "customer",
            livemode: nil,
            cards: nil,
            created: nil,
            account_balance: nil,
            currency: nil,
            default_card: nil,
            delinquent: nil,
            description: nil,
            discount: nil,
            email: nil,
            metadata: nil,
            subscriptions: nil

  @type id              :: binary
  @type object          :: binary
  @type livemode        :: boolean
  @type cards           :: [] #[Stripe.Card.t]
  @type created         :: {{1970..10000, 1..12, 1..31}, {0..23, 0..59, 0..59}}
  @type account_balance :: integer
  @type currency        :: binary
  @type default_card    :: binary
  @type delinquent      :: boolean
  @type description     :: binary
  @type discount        :: binary # Stripe.Discount.t
  @type email           :: binary
  @type metadata        :: Keyword.t
  @type subscriptions   :: [Stripe.Subscripton.t]

  @type t :: %Stripe.Customer{
    id: id,
    object: object,
    livemode: livemode,
    cards: cards,
    created: created,
    account_balance: account_balance,
    currency: currency,
    default_card: default_card,
    delinquent: delinquent,
    description: description,
    discount: discount,
    email: email,
    metadata: metadata,
    subscriptions: subscriptions
  }

  def from_keyword(data) do
    datetime = Stripe.Util.datetime_from_timestamp data[:created]
    %Stripe.Customer{
      id: data[:id],
      object: data[:object],
      cards: data[:cards],
      created: datetime,
      account_balance: data[:account_balance],
      currency: data[:currency],
      default_card: data[:default_card],
      delinquent: data[:delinquent],
      description: data[:description],
      discount: data[:discount],
      email: data[:email],
      metadata: data[:metadata],
      subscriptions: data[:subscriptions]
    }
  end
end