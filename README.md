# pdf2textmovie

## Version 0.1 (for macOS 12.4 Monterey)

## by Shyamal Suhana Chandra, shyamalc@gmail.com

-----------

**Purpose:** This bash script for MacOS is used to convert the most latest created PDF in the same directory into a single text movie video with embedded speech synthesis.

-----------

**Preliminary Prerequisites:** 

0. First, install [homebrew](https://brew.sh) and [pip](https://pip.pypa.io/en/stable/) on MacOS device.
1. Please do a `brew install pkg-config poppler`.
2. Please do a `sudo pip install --user pdftotext`.
3. Please do a `brew install ffmpeg`.
4. Please do a `sudo pip install --user numpy`.
5. Run the following commands in this [comment](https://github.com/mozilla/TTS/issues/726#issuecomment-913570903).
6. Please do a `sudo pip install --user TTS`.
7. Please do a `brew install imagemagick`.

Also, do a `chmod +x pdf2textmovie.sh` when you get into the 'pdftotextmovie' folder before running.

**Example argument list with the command inside the directory of the PDF that needs to be converted into a text movie with embedded speech synthesis:**

`./pdf2textmovie.sh 

-----------
