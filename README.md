# coolimge

Vertical, bold, transparent-background text labels as PNGs, hosted with GitHub Pages
and used as images in Kibana (Kibana only accepts png, jpeg, webp and avif, not SVG).

| File | Text | Colour |
|---|---|---|
| `images/overview.png` | Overview | `#AAAAAA` |
| `images/elastic-stack.png` | Elastic Stack | `#0077CC` |
| `images/azure-resources.png` | Azure Resources | `#00BFB3` |

Once Pages is enabled, each file is available at
`https://<user-or-org>.github.io/<repo>/images/<file>.png`.

## Generating an image

Requirements (macOS): `rsvg-convert` and Pillow.

```bash
brew install librsvg
pip3 install Pillow
```

Generate a single image:

```bash
utils/generate.sh <images/file.png> "<text>" "<#RRGGBB>"

# example
utils/generate.sh images/azure-resources.png "Azure Resources" "#00BFB3"
```

Or edit the `gen ...` lines at the bottom of `utils/generate.sh` and run
`utils/generate.sh` without arguments to rebuild all images.

The text is rotated to read bottom-to-top, set in bold Helvetica/Arial, and the PNG is
cropped tightly with a small margin. Images are rendered at 3x scale so they stay sharp
when Kibana scales them down. Files are written to `images/`.

## Publishing

1. Commit and push the PNGs to `main`.
2. In the repo, go to **Settings → Pages** and set the source to branch `main`, folder `/ (root)`.
3. Wait 1-2 minutes for the deploy (check the **Actions** tab), then use the URL above in Kibana.

## `index.html`

A dynamic page that renders the SVG from query params
(`?color=0xFFFFFF&text=Azure%20Resources`). It works in a browser but cannot be used as
an image source in Kibana, so use the PNGs instead.
