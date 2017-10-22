module Terminal

%include C "terminal.h"
%link C "terminal.o"

public export
set_raw : IO ()
set_raw = foreign FFI_C "set_raw_terminal" (IO ())
