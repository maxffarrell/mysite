# maxffarrell.com

Personal website built with [Zola](https://www.getzola.org) and the [Duckquill](https://duckquill.daudix.one) theme.

## About Zola

Zola is a static site generator (SSG) that comes with a number of built-in features designed to make creating and managing a blog or personal website straightforward:

- **Fast builds**: Zola is written in Rust, providing extremely fast build times
- **No database**: Content is written in Markdown, stored as flat files
- **Templating**: Uses the Tera templating engine for flexible page layouts
- **Built-in Sass compilation**: No need for separate build tools
- **Syntax highlighting**: Automatic code syntax highlighting via Chroma
- **Taxonomies**: Built-in support for tags, categories, and other taxonomies
- **Search**: Built-in search functionality with multiple index formats
- **Internationalization**: Support for multiple languages

### Installing Zola

**macOS (Homebrew):**
```bash
brew install zola
```

**Linux (pre-built binary):**
```bash
curl -sL https://github.com/getzola/zola/releases/download/v<version>/zola-v<version>-x86_64-unknown-linux-gnu.tar.gz | tar xz
sudo mv zola /usr/local/bin/
```

**Windows (Chocolatey):**
```bash
choco install zola
```

**From source (requires Rust):**
```bash
cargo install zola
```

For more installation methods, see the [official Zola documentation](https://www.getzola.org/documentation/installation/).

## Duckquill Theme

[Duckquill](https://duckquill.daudix.one) is an opinionated, modern, clean Zola theme designed for blogging. Key features include:

- Clean, readable typography with Inter and JetBrains Mono fonts
- Dark/light mode support with theme switcher
- Responsive design
- Code syntax highlighting
- KaTeX support for LaTeX math rendering
- Table of contents generation
- Social sharing buttons
- RSS/Atom feed generation
- Multi-language support (i18n)
- Mastodon comment integration

### Installing Duckquill

1. Clone the theme as a submodule:
   ```bash
   git submodule add https://github.com/daudix/duckquill.git themes/duckquill
   ```

   Or clone directly:
   ```bash
   git clone https://github.com/daudix/duckquill.git themes/duckquill
   ```

2. Set the theme in `config.toml`:
   ```toml
   theme = "duckquill"
   ```

3. Copy the theme's config.toml options to your own `config.toml` as needed.

### Updating Duckquill

If using submodules:
```bash
git submodule update --remote themes/duckquill
```

## Development

Run the local development server:
```bash
zola serve
```

Build for production:
```bash
zola build
```

The output will be generated in the `public/` directory.

## Project Structure

```
mysite/
├── config.toml          # Site configuration
├── content/            # Markdown content files
│   ├── _index.md       # Homepage content
│   ├── posts/          # Blog posts
│   ├── projects/       # Projects page
│   └── resume/         # Resume page
├── static/             # Static assets (CSS, images, PDFs)
├── templates/          # Custom templates
└── themes/
    └── duckquill/     # Theme files (git submodule)
```

## License

Content is MIT licensed. See individual files for specific licenses.
