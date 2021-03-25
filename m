Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FD5349A57
	for <lists+linux-api@lfdr.de>; Thu, 25 Mar 2021 20:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhCYThd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Mar 2021 15:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhCYThA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Mar 2021 15:37:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB61C06174A
        for <linux-api@vger.kernel.org>; Thu, 25 Mar 2021 12:36:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so1821004wmi.3
        for <linux-api@vger.kernel.org>; Thu, 25 Mar 2021 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=c28V1qEol1I4QrexdXU8KtR/UuqWaDR44oRtym8omog=;
        b=rqHrJiGtdaFIDWFvz2/YQL40pxirOdoQHfB+PAgJ0oYhv9k4vd3ALvRKEewsisgmtD
         POIKgErjUeibWdmqe+uCwplydDvG1qzxc/1w1rB7cQqjpahs7gG5Ih2T/TqCplsPrInz
         qUodO7S70wOSVekTbKaK+Hi11An+CrW4w73zPBAOen6GkfHjaJhXxY1M+Unl27tPHswB
         /5P9kS+jkE5w/niDGNqWJBP3Mog7C2cklB7fGL9C2RRGRzyKsVEBPFOuHObqvKekM6WF
         6sIuXkeeYNdqqRqzha5169RgSAQqEHdZ6jP/HJlOOEyMEaBktXCrlQImF040GvHlTU9K
         imEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c28V1qEol1I4QrexdXU8KtR/UuqWaDR44oRtym8omog=;
        b=Z7N3LXbEqT2xKcGWo+3GWD+QWfmVpT9CR+WiAZExuhDhxsQ6ZisezuwiJipls2KDGO
         ssLrEZ/f/GvPPrP10s40H4a65kfk2s0UUuKpeOloSWEBkuFrcN343aabBK5kCOLhztFf
         2r+RMuDuX4rPXydGy9mqDpxeEhbDSa5R4lJK9/Ol5Z7AvzPPwt9uZzo57g+KxiMbFWWd
         mwfL/ikYgW7vIdxTKyMGFZJ+adjUgeRgP2hzItOlSu1OSD3LUYYAoROWNka3IMsVvMAV
         XjFMEKxPTykucjV+GghjYRP2I1x3Z6wnBNfpEMhSd5JrWA9dt9bbDfozVGFH11zPu0d3
         xucQ==
X-Gm-Message-State: AOAM533p/SoEqPfWowI/BqunzwAzwJy1fN2Mwn7pv8nvKubVYlwkuIhI
        7xMAfs09lpIjETGOwEXcY2fjfg==
X-Google-Smtp-Source: ABdhPJzAgzLcQ9/+8u4JXx39HNXYUE0hH5J8RR+sFfQa2gG9t4cbr7wwLCsDJPg7ZmwASkeB9WA3aQ==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr9475403wmg.176.1616701017347;
        Thu, 25 Mar 2021 12:36:57 -0700 (PDT)
Received: from localhost.localdomain ([82.142.13.80])
        by smtp.gmail.com with ESMTPSA id h12sm2240217wrv.58.2021.03.25.12.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:36:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     rkumbako@quicinc.com, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list),
        linux-api@vger.kernel.org (open list:ABI/API)
Subject: [PATCH] thermal/drivers/netlink: Add the temperature when crossing a trip point
Date:   Thu, 25 Mar 2021 20:36:32 +0100
Message-Id: <20210325193633.19592-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The slope of the temperature increase or decrease can be high and when
the temperature crosses the trip point, there could be a significant
difference between the trip temperature and the measured temperatures.

That forces the userspace to read the temperature back right after
receiving a trip violation notification.

In order to be efficient, give the temperature which resulted in the
trip violation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c    |  6 ++++--
 drivers/thermal/thermal_netlink.c | 11 ++++++-----
 drivers/thermal/thermal_netlink.h |  8 ++++----
 include/uapi/linux/thermal.h      |  2 +-
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 996c038f83a4..948020ef51b1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -430,10 +430,12 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
 		if (tz->last_temperature < trip_temp &&
 		    tz->temperature >= trip_temp)
-			thermal_notify_tz_trip_up(tz->id, trip);
+			thermal_notify_tz_trip_up(tz->id, trip,
+						  tz->temperature);
 		if (tz->last_temperature >= trip_temp &&
 		    tz->temperature < (trip_temp - hyst))
-			thermal_notify_tz_trip_down(tz->id, trip);
+			thermal_notify_tz_trip_down(tz->id, trip,
+						    tz->temperature);
 	}
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 1234dbe95895..a16dd4d5d710 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -121,7 +121,8 @@ static int thermal_genl_event_tz(struct param *p)
 static int thermal_genl_event_tz_trip_up(struct param *p)
 {
 	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
-	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id))
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p->temp))
 		return -EMSGSIZE;
 
 	return 0;
@@ -285,16 +286,16 @@ int thermal_notify_tz_disable(int tz_id)
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
 }
 
-int thermal_notify_tz_trip_down(int tz_id, int trip_id)
+int thermal_notify_tz_trip_down(int tz_id, int trip_id, int temp)
 {
-	struct param p = { .tz_id = tz_id, .trip_id = trip_id };
+	struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DOWN, &p);
 }
 
-int thermal_notify_tz_trip_up(int tz_id, int trip_id)
+int thermal_notify_tz_trip_up(int tz_id, int trip_id, int temp)
 {
-	struct param p = { .tz_id = tz_id, .trip_id = trip_id };
+	struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
 }
diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
index 828d1dddfa98..e554f76291f4 100644
--- a/drivers/thermal/thermal_netlink.h
+++ b/drivers/thermal/thermal_netlink.h
@@ -11,8 +11,8 @@ int thermal_notify_tz_create(int tz_id, const char *name);
 int thermal_notify_tz_delete(int tz_id);
 int thermal_notify_tz_enable(int tz_id);
 int thermal_notify_tz_disable(int tz_id);
-int thermal_notify_tz_trip_down(int tz_id, int id);
-int thermal_notify_tz_trip_up(int tz_id, int id);
+int thermal_notify_tz_trip_down(int tz_id, int id, int temp);
+int thermal_notify_tz_trip_up(int tz_id, int id, int temp);
 int thermal_notify_tz_trip_delete(int tz_id, int id);
 int thermal_notify_tz_trip_add(int tz_id, int id, int type,
 			       int temp, int hyst);
@@ -49,12 +49,12 @@ static inline int thermal_notify_tz_disable(int tz_id)
 	return 0;
 }
 
-static inline int thermal_notify_tz_trip_down(int tz_id, int id)
+static inline int thermal_notify_tz_trip_down(int tz_id, int id, int temp)
 {
 	return 0;
 }
 
-static inline int thermal_notify_tz_trip_up(int tz_id, int id)
+static inline int thermal_notify_tz_trip_up(int tz_id, int id, int temp)
 {
 	return 0;
 }
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index c105054cbb57..bf5d9c8ef16f 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -18,7 +18,7 @@ enum thermal_trip_type {
 
 /* Adding event notification support elements */
 #define THERMAL_GENL_FAMILY_NAME		"thermal"
-#define THERMAL_GENL_VERSION			0x01
+#define THERMAL_GENL_VERSION			0x02
 #define THERMAL_GENL_SAMPLING_GROUP_NAME	"sampling"
 #define THERMAL_GENL_EVENT_GROUP_NAME		"event"
 
-- 
2.17.1

