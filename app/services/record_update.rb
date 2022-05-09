class RecordUpdate
  REQUIRED_KEY = :id
  VALID_KEYS = [:artist_name, :condition, :title, :release_year].freeze
  BAD_RECORD_UPDATE_MESSAGE = "Invalid or missing arguments supplied to RecordUpdate".freeze

  attr_reader :album, :artist, :params, :record

  def initialize(params)
    validate(params)

    @params = params
    @record = Record.includes(album: :artist).find(params[:id])
    @album = record.album
    @artist = album.artist
  end

  def perform
    ActiveRecord::Base.transaction do
      updatables.each do |updatable|
        updatable.process_record_change!(params)
      end
    end

    record.reload
  end

  private

  def validate(params)
    if !record_id?(params) || empty_params?(params)
      raise BadRecordUpdate.new(BAD_RECORD_UPDATE_MESSAGE)
    end
  end

  def record_id?(params)
    params.present? && params[REQUIRED_KEY].present?
  end

  def empty_params?(params)
    VALID_KEYS.all? do |key|
      params[key].blank?
    end
  end

  def updatables
    [record, album, artist]
  end
end
