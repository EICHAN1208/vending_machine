class VendingMachine
  attr_accessor :drinks, :deposit

  USEABLE_COIN = [10, 50, 100, 500].freeze

  def initialize(drinks)
    @drinks = drinks
    @deposit = 0
  end

  def push_button(drink)
    select_drink = buyable_drinks.select { |dk| dk.same_name(drink) }
    if select_drink.size.zero?
      nil
    else
      calculate_change(select_drink)
      [select_drink.first.name, @deposit]
    end
  end

  def cancel
    [nil, deposit]
  end

  def insert(coin)
    return unless USEABLE_COIN.include?(coin)

    @deposit += coin
  end

  private

  def buyable_drinks
    drinks.select { |drink| drink.buyable(deposit) }
  end

  def calculate_change(drink)
    @deposit -= drink.first.price
  end
end

class Drink
  attr_accessor :name, :price

  def initialize(name: nil, price: nil)
    @name = name
    @price = price
  end

  def buyable(deposit)
    @price <= deposit
  end

  def same_name(drink)
    @name == drink
  end
end
