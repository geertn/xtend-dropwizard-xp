package com.example.dwx.db

import org.skife.jdbi.v2.sqlobject.SqlQuery
import org.skife.jdbi.v2.sqlobject.Bind
import org.skife.jdbi.v2.sqlobject.BindBean
import org.skife.jdbi.v2.sqlobject.helpers.MapResultAsBean
import org.skife.jdbi.v2.sqlobject.SqlUpdate
import com.example.dwx.api.ParticipantBean

public interface ParticipantDAO {
	
	@SqlUpdate("CREATE TABLE IF NOT EXISTS participant(studyid VARCHAR(128) PRIMARY KEY, birthdate INTEGER, email VARCHAR(128))")
  	def void createParticipantTable()
  	
	@SqlQuery("SELECT email FROM participant WHERE studyid = :studyid")
	def String findEmailByStudyid(@Bind("studyid") String studyid)
	
	@SqlQuery("SELECT studyid, email, birthdate FROM participant WHERE studyid = :studyid and email = :email")
	@MapResultAsBean
	def ParticipantBean findParticipantByStudyidAndEmail(@Bind("studyid") String studyid, @Bind("email") String email)

	@SqlUpdate("INSERT INTO participant (email, birthdate, studyid) VALUES (:email, :birthdate, :studyid)")
	def int insert(@BindBean ParticipantBean o)
	
	@SqlUpdate("UPDATE participant SET email = :email, birthdate = :birthdate, studyid = :studyid where studyid = :studyid")
	def int update(@BindBean ParticipantBean o)
	
}
