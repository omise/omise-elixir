# Changelog

## 0.5.1 (2017-06-07)

- Fix a bug when making an HTTP request to Search API

## 0.5.0 (2017-06-06)

- Add support for [Charge Schedule API](https://www.omise.co/charge-schedules-api).
- Add support for [Occurrence API](https://www.omise.co/occurrences-api).
- Add support for [Forex API](https://www.omise.co/forex-api).
- Add `currency` attribute to `Omise.Account` module.
- Rename some functions for refund module:
  - `Omise.Refund.list(charge_id)` becomes `Omise.Charge.list_refunds(charge_id)`
  - `Omise.Refund.retrieve(charge_id)` becomes `Omise.Charge.retrieve_refund(charge_id)`
  - `Omise.Refund.create(charge_id, params)` becomes `Omise.Charge.refund(charge_id, params)`
- Rename some functions for card module:
  - `Omise.Card.list(customer_id)` becomes `Omise.Customer.list_cards(customer_id)`
  - `Omise.Card.retrieve(customer_id, card_id)` becomes `Omise.Customer.retrieve_card(customer_id, card_id)`
  - `Omise.Card.update(customer_id, card_id, params)` becomes `Omise.Customer.update_card(customer_id, card_id, params)`
  - `Omise.Card.destroy(customer_id, card_id)` becomes `Omise.Customer.destroy_card(customer_id, card_id)`
