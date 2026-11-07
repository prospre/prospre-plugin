# Official MCP registry

The listing for https://registry.modelcontextprotocol.io is `mcp-registry/server.json`:
`io.prospre/prospre`, one remote (`streamable-http`, `https://www.prospre.io/mcp`), no packages,
no headers. Authentication is OAuth, which the client discovers from the server's 401 challenge,
so the manifest carries nothing secret. `mcp-publisher validate` (v1.8.8) passes against the
registry. It holds only public facts: name, title, description (100 characters at most), version,
website, repository and the server URL.

## How it is published

The namespace `io.prospre` is proved by DNS: a TXT record at the apex of `prospre.io`
(`v=MCPv1; k=ed25519; p=<public key>`) and the matching Ed25519 private key. One key serves the
whole domain. That key exists only as the GitHub Actions secret `MCP_PUBLISHER_KEY` in
`prospre/nutrition-intelligence`; it was generated there on 2026-11-07 and never printed, so it
cannot be copied into this repository. This listing is therefore published by that repository's
manual workflow, `publish-mcp-registry`, run with the `listing` input set to `prospre`: it checks
out this repository (public) at `main`, validates `mcp-registry/server.json`, logs in with the DNS
proof and publishes.

```
gh workflow run publish-mcp-registry -R prospre/nutrition-intelligence -f listing=prospre
```

To update the listing, change `server.json` on `main`, bump `version`, and run the workflow again.
The registry rejects a publish whose version already exists.

## Checks

- `dig +short TXT prospre.io` shows the `v=MCPv1` record (the login fails without it:
  `no MCP public key found in DNS TXT records`).
- After a publish, `https://registry.modelcontextprotocol.io/v0.1/servers?search=io.prospre/prospre`
  lists the version.
