 -- Read one word per line and print list of unique words and their frequencies
-- Case sensitive
-- This is a minimalist version.  No bells or whistles.
WITH Ada.Strings.Unbounded; USE Ada.Strings.Unbounded;
with ada.integer_text_io; use ada.integer_text_io;
WITH Ada.Text_Io; USE Ada.Text_Io;

procedure v3  is
   type Word is record
      s: String(1 .. 120);  -- The string.  Assume 120 characters or less
      wlen: Natural;        -- Length of the word
      count: Natural := 0;  -- Total number of occurrences of this word
   end record;

   type Word_Array is array(1 .. 1000) of Word;

   type Word_List is record
      words: Word_Array;        --  The unique words
      num_words: Natural := 0;   --  How many unique words seen so far
   end record;

   PROCEDURE Get_Words(Wl: OUT Word_List) IS
      Input: File_Type;
   BEGIN
      Open (File => Input, Mode => In_File, Name => "test3.txt");

      wl.num_words := 0;  -- only to get rid of a warning
      loop
         declare
             line: String := Get_Line (Input);
            word_buff: Unbounded_String;
         begin
            for j in 1 .. line'length loop
               declare
                  is_word: Boolean := true;
                  found: Boolean := false;
                  word_complete: Boolean := false;
                  char_val : Integer;
               begin
                  char_Val := Character'Pos(line(J));

                  -- test each word for correct format
                  if (length(word_buff) = 0) and (((char_val < 65) or (char_val > 90)) and ((char_val < 97) or (char_val > 122))) then
                     is_word := false;
                  elsif ((char_val >= 48) and (char_val < 58)) or ((char_val >=65) and (char_val < 91)) or ((char_val >= 97) and (char_val < 123)) or (char_val = 45) or (char_val = 95) then
                     append(word_buff, line(j));
                  else
                     word_complete := true;
                  end if;

                  -- If word is complete add it to the frequency list
                  if (word_complete) or ((j + 1) > line'length) then
                     if (is_word) then

                        for i in 1 .. wl.num_words loop
                           if to_string(word_buff) = wl.words(i).s(1 .. wl.words(i).wlen) then
                              wl.words(i).count := wl.words(i).count + 1;
                              found := true;
                           end if;
                        exit when found;
                        end loop;

                        -- using unbounded string then setting it to a fixed string in the list
                        if not found then -- Add word to list
                           wl.num_words := wl.num_words + 1;
                           wl.words(wl.num_words).s(1 .. length(word_buff)) := to_string(word_buff);
                           wl.words(wl.num_words).wlen := length(word_buff);
                           wl.words(wl.num_words).count := 1;
                        END IF;

                     end if; -- if is_word
                     delete(word_buff, 1, length(word_buff));
                  end if; -- if word_complete if

               end; -- declare
            end loop;
         END; --  declare
      END LOOP;
      Close(Input);
      exception
      when End_Error =>
         if Is_Open(Input) then
            Close(Input);
         end if;
   end get_words;

   -- sort the frequency list using an insertion sort algorithm
   procedure sort_words(wl: in out Word_List) is
         n : integer := wl.num_words;
         j : Integer;
         temp : Word;
   begin
      for i IN 2 .. n loop
         Temp := Wl.Words(I);
         j := i - 1;
         while j in wl.words'range and then wl.words(j).s > temp.s loop
            wl.words(j + 1) := wl.words(j);
            j := j - 1;
         end loop;
         wl.words(j + 1) := temp;
      end loop;
   end sort_words;

   PROCEDURE Put_Words(Wl: Word_List) IS
      Output: File_Type;
   BEGIN
      Create (File => Output, Mode => Out_File, Name => "output.txt");
      for i in 1 .. wl.num_words loop
         put(Output, wl.words(i).count);
         put(Output, " " & wl.words(i).s(1 .. wl.words(i).wlen));
         new_line(Output);
      END LOOP;
   Close(Output);
   exception
      when End_Error =>
         if Is_Open(Output) then
            Close(Output);
         end if;
   end put_words;

   the_words: Word_List;
begin
   get_words(the_words);
   sort_words(the_words);
   put_words(the_words);
end v3;