module Terminal

%include C "terminal.h"
%link C "terminal.o"

public export
setRaw : IO ()
setRaw = foreign FFI_C "set_raw_terminal" (IO ())

public export
getRows : IO Int
getRows = foreign FFI_C "get_rows" (IO Int)

public export
getColumns : IO Int
getColumns = foreign FFI_C "get_columns" (IO Int)

public export
escapeString : String -> String
escapeString command = strCons '\ESC' command

public export
moveCursor : Nat -> Nat -> IO ()
moveCursor x y = do
  putStrLn $ escapeString $ "[" ++ show y ++ ";" ++ show x ++ "H"

public export
clearScreen : IO ()
clearScreen = do
  putStrLn $ escapeString "[2J"
  moveCursor 0 0

public export
hideCursor : IO ()
hideCursor = do
  putStrLn $ escapeString "[?25l"

public export
showCursor : IO ()
showCursor = do
  putStrLn $ escapeString "[?25h"
