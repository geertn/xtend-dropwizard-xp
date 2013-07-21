package com.example.dwx.core

import com.yammer.dropwizard.config.Configuration
import com.fasterxml.jackson.annotation.JsonProperty
import javax.validation.Valid
import javax.validation.constraints.NotNull
import com.yammer.dropwizard.db.DatabaseConfiguration

class DwxConfiguration extends Configuration {
	@Valid
	@NotNull
	@JsonProperty
	@Property DatabaseConfiguration databaseConfiguration = new DatabaseConfiguration
}
