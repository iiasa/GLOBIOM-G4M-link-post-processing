# GLOBIOM-G4M-link-post-processing

Containerized post processing for the GLOBIOM G4M link.

`Dockerfile` adapted from https://github.com/iiasa/gams-docker.

To build the container, copy a recent `gamslice.txt` GAMS license files to the
root of the working copy and from there invoke:

`docker build --tag <some tag> .`

**⚠️Warning:** Do **not** push the container image to DockerHub or any other
public registry: it contains a GAMS license file. Use the image only on your
local machine, or a server without public access.
