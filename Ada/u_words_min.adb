-- Read one word per line and print list of unique words and their frequencies
-- Case sensitive
-- This is a minimalist version.  No bells or whistles.
with ada.integer_text_io; use ada.integer_text_io;
with ada.text_io; use ada.text_io;

procedure u_words_min  is
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

   procedure get_words(wl: out Word_List) is
   begin
      wl.num_words := 0;  -- only to get rid of a warning
      while not End_of_File loop
         declare
            s: String := Get_Line;
            found: Boolean := false;
         begin
            for i in 1 .. wl.num_words loop
               if s = wl.words(i).s(1 .. wl.words(i).wlen) then
                  wl.words(i).count := wl.words(i).count + 1;
                  found := true;
               end if;
               exit when found;
            end loop;

            if not found then -- Add word to list
               wl.num_words := wl.num_words + 1;
               wl.words(wl.num_words).s(1 .. s'last) := s;
               wl.words(wl.num_words).wlen := s'length;
               wl.words(wl.num_words).count := 1;
            end if;
         end; --  declare
      end loop;
   end get_words;

   procedure put_words(wl: Word_List) is
   begin
      for i in 1 .. wl.num_words loop
         put(wl.words(i).count);
         put(" " & wl.words(i).s(1 .. wl.words(i).wlen));
         new_line;
      end loop;
   end put_words;

   the_words: Word_List;
begin
   get_words(the_words);
   put_words(the_words);
end u_words_min;