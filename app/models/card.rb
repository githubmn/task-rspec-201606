#
# カードの情報：共通モジュール
#
module Card
  #
  # カードを作成
  #
  def init_card(card)
    # 初期化
    card ||= ''

    # 大文字にする
    card = card.upcase

    # 各カードを取得
    cards = card.strip.split(/\s+/)

    # 各スーツと数字を取得
    suits = []
    numbers = []
    cards.each{ |c|
      /([[:alpha:]]*)([[:digit:]]*)/ =~ c

      suits << $1 if ['S', 'H', 'D', 'C'].include?($1)

      num = ($2 ? $2.to_i : 0)
      numbers << num if (1 <= num && num <= 13)
    }

    # p cards, suits, numbers

    raise 'format error' if (cards.length != 5 || suits.length != 5 || numbers.length != 5)

    @cards = cards
    @suits = suits
    @numbers = numbers
  end

  #
  # フラッシュ: 同じスートのカード5枚で構成されている場合
  #
  def flush
    hash = {}
    @suits.each { |s|
      hash[s] ||= 0
      hash[s] += 1
    }
    samed = (hash.select { |k, v| 5 <= v }.length != 0)

    samed
  end

  #
  # ストレート: 数字が連続する5枚のカードで構成されている場合
  #
  def straight
    i = @numbers.index(1)
    @numbers[i] = 14 if !i.nil?

    @numbers.sort!
    first = @numbers.first
    arrays = @numbers.select { |n| n + 1 == (first += 1) }
    sequenced = (5 <= arrays.length)

    sequenced
  end

  #
  # 同じ数字のカードが含まれる場合
  #
  def same_number(array)
    hash = {}
    @numbers.each { |n|
      hash[n] ||= 0
      hash[n] += 1
    }
    samed = (hash.values.sort == array)

    samed
  end
end