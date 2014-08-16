defmodule Stripe.Charges do
  @moduledoc """
  To charge a credit or a debit card, you create a new charge object. You can 
  retrieve and refund individual charges as well as list all charges. Charges 
  are identified by a unique random ID.
  """

  @endpoint "charges"

  @doc """
  To charge a credit card, you create a new charge object. If your API key is
  in test mode, the supplied card won't actually be charged, though 
  everything else will occur as if in live mode. (Stripe assumes that the 
  charge would have completed successfully).

  ## Arguments
  
  - `amount` - required - A positive integer in the smallest currency unit 
      (e.g 100 cents to charge $1.00, or 1 to charge ¥1, a 0-decimal currency) 
      representing how much to charge the card. The minimum amount is $0.50 
      (or equivalent in charge currency).
  - `currency` - required - 3-letter ISO code for currency.
  - `customer` - optional, either customer or card is required - The ID of an 
      existing customer that will be charged in this request.
  - `card` - optional, either card or customer is required - A card to be 
      charged. If you also pass a customer ID, the card must be the ID of a 
      card belonging to the customer. Otherwise, if you do not pass a customer 
      ID, the card you provide must either be a token, like the ones returned 
      by Stripe.js, or a dictionary containing a user's credit card details, 
      with the options described below. Although not all information is 
      required, the extra info helps prevent fraud.
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
  - `description` - optional, default is null - An arbitrary string which you 
      can attach to a charge object. It is displayed when in the web interface 
      alongside the charge. Note that if you use Stripe to send automatic email 
      receipts to your customers, your receipt emails will include the 
      description of the charge(s) that they are describing.
  - `metadata` - optional, default is { } - A set of key/value pairs that you 
      can attach to a customer object. It can be useful for storing additional 
      information about the customer in a structured format. It's often a good 
      idea to store an email address in metadata for tracking later.
  - `capture` - optional, default is true - Whether or not to immediately 
      capture the charge. When false, the charge issues an authorization (or 
      pre-authorization), and will need to be captured later. Uncaptured 
      charges expire in 7 days. For more information, see authorizing charges 
      and settling later.
  - `statement_description` - optional, default is null - An arbitrary string 
      to be displayed alongside your company name on your customer's credit 
      card statement. This may be up to 15 characters. As an example, if your 
      website is RunClub and you specify 5K Race Ticket, the user will see 
      RUNCLUB 5K RACE TICKET. The statement description may not include `<>"'` 
      characters. While most banks display this information consistently, some 
      may display it incorrectly or not at all.
  - `application_fee` - optional - A fee in cents that will be applied to the 
      charge and transferred to the application owner's Stripe account. The 
      request must be made with an OAuth key in order to take an application 
      fee. For more information, see the application fees documentation.
  
  ## Returns
  
  Returns a charge object if the charge succeeded. Returns an error if something 
  goes wrong. A common source of error is an invalid or expired card, or a valid 
  card with insufficient available balance.

  If the cvc parameter is provided, Stripe will attempt to check the CVC's 
  correctness, and the check's result will be returned. Similarly, If 
  address_line1 or address_zip are provided, Stripe will similarly try to check 
  the validity of those parameters. Some banks do not support checking one or 
  more of these parameters, in which case Stripe will return an 'unchecked' 
  result. Also note that, depending on the bank, charges can succeed even when 
  passed incorrect CVC and address information.
  """
  def create(params) do
    Stripe.make_request :post, @endpoint, params
  end
end