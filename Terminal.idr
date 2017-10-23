module Terminal

%include C "terminal.h"
%link C "terminal.o"

public export
setRaw : IO ()
setRaw = foreign FFI_C "set_raw_terminal" (IO ())

public export
escapeString : String -> String
escapeString command = strCons '\ESC' command

public export
moveCursor : Int -> Int -> IO ()
moveCursor x y = do
  putStrLn $ escapeString $ "[" ++ show y ++ ";" ++ show x ++ "H"

public export
clearScreen : IO ()
clearScreen = do
  putStrLn $ escapeString "[2J"
  moveCursor 0 0

