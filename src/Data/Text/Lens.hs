{-# LANGUAGE FlexibleContexts #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  Data.Text.Lens
-- Copyright   :  (C) 2012 Edward Kmett
-- License     :  BSD-style (see the file LICENSE)
-- Maintainer  :  Edward Kmett <ekmett@gmail.com>
-- Stability   :  provisional
-- Portability :  portable
--
----------------------------------------------------------------------------
module Data.Text.Lens
  ( IsText(..)
  ) where

import           Control.Lens
import           Data.Text as Strict
import qualified Data.Text.Strict.Lens as Strict
import           Data.Text.Lazy as Lazy
import qualified Data.Text.Lazy.Lens as Lazy

-- | Traversals for strict or lazy 'Text'
class IsText t where
  -- | 'pack' (or 'unpack') strict or lazy 'Text'.
  --
  -- @
  -- 'pack' x = x '^.' 'packed'
  -- 'unpack' x = x '^.' 'from' 'packed'
  -- @
  packed :: Simple Iso String t

  -- | Traverse the individual characters in strict or lazy 'Text'.
  --
  -- >>> anyOf text (=='o') $ "hello"^.packed
  -- True
  text :: SimpleIndexedTraversal Int t Char
  text = from packed .> itraversed
  {-# INLINE text #-}

instance IsText Strict.Text where
  packed = Strict.packed
  {-# INLINE packed #-}
  {-# SPECIALIZE packed :: Simple Lens String Strict.Text #-}
  text = Strict.text
  {-# INLINE text #-}

instance IsText Lazy.Text where
  packed = Lazy.packed
  {-# INLINE packed #-}
  {-# SPECIALIZE packed :: Simple Lens String Lazy.Text #-}
  text = Lazy.text
  {-# INLINE text #-}
