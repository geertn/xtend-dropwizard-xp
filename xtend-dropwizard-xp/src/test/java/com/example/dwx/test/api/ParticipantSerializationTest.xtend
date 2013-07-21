package com.example.dwx.test.api

import com.example.dwx.api.ParticipantBean
import org.junit.Test
import java.io.IOException
import static extension com.yammer.dropwizard.testing.JsonHelpers.*
import static org.hamcrest.MatcherAssert.*
import static org.hamcrest.CoreMatchers.*


class ParticipantSerializationTest {

	public static final String FIXTURE = "fixtures/participant.json"
	var ParticipantBean participant

	new() {
		participant = new ParticipantBean
		participant.setBirthdate(28)
		participant.setEmail("jd@example.com")
		participant.setStudyid("John Doe")
	}

	@Test
	def void testSerializeToJson() throws IOException {
		assertThat("a Participant can be serialized to JSON", participant.asJson, equalTo(jsonFixture(FIXTURE)))
	}

	@Test
	def void testDeserializeToJson() throws IOException {
		var ParticipantBean participantFromJson;
		participantFromJson = fromJson(jsonFixture("fixtures/participant.json"), ParticipantBean)
		assertThat("a Participant can be deserialized from JSON", participantFromJson.getBirthdate(), equalTo(this.participant.getBirthdate()))
		assertThat("a Participant can be deserialized from JSON", participantFromJson.getEmail(), equalTo(this.participant.getEmail()))
		assertThat("a Participant can be deserialized from JSON", participantFromJson.getStudyid(), equalTo(this.participant.getStudyid()))
	}
	
}
