# Ruby Gem for Cloverly API

Cloverly is an API for carbon offsets.  Cloverly powers the ability to "green" every day transaction with carbon offsets. Many customers use it to offer green shipping to their customers.

Other links:

* [Cloverly](https://cloverly.com)
* [API Documentation](https://cloverly.com/documentation)
* [Ruby Gem](https://rubygems.org/gems/cloverly)

## Bugs

If you find issues, please report them to https://github.com/cloverly/cloverly-ruby-gem/issues

## Getting started

1. `gem install cloverly`
2. Signup for Cloverly API at https://cloverly.com

## Basic Usage

Below is some basic code, which can be used to show the basics of the
Cloverly Ruby gem.

```
require 'cloverly'

Cloverly.default = Cloverly.new(<signup with cloverly to get an API key>)

# Purchase with estimate first
estimate = Cloverly::Estimate.shipping(distance: {value: 4500, units: "miles"}, weight: {value: 50, units: "kg"})
estimate.transaction_cost_in_usd_cents
purchase = estimate.purchase! # converts estimate to purchase and initializes new instance of Cloverly::Purchase
purchase.state == "purchased"

# Purchase without estimate
new_purchase = Cloverly::Purchase.shipping(distance: {value: 4500, units: "miles"}, weight: {value: 50, units: "kg"})
```

## Detailed Usage

## Initialization

To initialize cloverly, call `Cloverly.new('api-key')`.  If you choose to set a `Cloverly.default` value, then you can use the class methods. This is common for 90% of our customers who use Cloverly for their own tools:

```
Cloverly.default = Cloverly.new(<signup with cloverly to get an API key>)
```

For advanced use cases, which want to interact with multiple Cloverly API keys, you can initialize the instance as needed.  The Cloverly Slack app uses this method:

```
cloverly_one = Cloverly.new('api_key')
cloverly_two = Cloverly.new('api_key')

# Sent to first Cloverly
cloverly_one.estimate_offset("shipping", {distance: {value: 4500, units: "miles"}, weight: {value: 50, units: "kg"}})
# Sent to a second Cloverly
cloverly_two.estimate_offset("shipping", {distance: {value: 15, units: "miles"}, weight: {value: 50, units: "kg"}})
```

### How Cloverly Works

Cloverly has outlined it's [How it works](https://cloverly.com/how-it-works) in the world.  On a transaction method, the method of operations are: Estimate First or Purchase without Estimate.

* **Estimate First**
Some use cases require receiving an estimate first.  This allows showing the price of the estimate to a customer to get by in.  Then, convert the estimate to a purchase later.  To convert, use the `purchase!` method on a `Cloverly::Estimate` object.

* **Purchase without estimate**
If the use case does not require estimates first, then make a direct call to `cloverly.offset` or `Cloverly.shipping` or the methods.  Below, in the examples, we will show both use cases.

### Shipping Offset

A shipping offset requires two different variables: distance and weight. Cloverly can find dinstance with a `to` and `from` attribute, or with a `distance` attribute.

When using `Cloverly.default` with `to` and `from`:
```
Cloverly::Purchase.shipping({to: {zip: "35209"}, from: {country: "PK", postal_code: "54000"}, weight: {value: 5, units: "kg"}})
Cloverly::Estimate.shipping({to: {country: "US", postal_code: "35209"}, from: {country: "PK", postal_code: "54000"}, weight: {value: 5, units: "pounds"}})
```

Without `Cloverly.default` with `distance`:
```
cloverly.offset("shipping", {distance: {value: 15, units: "miles"}, weight: {value: 50, units: "kg"}})
cloverly.estimate_offset("shipping", {distance: {value: 15, units: "miles"}, weight: {value: 50, units: "kg"}})
```

### Transportation and vehicle offset

When using `Cloverly.default`:
```
Cloverly::Purchase.vehicle({to: {zip: "35209"}, from: {zip: "94043"}, fuel_efficiency: {value: 22, units: "mpg", of: "gasoline"}})
Cloverly::Estimate.vehicle({to: {country: "US", postal_code: "35209"}, from: {zip: "94043"}, fuel_efficiency: {value: 35, units: "km/l", of: "diesel"}})
```

When not:
```
cloverly.offset("vehicle", {distance: {value: 15, units: "miles"}, fuel_efficiency: {value: 28, units: "km/l", of: "diesel"}})
cloverly.estimate_offset("vehicle", {distance: {value: 15, units: "miles"}, fuel_efficiency: {value: 28, units: "km/l", of: "diesel"}})
```

### Direct offset on carbon weight

When using `Cloverly.default`:
```
Cloverly::Purchase.carbon(weight: {value: 20, units: "pounds"})
Cloverly::Estimate.carbon(weight: {value: 20, units: "pounds"})
```

without default:
```
cloverly.offset("carbon", weight: {value: 10.2, units: "kg"})
cloverly.estimate_offset("carbon", weight: {value: 10.2, units: "kg"})
```

### Fixed dollar amount to offset

When using `Cloverly.default`:
```
Cloverly::Purchase.currency({currency: {value: 75, unit: "usd cents"}})
Cloverly::Estimate.currency({currency: {value: 285, unit: "usd cents"}})
```

When not:
```
cloverly.offset("currency", {currency: {value: 9.34, unit: "usd"}})
cloverly.estimate_offset("currency", {currency: {value: 9.34, unit: "usd"}})
```

### Convert an estimate to a purchase

```
estimate = Cloverly::Estimate.shipping({to: {zip: "35209"}, from: {country: "PK", postal_code: "54000"}, weight: {value: 5, units: "kg"}})
purchase = estimate.purchase!
```