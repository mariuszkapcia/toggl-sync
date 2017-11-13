# TogglSync

TogglSync is a script written in ruby to synchronize [Toggl](http://www.toggl.com) and [JIRA](https://www.atlassian.com/software/jira).

## Requirements

Ruby installed in version 2.3.x or greater.

## Installation

Fetch repository.

## Configuration

Configuration can be found in `./config.yml`

```yml
toggl_sync:
  # show logs on terminal
  verbose: true
  # append '[created by TogglSync]' message to each worklog
  add_tag_to_worklogs: true
  toggl:
    # api token, available on web page
    api_token: 'api_token'
  jira:
    # account username, e.g a.test
    username: 'username'
    # account password
    password: 'password'
    # site
    site:     'https://jira.atlassian.com'

```

## Usage

Each Toggl entry that contains `jira-issue-key` in the description will be synchronized and tagged (`jira-issue-key` will not be sent to jira as part of the description).

```
NG-1 Meeting
very important time entry ng-101
another sl-54 sophisticated example
```

Script call:

```ruby
ruby toggl_sync.rb [method] [parameter]
```

Right now two methods are supported: `since` and `days_ago`.

### since

You can call the script in a two way:
- Without parameter only today will be synchronized.
- With parameter, all entries since specified date will be synchronized (dd-mm-yyyy).

```ruby
ruby toggl_sync.rb since
ruby toggl_sync.rb since '15-01-2017'
```

### days_ago

You can call the script in a two way:
- Without parameter only today will be synchronized.
- With parameter, specified number of days into the past will be synchronized.

```ruby
ruby toggl_sync.rb days_ago
ruby toggl_sync.rb days_ago 1
```

## License

Copyright (c) 2017 Mariusz Kapcia

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
