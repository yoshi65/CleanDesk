# CleanDesk
Keep your desktop clean by moving unused files to trash

## usage
```
usage: ./CleanDesk.sh [-p]

Keep your desktop clean by moving unused files to trash

optional arguments:
  -p	Choice unused period(default: 7 days)
```

p(period) option's arguments format is [1-9]+[0-9]*[dm].
[1-9]+[0-9]* is the number and [dm] is days(d) or months(m).

If you keep files as exceptions, please make `Except.txt`.
`Except.txt` format is one file name per line.
```
foo
bar
```

## requirements
* zsh

## example
```zsh
% ./CleanDesk.sh
```

If you want to set unused period to a month.
```zsh
% ./CleanDesk.sh -p 1m
```

There is `crontab` as one of the means to be executed periodically.
```zsh
% crontab -e

0 12 * * * $(pwd)/CleanDesk.sh
```
