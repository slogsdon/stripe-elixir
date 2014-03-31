# stripe-elixir

a Stripe wrapper for Elixir

## Usage

> ##### Note
> stripe-elixir requires the `STRIPE_SECRET_KEY` environment variable set to a 
> valid API key associated with your Stripe account.

```elixir
iex> Stripe.start
:ok
iex> Stripe.InvoiceItems.list
[Stripe.InvoiceItem[id: "ii_103lSZ2eZvKYlo2C6Zz1aFHv", object: "invoiceitem",
  livemode: false, amount: 1000, currency: "usd",
  customer: "cus_3lPWbj9wX1KqP6", date: {{2014, 3, 30}, {3, 0, 11}},
  proration: false, description: "One-time setup fee", invoice: nil,
  metadata: [{}], subscription: nil],
 Stripe.InvoiceItem[id: "ii_103kXf2eZvKYlo2CkRlaXEN6", object: "invoiceitem",
  livemode: false, amount: 350, currency: "usd", customer: "cus_3kXfWSyHPMZOan",
  date: {{2014, 3, 27}, {16, 11, 35}}, proration: false, description: nil,
  invoice: "in_103kXf2eZvKYlo2CgUV8Vctw", metadata: [{}], subscription: nil],
  ...]
```

## Reference

See [Stripe's API docs](https://stripe.com/docs/api/).

## Dependencies

- [HTTPoison](https://github.com/edgurgel/httpoison)
- [JSEX](https://github.com/talentdeficit/jsex)

## License

See [LICENSE](https://github.com/slogsdon/stripe-elixir/blob/master/LICENSE)
