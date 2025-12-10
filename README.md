# 𓄂 Art DeCC0s Meme Generator API 𓄘

**A Community Meme Creation API for the Museum of Crypto Art**

An API to programmatically generate memes based solely on requested URLs. Built for the [Art DeCC0s community](https://discord.com/invite/Rs7wxUTrWV) and part of MOCA's [Vibe Studio](https://vibe.museumofcryptoart.com) ecosystem.

[![API Docs](https://img.shields.io/badge/API-Documentation-FF9500)](https://api-memegen.decc0s.com/docs/) [![OpenAPI](https://img.shields.io/badge/OpenAPI-3.0-FF9500)](https://api-memegen.decc0s.com/docs/openapi.json) [![Meme Generator](https://img.shields.io/badge/App-memegen.decc0s.com-FF9500)](https://memegen.decc0s.com) [![License](https://img.shields.io/badge/license-MIT-blue)](https://github.com/mocaOS/memegen-api/blob/main/LICENSE.txt)

## About Art DeCC0s

Art DeCC0s are the Museum of Crypto Art's 10,000-piece PFP collection—a love-letter to crypto art and its amazing artists, collectors, developers, and admirers. Each DeCC0 is a completely unique 1/1 character with unprecedented visual diversity and, through [The Codex](https://codex.decc0s.com), deep AI-driven personalities.

This API powers the community meme generator at [memegen.decc0s.com](https://memegen.decc0s.com), enabling community members to create and share memes that become part of Art DeCC0s culture and history.

**Community Links:**
- 🎨 [Meme Generator](https://memegen.decc0s.com) - Create memes with this API
- 💬 [Art DeCC0s Discord](https://discord.com/invite/Rs7wxUTrWV) - Join the community
- 📖 [The Codex](https://codex.decc0s.com) - Explore DeCC0 personalities
- 🏛️ [Vibe Studio](https://vibe.museumofcryptoart.com) - MOCA's application hub

---

# API Overview

The Art DeCC0s Meme Generator API is stateless and uses URL-based requests to generate memes. All the information needed to create a meme is contained in the URL itself—no authentication required for basic usage.

## Quick Reference

| Endpoint | Purpose |
| :------- | :------ |
| `GET /templates` | List all available meme templates |
| `GET /templates/{id}` | Get details about a specific template |
| `POST /images` | Create a meme from a template (returns URL) |
| `GET /images/{template_id}/{text}.{ext}` | Generate and display a meme image |
| `GET /images/custom` | List popular custom memes |
| `POST /images/custom` | Create a meme from any image URL |
| `GET /fonts` | List available fonts |

# Images

The API is stateless so URLs contain all the information necessary to generate meme images. For example, <https://api-memegen.decc0s.com/images/everywhere/memes/memes_everywhere.png> produces:

![Example Image](https://api-memegen.decc0s.com/images/everywhere/memes/memes_everywhere.png)

## Available Formats

Clients can request `.jpg` instead of `.png` for smaller files. The `.gif` and `.webp` extensions can be used if an animated background is available or to animate text on static backgrounds:

| Format                     | Example                                                                                                     |
| :------------------------- | :---------------------------------------------------------------------------------------------------------- |
| PNG                        | [/images/spongebob-rainbow/small_file/high_quality.png](https://api-memegen.decc0s.com/images/spongebob-rainbow/small_file/high_quality.png)    |
| JPEG                       | [/images/sad-escobar/high_quality/small_file.jpg](https://api-memegen.decc0s.com/images/sad-escobar/high_quality/small_file.jpg)    |
| GIF (animated background)  | [/images/bernie-support/you_get/animated_text.gif](https://api-memegen.decc0s.com/images/bernie-support/you_get/animated_text.gif)         |
| GIF (static background)    | [/images/leonardo-cheers/animates_text/in_production.gif](https://api-memegen.decc0s.com/images/leonardo-cheers/animates_text/in_production.gif)   |
| WebP (animated background) | [/images/say-that-again/you_get/animated_text.webp](https://api-memegen.decc0s.com/images/say-that-again/you_get/animated_text.webp)       |
| WebP (static background)   | [/images/scientist-myself/animates_text/in_production.webp](https://api-memegen.decc0s.com/images/scientist-myself/animates_text/in_production.webp) |

## Custom Dimensions

Images can be scaled to a specific width or height using the `width=<int>` and `height=<int>` query parameters. If both are provided (`width=<int>&height=<int>`), the image will be padded to the exact dimensions.

For example, <https://api-memegen.decc0s.com/images/gentlemen-inform/width_or_height/why_not_both~q.png?height=450&width=800> produces:

![Custom Size](https://api-memegen.decc0s.com/images/gentlemen-inform/width_or_height/why_not_both~q.png?height=450&width=800&token=6alj86spiq9iyevbknm3)

## Special Characters

In URLs, spaces can be inserted using underscores or dashes:

- underscore (`_`) → space (` `)
- dash (`-`) → space (` `)
- 2 underscores (`__`) → underscore (`_`)
- 2 dashes (`--`) → dash (`-`)
- tilde + N (`~n`) → newline character

Reserved URL characters can be included using escape patterns:

- tilde + Q (`~q`) → question mark (`?`)
- tilde + A (`~a`) → ampersand (`&`)
- tilde + P (`~p`) → percentage (`%`)
- tilde + H (`~h`) → hashtag/pound (`#`)
- tilde + S (`~s`) → slash (`/`)
- tilde + B (`~b`) → backslash (`\`)
- tilde + L (`~l`) → less-than sign (`<`)
- tilde + G (`~g`) → greater-than sign (`>`)
- 2 single quotes (`''`) → double quote (`"`)

Emojis are also supported, both as characters (👍) and aliases (`:thumbsup:`).

For example, <https://api-memegen.decc0s.com/images/ancient-aliens/~hspecial_characters~q/underscore__-dash--_:thumbsup:.png> produces:

![Escaped Characters](https://api-memegen.decc0s.com/images/ancient-aliens/~hspecial_characters~q/underscore__-dash--_:thumbsup:.png?token=0wzowe01f5oxdtaqz21i)

All of the `POST` endpoints will return image URLs with special characters replaced with these alternatives.

# Programmatic Usage

You can also interact with the API programmatically to create memes:

## List All Templates

```bash
curl https://api-memegen.decc0s.com/templates
```

## Create a Meme (POST)

```bash
curl -X POST https://api-memegen.decc0s.com/images \
  -H "Content-Type: application/json" \
  -d '{
    "template_id": "buzz",
    "text": ["memes", "memes everywhere"]
  }'
```

Returns:
```json
{
  "url": "https://api-memegen.decc0s.com/images/buzz/memes/memes_everywhere.png"
}
```

## Create a Custom Meme from Any Image

```bash
curl -X POST https://api-memegen.decc0s.com/images/custom \
  -H "Content-Type: application/json" \
  -d '{
    "background": "https://example.com/your-image.jpg",
    "text": ["top text", "bottom text"]
  }'
```

# Templates

The list of predefined meme templates is available here: <https://api-memegen.decc0s.com/templates/>

## Custom Backgrounds

You can also use your own image URL as the background.

For example, <https://api-memegen.decc0s.com/images/custom/_/my_background.png?background=http://www.gstatic.com/webp/gallery/1.png> produces:

![Custom Background](https://api-memegen.decc0s.com/images/custom/_/my_background.png?background=http://www.gstatic.com/webp/gallery/1.png&width=800&token=kxxlu7wzoxgp5l2iruta)


# Layouts

Add the `layout=<str>` query parameter to switch between the default and `top` text positioning.

For example, <https://api-memegen.decc0s.com/images/spongebob-rainbow/When_you_taste_the_rainbow.webp?layout=top> produces:

![Top Layout](https://api-memegen.decc0s.com/images/spongebob-rainbow/When_you_taste_the_rainbow.webp?layout=top&width=800&token=orgyyu0tuzir7n4ktwvc)

# Fonts

The list of fonts is available here: <https://api.memegen.link/fonts/>

Add the `font=<str>` query parameter to customize the look of your meme:

| Name                                                                   | ID                  | Alias        |
| ---------------------------------------------------------------------- | ------------------- | ------------ |
| [Titillium Web Black](https://fonts.google.com/specimen/Titillium+Web) | `font=titilliumweb` | `font=thick` |
| [Kalam Regular](https://fonts.google.com/specimen/Kalam)               | `font=kalam`        | `font=comic` |
| [Impact](https://www.dafontfree.io/impact-font/)                       | `font=impact`       | -            |
| [Noto Sans Bold](https://fonts.google.com/noto/specimen/Noto+Sans)     | `font=notosans`     | -            |
| [Noto Sans Bold Hebrew](https://fonts.google.com/noto/specimen/Noto+Sans+Hebrew)              | `font=notosanshebrew`    | `font=he`    |
| [HG Mincho B](https://japanesefonts.org/hg-mincho-b.html)              | `font=hgminchob`    | `font=jp`    |


## 📚 API Documentation

Explore the full interactive API documentation with OpenAPI specification at:

**<https://api-memegen.decc0s.com/docs/>**

The OpenAPI JSON specification is also available at: <https://api-memegen.decc0s.com/openapi.json>

---

## 🤝 Community & Ecosystem

This API is part of the Art DeCC0s community infrastructure, supporting meme creation and sharing within the Museum of Crypto Art ecosystem.

### Create & Share Memes

1. **Use the Meme Generator**: Visit [memegen.decc0s.com](https://memegen.decc0s.com) for a user-friendly interface
2. **Or use this API directly**: Generate memes programmatically with URL-based requests
3. **Share with the community**: Post your creations in the [Art DeCC0s Discord](https://discord.com/invite/Rs7wxUTrWV)
4. **View the collection**: Community memes live on at [Vibe Studio](https://vibe.museumofcryptoart.com)

### Part of the Vibe Studio

The Vibe Studio is MOCA's nexus for everything the Museum of Crypto Art has created, is creating, and will create. This Meme Generator API is one piece of a larger ecosystem that includes The Codex, The Adoption Center, The DeCC0 Agent Launcher, and more.

### 🔗 Links

- **[The Vibe Studio](https://vibe.museumofcryptoart.com/)** - Visit the Museum of Crypto Art
- **[The Codex](https://codex.decc0s.com/)** - 100M+ words of DeCC0 personalities
- **[Adopt DeCC0s](https://adopt.decc0s.com/)** - Launch the Adoption Center
- **[Art DeCC0s Discord](https://discord.com/invite/Rs7wxUTrWV)** - Join the community

## 📝 License

This project is MIT licensed and available for use by the community and beyond. See the original memegen repository by jacebrowning, this fork doesn't add anything to the licence.

## 🙏 Credits

Powered by the MOCA technical team for the Art DeCC0s community.

Special thanks to all community members who create and share memes, building the culture and spirit of Art DeCC0s.