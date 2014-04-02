defmodule Stripe.Util do
  def datetime_from_timestamp(ts) when is_binary ts do
    ts = case Integer.parse ts do
      :error -> 0
      {i, _r} -> i
    end
    datetime_from_timestamp ts
  end
  def datetime_from_timestamp(ts) when is_number ts do
    {{year, month, day}, {hour, minutes, seconds}} = :calendar.gregorian_seconds_to_datetime ts
    {{year + 1970, month, day}, {hour, minutes, seconds}}
  end
end