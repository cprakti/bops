class MostCommonWordsQuery
  attr_reader :limit

  def initialize(limit: 50)
    @limit = limit
  end

  def search
    ActiveRecord::Base.connection.execute(statement)
      .entries
      .map { |entry| {word: entry["word"], count: entry["ndoc"]} }
  end

  private

  def statement
    <<~SQL
      SELECT *                                       
      FROM ts_stat(
        $$SELECT to_tsvector('pg_catalog.simple', title)
        FROM albums$$
      ) 
      ORDER BY ndoc DESC
      LIMIT #{limit};
    SQL
  end
end
