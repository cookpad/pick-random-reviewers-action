# Pick random reviewers

GitHub action for picking random reviewer from a GitHub team, written in Ruby.

## Usage

See [action.yml](action.yml)

Basic:

```yaml
steps:
  - id: pick-random-reviewers
    uses: cookpad/pick-random-reviewers-action@v1.0.0
    with:
      github_access_token: ${{ secrets.pick-random-reviewers-access-token }}
      organization_name: your-organization-name
      team_name: your-github-team-name
```

This action requires you to have a GitHub access token which has `org:read`
permission. You can add the access token in your repository's Settings page.

### Output

This action will return an array of GitHub usernames that it picks as reviewers.
If you use the same step id as above, you can access the output via
`${{ steps.pick-random-reviewers.outputs.reviewers}}`.

## Configuring the action

You can customize this action by passing your configuration under `with:` block.

### Number of reviewers

Number of reviewers this action should return.

```yaml
number_of_reviewers: 1    # Default: 3
```

### Return only available revieers

Make this action only return reviewers who do not have their status set to Busy.

```yaml
only_available: false     # Default: true
```

# License

The scripts and documentation in this project are released under the [MIT License](LICENSE)
