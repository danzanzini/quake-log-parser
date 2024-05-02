# Quake Log Parsing Application

This Ruby application parses a Quake game log file and generates a report with information about kills.

## Usage

1. Ensure that you have Ruby installed on your system.
2. Run bundle install to install dependencies
3. Place the Quake game log file in the `resources` directory with the name `quake_logs.txt`.
4. Run `rake run` to execute the application.
5. Run `rake test` to run the tests.

## Further improvements

#### Test coverage and exception handling
Several use cases were implemented as part of the development of the app, but edge cases were not covered.
Exception handling was also not covered.

#### FileProcessor
As it is now, the FileProcessor has too many responsibilities and doesn't have a end to end test.
The case clause where the entries are handled should be moved elsewhere making it more modular and testable.

#### Type Handling
The log types, i.e: `:kill, :client_connect`, are too loose in the code.
We can improve it by creating a Enum class.

#### Input receivable
For now, only the file at `resources/quake_logs.txt` will be used to generate a report.
It's possible to improve it by reading through input.
