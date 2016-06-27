module ApiHelper
  def get_hands(cards)
    hands = []

    cards ||= []
    cards.each { |card|
      hash = {}
      hash['card'] = card

      begin
        hand = Hand.new.get_hand(card)
        hash['hand'] = hand.name
        hash['rank'] = hand.rank
      rescue => exc
        hash['hand'] = exc.message
        hash['rank'] = 1000
      end

      hands << hash
    }

    hands.sort! { |a, b| a['rank'] <=> b['rank'] }
    hands[0]['best'] = true if (1 < hands.length) && (hands[0]['rank'] != hands[1]['rank'])
    hands.each { |r| r.delete('rank') }

    hands
  end

end
