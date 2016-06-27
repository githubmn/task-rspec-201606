class HighCard
  def name
    'ハイカード'
  end

  def rank
    9
  end

  #
  # ハイカード: 上述の役が1つも成立しない場合
  #  例: D1 D10 S9 C5 C4
  #   C13 D12 C11 H8 H7
  #
  def check(card)
    cards = [StraightFlush.new, FourOfAKind.new, FullHouse.new, Flush.new,
      Straight.new, ThreeOfAKind.new, TwoPair.new, OnePair.new]

    cards.each { |c|
      return false if c.check(card)
    }

    true
  end

end