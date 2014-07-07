/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package in.co.sneh.model;

import java.io.File;
import org.apache.commons.fileupload.FileItemStream;
import java.io.InputStream;
import java.io.FileOutputStream;

/**
 *
 * @author CEDIS TOLUCA3
 */
public class FileUpload {

    public static boolean processFile(String path, FileItemStream item) {
        try {
            File f = new File(path + File.separator + "exceles" + File.separator);
            if (!f.exists()) {
                f.mkdir();
            }
            File savedFile = new File(f.getAbsolutePath() + File.separator + item.getName());
            FileOutputStream fos = new FileOutputStream(savedFile);
            InputStream is = item.openStream();
            int x = 0;
            byte[] b = new byte[1024];
            while ((x = is.read(b)) != -1) {
                fos.write(b, 0, x);
            }
            fos.flush();
            fos.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
