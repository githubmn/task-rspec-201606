require 'rails_helper'

describe Hand do
  describe "1. ストレートフラッシュ" do
    context "正常系" do
      arrays = [
        ["クラブ", " C7 C6 C5 C4 C3"],
        ["ハート", " H1  H13 H12 H11 H10"],
        ["スペード", " S9  S13  S12 S11 S10"],
        ["ダイア", " D9  D6  D7 D8 D5 "]
      ]

      arrays.each { |a|
        it a[0] do
          hand = Hand.new.get_hand(a[1])
          expect(hand.name).to eq("ストレートフラッシュ")
        end
      }
    end
  end

  describe "2. フォー・オブ・ア・カインド" do
    context "正常系" do
      1.upto(13) { |i|
        val = " C1 D1 H1 S1 D1".gsub(/1/, i.to_s)
        it "5枚が#{i}" do
          hand = Hand.new.get_hand(val)
          expect(hand.name).to eq("フォー・オブ・ア・カインド")
        end
      }

      2.upto(13) { |i|
        val = "C1 D2 H2 S2 D2 ".gsub(/2/, i.to_s)
        it "1枚が1、4枚が#{i}" do
          hand = Hand.new.get_hand(val)
          expect(hand.name).to eq("フォー・オブ・ア・カインド")
        end
      }
    end
  end

  describe "3. フルハウス" do
    context "正常系" do
      2.upto(13) { |i|
        val = " C1 D1 H2 S2 D2".gsub(/2/, i.to_s)
        it "2枚が1、3枚が#{i}" do
          hand = Hand.new.get_hand(val)
          expect(hand.name).to eq("フルハウス")
        end
      }

      2.upto(13) { |i|
        val = "C1 D1 H1 S2 D2 ".gsub(/2/, i.to_s)
        it "3枚が1、2枚が#{i}" do
          hand = Hand.new.get_hand(val)
          expect(hand.name).to eq("フルハウス")
        end
      }
    end
  end

  describe "4. フラッシュ" do
    context "正常系" do
      ['S', 'H', 'D', 'C'].each { |v|
        val = " H1 H12 H10 H5 H3 ".gsub(/H/, v)
        it "5枚が#{v}" do
          hand = Hand.new.get_hand(val)
          expect(hand.name).to eq("フラッシュ")
        end
      }
    end
  end

  describe "5. ストレート" do
    context "正常系" do
      2.upto(10) { |i|
        val = "S#{i}"
        (i + 4).downto(i + 1) { |v| val << " D#{v}"}
        val.gsub!(/14/, "1")
        it val do
          hand = Hand.new.get_hand(val)
          expect(hand.name).to eq("ストレート")
        end
      }
    end
  end

  describe "6. スリー・オブ・ア・カインド" do
    context "正常系" do
      3.upto(13) { |i|
        val = "C1 D2 H3 S3 D3 ".gsub(/3/, i.to_s)
        it "1枚が1、1枚が2、3枚が#{i}" do
          hand = Hand.new.get_hand(val)
          expect(hand.name).to eq("スリー・オブ・ア・カインド")
        end
      }
    end
  end

  describe "7. ツーペア" do
    context "正常系" do
      3.upto(13) { |i|
        val = "C1 D2 H2 S3 D3 ".gsub(/3/, i.to_s)
        it "1枚が1、2枚が2、2枚が#{i}" do
          hand = Hand.new.get_hand(val)
          expect(hand.name).to eq("ツーペア")
        end
      }
    end
  end

  describe "8. ワンペア" do
    context "正常系" do
      4.upto(13) { |i|
        val = "C1 D2 H3 S4 D4 ".gsub(/4/, i.to_s)
        it "1枚が1、1枚が2、1枚が3、枚が#{i}" do
          hand = Hand.new.get_hand(val)
          expect(hand.name).to eq("ワンペア")
        end
      }
    end
  end

  describe "9. ハイカード" do
    context "正常系" do
      arrays = [
        ["", "D1 D10 S9 C5 C4"],
        ["", "C13 D12 C11 H8 H7"],
        ["", "S1 H2 D3 C4 C5"],
        ["", "S1 S2 S3 S4 C5"]
      ]

      arrays.each { |a|
        it a[0] do
          hand = Hand.new.get_hand(a[1])
          expect(hand.name).to eq("ハイカード")
        end
      }
    end
  end

  describe "0. 異常系" do
    context "例外" do
      arrays = [
        ["nil", nil],
        ["空", ""],
        ["不足", "C1 C2 C3 C4"],
        ["超過", "C1 C2 C3 C4 C5 C6"],
        ["スーツが不正:A", "A1 C2 C3 C4 C5"],
        ["スーツが不正:CC", "CC1 C2 C3 C4 C5"],
        ["スーツがなし", "1 C2 C3 C4 C5"],
        ["数字が不正:15", "C15 C2 C3 C4 C5"],
        ["数字が不正:0", "C0 C2 C3 C4 C5"]
      ]

      arrays.each { |a|
        it a[0] do
          expect{ Hand.new.get_hand(a[1]) }.to raise_error(RuntimeError, "format error")
        end
      }
    end
  end

end