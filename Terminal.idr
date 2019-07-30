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

public export
data Colour : Type where
  Black : Colour
  Red : Colour
  Green : Colour
  Yellow : Colour
  Blue : Colour
  Magenta : Colour
  Cyan : Colour
  White : Colour
  BrightBlack : Colour
  BrightRed : Colour
  BrightGreen : Colour
  BrightYellow : Colour
  BrightBlue : Colour
  BrightMagenta : Colour
  BrightCyan : Colour
  BrightWhite : Colour

colourCode : Colour -> String
colourCode Black = "[30m"
colourCode Red = "[31m"
colourCode Green = "[32m"
colourCode Yellow = "[33m"
colourCode Blue = "[34m"
colourCode Magenta = "[35m"
colourCode Cyan = "[36m"
colourCode White = "[37m"
colourCode BrightBlack = "[90m"
colourCode BrightRed = "[91m"
colourCode BrightGreen = "[92m"
colourCode BrightYellow = "[93m"
colourCode BrightBlue = "[94m"
colourCode BrightMagenta = "[95m"
colourCode BrightCyan = "[96m"
colourCode BrightWhite = "[97m"

export
setColour : Colour -> IO ()
setColour = putStr . escapeString . colourCode
