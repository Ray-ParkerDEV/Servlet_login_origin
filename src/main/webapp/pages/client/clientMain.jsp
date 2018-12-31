<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="spec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Clients account page</title>
    <link rel="stylesheet" type="text/css" href="<spec:url value="/css/clientMain.css"/>"/>
    <%--<script type="text/javascript" src="/js/time.js"></script>--%>
</head>
<body>
<div class="wrapperWelcomeInfo">
    <div class="welcomeElement">
        <jsp:useBean id="welcometext" scope="session" class="mybean.MyBean"/>
        This is useBean answer:
        <jsp:getProperty name="welcometext" property="field"/>
        <c:out value="${welcometext.who}"/>
        <c:out value="${sessionScope.clientUser.firstName} ${sessionScope.clientUser.surName}"/>!
    </div>
</div>
<div class="wrapperPageData">
    <fieldset>
        <legend align="center">YOUR ACTIVITIES TRACKING</legend>
        <div class="activityInfoForm">
            <table>
                <tr>
                    <th align="left" width="320">ACTIVITIES</th>
                    <th align="left" width="150">STATUS</th>
                    <th>ACTION</th>
                    <th align="left" width="100">TIME</th>
                    <th align="left" width="300">NOTICE</th>
                </tr>
                <c:forEach items="${sessionScope.trackingList}" var="tracking">
                    <c:set var="userId" value="${sessionScope.clientUser.userId}"/>
                    <tr>
                    <c:if test="${tracking.user.userId==userId}">
                        <td>
                            <c:out value="${tracking.activity.activityName}"/>
                        </td>
                        <td>
                            <c:out value="${tracking.status}"/>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <form class="formElement" name="actionForm" method="POST"
                                              action="controller">
                                            <div class="wrapperButtons">
                                                <input type="hidden" name="trackingId"
                                                       value="${tracking.trackingId}"/>
                                                <input type="hidden" name="command" value="startTime"/>
                                                <input class="buttonElement" type="submit" value="start"/>
                                            </div>
                                        </form>
                                    </td>
                                    <td>
                                        <form class="formElement" name="actionForm" method="POST"
                                              action="controller">
                                            <div class="wrapperButtons">
                                                <input type="hidden" name="trackingId"
                                                       value="${tracking.trackingId}"/>
                                                <input type="hidden" name="command" value="stopTime"/>
                                                <input class="buttonElement" type="submit" value="stop"/>
                                            </div>
                                        </form>
                                    </td>
                                    <td align="center">
                                        <form class="formElement" name="finishForm" method="POST"
                                              action="controller">
                                            <div class="wrapperButtons">
                                                <input type="hidden" name="trackingId"
                                                       value="${tracking.trackingId}"/>
                                                <input type="hidden" name="command" value="finish"/>
                                                <input class="buttonElement" type="submit" value="finish"/>
                                            </div>
                                        </form>
                                    </td>
                                    <td align="center">
                                        <c:if test="${tracking.status == 'FINISHED'}">
                                            <form class="formElement" name="finishForm" method="POST"
                                                  action="controller">
                                                <div class="wrapperButtons">
                                                    <input type="hidden" name="trackingId"
                                                           value="${tracking.trackingId}"/>
                                                    <input type="hidden" name="command" value="remove"/>
                                                    <input class="buttonElement" type="submit" value="remove"/>
                                                </div>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${tracking.timeSwitch == 'true'}">
                                    <label id="hours"></label>:<label id="minutes"></label>:<label id="seconds"></label>
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${tracking.elapsedTime}"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:set var="request" value="${tracking.userRequest}"/>
                            <c:if test="${request=='REMOVE'}">
                                wait for admin approval...
                            </c:if>
                        </td>
                        </tr>
                        <script type="text/javascript">
                            var countSecond = parseInt(${tracking.differenceTime/1000});
                            if (countSecond > 0 && countSecond < 9) {
                                document.getElementById("seconds").innerHTML = "0" + countSecond;
                            } else if (countSecond == 0){
                                document.getElementById("seconds").innerHTML = "00";
                            } else {
                                document.getElementById("seconds").innerHTML = countSecond;
                            }

                           // var countSecond = 0;
                           // document.getElementById("seconds").innerHTML = "00";
                            var timeSeconds = setInterval(function () {
                                myTimerSec()
                            }, 1000);

                            function myTimerSec() {
                                if (countSecond > 59) {
                                    countSecond = -1;
                                }
                                if (countSecond < 9) {
                                    countSecond = countSecond + 1;
                                    document.getElementById("seconds").innerHTML = "0" + countSecond;
                                } else {
                                    countSecond = countSecond + 1;
                                    document.getElementById("seconds").innerHTML = countSecond;
                                }
                            }

                            var countMinutes = 0;
                            document.getElementById("minutes").innerHTML = "00";
                            var timeMinutes = setInterval(function () {
                                myTimerMin()
                            }, 1000 * 60);

                            function myTimerMin() {
                                if (countMinutes == 59) {
                                    countMinutes = -1;
                                }
                                if (countMinutes < 9) {
                                    countMinutes = countMinutes + 1;
                                    document.getElementById("minutes").innerHTML = "0" + countMinutes;
                                } else {
                                    countMinutes = countMinutes + 1;
                                    document.getElementById("minutes").innerHTML = countMinutes;
                                }
                            }

                            var countHours = 0;
                            document.getElementById("hours").innerHTML = "00";
                            var timeHours = setInterval(function () {
                                myTimerHour()
                            }, 1000 * 60 * 60);

                            function myTimerHour() {
                                if (countHours == 59) {
                                    countHours = -1;
                                }
                                if (countHours < 9) {
                                    countHours = countHours + 1;
                                    document.getElementById("hours").innerHTML = "0" + countHours;
                                } else {
                                    countHours = countHours + 1;
                                    document.getElementById("hours").innerHTML = countHours;
                                }
                            }
                        </script>
                    </c:if>
                </c:forEach>
            </table>
            <table>
                <tr>
                    <td>
                        <form class="formElement" name="formElement" method="POST" action="controller">
                            <div class="wrapperButtons">
                                <input type="hidden" name="userId" value="${sessionScope.clientUser.userId}"/>
                                <input type="hidden" name="command" value="add"/>
                                <input type="submit" value="add new activity" style="height:20px; width:110px"/>
                            </div>
                        </form>
                    </td>
                    <td>
                        <c:if test="${sessionScope.overviewUser.requestAdd == 'true'}">
                            wait for admin response...
                        </c:if>
                    </td>
                    <%--<td>--%>
                    <%--<label id="hours"></label>:<label id="minutes"></label>:<label id="seconds"></label>--%>
                    <%--</td>--%>
                </tr>
            </table>
        </div>
    </fieldset>
</div>
<!--LOGOUT-->
<div class="logoutElement">
    <form name="logout" method="POST" action="controller">
        <input type="hidden" name="command" value="logout"/>
        <input type="submit" value="Log Out"/>
    </form>
</div>

</body>
</html>