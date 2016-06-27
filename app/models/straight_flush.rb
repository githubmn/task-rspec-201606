class StraightFlush
  include Card
  def name
    'ストレートフラッシュ'
  end

  def rank
    1
  end

  #
  # ストレートフラッシュ: 同じスートで数字が連続する5枚のカードで構成されている場合
  #  例: C7 C6 C5 C4 C3
  #   H1 H13 H12 H11 H10
  #
  def check(card)
    init_card(card)

    straight && flush
  end

end