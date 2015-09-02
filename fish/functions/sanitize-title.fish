function sanitize-title -d 'converts all to dashed a-z'
  tr '[:upper:]' '[:lower:]' | sed -e 's/[^[:alnum:]._-]/-/g;s/--*/-/g;s/-$//g;s/^-//g'
end

