xtend-dropwizard-xp
=======

Experimenting with dropwizard (v0.6.2) & Xtend (2.4.2) for fun. Comments very welcome.

This project is written with PostgreSQL, but using another database should be easy.

Based on the excellent dropwizard-todo sample at: https://github.com/bucharest-jug/dropwizard-todo

To get up and running:

```
* Setup database and configure dwx.yml
* mvn package
* java -jar target/xtend-dropwizard-xp-0.0.1-SNAPSHOT.jar server dwx.yml
```

Create the database table using a post to task "createParticipantTable":
```
curl -X POST http://localhost:8081/tasks/createParticipantTable
```

Insert a record:
```
curl -H "Content-Type: application/json" -X POST -d '{"email":"jd@example.com","studyid":"one","birthdate":"1"}' http://localhost:8080/participant
```

Request the record's email:
```
http://localhost:8080/participant/one/email
```

Request full record:
```
http://localhost:8080/participant/one?email=jd@example.com
```

Update record:
```
curl -H "Content-Type: application/json" -X POST -d '{"email":"jd@example.com","studyid":"one","birthdate":"2"}' http://localhost:8080/participant/one
```