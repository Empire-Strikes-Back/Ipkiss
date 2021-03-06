#!/bin/bash

repl(){
  clj \
    -J-Dclojure.core.async.pool-size=1 \
    -X:repl Ripley.core/process \
    :main-ns Ipkiss.main
}


main(){
  clojure \
    -J-Dclojure.core.async.pool-size=1 \
    -M -m Ipkiss.main
}

jar(){

  rm -rf out/*.jar
  clojure \
    -X:uberjar Genie.core/process \
    :main-ns Ipkiss.main \
    :filename "\"out/Ipkiss-$(git rev-parse --short HEAD).jar\"" \
    :paths '["src" "out/resources"]'
}

ui(){
  # watch release
  npm i --no-package-lock
  mkdir -p out/resources/ui/
  cp src/Ipkiss/index.html out/resources/ui/index.html
  clj -A:ui -M -m shadow.cljs.devtools.cli $1 ui
}

"$@"