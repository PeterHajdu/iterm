module Terminal

%include C "terminal.h"
%link C "terminal.o"

export
setRaw : IO ()
setRaw = foreign FFI_C "set_raw_terminal" (IO ())

--todo: remove after fix of: https://github.com/idris-lang/Idris-dev/issues/4723
theNat : Int -> Nat
theNat x = if x < 0 then Z else fromIntegerNat $ cast x

getRows' : IO Int
getRows' = foreign FFI_C "get_rows" (IO Int)

export
getRows : IO Nat
getRows = theNat <$> getRows'

getColumns' : IO Int
getColumns' = foreign FFI_C "get_columns" (IO Int)

export
getColumns : IO Nat
getColumns = theNat <$> getColumns'

export
escapeString : String -> String
escapeString command = strCons '\ESC' command

export
moveCursor : Nat -> Nat -> IO ()
moveCursor x y = do
  putStrLn $ escapeString $ "[" ++ show y ++ ";" ++ show x ++ "H"

export
clearScreen : IO ()
clearScreen = do
  putStrLn $ escapeString "[2J"
  moveCursor 0 0

export
hideCursor : IO ()
hideCursor = do
  putStrLn $ escapeString "[?25l"

export
showCursor : IO ()
showCursor = do
  putStrLn $ escapeString "[?25h"
