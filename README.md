reference-manager
=================

3-tier application model

Presentation layer
: [[client/README]]: static web forms/pages that consume API

Application logic layer
: [[server/README]]: API server, ORM, back-end processing

Data layer
: [[db/README]]: data tier (branches)
  - [x] flat json (app + data combined)
  - [ ] mongodb
  - [ ] sqlite

Journal
-------

```todo
remove front-end from references API +server @expressjs

client - read collection @html
client - read resource @html
client - update resource @html
client - delete resource @html

entries API PUT JSON data, validate against csl-json schema +server
entries API PUT form data, shape into csl-json format +server
```

Journal
=======

2023-01-15
----------

Static HTML front-end (`/static/index.html`):

- `<form>`: executes custom function on submit
- `form.onsubmit`: compile object, send `POST` request using `fetch`
- running on `express.static` server

General back-end (`/src/index.js`):

- request logging using `morgan`

`uploads` API

- `POST` request writes JSON to file
- `GET` request reads JSON from file
- `DELETE` request deletes file

2023-01-18
----------

`uploads` API

- back-end routing: refactored `uploads` router to use routes

Front-end: 

- use `serve-index` to create directory listing of `/uploads`
- added HTML `iframe` to display directory listing
- submit `POST` requests as urlencoded form data

2023-01-21
----------

Terraform/docker dev stack:

- bridge network
- server container
- client container
- mount busybox binary

Decouple frontend from API server. Frontend has choices:

- submit HTML forms back to frontend express server, communicate with API server over docker network
- send HTML forms directly to API server, may require CORS

2023-01-22
----------

Decouple frontend from API server

- Removed static html from API server

Front-end

- Web server: express.static(), serveIndex()
- create/POST: reformatted form to get rid of table

Entries API

- Renamed references -> entries API
- GET resource: pipes read stream directly from file
- GET collection: reads every file and returns selected fields
- POST collection: overwrite protected fs.writeFile ('wx' flag)
- DELETE resource
