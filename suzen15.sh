#!/bin/bash
IFS= read -r -d '' text < -diary.txt-; printf '%s\n' "${text//$'\n'/\\n}"