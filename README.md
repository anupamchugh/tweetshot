# tweetshot

`bird + ffmpeg + jq` in one CLI for tweet/X media analysis.

`tweetshot` fetches tweet text and media without a paid X API key, downloads the media, extracts representative video frames, and emits a JSON blob plus an optional analysis prompt or OpenAI-powered media analysis.

## What it does

```text
tweet URL
-> bird read --json
-> media URLs
-> curl download
-> ffmpeg frame extraction
-> JSON output
-> optional analysis_prompt.md
-> optional analysis.md from OpenAI
```

By default it prepares media for inference. With `--analyze`, it calls OpenAI's Responses API and writes `analysis.md`.

## Install

```bash
brew install ffmpeg jq
npm install -g @steipete/bird
curl -L -o ~/bin/tweetshot https://raw.githubusercontent.com/anupamchugh/tweetshot/main/tweetshot
chmod +x ~/bin/tweetshot
```

## Usage

```bash
tweetshot "https://x.com/example/status/1234567890" --frames 8 --analyze-prompt
tweetshot "https://x.com/example/status/1234567890" --frames 8 --analyze
```

Output shape:

```json
{
  "tweet_id": "1234567890",
  "author": { "username": "example", "name": "Example User" },
  "text": "...",
  "media_count": 1,
  "analysis": "/tmp/tweetshot/.../analysis.md",
  "media": [
    {
      "type": "video",
      "path": "/tmp/tweetshot/.../video_0.mp4",
      "frames": ["/tmp/tweetshot/.../frame_01.jpg"],
      "duration_sec": 47.0,
      "transcript": null
    }
  ],
  "analysis_prompt": "/tmp/tweetshot/.../analysis_prompt.md",
  "output_dir": "/tmp/tweetshot/..."
}
```

## Options

```text
--frames N         Target frame count per video. Default: 8
--out DIR          Output base directory. Default: $TMPDIR/tweetshot
--thread           Use bird thread --json
--transcribe       Optional Whisper transcript. Needs whisper-cli and WHISPER_MODEL
--analyze-prompt   Write analysis_prompt.md beside the media
--analyze          Call OpenAI on extracted frames. Needs OPENAI_API_KEY
--model MODEL      Model for --analyze. Default: gpt-4.1-mini
```

## Why not just use media-mcp?

Use both when useful. `media-mcp` has a richer media pipeline, but its X tools require a paid TwitterAPI.io key. `tweetshot` is the small no-key primitive for agents and shell workflows.

## License

MIT
