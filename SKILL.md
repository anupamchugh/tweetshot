---
name: tweetshot
description: Use when a user wants to analyze media from a tweet/X post without a paid X API key.
---

# tweetshot

Use `tweetshot` to fetch tweet text/media with `bird`, download images/videos, extract frames with `ffmpeg`, and produce an LLM-ready JSON blob.

## Tool

Run:

```bash
tweetshot "https://x.com/user/status/123" --frames 8 --analyze-prompt
```

Then give the generated `analysis_prompt.md` and frame paths to a multimodal model.

## Notes

- No X API key required; `bird` uses browser cookies.
- `tweetshot` prepares media for analysis. It does not call a model by default.
- `--transcribe` needs `whisper-cli` and `WHISPER_MODEL`.
