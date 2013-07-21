package com.example.dwx.health

import com.yammer.metrics.core.HealthCheck
import com.yammer.metrics.core.HealthCheck.Result
import org.skife.jdbi.v2.DBI
import org.skife.jdbi.v2.Handle
import java.sql.SQLException

class DatabaseHealthCheck extends HealthCheck {

	val DBI database

	new(DBI database) {
		super("database")
		this.database = database
	}

	override protected def Result check() throws Exception {
		
		try {
			val Handle h = database.open()
			try {
				h.connection.isValid(1)
			} catch (SQLException e) {
				return Result.unhealthy("Connection is not valid")
			} finally {
				h.close()
			}
		} catch (SQLException e) {
			return Result.unhealthy("Cannot connect to " + database.toString())
		}
		
		return Result.healthy()
	}

}
