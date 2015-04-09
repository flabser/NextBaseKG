package handler.convert_blobs

import kz.nextbase.script._Session
import kz.nextbase.script.events._DoScheduledHandler
import org.apache.commons.dbcp.ConnectionFactory
import org.apache.commons.dbcp.DriverManagerConnectionFactory
import org.apache.commons.dbcp.PoolableConnectionFactory
import org.apache.commons.dbcp.PoolingDataSource
import org.apache.commons.pool.impl.GenericObjectPool
import org.postgresql.largeobject.LargeObject
import org.postgresql.largeobject.LargeObjectManager

import java.sql.*

class Trigger extends _DoScheduledHandler {

    @Override
    int doHandler(_Session ses) {
        try {
            String host = ses.getGlobalSettings().dbURL;
            String uName = ses.getGlobalSettings().dbUserName;
            String uPass = ses.getGlobalSettings().dbPassword;
            String dName = ses.getGlobalSettings().driver;
            Driver driver = (Driver) Class.forName(dName).newInstance();
            DriverManager.registerDriver(driver);
            GenericObjectPool connectionPool = new GenericObjectPool(null);
            connectionPool.setTestOnBorrow(true);
            connectionPool.setWhenExhaustedAction(GenericObjectPool.WHEN_EXHAUSTED_BLOCK);
            connectionPool.setMaxWait(15000);

            Properties props = new Properties();
            props.setProperty("user", uName);
            props.setProperty("password", uPass);
            props.setProperty("accessToUnderlyingConnectionAllowed", "true");

            ConnectionFactory connectionFactory = new DriverManagerConnectionFactory(host, props);
            new PoolableConnectionFactory(connectionFactory, connectionPool, null, "SELECT 1", false, true);
            new PoolingDataSource(connectionPool);
            connectionPool.setMaxIdle(200);
            connectionPool.setMaxActive(2000);

            props.setProperty("user", uName);
            props.setProperty("password", uPass);
            props.setProperty("accessToUnderlyingConnectionAllowed", "true");
            Connection conn = (Connection) connectionPool.borrowObject();
            conn.setAutoCommit(false);
            LargeObjectManager lobj = ((org.postgresql.PGConnection) ((org.apache.commons.dbcp.DelegatingConnection) conn).getInnermostDelegate()).getLargeObjectAPI();
            String sql = "SELECT * FROM CUSTOM_BLOBS_MAINDOCS";
            Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                if (rs.getBytes("VALUE") != null) {
                    long oid = lobj.createLO(LargeObjectManager.READ | LargeObjectManager.WRITE);
                    LargeObject obj = lobj.open(oid, LargeObjectManager.WRITE);
                    InputStream fin = new ByteArrayInputStream(rs.getBytes("VALUE"));
                    byte[] buf = new byte[1048576];
                    int s, tl = 0;
                    while ((s = fin.read(buf, 0, 1048576)) > 0) {
                        obj.write(buf, 0, s);
                        tl += s;
                    }
                    obj.close();
                    System.out.println(rs.getInt("ID"));
                    System.out.println(oid);
                    PreparedStatement pst = conn.prepareStatement("update custom_blobs_maindocs set value_oid = ? where id = ?");
                    pst.setLong(1, oid);
                    pst.setInt(2, rs.getInt("ID"));
                    pst.executeUpdate();
                }
            }
            conn.commit();
            conn.close();
        }

        catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0
    }

}
