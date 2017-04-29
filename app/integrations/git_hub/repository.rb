module GitHub
  class Repository
    attr_reader :owner, :name, :url

    def initialize(url)
      @url = url
      validate_hostname
      set_instance_vars
    end

    def to_code_example_attributes
      # map repo attributes to code_example attributes
      {
        name: exloc_metadata["name"] || data["full_name"],
        description: exloc_metadata["description"] || data["description"],
        exloc_metadata: exloc_metadata,
        repository_metadata: data,
        content: exloc_content,  # exloc.md || README.md
        file_objects_attributes: file_objects_attributes
      }
    end

    def tarball_url
      response = GitHub::API.new(:tarball, { owner: owner, repo: name }).get_response
      response["Location"]
    end

    def zipball_url
      response = GitHub::API.new(:zipball, { owner: owner, repo: name }).get_response
      response["Location"]
    end

    private
    def uri
      URI(url)
    end

    def validate_hostname
      raise "#{self} - Invalid Hostname: #{uri.host}" if uri.host != "github.com"
    end

    def set_instance_vars
      path = uri.path.split("/")
      @owner = path[1]
      @name = path[2]
      raise "#{self} - Unable to parse uri: #{uri}" if @owner.empty? || @name.empty?
    end

    def data
      @_data ||= GitHub::API.new(:repo, { owner: owner, repo: name }).get_attributes
    end

    def files
      @_files ||= GitHub::API.new(:files, { owner: owner, repo: name }).get_attributes
    end

    def filenames
      @_filenames ||= files.map { |file| file["name"] }
    end

    def exloc_metadata
      @_exloc_json ||= file_content("exloc.json") if filenames.include?("exloc.json")
      JSON.parse(@_exloc_json)
    end

    def exloc_content
      return file_content("exloc.md") if filenames.include?("exloc.md")
      return file_content("README.md") if filenames.include?("README.md")
    end

    def file_content(filename)
      attrs = GitHub::API.new(:file, { owner: owner, repo: name, file: filename }).get_attributes
      Base64.decode64(attrs["content"])
    end

    def file_objects_attributes
      files.map do |file|
        {
          name: file["name"],
          size: file["size"],
          file_type: file["type"],
          url: file["download_url"]
        }
      end
    end
  end
end
