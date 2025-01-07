package Model;

import java.util.Date;

public class TinTuc {
    private String id;
    private String content;
    private String image;
    private String title;
    private Date datePosted;

    public TinTuc(String id, String content, String image, String title, Date datePosted) {
        this.id = id;
        this.content = content;
        this.image = image;
        this.title = title;
        this.datePosted = datePosted;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getDatePosted() {
        return datePosted;
    }

    public void setDatePosted(Date datePosted) {
        this.datePosted = datePosted;
    }
}
