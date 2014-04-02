defrecord Stripe.Subscription,
  id: nil,
  object: "subscription",
  cancel_at_period_end: nil,
  customer: nil,
  plan: nil,
  quantity: nil,
  start: nil,
  status: nil,
  application_fee_percent: nil,
  canceled_at: nil,
  current_period_end: nil,
  current_period_start: nil,
  discount: nil,
  ended_at: nil,
  trial_end: nil,
  trial_start: nil do

  @type id                      :: binary
  @type object                  :: binary
  @type cancel_at_period_end    :: boolean
  @type customer                :: binary
  @type plan                    :: Keyword.t #| Stripe.Plan.t
  @type quantity                :: pos_integer
  @type start                   :: {{1970..10000, 1..12, 1..31}, {0..23, 0..59, 0..59}}
  @type status                  :: binary
  @type application_fee_percent :: float
  @type canceled_at             :: {{1970..10000, 1..12, 1..31}, {0..23, 0..59, 0..59}}
  @type current_period_end      :: {{1970..10000, 1..12, 1..31}, {0..23, 0..59, 0..59}}
  @type current_period_start    :: {{1970..10000, 1..12, 1..31}, {0..23, 0..59, 0..59}}
  @type discount                :: Keyword.t #| Stripe.Discount.t
  @type ended_at                :: {{1970..10000, 1..12, 1..31}, {0..23, 0..59, 0..59}}
  @type trial_end               :: {{1970..10000, 1..12, 1..31}, {0..23, 0..59, 0..59}}
  @type trial_start             :: {{1970..10000, 1..12, 1..31}, {0..23, 0..59, 0..59}}

  record_type id: id,
              object: object,
              cancel_at_period_end: cancel_at_period_end,
              customer: customer,
              plan: plan,
              quantity: quantity,
              start: start,
              status: status,
              application_fee_percent: application_fee_percent,
              canceled_at: canceled_at,
              current_period_end: current_period_end,
              current_period_start: current_period_start,
              discount: discount,
              ended_at: ended_at,
              trial_end: trial_end,
              trial_start: trial_start

  @moduledoc """
  ## Attributes
  
  - `id` - string 
  - `object` - string, value is "subscription" 
  - `cancel_at_period_end` - boolean - If the subscription has been 
      canceled with the at_period_end flag set to true, 
      cancel_at_period_end on the subscription will be true. You can use 
      this attribute to determine whether a subscription that has a 
      status of active is scheduled to be canceled at the end of the 
      current period.
  - `customer` - string  
  - `plan` - hash, plan object - Hash describing the plan the customer 
      is subscribed to
  - `quantity` - integer 
  - `start` - timestamp - Date the subscription started
  - `status` - string - Possible values are trialing, active, past_due, 
      canceled, or unpaid. A subscription still in its trial period is 
      trialing and moves to active when the trial period is over. When 
      payment to renew the subscription fails, the subscription becomes 
      past_due. After Stripe has exhausted all payment retry attempts, 
      the subscription ends up with a status of either canceled or 
      unpaid depending on your retry settings. Note that when a 
      subscription has a status of unpaid, no subsequent invoices will 
      be attempted (invoices will be created, but then immediately 
      automatically closed). After receiving updated card details from a 
      customer, you may choose to reopen and pay their closed invoices.
  - `application_fee_percent` - decimal - A positive decimal that 
      represents the fee percentage of the subscription invoice amount 
      that will be transferred to the application owner’s Stripe account 
      each billing period.
  - `canceled_at` - timestamp - If the subscription has been canceled, 
      the date of that cancellation. If the subscription was canceled 
      with cancel_at_period_end, canceled_at will still reflect the date 
      of the initial cancellation request, not the end of the 
      subscription period when the subscription is automatically moved 
      to a canceled state.
  - `current_period_end` - timestamp - End of the current period that the 
      subscription has been invoiced for. At the end of this period, a 
      new invoice will be created.
  - `current_period_start` - timestamp - Start of the current period that 
      the subscription has been invoiced for
  - `discount` - hash, discount object - Describes the current discount 
      applied to this subscription, if there is one. When billing, a 
      discount applied to a subscription overrides a discount applied on 
      a customer-wide basis.
  - `ended_at` - timestamp - If the subscription has ended (either 
      because it was canceled or because the customer was switched to a 
      subscription to a new plan), the date the subscription ended
  - `trial_end` - timestamp - If the subscription has a trial, the end of 
      that trial.
  - `trial_start` - timestamp - If the subscription has a trial, the 
      beginning of that trial.
  """

  def from_keyword(data) do
    start = Stripe.Util.datetime_from_timestamp data[:start]
    canceled_at = Stripe.Util.datetime_from_timestamp data[:canceled_at]
    current_period_end = Stripe.Util.datetime_from_timestamp data[:current_period_end]
    current_period_start = Stripe.Util.datetime_from_timestamp data[:current_period_start]
    ended_at = Stripe.Util.datetime_from_timestamp data[:ended_at]
    trial_end = Stripe.Util.datetime_from_timestamp data[:trial_end]
    trial_start = Stripe.Util.datetime_from_timestamp data[:trial_start]
    Stripe.InvoiceItem.new(
      id: data[:id],
      object: data[:object],
      cancel_at_period_end: data[:cancel_at_period_end],
      customer: data[:customer],
      plan: data[:plan],
      quantity: data[:quantity],
      start: start,
      status: data[:status],
      application_fee_percent: data[:application_fee_percent],
      canceled_at: canceled_at,
      current_period_end: current_period_end,
      current_period_start: current_period_start,
      discount: data[:discount],
      ended_at: ended_at,
      trial_end: trial_end,
      trial_start: trial_start
    )
  end
end