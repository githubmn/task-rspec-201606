class FullHouse
  include Card
  def name
    'フルハウス'
  end

  def rank
    3
  end

  #
  # フルハウス: 同じ数字のカード3枚と、別の同じ数字のカード2枚で構成されている場合
  #  例: S10 H10 D10 S4 D4
  #   H9 C9 S9 H1 C1
  #
  def check(card)
    init_card(card)

    same_number([2, 3])
  end

end