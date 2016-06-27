class FourOfAKind
  include Card
  def name
    'フォー・オブ・ア・カインド'
  end

  def rank
    2
  end

  #
  # フォー・オブ・ア・カインド: 同じ数字のカードが4枚含まれる場合
  #  例: C10 D10 H10 S10 D5
  #   D6 H6 S6 C6 S13
  #
  def check(card)
    init_card(card)

    same_number([1, 4]) || same_number([5])
  end

end