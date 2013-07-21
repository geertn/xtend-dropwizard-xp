package com.example.dwx.core

import com.example.dwx.db.ParticipantDAO
import com.example.dwx.health.DatabaseHealthCheck
import com.example.dwx.task.ParticipantTableTask
import com.example.dwx.resources.ParticipantResource
import com.yammer.dropwizard.Service
import com.yammer.dropwizard.config.Bootstrap
import com.yammer.dropwizard.config.Environment
import com.yammer.dropwizard.jdbi.DBIFactory
import com.yammer.dropwizard.jdbi.bundles.DBIExceptionsBundle
import org.skife.jdbi.v2.DBI

class DwxService extends Service<DwxConfiguration> {

	def static void main(String[] args) {
		new DwxService().run(args)
	}

	override initialize(Bootstrap<DwxConfiguration> bootstrap) {
		bootstrap.addBundle(new DBIExceptionsBundle())
	}
	
	override run(DwxConfiguration configuration, extension Environment environment) throws Exception {
		val DBIFactory factory = new DBIFactory
		val DBI jdbi = factory.build(environment, configuration.getDatabaseConfiguration(), "postgresql")
		
		new ParticipantResource(jdbi.onDemand(ParticipantDAO)).addResource
		new DatabaseHealthCheck(jdbi).addHealthCheck
		new ParticipantTableTask(jdbi.onDemand(ParticipantDAO)).addTask
	}
}
