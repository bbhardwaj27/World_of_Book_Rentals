---
name: test
description: Run this app's Minitest suite, or a single file or test, with the flags this machine needs. Use when asked to run tests, check that tests pass, or verify a change with tests.
argument-hint: "[file or file:line] (optional; omit to run everything)"
---
Run the Rails tests for World of Book Rentals.

1. Build the command. Always prefix it with `DISABLE_SPRING=1` (Spring hangs on this machine):
   - With an argument (`$ARGUMENTS`), run only that: `DISABLE_SPRING=1 bin/rails test $ARGUMENTS`
   - Without one, run everything: `DISABLE_SPRING=1 bin/rails test`
   Never run `db:seed` or `db:reset` to prepare for tests: the seeds delete all users, books and reviews.
2. Run it with a timeout of at least 5 minutes. The full-suite output can be very large (failing tests dump whole objects), so pipe it through `grep -E "^[0-9]+ runs,|Failure:|Error:|^(test_|[A-Z][A-Za-z]+Test#)|rails test " | cut -c1-200` or similar and pull detail from individual failures only as needed.
3. Report:
   - The totals line (runs, assertions, failures, errors).
   - Each failing or erroring test with its file:line and a one-line reason.
   - The suite was fully green as of 2026-10-14, so treat any failure as new and say which recent change likely caused it.
4. Don't fix anything unless asked. If a failure looks caused by recent changes, say so and offer to fix it.
