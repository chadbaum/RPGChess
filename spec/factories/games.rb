FactoryGirl.define do
  factory :game do
  end

  factory :empty_chess_board, class: Game do
    # after rails 5 you need to set up call_back first
    after(:build) do |game|
      game.class.set_callback(:create, :after,
      :populate_bishops!, :populate_rooks!,
      :populate_knights!, :populate_pawns!,
      :populate_queens_kings!)
    end

    # After game is created, skip populate game pieces
    after(:build) do |game|
      game.class.skip_callback(:create, :after,
      :populate_bishops!, :populate_rooks!,
      :populate_knights!, :populate_pawns!,
      :populate_queens_kings!)
    end
  end
end
