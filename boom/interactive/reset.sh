#!/bin/bash

curl -X PUT \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6ImYyYjkyZTYwLWM5ZTQtNDUxYi04MDQzLTdlMDAwMzc1ZmRhNyIsInN1YiI6ImYyYjkyZTYwLWM5ZTQtNDUxYi04MDQzLTdlMDAwMzc1ZmRhNyIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTU5MDk1Mjk1MSwiZXhwIjoxNTkxMDM5MzUxLCJqdGkiOiI5ZjgxZjQxZC01ZDgxLTQyYmEtODg1MS0wOWE3NmFiYzdkM2EifQ.bYXz23DrYanTo5g0VCBavFt0qjCsQbvMJU7x8DfPN_4" \
  --data-raw '{ "current": 1000 }' \
  'http://localhost:3001/v1/current'
echo

curl -X PUT \
  -H "Accept: application/vnd.api+json" \
  -H "Content-Type: application/vnd.api+json" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6ImYyYjkyZTYwLWM5ZTQtNDUxYi04MDQzLTdlMDAwMzc1ZmRhNyIsInN1YiI6ImYyYjkyZTYwLWM5ZTQtNDUxYi04MDQzLTdlMDAwMzc1ZmRhNyIsInNjcCI6InVzZXIiLCJhdWQiOm51bGwsImlhdCI6MTU5MDk1Mjk1MSwiZXhwIjoxNTkxMDM5MzUxLCJqdGkiOiI5ZjgxZjQxZC01ZDgxLTQyYmEtODg1MS0wOWE3NmFiYzdkM2EifQ.bYXz23DrYanTo5g0VCBavFt0qjCsQbvMJU7x8DfPN_4" \
  'http://localhost:3001/v1/current?current=1000'
echo
