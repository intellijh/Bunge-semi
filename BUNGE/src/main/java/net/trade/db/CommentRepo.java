package net.trade.db;

import javax.naming.NamingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CommentRepo {
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public CommentRepo() throws SQLException, NamingException {
        con = DsCon.getConnection();
    }

    // ºñµð¿À ID¸¦ ¾ò¾î¼­ ÇØ´ç ±ÛÀÇ ´ñ±Û ºÒ·¯¿À±â
    public ArrayList<Comment> getCommentListByVideoId(int videoId) throws SQLException{
        String sql = "SELECT author,description,id FROM comment WHERE video_id=?";

        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, videoId);
        rs = pstmt.executeQuery();

        // ArrayList ÇüÅÂ·Î ÀúÀå
        ArrayList<Comment> list = new ArrayList<Comment>();
        while(rs.next()) {
            Comment comment = new Comment();
            comment.setAuthor(rs.getString("author"));
            comment.setDesc(rs.getString("description"));
            comment.setId(rs.getInt("id"));

            list.add(comment);
        }

        return list;
    }

    // ´ñ±Û ÀÛ¼º
    public void insertComment(Comment comment) throws SQLException{
        String sql = "INSERT INTO comment (video_id,author,password,description) values(?,?,password(?),?)";

        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, comment.getVideoId());
        pstmt.setString(2, comment.getAuthor());
        pstmt.setString(3,comment.getPassword());
        pstmt.setString(4, comment.getDesc());

        pstmt.execute();
    }

    // ´ñ±Û »èÁ¦
    public boolean deleteComment(int id,String password) throws SQLException {
        // ´ñ±Û ID¿Í ºñ¹Ð¹øÈ£°¡ ÀÏÄ¡ÇÏ´Â ´ñ±ÛÀÇ Á¸Àç ¿©ºÎ È®ÀÎ
        String sql = "select EXISTS (select * from comment where id=? and password=password(?)) as success";

        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, id);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        rs.next();
        if (rs.getBoolean("success")) {
            sql = "delete from comment where id=?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.execute();

            return true;
        } else {
            // ÇØ´ç ´ñ±ÛÀÌ ÀÌ¹Ì ¾ø°Å³ª ºñ¹Ð¹øÈ£ ºÒÀÏÄ¡
            return false;
        }
    }

    public void close() throws SQLException {
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
}
