#!/bin/bash
bounce install

code-server --bind-addr="0.0.0.0:8000" --auth="none" --disable-getting-started-override --disable-workspace-trust ${DEFAULT_FOLDER}