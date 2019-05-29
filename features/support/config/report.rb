require_relative 'dotenv'

module ReportModule
    
    include EnvironmentModule

    def self.env
        {
            'report_type' => ENV.fetch('REPORT_TYPE', 'html'),
            'report_only_defects' => ENV.fetch('REPORT_ONLY_DEFECTS', false),
            'report_include_evidences' => ENV.fetch('REPORT_INCLUDE_EVIDENCES', false)
        }
    end
end