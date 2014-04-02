defrecord Stripe.Charge,
  id: nil,
  object: "charge",
  livemode: nil,
  amount: nil,
  captured: nil,
  card: nil,
  created: nil,
  currency: nil,
  paid: nil,
  refunded: nil,
  refunds: nil,
  amount_refunded: nil,
  balance_transaction: nil,
  customer: nil,
  description: nil,
  dispute: nil,
  failure_code: nil,
  failure_message: nil,
  invoice: nil,
  metadata: nil,
  statement_description: nil do

  @type id                    :: binary
  @type object                :: binary
  @type livemode              :: boolean
  @type amount                :: pos_integer
  @type captured              :: boolean
  @type card                  :: binary
  @type created               :: {{1970..10000, 1..12, 1..31}, {0..23, 0..59, 0..59}}
  @type currency              :: binary
  @type paid                  :: boolean
  @type refunded              :: boolean
  @type refunds               :: Keyword.t
  @type amount_refunded       :: pos_integer
  @type balance_transaction   :: binary
  @type customer              :: binary
  @type description           :: binary
  @type dispute               :: Keyword.t
  @type failure_code          :: binary
  @type failure_message       :: binary
  @type invoice               :: binary
  @type metadata              :: Keyword.t
  @type statement_description :: binary

  record_type id: id,
              object: object,
              livemode: livemode,
              amount: amount,
              captured: captured,
              card: card,
              created: created,
              currency: currency,
              paid: paid,
              refunded: refunded,
              refunds: refunds,
              amount_refunded: amount_refunded,
              balance_transaction: balance_transaction,
              customer: customer,
              description: description,
              dispute: dispute,
              failure_code: failure_code,
              failure_message: failure_message,
              invoice: invoice,
              metadata: metadata,
              statement_description: statement_description

  @moduledoc """
  ## Attributes

  - `id` - `String`
  - `object` - `String` - value is "charge"
  - `livemode` - `Boolean`
  - `amount` - `Integer` - Amount charged in cents
  - `captured` - `Boolean` - If the charge was created without capturing, 
      this boolean represents whether or not it is still uncaptured or has 
      since been captured.
  - `card` - `Keyword` -, card object Hash describing the card used to make 
      the charge
  - `created` - `Tuple`
  - `currency` - `String` - Three-letter ISO currency code representing the 
      currency in which the charge was made.
  - `paid` - `Boolean`
  - `refunded` - `Boolean` - Whether or not the charge has been fully 
      refunded. If the charge is only partially refunded, this attribute 
      will still be false.
  - `refunds` - `Keyword` - A list of refunds that have been applied to the 
      charge.
  - `amount_refunded` - `Integer` - Amount in cents refunded (can be less 
      than the amount attribute on the charge if a partial refund was 
      issued)
  - `balance_transaction` - `String` - Balance transaction that describes 
      the impact of this charge on your account balance (not including 
      refunds or disputes).
  - `customer` - `String` - ID of the customer this charge is for if one 
      exists
  - `description` - `String`
  - `dispute` - `Keyword` -, dispute object Details about the dispute if the 
      charge has been disputed
  - `failure_code` - `String` - Error code explaining reason for charge 
      failure if available (see https://stripe.com/docs/api#errors for a 
      list of codes)
  - `failure_message` - `String` - Message to user further explaining reason 
      for charge failure if available
  - `invoice` - `String` - ID of the invoice this charge is for if one exists
  - `metadata` - `Keyword` - Keyword A set of key/value pairs that you can 
      attach to a charge object. It can be useful for storing additional 
      information about the charge in a structured format.
  - `statement_description` - `String` - Extra information about a charge for 
      the customer’s credit card statement.
  """
end