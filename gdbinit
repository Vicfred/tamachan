# Competitive programming GDB configuration.

# Interface.
set confirm off
set pagination off
set listsize 15

# Pretty printing.
set print pretty on
set print array on
set print array-indexes on
set print object on
set print static-members off
set print elements 20
set print frame-arguments scalars

# Breakpoints.
set breakpoint pending on

# Persistent command history.
set history save on
set history filename ~/.gdb_history
set history size 10000

# Disable useless warning noise on launch
set verbose off
