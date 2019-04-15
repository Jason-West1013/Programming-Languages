 -- V3 of PLA4
 -- this changes the program to include file input and output instead of
 -- just user input
with ada.strings.unbounded; use ada.strings.unbounded;
with ada.integer_text_io; use ada.integer_text_io;
with ada.text_io; use ada.text_io;

procedure v3  is
   type word is record
      s: string(1 .. 120);  -- the string.  assume 120 characters or less
      wlen: natural;        -- length of the word
      count: natural := 0;  -- total number of occurrences of this word
   end record;

   type word_array is array(1 .. 1000) of word;

   type word_list is record
      words: word_array;        --  the unique words
      num_words: natural := 0;   --  how many unique words seen so far
   end record;

   procedure get_words(wl: out word_list) is
      input: file_type;
   begin
      open (file => input, mode => in_file, name => "test3.txt");

      wl.num_words := 0;  -- only to get rid of a warning
      loop
         declare
             line: string := get_line (input);
            word_buff: unbounded_string;
         begin
            for j in 1 .. line'length loop
               declare
                  is_word: boolean := true;
                  found: boolean := false;
                  word_complete: boolean := false;
                  char_val : integer;
               begin
                  char_val := character'pos(line(j));

                  -- test each word for correct format
                  if (length(word_buff) = 0) and (((char_val < 65) or (char_val > 90)) and ((char_val < 97) or (char_val > 122))) then
                     is_word := false;
                  elsif ((char_val >= 48) and (char_val < 58)) or ((char_val >=65) and (char_val < 91)) or ((char_val >= 97) and (char_val < 123)) or (char_val = 45) or (char_val = 95) then
                     append(word_buff, line(j));
                  else
                     word_complete := true;
                  end if;

                  -- if word is complete add it to the frequency list
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
                        if not found then -- add word to list
                           wl.num_words := wl.num_words + 1;
                           wl.words(wl.num_words).s(1 .. length(word_buff)) := to_string(word_buff);
                           wl.words(wl.num_words).wlen := length(word_buff);
                           wl.words(wl.num_words).count := 1;
                        end if;

                     end if; -- if is_word
                     delete(word_buff, 1, length(word_buff));
                  end if; -- if word_complete if

               end; -- declare
            end loop;
         end; --  declare
      end loop;
      close(input);
      exception
      when end_error =>
         if is_open(input) then
            close(input);
         end if;
   end get_words;

   -- sort the frequency list using an insertion sort algorithm
   procedure sort_words(wl: in out word_list) is
         n : integer := wl.num_words;
         j : integer;
         temp : word;
   begin
      for i in 2 .. n loop
         temp := wl.words(i);
         j := i - 1;
         while j in wl.words'range and then wl.words(j).s > temp.s loop
            wl.words(j + 1) := wl.words(j);
            j := j - 1;
         end loop;
         wl.words(j + 1) := temp;
      end loop;
   end sort_words;

   procedure put_words(wl: word_list) is
      output: file_type;
   begin
      create (file => output, mode => out_file, name => "output.txt");
      for i in 1 .. wl.num_words loop
         put(output, wl.words(i).count);
         put(output, " " & wl.words(i).s(1 .. wl.words(i).wlen));
         new_line(output);
      end loop;
   close(output);
   exception
      when end_error =>
         if is_open(output) then
            close(output);
         end if;
   end put_words;

   the_words: word_list;
begin
   get_words(the_words);
   sort_words(the_words);
   put_words(the_words);
end v3;