module DeploymentTracker

  class Deployments

    DEPLOYMENT_FILE         = "#{Rails.root}/DEPLOYMENT_INFO.json"
    DEPLOYMENT_HISTORY_FILE = "#{Rails.root}/log/DEPLOYMENT_HISTORY.json"

    def self.all
      return @all if @all
      if File.exist?(DEPLOYMENT_HISTORY_FILE)
        json_fragments = File.read(DEPLOYMENT_HISTORY_FILE)
        @all = JSON.parse('[' + json_fragments.split("}\n{").join("},{") + ']')
      else
        @all = []
      end
    end

    def self.current
      @current ||= File.exist?(DEPLOYMENT_FILE) ? JSON.parse(File.read(DEPLOYMENT_FILE)) : { 'sha' => 'unknown' }
    end

    def self.reset
      @current = nil
      @all     = nil
    end

  end

end
