package com.example.dwx.task

import com.example.dwx.db.ParticipantDAO
import com.google.common.collect.ImmutableMultimap
import com.yammer.dropwizard.tasks.Task
import java.io.PrintWriter

class ParticipantTableTask extends Task {

	final ParticipantDAO participantDAO

	new(ParticipantDAO participantDAO) {
		super("createParticipantTable")
		this.participantDAO = participantDAO
	}
		
	/*
	 * curl -X POST http://localhost:8081/tasks/createParticipantTable
	 */
	override execute(ImmutableMultimap<String,String> parameters, PrintWriter output) throws Exception {
		participantDAO.createParticipantTable
	}

}
