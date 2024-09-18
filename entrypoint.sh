#!/bin/bash

_term() { 
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM

echo "FRONT STARTS IN DEVEL"
npm run dev -- --host 0.0.0.0 --port 5173 &

child=$! 
wait "$child"

