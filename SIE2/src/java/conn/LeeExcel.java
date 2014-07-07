package conn;

import java.io.FileInputStream;
import java.sql.ResultSet;
import java.util.Iterator;
import java.util.Vector;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Indra Hidayatulloh
 */
public class LeeExcel {

    private Vector vectorDataExcelXLSX = new Vector();
    ConectionDB con = new ConectionDB();

    public boolean obtieneArchivo(String path, String file) {
        String excelXLSXFileName = path + "/exceles/" + file;
        vectorDataExcelXLSX = readDataExcelXLSX(excelXLSXFileName);
        displayDataExcelXLSX(vectorDataExcelXLSX);
        return true;
    }

    public Vector readDataExcelXLSX(String fileName) {
        Vector vectorData = new Vector();

        try {
            FileInputStream fileInputStream = new FileInputStream(fileName);

            XSSFWorkbook xssfWorkBook = new XSSFWorkbook(fileInputStream);

            // Read data at sheet 0
            XSSFSheet xssfSheet = xssfWorkBook.getSheetAt(0);

            Iterator rowIteration = xssfSheet.rowIterator();

            // Looping every row at sheet 0
            while (rowIteration.hasNext()) {
                XSSFRow xssfRow = (XSSFRow) rowIteration.next();
                Iterator cellIteration = xssfRow.cellIterator();

                Vector vectorCellEachRowData = new Vector();

                // Looping every cell in each row at sheet 0
                while (cellIteration.hasNext()) {
                    XSSFCell xssfCell = (XSSFCell) cellIteration.next();
                    vectorCellEachRowData.addElement(xssfCell);
                }

                vectorData.addElement(vectorCellEachRowData);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return vectorData;
    }

    public void displayDataExcelXLSX(Vector vectorData) {
        // Looping every row data in vector
        
        for (int i = 0; i < vectorData.size(); i++) {
            Vector vectorCellEachRowData = (Vector) vectorData.get(i);
            String qry = "insert into TB_UniReq values (";
            // looping every cell in each row
            for (int j = 0; j < vectorCellEachRowData.size(); j++) {
                
                qry = qry + "'" + vectorCellEachRowData.get(j).toString() + "' , ";
            }
            qry = qry + "curdate(), 0)"; // agregar campos fuera del excel
            System.out.println(qry);
            try {
                con.conectar();
                try {
                    con.insertar(qry);
                } catch (Exception e) {
                }
                con.cierraConexion();
            } catch (Exception e) {
            }
        }
    }    

}
