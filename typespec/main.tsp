import "@typespec/http";
import "./api4sportius.tsp";

using Http;

/**
 * Sportius is the organisational sports extension behind Sneat Club.
 *
 * Personal data lives under `/users/{userID}/ext/sportius`. Team and club
 * profiles live under their independent Sneat Spaces. Generic Sneat linkages
 * remain authoritative for team-to-club and parent-to-player relationships.
 */
@service(#{ title: "Sportius API" })
namespace Sportius;
