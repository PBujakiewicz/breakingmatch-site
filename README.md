# breakingmatch-site

Strona [breakingmatch.com](https://breakingmatch.com) na Cloudflare Pages (direct upload z GitHub Actions). Repo **publiczne**.

```
public/              statyczne pliki strony (bez buildu)
  privacy/           polityka prywatności PL + EN (źródło: breakingmatch-game/privacy/data-inventory.yaml)
  terms/             regulamin PL + EN
  _headers           nagłówki bezpieczeństwa (CSP, HSTS…)
scripts/check-site.sh  kontrole przed deployem (m.in. brak {{PLACEHOLDERÓW}})
```

## Workflow

- `deploy` — PR: tylko kontrole; `main`: kontrole + `wrangler pages deploy` (environment `production`).
- `availability` — codziennie i po deployu: `/privacy` i `/terms` zwracają 200 i zawierają nagłówki PL/EN; błąd → issue `auto-bug` `P0`.
- `secrets-scan` — gitleaks.

## Sekrety (Settings → Secrets and variables → Actions)

| Sekret | Skąd |
|---|---|
| `CLOUDFLARE_API_TOKEN` | token tylko z uprawnieniem *Account → Cloudflare Pages → Edit* |
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare dashboard → Account ID |

Projekt Pages i domeny tworzy Terraform w `breakingmatch-infra/cloudflare` — przed pierwszym deployem.

## Lokalnie

```bash
./scripts/check-site.sh
npx wrangler pages dev public
```
