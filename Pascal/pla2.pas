
Program pla2;

// Record used to store the words and frequencies

Type 
  WordFreq = Record
    word:         string;
    freq:         integer;
  End;

Var 
  inputFile:      text;
  i:              integer;
  j:              integer;
  isWord:         boolean;
  wordFound:      boolean;
  totalLines:     integer;
  totalChars:     integer;
  totalWords:     integer;
  line:           packed array [1..75] Of char;
  list:           packed array [1..200] Of WordFreq;
  word:           string;

Begin
  // Variable initiation
  totalLines := 0;
  totalChars := 0;
  totalWords := 0;
  word := '';

  // Open file
  assign(inputFile, 'test4.txt');
  reset(inputFile);

  // Begin of huge main loop 
  While Not EOF (inputFile) Do
    Begin
      isWord := true;
      readln(inputFile, line);
      totalLines := totalLines + 1;

   // Put each line of the text file into an array and loop picking out the data
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
                      totalWords := totalWords + 1;

                      // Add word to list or increment its frequency
                      j := 1;
                      wordFound := false;

                      // Search list for word ignoring empty elements
                      While (ord(list[j].freq) <> 0) Do
                        Begin
                          If (list[j].word = word) Then
                            Begin
                              wordFound := true;
                              break;
                            End;
                          j := j + 1;
                        End;

                      If Not(wordFound) Then
                        Begin
                          list[j].word := word;
                          list[j].freq := 1;
                        End
                      Else
                        Begin
                          list[j].freq := list[j].freq + 1;
                        End;
                    End;

                  // reset values
                  word := '';
                  isWord := true;
                End;
            End;
        End;
    End;

  i := 1;
  While (ord(list[i].freq) <> 0) Do
    Begin
      writeln(list[i].word);
      writeln(list[i].freq);
      i := i + 1;
    End;

  writeln(totalLines);
  writeln(totalChars);
  writeln(totalWords);
End.
