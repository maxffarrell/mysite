#!/bin/bash
cd "$(dirname "$0")"
typst compile --font-path fonts cv.typ ../static/resume.pdf
echo "Built resume.pdf -> static/resume.pdf"
