defmodule Stripe.Customers do
  @moduledoc """
  Customer objects allow you to perform recurring charges and track multiple 
  charges that are associated with the same customer. The API allows you to 
  create, delete, and update your customers. You can retrieve individual 
  customers as well as a list of all your customers.
  """

  @endpoint "customers"

  @doc """
  Creates a new customer object.

  ## Arguments

  - `account_balance` - `optional` - An integer amount in cents that is the 
      starting account balance for your customer. A negative amount represents a 
      credit that will be used before attempting any charges to the customer’s 
      card; a positive amount will be added to the next invoice.
  - `card` - `optional` - The card can either be a token, like the ones returned 
      by our Stripe.js, or a dictionary containing a user’s credit card details 
      (with the options shown below). Passing card will create a new card, make 
      it the new customer default card, and delete the old customer default if 
      one exists. If you want to add additional cards instead of replacing the 
      existing default, use the card creation API. Whenever you attach a card to 
      a customer, Stripe will automatically validate the card.
      - `number` - required - The card number, as a string without any 
          separators.
      - `exp_month` - required - Two digit number representing the card's 
          expiration month.
      - `exp_year` - required - Two or four digit number representing the 
          card's expiration year.
      - `cvc` - optional, highly recommended - Card security code.
      - `name` - optional - Cardholder's full name.
      - `address_line1` - optional
      - `address_line2` - optional
      - `address_city` - optional
      - `address_zip` - optional
      - `address_state` - optional
      - `address_country` - optional
  - `coupon` - `optional` - If you provide a coupon code, the customer will have 
      a discount applied on all recurring charges. Charges you create through 
      the API will not have the discount.
  - `description` - `optional` - An arbitrary string that you can attach to a 
      customer object. It is displayed alongside the customer in the dashboard. 
      This will be unset if you POST an empty value.
  - `email` - `optional` - Customer’s email address. It’s displayed alongside 
      the customer in your dashboard and can be useful for searching and 
      tracking. This will be unset if you POST an empty value.
  - `metadata` - `optional` - A set of key/value pairs that you can attach to a 
      customer object. It can be useful for storing additional information about 
      the customer in a structured format. This will be unset if you POST an 
      empty value.
  - `plan` - `optional` - The identifier of the plan to subscribe the customer 
      to. If provided, the returned customer object will have a list of 
      subscriptions that the customer is currently subscribed to. If you 
      subscribe a customer to a plan without a free trial, the customer must 
      have a valid card as well.
  - `quantity` - `optional` - The quantity you’d like to apply to the 
      subscription you’re creating (if you pass in a plan). For example, if your 
      plan is 10 cents/user/month, and your customer has 5 users, you could pass 
      5 as the quantity to have the customer charged 50 cents (5 x 10 cents) 
      monthly. Defaults to 1 if not set. Only applies when the plan parameter is 
      also provided.
  - `trial_end` - `optional` - Unix timestamp representing the end of the trial 
      period the customer will get before being charged for the first time. If 
      set, trial_end will override the default trial period of the plan the 
      customer is being subscribed to. The special value now can be provided to 
      end the customer’s trial immediately. Only applies when the plan parameter 
      is also provided.
  
  ## Returns

  Returns a customer object if the call succeeded. The returned object will have 
  information about subscriptions, discount, and cards, if that information has 
  been provided. If a non-free plan is specified and a card is not provided 
  (unless the plan has a trial period), the call will return an error. If a 
  non-existent plan or a non-existent or expired coupon is provided, the call 
  will return an error.

  If a card has been attached to the customer, the returned customer object will 
  have a default_card attribute, which is an ID that can be expanded into the 
  full card details when retrieving the customer.
  """
  def create(params) do
    obj = Stripe.make_request :post, @endpoint, params
    if obj[:object] do
      Stripe.Customer.from_keyword(obj[:object])
    else
      []
    end
  end
end