FROM ruby:alpine

COPY assign_random_reviewers.rb /assign_random_reviewers.rb

ENTRYPOINT ["ruby", "/assign_random_reviewers.rb"]
