class ThreeOfAKind
  include Card
  def name
    'スリー・オブ・ア・カインド'
  end

  def rank
    6
  end

  #
  # スリー・オブ・ア・カインド: 同じ数字の札3枚と数字の違う2枚の札から構成されている場合
  #  例: S12 C12 D12 S5 C3
  #   C5 H5 D5 D12 C10
  #
  def check(card)
    init_card(card)

    same_number([1, 1, 3])
  end

end