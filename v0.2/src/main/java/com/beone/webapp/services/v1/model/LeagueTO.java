package com.beone.webapp.services.v1.model;

/**
 * Transfer object for the REST services in order to retrieve information about the league
 * @author Selcuk
 *
 */
public class LeagueTO {
	private boolean doesUserFollowLeague;

	public boolean isDoesUserFollowLeague() {
		return doesUserFollowLeague;
	}

	public void setDoesUserFollowLeague(boolean doesUserFollowLeague) {
		this.doesUserFollowLeague = doesUserFollowLeague;
	}
}
