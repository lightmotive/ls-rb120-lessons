module RPS
  module Moves
    class History
      attr_reader :history, :players

      def initialize(*players)
        @history = []
        @players = players
      end

      def record
        @history.push(record_item)
      end

      def print
        puts "** Move History - #{players.map(&:name).join(' vs ')} **"
        @history.each do |item|
          print_item(item)
        end
      end

      private

      def player_item(player)
        { player: player, move: player.move }
      end

      def record_item
        players.each_with_object([]) do |player, record|
          record.push(player_item(player))
        end
      end

      def battle_overview(item)
        first, second = item

        case first[:move] <=> second[:move]
        when -1 then 'Lost'
        when 0 then  'Tied'
        when 1 then  'Won'
        end
      end

      def battle_detail(item)
        first, second = item
        "#{first[:move]} v #{second[:move]}"
      end

      def battle_explanation(item)
        first, second = item
        first[:move].win_explanation_vs(second[:move])
      end

      def print_item(item)
        result = battle_overview(item)
        battle = battle_detail(item)
        explanation = battle_explanation(item)
        explanation = explanation.empty? ? '' : " - #{explanation}"
        puts "#{result}: #{battle}#{explanation}"
      end
    end
  end
end
