# Backend Challenge

I have only use the https://api.magicthegathering.io/v1/cards endpoint from the Magic the Gathering API, without using any query parameters for filtering.

By running `ruby run.rb`  the command line will output:

* A list of all **Cards** grouped by **`set`**.
* A list of all **Cards** grouped by **`set`** and then each **`set`** grouped by **`rarity`**.
* A list of cards from the  **Khans of Tarkir (KTK)** that have the colours `red` AND `blue` 

Tests can be run with `rake test`.

Minor comment: I believe there might be an error in the challenge description: the results from https://api.magicthegathering.io/v1/cards?set=KTK&colors=Red,Blue contain cards that have Red and Blue colors, but not exclusively only those two colors. However, the challenge description affirms that those result ONLY have the colors Red and Blue.

## Environment

* I use Ruby 2.6.5.

## Limitations

* No third-party library that wraps the MTG API was used.
* Only the https://api.magicthegathering.io/v1/cards endpoint was used for fetching all the cards. No query parameters to filter the cards were used.

## Bonus points for...

* I only use Ruby's standard library. There is no Gemfile.
* I parallelize the retrieval of all the **Cards**  to speed up things.
* To respect the API's Rate Limiting facilities, I use a simple memoization tecnique on the class `Card`.

## TODOS with more time

* Implement `'optparse'` for a proper command line tool.
* Unit test each public method on each class under `/lib` (`Card, Fetcher, Query`).