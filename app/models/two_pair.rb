class TwoPair
  include Card
  def name
    'ツーペア'
  end

  def rank
    7
  end

  #
  # ツーペア: 同じ数の2枚組を2組と他のカード1枚で構成されている場合
  #  例: H13 D13 C2 D2 H11
  #   D11 S11 S10 C10 S9
  #
  def check(card)
    init_card(card)

    same_number([1, 2, 2])
  end

end