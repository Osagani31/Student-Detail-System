import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/FileUploadServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
                 maxFileSize = 1024 * 1024 * 10,       // 10MB
                 maxRequestSize = 1024 * 1024 * 50)     // 50MB
public class FileUploadServlet extends HttpServlet {

    public static final String UPLOAD_DIR = "images";
    public String dbFileName = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        int id = Integer.parseInt(request.getParameter("id"));
        String FullName = request.getParameter("FullName");
        String degreeName = request.getParameter("degreename");

        Part part = request.getPart("file");
        String fileName = extractFileName(part);

        // Save to web/images directory so it's always accessible
        String uploadPath = getServletContext().getRealPath("/images");
        File fileUploadDirectory = new File(uploadPath);

        if (!fileUploadDirectory.exists()) {
            fileUploadDirectory.mkdirs();
        }

        String savePath = uploadPath + File.separator + fileName;
        part.write(savePath);

        // Store only the relative path for browser access
        dbFileName = "images/" + fileName;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fileupload", "root", "");
            PreparedStatement pst = con.prepareStatement("INSERT INTO image_table VALUES (?, ?, ?, ?, ?)");

            pst.setInt(1, id);
            pst.setString(2, FullName);
            pst.setString(3, degreeName);
            pst.setString(4, dbFileName);
            pst.setString(5, savePath);
            pst.executeUpdate();

            // ✅ Styled HTML response using style.css
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<title>Upload Success</title>");
            out.println("<link rel='stylesheet' href='style.css'>");
            out.println("</head>");
            out.println("<body class='container'>");
            out.println("<h2>✅ Image uploaded successfully!</h2>");
            out.println("<div class='center'>");
            out.println("<a href='display.jsp?id=" + id + "'>➡ View Uploaded Image</a><br><br>");
            out.println("<a href='upload.jsp'>⬅ Back to Upload</a>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");

        } catch (Exception e) {
            out.println("<!DOCTYPE html>");
            out.println("<html><head>");
            out.println("<link rel='stylesheet' href='style.css'>");
            out.println("</head><body class='container'>");
            out.println("<h2 style='color:red;'>❌ Error Occurred</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("<a href='upload.jsp'>⬅ Try Again</a>");
            out.println("</body></html>");
        }
    }

    // ✅ Extracts file name from the uploaded part
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
