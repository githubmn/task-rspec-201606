module CardHelper
  def get_hand_name(card)
    begin
      hand = Hand.new.get_hand(card)
      return hand.name
    rescue => exc
      return exc.message
    end
  end

end
