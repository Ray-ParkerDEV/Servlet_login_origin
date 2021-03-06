package services;

import connection.ConnectionPool;
import dao.daofactory.DaoFactory;

import java.util.HashMap;
import java.util.Map;

public class ServiceHelper {
    private volatile static ServiceHelper instance;
    private Map<String, Object> serviceMap = new HashMap<>(10);

    private ServiceHelper() {
        serviceMap.put("activityService", ActivityService.getInstance());
        serviceMap.put("adminService", AdminService.getInstance());
        serviceMap.put("clientService", ClientService.getInstance());
        serviceMap.put("trackingService", TrackingService.getInstance());
        serviceMap.put("userService", UserService.getInstance());
    }

    public static ServiceHelper getInstance() {
        if (instance == null) {
            synchronized (UserService.class) {
                if (instance == null) {
                    return instance = new ServiceHelper();
                }
            }
        }
        return instance;
    }

    public Object getService(String serviceName) {
        Object service = serviceMap.get(serviceName);
        if (service == null) {
            throw new RuntimeException("Can't find service " + serviceName);
        }
        setUpServices(serviceName);
        return service;
    }

    private void setUpServices(String serviceName) {
        switch (serviceName) {
            case "activityService": {
                ActivityService activityService = ActivityService.getInstance();
                DaoFactory daoFactory = DaoFactory.getDaoFactory(DaoFactory.MYSQL);
                activityService.setActivityDao(daoFactory.getActivityDao());
                activityService.setConnectionPool(ConnectionPool.getInstance());
                break;
            }
            case "trackingService": {
                TrackingService trackingService = TrackingService.getInstance();
                DaoFactory daoFactory = DaoFactory.getDaoFactory(DaoFactory.MYSQL);
                trackingService.setTrackingDao(daoFactory.getTrackingDao());
                trackingService.setConnectionPool(ConnectionPool.getInstance());
                break;
            }
            case "userService": {
                UserService userService = UserService.getInstance();
                DaoFactory daoFactory = DaoFactory.getDaoFactory(DaoFactory.MYSQL);
                userService.setUserDao(daoFactory.getUserDao());
                userService.setConnectionPool(ConnectionPool.getInstance());
                break;
            }
        }
    }
}
