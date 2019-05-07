# Ruby Gem for Cloverly API

Cloverly is an API for carbon offsets.  Cloverly powers the ability to
"green" every day transaction with carbon offsets.  Many customers use
it to offer green shipping to their customers.

# How to use it

_Gemfile_
```
gem 'cloverly'
```

_Usage_
```
require 'cloverly'

Cloverly.default = Cloverly.new(<signup with cloverly to get an API key>)

estimate = Cloverly::Estimate.shipping(distance: {value: 4500, units: "miles"}, weight: {value: 50, units: "kg"})

puts estimate.transaction_cost_in_usd_cents # about $2.00
```
