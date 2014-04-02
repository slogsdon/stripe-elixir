defmodule Stripe.Subscriptions do
  @moduledoc """
  To charge a credit or a debit card, you create a new charge object. You can 
  retrieve and refund individual charges as well as list all charges. Charges 
  are identified by a unique random ID.
  """

  @doc """
  You can see a list of the customer's active subscriptions. Note that the 10 
  most recent active subscriptions are always available by default on the 
  customer object. If you need more than those 10, you can use the limit and 
  starting_after parameters to page through additional subscriptions.

  ## Arguments

  - `id` - required - The ID of the customer whose subscriptions will be 
      retrieved
  - `limit` - optional — default is 10 - A limit on the number of objects to 
      be returned. Limit can range between 1 and 100 items.
  - `starting_after` - optional - A "cursor" for use in pagination. 
      starting_after is an object id that defines your place in the list. For 
      instance, if you make a list request and receive 100 objects, ending 
      with obj_foo, your subsequent call can include starting_after=obj_foo 
      in order to fetch the next page of the list.

  ## Returns
  
  Returns a list of the customer's active subscriptions.
  
  You can optionally request that the response include the total count of all 
  subscriptions for the customer. To do so, specify `include[]=total_count` 
  in your request.
  """
  def list(params) do
    obj = Stripe.make_request :get, "customers/#{params[:customer_id]}/subscriptions"
    if obj[:data] do
      Enum.map obj[:data], &Stripe.Subscription.from_keyword(&1)
    else
      []
    end
  end

  @doc """
  Updates an existing subscription on a customer to match the specified 
  parameters. When changing plans or quantities, we will optionally prorate 
  the price we charge next month to make up for any price changes.

  ## Arguments
  
  - `plan` - optional - The identifier of the plan to update the subscription 
      to. If omitted, the subscription will not change plans.
  - `coupon` - optional - default is null - The code of the coupon to apply 
      to the customer if you would like to apply it at the same time as 
      creating the subscription.
  - `prorate` - optional - default is true - Flag telling us whether to 
      prorate switching plans during a billing cycle.
  - `trial_end` - optional - default is null - UTC integer timestamp 
      representing the end of the trial period the customer will get before 
      being charged for the first time. If set, trial_end will override the 
      default trial period of the plan the customer is being subscribed to. 
      The special value now can be provided to end the customer's trial 
      immediately.
  - `card` - optional - default is null - The card can either be a token, like 
      the ones returned by our Stripe.js, or a dictionary containing a user's 
      credit card details (with the options shown below). You must provide a 
      card if the customer does not already have a valid card attached, and 
      you are subscribing the customer for a plan that is not free. Passing 
      card will create a new card, make it the customer default card, and 
      delete the old customer default if one exists. If you want to add an 
      additional card to use with subscriptions, instead use the card creation 
      API to add the card and then the customer update API to set it as the 
      default. Whenever you attach a card to a customer, Stripe will 
      automatically validate the card.
  - `quantity` - optional - default is 1 - The quantity you'd like to apply to 
      the subscription you're updating. For example, if your plan is 
      $10/user/month, and your customer has 5 users, you could pass 5 as the 
      quantity to have the customer charged $50 (5 x $10) monthly. If you 
      update a subscription but don't change the plan ID (e.g. changing only 
      the trial_end), the subscription will inherit the old subscription's 
      quantity attribute unless you pass a new quantity parameter. If you 
      update a subscription and change the plan ID, the new subscription will 
      not inherit the quantity attribute and will default to 1 unless you pass 
      a quantity parameter.
  - `application_fee_percent` - optional - default is null - A positive 
      decimal (with at most two decimal places) between 1 and 100 that 
      represents the percentage of the subscription invoice amount due each 
      billing period (including any bundled invoice items) that will be 
      transferred to the application owner’s Stripe account. The request must 
      be made with an OAuth key in order to set an application fee percentage. 
      For more information, see the application fees documentation.

  By default, we prorate subscription changes. For example, if a customer signs 
  up on May 1 for a $10 plan, she'll be billed $10 immediately. If she then 
  switches to a $20 plan on May 15, on June 1 she'll be billed $25 ($20 for a 
  renewal of her subscription and a $5 prorating adjustment for the previous 
  month). Similarly, a downgrade will generate a credit to be applied to the 
  next invoice. We also prorate when you make quantity changes. Switching plans 
  does not change the billing date or generate an immediate charge unless 
  you're switching between different intervals (e.g. monthly to yearly), in 
  which case we apply a credit for the time unused on the old plan and charge 
  for the new plan starting right away, resetting the billing date.
  
  If you'd like to charge for an upgrade immediately, just pass prorate as true 
  as usual, and then invoice the customer as soon as you make the subscription 
  change. That'll collect the proration adjustments into a new invoice, and 
  Stripe will automatically attempt to pay the invoice.
  
  If you don't want to prorate at all, set the prorate option to false and the 
  customer would be billed $10 on May 1 and $20 on June 1. Similarly, if you 
  set prorate to false when switching between different billing intervals 
  (monthly to yearly, for example), we won't generate any credits for the old 
  subscription's unused time, although we will still reset the billing date 
  and bill immediately for the new subscription.
  
  ## Returns
  
  The newly created subscription object if the call succeeded.

  If the customer has no card or the attempted charge fails, this call returns 
  an error (unless the specified plan is free or has a trial period).
  """
  def update(params) do
    customer_id = params[:customer_id]
    subscription_id = params[:subscription_id]
    params = Keyword.drop params, [:customer_id, :subscription_id]
    obj = Stripe.make_request :post, "customers/#{customer_id}/subscriptions/#{subscription_id}", params
    IO.inspect obj
    Stripe.Subscription.from_keyword obj
  end
end