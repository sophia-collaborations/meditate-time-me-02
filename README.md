# meditate-time-me-02
A second new-and-improved shell-script tool for meditation.

## A Shell-Script Tool
That means it's very much like a command-line tool - except instead
of being located along the __PATH__ environment variable, it is
located along the __SH\_SCRIP\_TLL\_PATH__ environment variable.

Instead of being invoked as follows ...

    meditate-time-me-02 <rest-of-command-line>

... it will be invoked as follows:

    "$(chobakwrap-pathfind meditate-time-me-02 "${SH_SCRIP_TLL_PATH}")" <rest-of-command-line>
