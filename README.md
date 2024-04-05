# pdf2textmovie

## Version 0.2 (for macOS 14.4.1 Sonoma)

## by Shyamal Suhana Chandra, shyamalc@gmail.com
## Copyright 2024
-----------

**Purpose:** This bash script for MacOS is used to convert the most latest created PDF in the same directory into a single text movie video with embedded speech synthesis.

-----------

**Quick installation:** `brew install --build-from-source pdftotextmovie` *(Only one line!)*

To run: `pdftotextmovie` in the directory of the latest pdf.

-----------

# How-to video:

[![How-to video for pdftotextvideo!](https://img.youtube.com/vi/vM0bgBSyReI/0.jpg)](https://www.youtube.com/watch?v=vM0bgBSyReI)

-----------

To run from source:

1. `gh repo clone shyamalschandra/pdftotextmovie`
2. `cd pdftotextmovie`
3. Follow the prequisities below.

-----------

**Preliminary Prerequisites:** 

0. First, install [homebrew](https://brew.sh) and [pip](https://pip.pypa.io/en/stable/) on MacOS device.
1. Please do a `brew install pkg-config poppler`.
2. Please do a `sudo pip install --user pdftotext`.
3. Please do a `brew install ffmpeg`.
4. Please do a `sudo pip install --user numpy`.
5. Run the following commands in this [comment](https://github.com/mozilla/TTS/issues/726#issuecomment-913570903).
6. Please do a `brew install imagemagick`.
7. Download the model for `Zoe (Premium)` from the voices under `Accessibility -> Spoken Content -> System Voice -> under English (US)`.

Also, do a `chmod +x pdf2textmovie.sh` when you get into the 'pdftotextmovie' folder before running.

**Example argument list with the command inside the directory of the PDF that needs to be converted into a text movie with embedded speech synthesis:**

`./pdf2textmovie.sh` 

-----------
