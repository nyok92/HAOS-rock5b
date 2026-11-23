<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
# V4L2 request-API hwaccel (media-accel/ffmpeg)

FFmpeg has no decoder for the Linux V4L2 stateless (request API) interface. On a
mainline kernel that interface is the only route to the RK3588's `rkvdec` and
`hantro` decoders. These 13 patches add it: a `v4l2request` hardware device type,
the shared request-API code, and hwaccels for MPEG-2, H.264, HEVC, VP8, VP9 and AV1.

They apply first in the `ffmpeg` scope, onto the FFmpeg release tag the SoC layer
pins. The graft and the fixes in [`../`](../) apply after them.

## Provenance

The patches are Kwiboo's `FFmpeg` branch `v4l2-request-n8.1`, carried verbatim: the
13 commits from `n8.1` to the branch tip `b57fbbe5`, in branch order, with the
original authors and dates. Each patch's patch-id equals its branch commit's.

The branch is based on `n8.1`, and the scope's base is a later tag on
`release/8.1`. All 13 apply to `n8.1.3` with no conflict under strict `git am`.
Carrying them rather than pinning the branch is what lets the image take FFmpeg's
point releases as they are tagged.

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

When Kwiboo moves the branch, regenerate this directory from it rather than
editing a patch here. Replace the 13 files with `git format-patch --zero-commit -N
--filename-max-length=100 <base>..<tip>`, strip the trailing blank line after the
version trailer, and check that the whole `ffmpeg` scope still applies under strict
`git am` onto the pinned tag. The fixes in [`../`](../) that name the request-API
base (`0005`, `0016`) are the ones to re-read when a hwaccel file moves.
