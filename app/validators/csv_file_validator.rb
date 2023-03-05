module CsvFileValidator

  def self.validate(file)
    errors = ''
    csv_contens = []

    return errors = I18n.t('keyword.error.no_file') if file.blank?

    csv_contens = CSV.read(file).flatten(2)
    errors = I18n.t('keyword.error.exceed_length') if csv_contens.count > 100

    return errors, csv_contens
  end
end