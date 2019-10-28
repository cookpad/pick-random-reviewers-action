# frozen_string_literal: true

require "json"
require "net/http"
require "uri"

GITHUB_ACCESS_TOKEN = ARGV[0]
GITHUB_ORG_NAME = ARGV[1]
GITHUB_TEAM_NAME = ARGV[2]
NUMBER_OF_REVIEWERS = ARGV[3]
AVOID_BUSY_REVIEWER = ARGV[4]
GITHUB_TEAMS_URL = "https://api.github.com/orgs/#{GITHUB_ORG_NAME}/teams"

# Sync $stdout so we can output log message right away
$stdout.sync = true

def download_json(url)
  uri = URI(url + "?access_token=#{GITHUB_ACCESS_TOKEN}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(uri.request_uri)
  request["Accept"] = "application/vnd.github.hellcat-preview+json"

  response = http.request(request)

  JSON.parse(response.body)
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

# Step 2: Download list of members in the team
print "=> Downloading a list of members in #{GITHUB_TEAM_NAME}... "
members_url = matching_team["members_url"].sub(/\{.+$/, "")
members = download_json(members_url)

if members.empty?
  puts "ERROR!"
  puts "ERROR: Unable to find matching team. Exiting."
else
  puts "done!"
end
