pdf-mupdf () {
  f=$1
  mupdf $f &
  while inotifywait -e close_write $f; do 
    pkill -HUP mupdf; 
  done
}

pdf-okular () {
  f=$1
  okular $f 2>&1 > /dev/null &
}

# Open a pdf file with auto refresh
pdf () {
  if command -v okular &> /dev/null; then
    pdf-okular "$@"
  elif command -v mupdf &> /dev/null; then
    pdf-mupdf "$@"
  else
    echo "No pdf reader found"
    exit 1
  fi
}

# Can't remeber the name
gnome-pdf () {
  evince "$@" &
}
