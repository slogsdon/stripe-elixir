defrecord Stripe.Plan,
  id: nil,
  object: "plan",
  livemode: nil,
  amount: nil,
  created: nil,
  currency: nil,
  interval: nil,
  interval_count: nil,
  name: nil,
  metadata: nil,
  trial_period_days: nil,
  statement_description: nil do

  @type id                    :: binary
  @type object                :: binary
  @type livemode              :: boolean
  @type amount                :: pos_integer
  @type created               :: {{1970..10000, 1..12, 1..31}, {0..23, 0..59, 0..59}}
  @type currency              :: binary
  @type interval              :: binary
  @type interval_count        :: pos_integer
  @type name                  :: binary
  @type metadata              :: Keyword.t
  @type trial_period_days     :: pos_integer
  @type statement_description :: binary

  record_type id: id,
              object: object,
              livemode: livemode,
              amount: amount,
              created: created,
              currency: currency,
              interval: interval,
              interval_count: interval_count,
              name: name,
              metadata: metadata,
              trial_period_days: trial_period_days,
              statement_description: statement_description

  @doc """
  ## Attributes

  - `id` - `string`
  - `object` - `string`, value is "plan"
  - `livemode` - `boolean`
  - `amount` - `Integer` -   The amount in cents to be charged on the interval specified
  - `created` - `timestamp`
  - `currency` - `String` - Currency in which subscription will be charged
  - `interval` - `String` - One of week, month or year. The frequency with which a subscription should be billed.
  - `interval_count` - `Integer` - The number of intervals (specified in the interval property) between each subscription billing. For example, interval=month and interval_count=3 bills every 3 months.
  - `name` - `string` - Display name of the plan
  - `metadata` - `Keyword` - A set of key/value pairs that you can attach to a plan object. It can be useful for storing additional information about the plan in a structured format.
  - `trial_period_days` - `Integer` - Number of trial period days granted when subscribing a customer to this plan. Null if the plan has no trial period.
  - `statement_description` - `String` - Extra information about a charge for the customer’s credit card statement.
  """

  def from_keyword(data) do
    created = Stripe.Util.datetime_from_timestamp data[:created]
    Stripe.Plan.new(
      id: data[:id],
      object: data[:object],
      livemode: data[:livemode],
      amount: data[:amount],
      created: created,
      currency: data[:currency],
      interval: data[:interval],
      interval_count: data[:interval_count],
      name: data[:name],
      metadata: data[:metadata],
      trial_period_days: data[:trial_period_days],
      statement_description: data[:statement_description]
    )
  end
end