// Updated method to fix horizontal layout widget update
public void updateAppWidget(Context context, AppWidgetManager appWidgetManager, int appWidgetId) { 
    // New implementation details here
    RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_layout);
    // Update views as needed 
    appWidgetManager.updateAppWidget(appWidgetId, views);
}