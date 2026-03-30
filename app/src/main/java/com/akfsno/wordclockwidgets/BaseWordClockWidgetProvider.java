package com.akfsno.wordclockwidgets;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.graphics.Color;
import android.widget.RemoteViews;
import java.util.Calendar;
import java.util.TimeZone;

public abstract class BaseWordClockWidgetProvider extends AppWidgetProvider {

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        for (int appWidgetId : appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId);
        }
    }

    protected abstract int getLayoutResource();

    protected abstract void setTexts(RemoteViews views, String hourText, String minuteText, String dayNightText, String dayOfWeekText, String dateText);

    protected abstract int getDefaultTextColor();

    protected abstract int getDefaultBorderColor();

    void updateAppWidget(Context context, AppWidgetManager appWidgetManager, int appWidgetId) {
        Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("GMT+3"));
        int hour = calendar.get(Calendar.HOUR);
        int minute = calendar.get(Calendar.MINUTE);
        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        int month = calendar.get(Calendar.MONTH) + 1;
        int year = calendar.get(Calendar.YEAR);

        String hourText = NumberToWords.convertHour(hour);
        String minuteText = NumberToWords.convertMinute(minute);
        String dayNightText = NumberToWords.getDayNight(hour);
        String dayOfWeekText = NumberToWords.getDayOfWeek(dayOfWeek);
        String dateText = NumberToWords.convertDate(day, month, year);

        RemoteViews views = new RemoteViews(context.getPackageName(), getLayoutResource());
        setTexts(views, hourText, minuteText, dayNightText, dayOfWeekText, dateText);

        // Apply custom settings
        int textColor = WidgetPreferences.getColor(context, appWidgetId, getDefaultTextColor());
        float fontSize = WidgetPreferences.getFontSize(context, appWidgetId, 24f);
        String fontType = WidgetPreferences.getFontType(context, appWidgetId, "Обычный");
        float lineSpacing = WidgetPreferences.getLineSpacing(context, appWidgetId, 1.0f);
        int borderColor = WidgetPreferences.getBorderColor(context, appWidgetId, getDefaultBorderColor());
        int borderWidth = WidgetPreferences.getBorderWidth(context, appWidgetId, 2);
        int backgroundColor = WidgetPreferences.getBackgroundColor(context, appWidgetId, Color.TRANSPARENT);
        int backgroundAlpha = WidgetPreferences.getBackgroundAlpha(context, appWidgetId, 0);

        // Apply background
        int bgColor = Color.argb(backgroundAlpha, Color.red(backgroundColor), Color.green(backgroundColor), Color.blue(backgroundColor));
        views.setInt(R.id.widget_container, "setBackgroundColor", bgColor);

        // Apply border color (if possible, using a custom method or different approach)
        // For now, we'll use a simple approach with padding for border effect

        if (views.getLayoutId() == R.layout.horizontal_widget_layout) {
            views.setTextColor(R.id.time_text, textColor);
            views.setTextViewTextSize(R.id.time_text, 0, fontSize);
            views.setFloat(R.id.time_text, "setLineSpacing", 0, lineSpacing * fontSize);
            setTextStyle(views, R.id.time_text, fontType);
        } else {
            views.setTextColor(R.id.hour_text, textColor);
            views.setTextViewTextSize(R.id.hour_text, 0, fontSize);
            views.setFloat(R.id.hour_text, "setLineSpacing", 0, lineSpacing * fontSize);
            setTextStyle(views, R.id.hour_text, fontType);

            views.setTextColor(R.id.minute_text, textColor);
            views.setTextViewTextSize(R.id.minute_text, 0, fontSize);
            views.setFloat(R.id.minute_text, "setLineSpacing", 0, lineSpacing * fontSize);
            setTextStyle(views, R.id.minute_text, fontType);

            views.setTextColor(R.id.day_night_text, borderColor);
            views.setTextViewTextSize(R.id.day_night_text, 0, fontSize * 0.75f);
            views.setFloat(R.id.day_night_text, "setLineSpacing", 0, lineSpacing * fontSize * 0.75f);
            setTextStyle(views, R.id.day_night_text, fontType);

            if (views.getLayoutId() == R.layout.extended_widget_layout) {
                views.setTextColor(R.id.day_of_week_text, textColor);
                views.setTextViewTextSize(R.id.day_of_week_text, 0, fontSize * 0.6f);
                views.setFloat(R.id.day_of_week_text, "setLineSpacing", 0, lineSpacing * fontSize * 0.6f);
                setTextStyle(views, R.id.day_of_week_text, fontType);

                views.setTextColor(R.id.date_text, textColor);
                views.setTextViewTextSize(R.id.date_text, 0, fontSize * 0.5f);
                views.setFloat(R.id.date_text, "setLineSpacing", 0, lineSpacing * fontSize * 0.5f);
                setTextStyle(views, R.id.date_text, fontType);
            }
        }

        appWidgetManager.updateAppWidget(appWidgetId, views);
    }

    private void setTextStyle(RemoteViews views, int viewId, String fontType) {
        // RemoteViews has limited support for Typeface, so we'll use basic styles
        switch (fontType) {
            case "Жирный":
                views.setInt(viewId, "setTypeface", 1); // Typeface.BOLD
                break;
            case "Курсив":
                views.setInt(viewId, "setTypeface", 2); // Typeface.ITALIC
                break;
            case "Моноширинный":
                views.setInt(viewId, "setTypeface", 3); // Typeface.MONOSPACE
                break;
            case "Санс-сериф":
                views.setInt(viewId, "setTypeface", 4); // Typeface.SANS_SERIF
                break;
            default:
                views.setInt(viewId, "setTypeface", 0); // Typeface.NORMAL
                break;
        }
    }
}