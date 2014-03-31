defmodule Stripe.Util do
  def datetime_from_timestamp(ts) do
    {{year, month, day}, {hour, minutes, seconds}} = :calendar.gregorian_seconds_to_datetime ts
    {{year + 1970, month, day}, {hour, minutes, seconds}}
  end
end