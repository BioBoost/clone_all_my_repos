require 'httparty'

class GithubRepoFetcher
  def self.fetch username
    uri = "https://api.github.com/users/#{username}/repos"

    response = HTTParty.get(uri)

    repositories = Array.new
    response.each do |repo|
      repositories << { name: repo['name'], uri: repo['ssh_url'] }
    end

    return repositories
  end
end