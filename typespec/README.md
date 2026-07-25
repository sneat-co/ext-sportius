# Sportius TypeSpec contract

`main.tsp` and `api4sportius.tsp` define the frozen HTTP/JSON boundary for
personal sports, teams, clubs, participation and invitations. Every operation
derives the actor from bearer authentication and returns a stable
`SportiusError` shape on failure; request bodies never accept an actor user ID.
