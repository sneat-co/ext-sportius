# ext-sportius

Public definition repository for the Sportius extension that powers the first
Sneat Club surface. The contract is deliberately product-neutral: Sneat Club,
the Sneat Telegram bot and future Sportius surfaces share these stable IDs,
catalogues, DTOs and facade interfaces.

The paired [`sportius`](https://github.com/sneat-co/sportius) repository owns
application logic and persistence. Telegram presentation lives in
[`sneat-bots`](https://github.com/sneat-co/sneat-bots).

## Layout

```text
typespec/   # frozen HTTP/JSON wire contract
backend/    # github.com/sneat-co/ext-sportius/backend
frontend/   # @sneat/extension-sportius-contract
```

TypeSpec is the wire source of truth. Go and TypeScript bindings are
hand-maintained and parity-tested. This repository depends only on foundational
types and never on an extension implementation.
