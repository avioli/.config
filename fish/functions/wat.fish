function wat
  # Commands:
  # cancel    Cancel the last call to the start command.
  # config    Get and set configuration options.
  # edit      Edit a frame.
  # frames    Display the list of all frame IDs.
  # help      Display help information
  # log       Display each recorded session during the...
  # merge     Perform a merge of the existing frames with a...
  # projects  Display the list of all the existing...
  # remove    Remove a frame.
  # report    Display a report of the time spent on each...
  # restart   Restart monitoring time for a previously...
  # start     Start monitoring time for the given project.
  # status    Display when the current project was started...
  # stop      Stop monitoring time for the current project.
  # sync      Get the frames from the server and push the...
  # tags      Display the list of all the tags.

  set command $argv[1]

  switch (echo $command)
  case 'ca*'
    set command cancel
  case 'co*'
    set command config
  case 'e*'
    set command edit
  case 'f*'
    set command frame
  case 'h*'
    set command help
  case 'l*'
    set command log
  case 'm*'
    set command merge
  case 'p*'
    set command projects
  case 'rem*' 'rm'
    set command remove
  case 'rep*' 'rp'
    set command report
  case 'res*' 'rs'
    set command restart
  case strt
    set command start
  case 'stt*'
    set command status
  case stp
    set command stop
  case 'sy*'
    set command sync
  case 't*'
    set command tags
  case '*'
    set --erase command
    watson $argv
  end

  if test (count $argv) -gt 1
    set kargs $argv[2..-1]
  end

  set -q command; and watson $command $kargs
end
