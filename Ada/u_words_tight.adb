-- Read one word per line and print list of unique words and their frequencies
-- Case sensitive
-- This is a minimalist version.  No bells or whistles.
-- This version has a fast inner loop.  It has only one comparison.
--
-- This is done by always putting the word being sought at the
-- end of the list.  If the word being sought is found earlier
-- in the list, then the value at the end is ignored.  If it is
-- not found earlier, then it has already been added.
-- The final location in the list can't hold a word that is
-- being counted.  It can only be used to hold a sentinal during
-- a search.

with ada.integer_text_io; use ada.integer_text_io;
with ada.text_io; use ada.text_io;

procedure u_words_tight  is
   type Word is record
      str: String (1 .. 120);   -- The string.  Assume 120 characters or less
      wlen: Natural;           -- Length of the word
      count: Natural := 1;     -- Total number of occurrences of this word
   end record;

   type Word_Array is array(1 .. 1000) of Word;

   type Word_List is record
      words: Word_Array;        --  The unique words
      num_words: Natural;   --  How many unique words seen so far
   end record;

   procedure get_words (wl: out Word_List) is
      i : Natural;
   begin
      wl.num_words := 0;  -- Initialize here to avoid a warning
      while not End_of_File loop
         declare
            s: String := Get_Line;
         begin
            wl.words (wl.num_words + 1).str (1 .. s'Last) := s;
            wl.words (wl.num_words + 1).wlen := s'Length;

            i := 1;
            while s /= wl.words (i).str (1 .. wl.words (i).wlen) loop
               i := i + 1;
            end loop;
            --  s = wl.words(i)

            if i = wl.num_words + 1 then
               wl.num_words := wl.num_words + 1;
            else
               wl.words(i).count := wl.words(i).count + 1;
            end if;
         end; --  declare
      end loop;
   end get_words;

   procedure put_words (wl: Word_List) is
   begin
      for i in 1 .. wl.num_words loop
         put (wl.words(i).count);
         put (" " & wl.words(i).str(1 .. wl.words(i).wlen));
         new_line;
      end loop;
   end put_words;

   the_words: Word_List;
begin
   get_words (the_words);
   put_words (the_words);
end u_words_tight;