class Hand
  #
  # 役を取得
  #
  # raise 'format error'
  #
  def get_hand(card)
    hands = [StraightFlush.new, FourOfAKind.new, FullHouse.new, Flush.new,
      Straight.new, ThreeOfAKind.new, TwoPair.new, OnePair.new, HighCard.new]

    hands.each { |h|
      if h.check(card)
        return h
      end
    }
  end

end
