# TogglSync

TogglSync jes to skrypt w Rubym służący do synchronizacji pomiędzy [Toggl](http://www.toggl.com) a [JIRA](https://www.atlassian.com/software/jira).

## Wymagania

Zainstalowane Ruby w wersji 2.3.x lub nowszej.

## Instalacja

Pobrać zawartość repozytorium.

## Konfiguracja

Konfiguracja znajduje się w pliku `./config.yml`.

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
    site:     'https://nomtek.atlassian.net'

```

## Używanie

Skrypt można wywołać na dwa sposoby:
- Bez parametru zostanie uruchomiona synchronizacja dzisiejszego dnia.
- Z parametrem zostanie uruchomiona synchronizacja od podanej daty (dd-mm-yyyy).

```ruby
ruby toggl_sync.rb
ruby toggl_sync.rb '15-01-2017'
```

Każdy wpis z Toggl zawierający w swoim opisie `jira-issue-key` zostanie zsynchronizowany oraz oznaczony tag'iem (`jira-issue-key` zostanie usunięte z opisu).

```
NG-1 Meeting
very important time entry ng-101
another sl-54 sophisticated example
```

## Licencja

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
