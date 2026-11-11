#!/usr/bin/env bash
# Kontrole przed deployem: brak niewypełnionych {{PLACEHOLDERÓW}}, wymagane strony istnieją.
set -euo pipefail
cd "$(dirname "$0")/../public"

fail=0
for f in index.html privacy/index.html terms/index.html 404.html _headers; do
  [[ -f "$f" ]] || { echo "Brak pliku: $f"; fail=1; }
done

if grep -rnE '\{\{[A-Z_]+\}\}' . ; then
  echo "Niewypełnione placeholdery (powyżej) — uzupełnij przed publikacją."
  fail=1
fi

grep -q 'id="pl"' privacy/index.html && grep -q 'id="en"' privacy/index.html || { echo "privacy: brak sekcji PL/EN"; fail=1; }
grep -q 'id="pl"' terms/index.html && grep -q 'id="en"' terms/index.html || { echo "terms: brak sekcji PL/EN"; fail=1; }

exit $fail
