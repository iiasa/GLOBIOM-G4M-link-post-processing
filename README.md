# GLOBIOM-G4M-link-post-processing

Containerized post processing for the GLOBIOM G4M link. Installs, GAMS, R,
and the tidyverse. Based on Debian stable.

`Dockerfile` adapted from https://github.com/iiasa/gams-docker.

To build the container, copy a recent `gamslice.txt` GAMS license file
adjacent to the `Dockerfile` and from that directory invoke:

`docker build --tag <tag> .`

To instantiate and run the container interactively invoke:

`docker run -it [--rm] <tag> [cmd] [args]`

By default (without `[cmd]` nor `[args]`, `R` is invoked for an interactive
R prompt. To see the installed GAMS, invoke:

`docker run -it [--rm] <tag> gams /?`

**⚠️Warning:** Do **not** push the container image to DockerHub or any other
public registry: it contains a GAMS license file. Use the image only on your
local machine, or a server without public access.
