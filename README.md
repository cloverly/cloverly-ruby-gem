# Ruby Gem for Cloverly API

Cloverly is an API for carbon offsets.  Cloverly powers the ability to
"green" every day transaction with carbon offsets.  Many customers use
it to offer green shipping to their customers.

# Signup & Install

Sign up for the Cloverly API at https://cloverly.com

**Install the Gem**
```
gem install cloverly
```

### Basic Usage

Below is some basic code, which can be used to show the basics of the
Cloverly Ruby gem.

```
require 'cloverly'

Cloverly.default = Cloverly.new(<signup with cloverly to get an API key>)

estimate = Cloverly::Estimate.shipping(distance: {value: 4500, units: "miles"}, weight: {value: 50, units: "kg"})
estimate.transaction_cost_in_usd_cents

# convert estimate to purchase
purchase = estimate.purchase!

purchase.state == "purchased"

puts purchase.pretty_url
```

### Initialization

To initialize cloverly, call `Cloverly.new('api-key')`.  If you choose
to set a `Cloverly.default` value, then all calls will be made with that
API key. This is common for 90% of our customers who use Cloverly for
their own tools.

For advanced use cases, which want to interact with multiple Cloverly
API keys, you can initialize the instance as needed.  The Cloverly Slack
app uses this method:

```
cloverly_one = Cloverly.new('api_key')
cloverly_two = Cloverly.new('api_key')

# Sent to first Cloverly
cloverly_one.estimate_offset("shipping", {distance: {value: 4500, units: "miles"}, weight: {value: 50, units: "kg"}})
# Sent to a second Cloverly
cloverly_two.estimate_offset("shipping", {distance: {value: 15, units: "miles"}, weight: {value: 50, units: "kg"}})
```

### Purchasing offsets

**Shipping**
```
# with default
Cloverly::Purchase.shipping({to: {zip: "35209"}, from: {country: "PK", postal_code: "54000"}, weight: {value: 5, units: "kg"}})

# without default
cloverly.offset("shipping", {distance: {value: 15, units: "miles"}, weight: {value: 50, units: "kg"}})
```

**Vehicle**
```
# with default
Cloverly::Purchase.vehicle({to: {zip: "35209"}, from: {zip: "94043"}, fuel_efficiency: {value: 22, units: "mpg", of: "gasoline"}})

# without default
cloverly.offset("vehicle", {distance: {value: 15, units: "miles"}, fuel_efficiency: {value: 28, units: "km/l", of: "diesel"}})
```

**Carbon**
```
# with default
Cloverly::Purchase.carbon(weight: {value: 20, units: "pounds"})

# without default
cloverly.offset("carbon", weight: {value: 10.2, units: "kg"})
```

**Currency**
```
# with default
Cloverly::Purchase.currency({currency: {value: 357, unit: "usd cents"}})

# without default
cloverly.offset("currency", {currency: {value: 3.57, unit: "usd"}})
```

### Estimating Offsets

**Shipping**
```
# with default
Cloverly::Estimate.shipping({to: {zip: "35209"}, from: {country: "PK", postal_code: "54000"}, weight: {value: 5, units: "kg"}})

# without default
cloverly.estimate_offset("shipping", {distance: {value: 15, units: "miles"}, weight: {value: 50, units: "kg"}})
```

**Vehicle**
```
# with default
Cloverly::Estimate.vehicle({to: {zip: "35209"}, from: {zip: "94043"}, fuel_efficiency: {value: 22, units: "mpg", of: "gasoline"}})

# without default
cloverly.estimate_offset("vehicle", {distance: {value: 15, units: "miles"}, fuel_efficiency: {value: 28, units: "km/l", of: "diesel"}})
```

**Carbon**
```
# with default
Cloverly::Estimate.carbon(weight: {value: 20, units: "pounds"})

# without default
cloverly.estimate_offset("carbon", weight: {value: 10.2, units: "kg"})
```

**Currency**
```
# with default
Cloverly::Estimate.currency({currency: {value: 357, unit: "usd cents"}})

# without default
cloverly.estimate_offset("currency", {currency: {value: 3.57, unit: "usd"}})
```

### Convert an estimate to a purchase

```
estimate = Cloverly::Estimate.shipping({to: {zip: "35209"}, from: {country: "PK", postal_code: "54000"}, weight: {value: 5, units: "kg"}})
purchase = estimate.purchase!
```
