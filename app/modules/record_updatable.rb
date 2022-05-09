module RecordUpdatable
  def process_record_change!(params)
    relevant_params = record_updatable_params(params)
    update!(relevant_params)
  end

  private

  def record_updatable_params(params)
    raise "Class must implement"
  end
end
