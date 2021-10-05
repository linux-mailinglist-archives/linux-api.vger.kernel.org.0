Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6981B422C3E
	for <lists+linux-api@lfdr.de>; Tue,  5 Oct 2021 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhJEPWv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Oct 2021 11:22:51 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:44697 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbhJEPWv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Oct 2021 11:22:51 -0400
Received: by mail-oo1-f49.google.com with SMTP id e16-20020a4ad250000000b002b5e1f1bc78so6510769oos.11;
        Tue, 05 Oct 2021 08:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1SQZI9IBqKFsTuTJMiu0Zhaccp541Qn8MR+8yauPlhA=;
        b=z7zC97mQqbLUgJ2P02j79Y83xq26wYgcFRZMCBpF4GMBUBxQR0/yG9L77yg1QTEbsj
         +f4KUS6qfbhXbrO/d/63HhLAvUd1nwEZIS7JX3SVUyPs2aMEQazDGLtJIMEuLKtXKBzg
         lE/VF81zJzKPeHYExV8hL1gyit0NM+ojNL87o/i3UEPtvfGlUbrEZkyTUT+/hmN1oQV4
         iGJeJvMA1IvaCkDdpeYFwpZMw6t3VyvPkeOrSERkJt9gDKI9rj8C2NgcODSAqU2wONrc
         iC6kxHH/jRkEvM/bAfD36B8ZYZGOhok+ru4Z2jQFyShcmI1CipRYd2QRWLI5419QphNo
         B2hw==
X-Gm-Message-State: AOAM532fjJnHewJ1pzT7ajy6XZ0lxUfRdreziA44pNgeHr109R0GAVvk
        XnCuzcSt97vKYjbIdFIHaJFH2W1JfwMsnWPPN10=
X-Google-Smtp-Source: ABdhPJz3o1zdtTqn2dRO6CD59AnsSHBZi3lWDbFWsKT7A5voSXt4yIFP8MWAC6YW3xqWPqco4B579RslsyAXRyAsyBI=
X-Received: by 2002:a05:6820:17a:: with SMTP id k26mr13990963ood.37.1633447260320;
 Tue, 05 Oct 2021 08:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211001223323.1836640-1-daniel.lezcano@linaro.org>
In-Reply-To: <20211001223323.1836640-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 17:20:49 +0200
Message-ID: <CAJZ5v0hcHq2WJ6UkdDbHynnQYv4MukCWXob_rH=Sa=aYDrr7Cw@mail.gmail.com>
Subject: Re: [PATCH RESEND] thermal/drivers/netlink: Add the temperature when
 crossing a trip point
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>, rkumbako@quicinc.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Oct 2, 2021 at 12:33 AM Daniel Lezcano
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
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This looks fine to me too.

> ---
>  drivers/thermal/thermal_core.c    |  6 ++++--
>  drivers/thermal/thermal_netlink.c | 11 ++++++-----
>  drivers/thermal/thermal_netlink.h |  8 ++++----
>  3 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 51374f4e1cca..9e243d9f929e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -375,10 +375,12 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
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

While at it, I'm not sure if all of the additional line breaks due to
the line length limit are really necessary.  The code would be easier
to follow without them IMV.

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
> --
> 2.25.1
>
