require "csv"

class RecordsFile
  attr_reader :csv, :errors, :headers, :invalid_rows
  REQUIRED_HEADERS = %w[title artist condition year].freeze
  MISSING_HEADERS_STEM = "CSV is missing required headers; missing headers".freeze
  MISSING_FILE_MESSAGE = "No CSV file received".freeze

  def initialize(file)
    raise NoFileError.new(MISSING_FILE_MESSAGE) if file.blank?

    @csv = CSV.new(File.open(file.path, "r"), **csv_options).read
    @headers = csv.headers
    @errors = {}
  end

  def ingest!
    validate_file
    records_added = process_file

    {records_added: records_added, errors: errors}
  end

  private

  def csv_options
    {
      headers: true,
      skip_blanks: true
    }
  end

  def validate_file
    missing_headers = (REQUIRED_HEADERS - headers)
    return if missing_headers.blank?

    raise BadCsvError.new("#{MISSING_HEADERS_STEM} #{missing_headers.join(", ")}")
  end

  def process_file
    records_added = 0

    csv.each do |row|
      process_row(row)
      records_added += 1
    rescue ActiveRecord::RecordInvalid => e
      handle_error(e)
    end

    records_added
  end

  def process_row(row)
    ActiveRecord::Base.transaction do
      artist = Artist.find_or_create_by!(name: row["artist"])
      album = Album.find_or_create_by!(title: row["title"], release_year: row["year"], artist: artist)
      Record.create!(condition: row["condition"], notes: row["notes"], album: album)
    end
  end

  def handle_error(e)
    errors[e.message] ||= 0
    errors[e.message] += 1
  end
end
