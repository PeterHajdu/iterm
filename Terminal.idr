module Terminal

%include C "terminal.h"
%link C "terminal.o"

public export
setRaw : IO ()
setRaw = foreign FFI_C "set_raw_terminal" (IO ())
