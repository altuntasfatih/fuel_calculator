defmodule FuelCalculatorTest do
  use ExUnit.Case
  doctest FuelCalculator


  test "Apollo 11 land from earh" do
    mass=28801
    route=[{:land, 9.807}]
    assert FuelCalculator.calculate(mass,route) == 13447
  end

  test "Apollo 11 route to moon" do
    mass=28801
    route=[{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}]
    assert FuelCalculator.calculate(mass,route) == 51898
  end

  test "Mission on mars" do
    mass=14606
    route=[{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
    assert FuelCalculator.calculate(mass,route) == 33388
  end

  test "Passenger ship" do
    mass=75432
    route= [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
    assert FuelCalculator.calculate(mass,route) == 212161
  end

  test "Invalid path" do
    mass=28801
    route=[{:launch, 9.807}, {:land, 1.62}, {:land, 1.62}, {:land, 9.807}]
    assert FuelCalculator.calculate(mass,route) == {:error, "Invalid path"}
  end

  test "Invalid direction" do
    mass=28801
    route=[{:launch, 9.807}, {:land, 1.62}, {:moon, 1.62}, {:land, 9.807}]
    assert FuelCalculator.calculate(mass,route) == {:error, "Invalid direction"}
  end
end
