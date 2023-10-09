# Changelog

## 0.10.0

- Update failing CI [(#32)](https://github.com/omise/omise-elixir/pull/32)
- Update dependencies [(#33)](https://github.com/omise/omise-elixir/pull/33)
- Add support for partial capture [(#31)](https://github.com/omise/omise-elixir/pull/31)
## 0.9.0

- Add more supported attributes for API version 2019
## 0.8.0

- Update `Charge.refund/3` type so that it matches the function behavior

## 0.7.0

- Various fixes

## 0.6.2 (2018-12-11)

- Update the required version of `httpoison` dependency to support `version ~> 1.0`.
- Fix an issue when getting application version via `Mix` module by using `Application.spec/2` instead.

## 0.6.1 (2017-11-14)

- Support [Source API](https://www.omise.co/source-api).

## 0.6.0 (2017-11-04)

- Add support for [Receipt API](https://www.omise.co/receipt-api).
- Fix a bug when uploading dispute document.
- Handle http request errors.
- Drop support for Elixir 1.2 and 1.3.

## 0.5.2 (2017-10-02)

- Add support for [Transfer Schedule API](https://www.omise.co/transfer-schedules-api).

## 0.5.1 (2017-06-07)

- Fix a bug when making an HTTP request to Search API.

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
