
Program pla2;

Const 
  MAX_LINE_LENGTH = 100;

Var 
  inputFile:      text;
  letter:         char;
  i:              integer;
  totalLines:     integer;
  totalChars:     integer;
  totalWords:     integer;

  line:           packed array [1..MAX_LINE_LENGTH] Of char;

Begin
  totalChars := 0;
  totalLines := 0;
  totalWords := 0;

  assign(inputFile, 'test4.txt');
  reset(inputFile);

  // Reads in a line at a time
  While Not EOF (inputFile) Do
    Begin
      readln(inputFile, line);

      // counts total lines
      totalLines := totalLines + 1;

      // loops through to pull out words and count chars/words
      For i := 1 To MAX_LINE_LENGTH Do
        Begin
          If (line[i] <> ' ') And (ord(line[i]) <> 0) Then
            totalChars := totalChars + 1;

        End;

    End;

  writeln(totalChars);
  writeln(totalLines);
  writeln(totalWords);
  writeln(line);
  close(inputFile);
End.
