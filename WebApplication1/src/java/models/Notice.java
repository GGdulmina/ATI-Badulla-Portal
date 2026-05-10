package models;

import java.sql.Timestamp;

public class Notice {
    
    private int id;
    private String title;
    private String content;
    private Timestamp postedDate;
    private int priority;
    
     public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Timestamp getPostedDate() { return postedDate; }
    public void setPostedDate(Timestamp postedDate) { this.postedDate = postedDate; }

    public int getPriority() { return priority; }
    public void setPriority(int priority) { this.priority = priority; }
}