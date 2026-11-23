<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
# V4L2 request-API hwaccel (media-accel/ffmpeg)

FFmpeg has no decoder for the Linux V4L2 stateless (request API) interface. On a
mainline kernel that interface is the only route to the RK3588's `rkvdec` and
`hantro` decoders. These 13 patches add it: a `v4l2request` hardware device type,
the shared request-API code, and hwaccels for MPEG-2, H.264, HEVC, VP8, VP9 and AV1.

They apply first in the `ffmpeg` scope, onto the FFmpeg release tag the SoC layer
pins. The graft and the fixes in [`../`](../) apply after them.

## Provenance

The patches are Kwiboo's `FFmpeg` branch `v4l2-request-n8.1`: the 13 commits from
`n8.1` to the branch tip `b57fbbe5`, in branch order, with the original authors and
dates, rebased onto the release tag the SoC layer pins. Each patch adds and removes
exactly the lines its branch commit does; the rebase moves context only. The one
exception is `0005`'s fall-through comment, which is `av_fallthrough` here: the base
builds with `-Wimplicit-fallthrough=5`, which accepts no other marker, and the patch
carries a note saying so.

Carrying them rather than pinning the branch is what lets the image take FFmpeg's
releases as they are tagged.

| Patch | Author | Adds |
|---|---|---|
| `0001` | Jonas Karlman | The `v4l2request` hardware device type |
| `0002` | Jonas Karlman | Probing for a video device that decodes the stream's codec and size |
| `0003` | Jonas Karlman | Common request-API helpers: decode session setup, buffers and requests |
| `0004` | Jonas Karlman | Common decode support for the hwaccels below |
| `0005` | Jonas Karlman | MPEG-2 hwaccel |
| `0006` | Boris Brezillon | H.264 slice-context fields the H.264 hwaccel reads |
| `0007` | Jernej Skrabec | H.264 hwaccel |
| `0008` | Jernej Skrabec | HEVC hwaccel |
| `0009` | Boris Brezillon | VP8 hwaccel |
| `0010` | Boris Brezillon | VP9 hwaccel |
| `0011` | Jonas Karlman | AV1 hwaccel |
| `0012` | Jernej Skrabec | AFBC 16x16 split pixel formats |
| `0013` | Jonas Karlman | Broadcom SAND128 pixel formats |

## Re-syncing

When Kwiboo moves the branch, or the SoC layer moves the tag, regenerate this
directory rather than editing a patch here. Rebase the branch's commits onto the
pinned tag, export them with `git format-patch --zero-commit -N
--filename-max-length=100 <tag>..<rebased tip>`, and strip the trailing blank line
after the version trailer. Keep an existing file wherever it still applies at its
position under strict `git am` and adds and removes the same lines, so the directory
changes only where the rebase did, and check that the whole `ffmpeg` scope applies
under strict `git am` onto the pinned tag. The fixes in [`../`](../) that name the request-API
base (`0005`, `0016`) are the ones to re-read when a hwaccel file moves.
