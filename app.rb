require './github_repo_fetcher'
require 'fileutils'
require 'git'
require 'logger'

github_repos = GithubRepoFetcher.fetch 'BioBoost'

github_dir = '/home/bioboost/.repositories/github/'

FileUtils::mkdir_p github_dir
github_repos.each do |repo|
  repo_dir = github_dir + repo[:name]

  if !Dir.exists?(repo_dir)
    puts "Cloning #{repo[:name]}"
    Git.clone(repo[:uri], repo[:name], :path => github_dir)
  else
    puts "Pulling #{repo[:name]}"
    g = Git.open(repo_dir, :log => Logger.new(STDOUT))
    g.pull
  end
end