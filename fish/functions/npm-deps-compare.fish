function npm-deps-compare
  jq '. | .dependencies + .devDependencies' package.json | sort -r | tail +3 | sort | sed 's/,//g' | sed 's/\^//g' | sed 's/~//g'  > /tmp/package.versions
  find ./node_modules -name "package.json" -maxdepth 2 | while read file
    set dname (dirname "$file")
    echo -n '  "'(basename "$dname")'": '
    cat "$file" \
      | grep '"version"' \
      | sed 's/  "version": //' \
      | sed 's/,//g'
  end | sort > /tmp/modules.versions
  diff /tmp/package.versions /tmp/modules.versions
end
