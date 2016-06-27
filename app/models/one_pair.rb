class OnePair
  include Card
  def name
    'ワンペア'
  end

  def rank
    8
  end

  #
  # ワンペア: 同じ数字の2枚組とそれぞれ異なった数字の札3枚によって構成されている場合
  #  例: C10 S10 S6 H4 H2
  #   H9 C9 H1 D12 D10
  #
  def check(card)
    init_card(card)

    same_number([1, 1, 1, 2])
  end

end