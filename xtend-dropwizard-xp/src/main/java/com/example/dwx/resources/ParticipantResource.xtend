package com.example.dwx.resources

import javax.ws.rs.Path
import com.example.dwx.db.ParticipantDAO
import javax.ws.rs.Consumes
import javax.ws.rs.Produces
import javax.ws.rs.core.MediaType
import javax.ws.rs.PathParam
import javax.ws.rs.WebApplicationException
import javax.ws.rs.GET
import javax.ws.rs.QueryParam
import javax.ws.rs.core.Response
import javax.ws.rs.POST
import java.net.URI
import com.example.dwx.api.ParticipantBean

@Path("/participant")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ParticipantResource {
	final ParticipantDAO participantDAO

	new(ParticipantDAO participantDAO) {
		this.participantDAO = participantDAO
	}

	// http://localhost:8080/participant/one/email
	@GET
	@Path("{studyid}/email")
	public def String get(@PathParam("studyid") String studyid) {
		var String email = participantDAO.findEmailByStudyid(studyid)

		if (null == email) {
			throw new WebApplicationException(Response.Status.NOT_FOUND)
		}

		return email;
	}

	// http://localhost:8080/participant/one?email=jd@example.com
	@GET
	@Path("{studyid}")
	public def ParticipantBean get(@PathParam("studyid") String studyid, @QueryParam("email") String email) {
		var ParticipantBean participant = participantDAO.findParticipantByStudyidAndEmail(studyid, email)

		if (null == participant) {
			throw new WebApplicationException(Response.Status.NOT_FOUND);
		}

		return participant;
	}

	/* 
	 * curl -H "Content-Type: application/json" -X POST -d '{"email":"jd@example.com","studyid":"one","birthdate":"2"}' http://localhost:8080/participant/one
	*/
	@POST
	@Path("{studyid}")
	public def Response update(ParticipantBean participant) {
		participantDAO.update(participant);
		return Response.noContent().build()
	}

	/* 
	 * curl -H "Content-Type: application/json" -X POST -d '{"email":"jd@example.com","studyid":"one","birthdate":"1"}' http://localhost:8080/participant
	*/
	@POST
	public def Response create(ParticipantBean participant) {
		participantDAO.insert(participant);
		return Response.created(URI.create(participant.getStudyid())).build();
	}
}
