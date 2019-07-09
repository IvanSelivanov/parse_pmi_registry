# frozen_string_literal: true

module Services
  class PageGetter
    PAGE_URL           = 'https://certification.pmi.org/registry.aspx'
    TABLE_FIELDS       = %i[name city country credential earned status].freeze
    USER_FIELDS        = %i[name city country].freeze
    CREDENTIAL_FIELDS  = %i[credential earned].freeze

    def initialize
      @mechanize = Mechanize.new
    end

    def call
      visit_page
      ('A'..'B').each do |letter|
        fill_in_form(letter)
        parse_table
      end
    end

    private

    def visit_page
      @page = @mechanize.get(PAGE_URL)
    end

    def fill_in_form(letter)
      form = @page.forms.first
      form['dph_RegistryContent$tbSearch'] = letter
      form['dph_RegistryContent$wcountry'] = 'RUS'
      page = form.submit
      @rows = page.search('tr')
    end

    def parse_table
      user = nil
      @rows.each do |row|
        fields = row.search('td')
        next if fields.blank?

        attributes = TABLE_FIELDS.zip(fields.map { |t| t.text.strip }).to_h

        user_attributes = attributes.slice(*USER_FIELDS)
        user = PmiUser.find_or_create_by(user_attributes) unless user_attributes.values.join('').blank?
        next unless user.present?

        credential = PmiCredential.find_or_initialize_by(
          pmi_user_id: user.id,
          credential: attributes[:credential]
        )
        credential.assign_attributes(attributes.slice(*CREDENTIAL_FIELDS))
        credential.save
      end
    end
  end
end
