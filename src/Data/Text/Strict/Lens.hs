{-# LANGUAGE FlexibleContexts #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  Data.Text.Strict.Lens
-- Copyright   :  (C) 2012 Edward Kmett
-- License     :  BSD-style (see the file LICENSE)
-- Maintainer  :  Edward Kmett <ekmett@gmail.com>
-- Stability   :  provisional
-- Portability :  portable
--
----------------------------------------------------------------------------
module Data.Text.Strict.Lens
  ( packed
  , text
  ) where

import Control.Lens
import Data.Text

-- | 'pack' (or 'unpack') strict 'Text'.
--
-- @
-- 'pack' x = x '^.' 'packed'
-- 'unpack' x = x '^.' 'from' 'packed'
-- @
packed :: Simple Iso String Text
packed = iso pack unpack
{-# INLINE packed #-}
{-# SPECIALIZE packed :: Simple Lens String Text #-}

-- | Traverse the individual characters in strict 'Text'.
--
-- >>> anyOf text (=='o') $ "hello"^.packed
-- True
text :: SimpleIndexedTraversal Int Text Char
text = from packed .> itraversed
{-# INLINE text #-}
