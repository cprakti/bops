class RecordsController < ApplicationController
  def index
    records_results = Record.where_title(params[:query])
      .includes(album: :artist)
      .page(params[:page])
      .per(params[:per_page])

    render json: records_results
  end

  def create
    ingestion_data = RecordsFile.new(params.require(:file)).ingest!

    render json: ingestion_data, status: :created
  end

  def update
    updated_record = RecordUpdate.new(record_params).perform

    render json: updated_record, serializer: UpdatedRecordSerializer
  end

  private

  def record_params
    params.permit(:id, :artist_name, :condition, :title, :release_year)
  end
end
