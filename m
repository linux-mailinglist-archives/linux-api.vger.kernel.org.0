Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C3E34ACA3
	for <lists+linux-api@lfdr.de>; Fri, 26 Mar 2021 17:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCZQhi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Mar 2021 12:37:38 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34503 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCZQhU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Mar 2021 12:37:20 -0400
Received: by mail-oi1-f171.google.com with SMTP id x207so6285383oif.1;
        Fri, 26 Mar 2021 09:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhRekWdV8u9KdLF2RCq0OQxVx6Mo40YWf08R+wW1/BY=;
        b=dE7yLbxNPe4nISktCoq2QQ1/Z8ov/7JOsSQZSx/foaW7SpcZfOD/GspgjqGHJA/p1v
         F/eYcqMIqw9G0xq6HJjxNmzkNSz7fqrdjeqA+Z/1Dhd71bRDP85SaKYrxR7jflQDIr+9
         RYyipMCZiofmxC28J7+ZZ2j3rde8HUw6KDpVjeWyINQ9EUn9U6oxZqz+a89Cl8Xldpnv
         txdvP1PGJO7jntpUkDDOqsGD2Li4VUbOEzATC6BcPjOAgnDEcvCZ60kMFrqT3ASeCtce
         YWIMi/8UP/LfyocN8TNxh4IEeBLyq7Gi3Dm8pCX72zSvlsRro1k/y8LFI4FXGHGODHb7
         PrjQ==
X-Gm-Message-State: AOAM532tTQjxs86wqrxdN+hmbWuV3jQ5SezIV3VqU6u9sce1itWflqMi
        EzyxOFGApsxBJ2LCsaiWwxCKHX2jVPrIBaOs3PxAjXzu
X-Google-Smtp-Source: ABdhPJxgmv1E8JTq6EAx1/UKUC4yZTKrnuAaa7XTBT06zC37rQNdkitdgZaJ4WjVT4JJyWykgvGWXlCNVE+bkYI038A=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr9940383oib.69.1616776639936;
 Fri, 26 Mar 2021 09:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210325193633.19592-1-daniel.lezcano@linaro.org>
In-Reply-To: <20210325193633.19592-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Mar 2021 17:37:08 +0100
Message-ID: <CAJZ5v0g58LMVwRWdJaTWVOx09gt6KRGTa974k3cvHYQyxk0EYg@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/netlink: Add the temperature when
 crossing a trip point
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rkumbako@quicinc.com, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 25, 2021 at 8:38 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The slope of the temperature increase or decrease can be high and when
> the temperature crosses the trip point, there could be a significant
> difference between the trip temperature and the measured temperatures.
>
> That forces the userspace to read the temperature back right after
> receiving a trip violation notification.
>
> In order to be efficient, give the temperature which resulted in the
> trip violation.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Srinivas, what do you think?

> ---
>  drivers/thermal/thermal_core.c    |  6 ++++--
>  drivers/thermal/thermal_netlink.c | 11 ++++++-----
>  drivers/thermal/thermal_netlink.h |  8 ++++----
>  include/uapi/linux/thermal.h      |  2 +-
>  4 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 996c038f83a4..948020ef51b1 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -430,10 +430,12 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>         if (tz->last_temperature != THERMAL_TEMP_INVALID) {
>                 if (tz->last_temperature < trip_temp &&
>                     tz->temperature >= trip_temp)
> -                       thermal_notify_tz_trip_up(tz->id, trip);
> +                       thermal_notify_tz_trip_up(tz->id, trip,
> +                                                 tz->temperature);
>                 if (tz->last_temperature >= trip_temp &&
>                     tz->temperature < (trip_temp - hyst))
> -                       thermal_notify_tz_trip_down(tz->id, trip);
> +                       thermal_notify_tz_trip_down(tz->id, trip,
> +                                                   tz->temperature);
>         }
>
>         if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
> index 1234dbe95895..a16dd4d5d710 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -121,7 +121,8 @@ static int thermal_genl_event_tz(struct param *p)
>  static int thermal_genl_event_tz_trip_up(struct param *p)
>  {
>         if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
> -           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id))
> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->trip_id) ||
> +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p->temp))
>                 return -EMSGSIZE;
>
>         return 0;
> @@ -285,16 +286,16 @@ int thermal_notify_tz_disable(int tz_id)
>         return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
>  }
>
> -int thermal_notify_tz_trip_down(int tz_id, int trip_id)
> +int thermal_notify_tz_trip_down(int tz_id, int trip_id, int temp)
>  {
> -       struct param p = { .tz_id = tz_id, .trip_id = trip_id };
> +       struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
>
>         return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DOWN, &p);
>  }
>
> -int thermal_notify_tz_trip_up(int tz_id, int trip_id)
> +int thermal_notify_tz_trip_up(int tz_id, int trip_id, int temp)
>  {
> -       struct param p = { .tz_id = tz_id, .trip_id = trip_id };
> +       struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
>
>         return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
>  }
> diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
> index 828d1dddfa98..e554f76291f4 100644
> --- a/drivers/thermal/thermal_netlink.h
> +++ b/drivers/thermal/thermal_netlink.h
> @@ -11,8 +11,8 @@ int thermal_notify_tz_create(int tz_id, const char *name);
>  int thermal_notify_tz_delete(int tz_id);
>  int thermal_notify_tz_enable(int tz_id);
>  int thermal_notify_tz_disable(int tz_id);
> -int thermal_notify_tz_trip_down(int tz_id, int id);
> -int thermal_notify_tz_trip_up(int tz_id, int id);
> +int thermal_notify_tz_trip_down(int tz_id, int id, int temp);
> +int thermal_notify_tz_trip_up(int tz_id, int id, int temp);
>  int thermal_notify_tz_trip_delete(int tz_id, int id);
>  int thermal_notify_tz_trip_add(int tz_id, int id, int type,
>                                int temp, int hyst);
> @@ -49,12 +49,12 @@ static inline int thermal_notify_tz_disable(int tz_id)
>         return 0;
>  }
>
> -static inline int thermal_notify_tz_trip_down(int tz_id, int id)
> +static inline int thermal_notify_tz_trip_down(int tz_id, int id, int temp)
>  {
>         return 0;
>  }
>
> -static inline int thermal_notify_tz_trip_up(int tz_id, int id)
> +static inline int thermal_notify_tz_trip_up(int tz_id, int id, int temp)
>  {
>         return 0;
>  }
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index c105054cbb57..bf5d9c8ef16f 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -18,7 +18,7 @@ enum thermal_trip_type {
>
>  /* Adding event notification support elements */
>  #define THERMAL_GENL_FAMILY_NAME               "thermal"
> -#define THERMAL_GENL_VERSION                   0x01
> +#define THERMAL_GENL_VERSION                   0x02
>  #define THERMAL_GENL_SAMPLING_GROUP_NAME       "sampling"
>  #define THERMAL_GENL_EVENT_GROUP_NAME          "event"
>
> --
> 2.17.1
>
