class Flush
  include Card
  def name
    'フラッシュ'
  end

  def rank
    4
  end

  #
  # フラッシュ: 同じスートのカード5枚で構成されている場合
  #  例: H1 H12 H10 H5 H3
  #   S13 S12 S11 S9 S6
  #
  def check(card)
    init_card(card)

    flush
  end

end