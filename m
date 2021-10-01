Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C037641F770
	for <lists+linux-api@lfdr.de>; Sat,  2 Oct 2021 00:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355890AbhJAWfT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 1 Oct 2021 18:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355814AbhJAWfR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 1 Oct 2021 18:35:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF234C0613E2
        for <linux-api@vger.kernel.org>; Fri,  1 Oct 2021 15:33:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so12406977wmc.0
        for <linux-api@vger.kernel.org>; Fri, 01 Oct 2021 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8nDTUff3NWAShPXkSJUHpdXF/tre0swCngGs+0ldBuo=;
        b=iTFcfgD9k1Ew/Q3d85rswksP5KXCDig/JMG7z4OhD2EquHZpCoQt7WZ1Ks7iAxlx5F
         j79zOLzzrSFIu3t5mp3BdYb8xK+ue+VQpYMOng91ymPADIOBDQXsYPTrI+Y8Pp8Ddl3z
         VStEoSKYKklC02gxEXkv2MM+BBemjoiJHqs0CPbPJq/xooJxLlrm6IaCkzaW9U0bInzq
         ssdNVwWQQrjFwmBfEXg3Q4QVKTRZvE6SqrE19ONi7tNV0Uq2cvwjt8FESqH/Y2ij2+56
         Cw+mRWRH+K+isrtp97UodjIvbXVjfs5bke++3w26zh5lK1BoDhVuHpNnxoSRP5I+eSuS
         5kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8nDTUff3NWAShPXkSJUHpdXF/tre0swCngGs+0ldBuo=;
        b=STDGXAymE+4V9J3eO87YaXwlfJRZ86nKVIyVW4Kop67I4pefHLjGp0aEJeCxhl2Ltn
         u1aVi8nivpkWJeD+krZL3j02klSEB6PbpTdbHpyu5oDu7/iEy3t0DVCVuFh4zc61fc4W
         Xb32adTsTofJPe1srbtTmNKlq95trCVlIEzgv2pMJuuNIEPfoZ4GyrWInLI3dMxN613Q
         FiVffCNGIfRHwnqYeYVAypkPnbTaLQo8Zf9GaQyhWLps9dhILV8hsyiQqfe4omNHHbSF
         aHu5YLeiFfZ52WJo/SOyNvkBn6bxf79iqVrj1yeiH/4G8xE8+QBmUTJbppkcvQC7/vGV
         dzEg==
X-Gm-Message-State: AOAM530RD0JC6wK+yaPO8pI3cCJ1KqJoAdccNyR9S4tt+x4PQTmNbFdm
        K9BV53zyjH2izJ6NWbSAk0WD3Q==
X-Google-Smtp-Source: ABdhPJzh1k5pcEzW+6hASRwgn1OJytpkdGERs5wRyy/ZUXwRtlPchpG7YDA1eNuK2SyZAzEIk0QR1A==
X-Received: by 2002:a05:600c:a45:: with SMTP id c5mr6979189wmq.79.1633127611224;
        Fri, 01 Oct 2021 15:33:31 -0700 (PDT)
Received: from localhost.localdomain ([82.142.20.44])
        by smtp.gmail.com with ESMTPSA id 8sm6921066wmo.47.2021.10.01.15.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 15:33:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, rkumbako@quicinc.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH RESEND] thermal/drivers/netlink: Add the temperature when crossing a trip point
Date:   Sat,  2 Oct 2021 00:33:23 +0200
Message-Id: <20211001223323.1836640-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/thermal_core.c    |  6 ++++--
 drivers/thermal/thermal_netlink.c | 11 ++++++-----
 drivers/thermal/thermal_netlink.h |  8 ++++----
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 51374f4e1cca..9e243d9f929e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -375,10 +375,12 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
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
-- 
2.25.1

