# frozen_string_literal: true

require "json"
require "open-uri"

GITHUB_ACCESS_TOKEN = ARGV[0]
GITHUB_ORG_NAME = ARGV[1]
GITHUB_TEAM_NAME = ARGV[2]
NUMBER_OF_REVIEWERS = ARGV[3]
AVOID_BUSY_REVIEWER = ARGV[4]
GITHUB_TEAMS_URL = "https://api.github.com/orgs/#{GITHUB_ORG_NAME}/teams"

# Sync $stdout so we can output log message right away
$stdout.sync = true

def download_json(url)
  JSON.parse(URI(url + "?access_token=#{GITHUB_ACCESS_TOKEN}").read)
end

# Step 1: Download list of teams to find its ID
print "=> Downloading a list of teams for #{GITHUB_ORG_NAME}... "
teams = download_json(GITHUB_TEAMS_URL)
matching_team = teams.detect { |team| team["name"] == GITHUB_TEAM_NAME }

if matching_team.nil?
  puts "ERROR!"
  puts "ERROR: Unable to find matching team. Exiting."
  exit 10
else
  puts "done!"
end
