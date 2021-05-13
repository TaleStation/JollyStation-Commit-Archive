/// -- Extension of the base antagonist datum. --
/// Extra vars for datum/antagonists
/datum/antagonist
	/// Whether this antag can see exploitable info on examine.
	var/antag_flags = CAN_SEE_EXPOITABLE_INFO
	/// The advanced antag datum we are linked to.
	var/datum/advanced_antag_datum/linked_advanced_datum
	/// Some blacklisted objectives we don't want showing up in the similar objectives pool
	var/static/list/blacklisted_similar_objectives = list("custom", "absorb", "nuclear", "capture")
	/// Goals that advanced traitor malf AIs shouldn't be able to pick
	var/static/list/blacklisted_ai_objectives = list("survive", "destroy AI", "download", "steal", "escape", "debrain")

/// Antagonist-level proc to show this antagonist their advanced antag panel, should they have the datum.
/datum/antagonist/proc/show_advanced_traitor_panel(mob/user)
	if(!linked_advanced_datum)
		return

	linked_advanced_datum.show_advanced_antag_panel(user)

/// An extension of the admin topic for the extra buttons.
/datum/admins/Topic(href, href_list)
	. = ..()
	if(href_list["admin_check_goals"])
		var/datum/antagonist/our_antag = locate(href_list["admin_check_goals"])
		if(!check_rights(R_ADMIN))
			return

		our_antag.show_advanced_traitor_panel(usr)
		return
