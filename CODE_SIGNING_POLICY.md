# Code signing policy

Free code signing provided by [SignPath.io](https://signpath.io), certificate by
[SignPath Foundation](https://signpath.org).

This covers the **Windows** builds of vBase Imager. They're signed with SignPath Foundation's
certificate, so Windows shows **SignPath Foundation** as the publisher.

## What gets signed

- Only builds made by this repository's GitHub Actions workflow
  (`.github/workflows/vbase-build.yml`) from the `vbase` branch. Nothing built on a
  developer's own computer is ever signed.
- Only releases: a vBase release tag (`vbase-v*`), or a run started by hand with *sign* chosen. Ordinary
  pushes are built unsigned.
- Every signing request is approved by hand in SignPath before it's signed.
- Signed: vBase Imager's own programs (`vbase-imager.exe` and the other `.exe` files built
  from this source), and then the self-contained `vbase-imager.exe` that packs them (7-Zip's
  public-domain SFX module with the app's files appended). Libraries from other projects (Qt
  and the like) keep their publishers' signatures, if they have any.

## Team

| Role | Members |
|---|---|
| Committers and reviewers | [MSNFernando](https://github.com/MSNFernando) |
| Approvers | [MSNFernando](https://github.com/MSNFernando) |

Everyone in these roles uses multi-factor authentication on GitHub and on SignPath.

## Privacy

This program will not transfer any information to other networked systems unless
specifically requested by the user or the person installing or operating it.

What it contacts, and only when you use it:

- **The vBase release list**: `https://raw.githubusercontent.com/MSNFernando/vbase-releases/main/os_list.json`,
  when it starts, so it can show the releases.
- **The release you choose**: the image file named in that list (a GitHub release download),
  when you write a stick.

It sends no telemetry, usage statistics or crash reports, and it has no account sign-in.
GitHub's privacy statement covers those two downloads:
<https://docs.github.com/site-policy/privacy-policies/github-general-privacy-statement>.

Settings (such as the language) are stored on your computer only.
