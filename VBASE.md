# vBase Imager

A USB writer for the vBase installer image, forked from rpi-imager (Apache-2.0,
see `NOTICE` and `license.txt`). Branch `vbase`; `main` tracks upstream.

## Release list (`os_list.json`)

The app reads
`https://raw.githubusercontent.com/MSNFernando/vbase-releases/main/os_list.json`
(set `VBASE_IMAGER_OSLIST_URL` to test another list or a `file://` path).
The vBase release script should write it in this shape:

```json
{
  "imager": {},
  "os_list": [
    {
      "name": "vBase 0.1",
      "description": "Released 26 Nov 2026 · Ubuntu 26.04 · for IBM System x and other x86-64 servers",
      "url": "https://github.com/MSNFernando/vbase-releases/releases/download/v0.1/vbase-0.1.img.xz",
      "extract_size": 5798205440,
      "extract_sha256": "<sha256 of the uncompressed .img>",
      "image_download_size": 1846835200,
      "image_download_sha256": "<sha256 of the .img.xz as downloaded>",
      "release_date": "2026-11-26",
      "icon": "https://raw.githubusercontent.com/MSNFernando/vbase-releases/main/icons/vbase.png"
    }
  ]
}
```

| Field | Needed | Notes |
|---|---|---|
| `name` | yes | Shown as the release title, e.g. `vBase 0.1`, `vBase 0.1 RC 2`. |
| `description` | yes | One line under the title (date, base OS, target hardware). |
| `url` | yes | Direct HTTPS download of the image: `.img`, `.img.xz`, `.img.zst` or `.img.gz`. GitHub release assets are fine. |
| `extract_size` | yes | Bytes of the **uncompressed** image. Drives the write progress bar; also must fit on the stick. |
| `extract_sha256` | yes | SHA-256 of the **uncompressed** image. This is the checksum Imager enforces: it hashes the data as it writes and fails the write on a mismatch. Leaving it out disables the check. |
| `image_download_size` | yes | Bytes of the file at `url` (shown as the download size). |
| `image_download_sha256` | recommended | SHA-256 of the file at `url`. Kept for tooling and humans; Imager itself checks `extract_sha256`. |
| `release_date` | yes | `YYYY-MM-DD`. |
| `icon` | optional | URL of a 40×40 PNG or SVG. Without it the app draws its own release glyph. |

Do not set `init_format`, `devices` or `capabilities`: they belong to Raspberry Pi
OS customisation, which vBase Imager does not use.

### Older versions and test builds

Put the newest release first. Older releases can sit in a sub-list entry so the
main list stays short:

```json
{
  "name": "Older versions",
  "description": "Earlier vBase releases",
  "subitems": [ { "name": "vBase 0.0.9", "...": "same fields as above" } ]
}
```

### Update prompt (optional)

`"imager": { "latest_version": "1.0.1", "url": "https://github.com/MSNFernando/vbase-imager/releases" }`
makes older vBase Imager builds offer the download page. The app's own version
comes from `vbase-v*` git tags on this repo (e.g. `vbase-v1.0.0`); untagged
builds report `1.0.0-dev-g<hash>`.

## Builds

`.github/workflows/vbase-build.yml` builds on every push to `vbase`:
Linux x86_64 AppImage (`create-appimage.sh`, Qt 6.9 from install-qt-action),
plus Windows and macOS jobs. All unsigned; artifacts are attached to the run
(`vbase-imager-linux-x86_64`, `vbase-imager-windows-x64`, `vbase-imager-macos`).

## Names the OS sees

The program is `vbase-imager` (`vbase-imager.exe`, `vBase Imager.app`,
`vbase-imager-<version>-desktop-x86_64.AppImage`). Linux installs
`vbase-imager.desktop`, the `vbase-imager` icon, AppStream id and polkit
actions under `nz.co.onecomet.vbase-imager`; the macOS bundle id and D-Bus name
are `nz.co.onecomet.vbase-imager`; the callback URL scheme is `vbase-imager://`.
Settings and caches live under organisation "ONECOMET", app "vBase Imager", so
nothing is shared with Raspberry Pi Imager. Internal source, class and
translation-catalogue names (`imagewriter.cpp`, `i18n/rpi-imager_*.ts`) keep
their upstream names to ease merges.
