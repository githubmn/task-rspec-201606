class Straight
  include Card
  def name
    'ストレート'
  end

  def rank
    5
  end

  #
  # ストレート: 数字が連続した5枚のカードによって構成されている場合
  #  例: S8 S7 H6 H5 S4
  #   D6 S5 D4 H3 C2
  #
  def check(card)
    init_card(card)

    straight
  end

end