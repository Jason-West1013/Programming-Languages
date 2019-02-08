
Program pla2;

Var 
  inputFile:      text;
  i:              integer;
  isWord:         boolean;
  totalLines:     integer;
  totalChars:     integer;
  totalWords:     integer;
  line:           packed array [1..75] Of char;
  word:           string;

Begin
  totalLines := 0;
  totalChars := 0;
  totalWords := 0;
  word := '';

  assign(inputFile, 'test4.txt');
  reset(inputFile);

  While Not EOF (inputFile) Do
    Begin
      isWord := true;
      readln(inputFile, line);
      totalLines := totalLines + 1;

      For i := 1 To 75 Do
        Begin
          If (line[i] <> ' ') And (ord(line[i]) <> 0) Then
            totalChars := totalChars + 1;

          // if it's a new word
          If (word = '') Then
            Begin
              // test that the first character is a letter
              If (line[i] In ['a'..'z', 'A'..'Z']) Then
                Begin
                  word := line[i];
                  continue;
                End
              Else
                // if not set flag, and if not a blank space continue
                isWord := false;
              If (line[i] <> ' ') And (ord(line[i]) <> 0) Then
                Begin
                  word := line[i];
                  continue;
                End;
            End
          Else
            Begin
              // if not a new word, test remaining characters
              If (line[i] In ['a'..'z', 'A'..'Z', '0'..'9', '-', '_']) Then
                Insert(line[i], word, length(word) + 1)
              Else
                Begin
                  If (isWord = true) Then
                    Begin
                      // write word into list
                      totalWords := totalWords + 1;
                      //writeln(word);
                    End;
                  word := '';
                  isWord := true;
                End;
            End;
        End;
    End;

  writeln(totalLines);
  writeln(totalChars);
  writeln(totalWords);
End.
