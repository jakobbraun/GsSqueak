Contrary to TTFontDescritption, this class leaves true type files on disk and only reads the required portions when constructing glyphs. This avoids the need of reading the entire font into memory at the cost of having to hit disk whenever a glyph is requested.