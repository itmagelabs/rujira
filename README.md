# Rujira

## Running

    RUJIRA_DEBUG=true RUJIRA_URL=http://localhost:8080 RUJIRA_TOKEN=<JIRA_ACCESS_TOKEN> bundle exec ./bin/console

## Usage in the code

    name = Rujira::Api::Myself.get.name
    Rujira::Api::Project.get 'ITMG'
    Rujira::Api::Issue.create do
        data fields: {
             project: { key: 'ITMG' },
             summary: 'BOT: added a new feature.',
             description: 'This task was generated by the bot when creating changes in the repository.',
             issuetype: { name: 'Task' },
             labels: ['bot'] }
        params updateHistory: true
    end
    Rujira::Api::Issue.watchers 'ITMG-1', 'wilful'
    Rujira::Api::Issue.get 'ITMG-1'
    result = Rujira::Api::Search.get do
        data jql: 'project = ITMG and status IN ("To Do", "In Progress") ORDER BY issuekey',
             maxResults: 10,
             startAt: 0,
             fields: ['id', 'key']
    end
    result.iter
    Rujira::Api::Issue.comment 'ITMG-1' do
        data body: 'Adding a new comment'
    end
    Rujira::Api::Issue.edit 'ITMG-1' do
        data update: {
             labels:[{add: 'rujira'},{remove: 'bot'}],
            },
            fields: {
            assignee: { name: name },
            summary: 'This is a shorthand for a set operation on the summary field'
        }
    end
    Rujira::Api::Issue.attachments 'ITMG-1', 'upload.png'
    Rujira::Api::Issue.del 'ITMG-1'

## Rake tasks

    require 'rujira/tasks/jira'
    rake jira::whoami
    rake jira:create -- '--project=ITMG' \
        '--summary=The short summary information' \
        '--description=The base description of task' \
        '--issuetype=Task'
    rake jira:search -- '-q project = ITMG'
    rake jira:attach -- '--file=upload.png' '--issue=ITMG-1'

## Testing

### Run the instance of jira

    docker compose up -d
    open http://localhost:8080

### Example with Curl

    curl -H "Authorization: Bearer <JIRA_ACCESS_TOKEN>" 'http://localhost:8080/rest/api/2/search?expand=summary'
    curl -D- -F "file=@upload.png" -X POST -H "X-Atlassian-Token: nocheck" \
        -H "Authorization: Bearer <JIRA_ACCESS_TOKEN>" 'http://localhost:8080/rest/api/2/issue/ITMG-70/attachments'
