
trigger EventReminderTrigger on Event (after insert, after update, after delete) {
    // Trigger logic for event reminders
    
    // Check if the trigger is fired after insert or update
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        List<Event> eventsWithReminders = new List<Event>();
        
        // Iterate through the new or updated events
        for (Event event : Trigger.new) {
            // Check if the event has a reminder set
            if (event.ReminderDateTime != null) {
                eventsWithReminders.add(event);
            }
        }
        
        // Process events with reminders
        if (!eventsWithReminders.isEmpty()) {
            // Logic to integrate with personal calendar and set reminders
            // This can involve making API calls to the calendar application
            
            // Example: Integration with Google Calendar
            for (Event event : eventsWithReminders) {
                // Create a new reminder in Google Calendar
                GoogleCalendarAPI.createReminder(event.Id, event.ReminderDateTime);
            }
        }
    }
    
    // Check if the trigger is fired after delete
    if (Trigger.isAfter && Trigger.isDelete) {
        List<Event> deletedEvents = Trigger.old;
        
        // Process deleted events
        if (!deletedEvents.isEmpty()) {
            // Logic to handle event cancellations in the personal calendar
            // This can involve making API calls to the calendar application
            
            // Example: Integration with Google Calendar
            for (Event event : deletedEvents) {
                // Cancel the corresponding event in Google Calendar
                GoogleCalendarAPI.cancelEvent(event.Id);
            }
        }
    }
}
