defmodule Stripe.Plans do
  @moduledoc """
  A subscription plan contains the pricing information for different products 
  and feature levels on your site. For example, you might have a $10/month 
  plan for basic features and a different $20/month plan for premium features.
  """

  @endpoint "plans"

  @doc """
  You can create plans easily via the plan management page of the Stripe 
  dashboard. Plan creation is also accessible via the API if you need to 
  create plans on the fly.
  
  ## Arguments
  
  - `id` - required - Unique string of your choice that will be used to 
      identify this plan when subscribing a customer. This could be an 
      identifier like "gold" or a primary key from your own database.
  - `amount` - required - A positive integer in cents (or 0 for a free plan) 
      representing how much to charge (on a recurring basis).
  - `currency` - required - 3-letter ISO code for currency.
  - `interval` - required - Specifies billing frequency. Either week, month 
      or year.
  - `interval_count` - optional - default is 1 - The number of intervals 
      between each subscription billing. For example, interval=month and 
      interval_count=3 bills every 3 months. Maximum of one year 
  - `interval` - allowed -  (1 year, 12 months, or 52 weeks).
  - `name` - required - Name of the plan, to be displayed on invoices and in 
      the web interface.
  - `trial_period_days` - optional - Specifies a trial period in (an integer 
      number of) days. If you include a trial period, the customer won't be 
      billed for the first time until the trial period ends. If the customer 
      cancels before the trial period is over, she'll never be billed at all.
  - `metadata` - optional - default is { } - A set of key/value pairs that 
      you can attach to a plan object. It can be useful for storing 
      additional information about the plan in a structured format.
  - `statement_description` - optional - default is null - An arbitrary 
      string to be displayed on your customers' credit card statements 
      (alongside your company name) for charges created by this plan. This 
      may be up to 15 characters. As an example, if your website is RunClub 
      and you specify Silver Plan, the user will see RUNCLUB SILVER PLAN. 
      The statement description may not include `<>"'` characters. While 
      most banks display this information consistently, some may display 
      it incorrectly or not at all.
  """
  def create(params) do
    obj = Stripe.make_request :post, @endpoint, params
    Stripe.Plan.from_keyword obj
  end
end