package models;

import java.sql.Timestamp;

public class Gallery {
    
    private int id;
    private String imagePath;
    private String caption;
    private boolean isCarousel;
    private Timestamp uploadDate;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public String getCaption() { return caption; }
    public void setCaption(String caption) { this.caption = caption; }

    public boolean isCarousel() { return isCarousel; }
    public void setCarousel(boolean isCarousel) { this.isCarousel = isCarousel; }

    public Timestamp getUploadDate() { return uploadDate; }
    public void setUploadDate(Timestamp uploadDate) { this.uploadDate = uploadDate; }
}
