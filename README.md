# README


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Configuration

This app uses figaro to configure certain components. The following needs to be
set in the environment or via a figaro config file:

```
default_bucket:         # The S3 bucket the files are stored in
default_region:         # The S3 region to use
json_web_token_secret:  # The secret key for checking token signatures
default_upload_limit:   # The default max file size for any particular blob
user_upload_limit:      # The default combined maximum a user can upload
```

# Accessing the RailsAdmin

The server does not keep a record of the current logged in user, and therefore
your credentials must be sent with every request. This makes using the
`RailsAdmin` a bit tricky, as it is the only component that is a web UI.

The easiest work around is the set your `flight_sso` token as a cookie. This
way it will automatically be sent with each request.

# License
Eclipse Public License 2.0, see LICENSE.txt for details.

Copyright (C) 2019-present Alces Flight Ltd.

This program and the accompanying materials are made available under the terms of the Eclipse Public License 2.0 which is available at https://www.eclipse.org/legal/epl-2.0, or alternative license terms made available by Alces Flight Ltd - please direct inquiries about licensing to licensing@alces-flight.com.

flight-cache-server is distributed in the hope that it will be useful, but WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR CONDITIONS OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. See the Eclipse Public License 2.0 for more details.
