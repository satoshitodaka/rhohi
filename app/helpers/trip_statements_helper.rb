module TripStatementsHelper
  def applied_trip_statement?
    @trip_statement = TripStatement.find(params: [:id])
  end
end
