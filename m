Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D4334B899
	for <lists+linux-api@lfdr.de>; Sat, 27 Mar 2021 18:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhC0Rq5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 27 Mar 2021 13:46:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:37771 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhC0Rq2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 27 Mar 2021 13:46:28 -0400
IronPort-SDR: gM1RYJ1L6wgzV88lM6L6ea0UgJEGP7FZhew76D4NTzJ642JRc1AvsRIWLGO79z3U2D2Lw0pg33
 bYYF3LREQBnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="189060541"
X-IronPort-AV: E=Sophos;i="5.81,283,1610438400"; 
   d="scan'208";a="189060541"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 10:46:28 -0700
IronPort-SDR: Wk2jZpDv2u2fPI/W/0zui+Lve5VH8pvHsWApY4hm9Ym46E4HEF6sItHkD/TAmvzPuexn4Nns1J
 O0M7I1391NSA==
X-IronPort-AV: E=Sophos;i="5.81,283,1610438400"; 
   d="scan'208";a="375881755"
Received: from learls-mobl.amr.corp.intel.com ([10.209.127.167])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2021 10:46:28 -0700
Message-ID: <444a7fc72e6525575b929760fcad186630577afc.camel@linux.intel.com>
Subject: Re: [PATCH] thermal/drivers/netlink: Add the temperature when
 crossing a trip point
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rkumbako@quicinc.com, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>
Date:   Sat, 27 Mar 2021 10:46:27 -0700
In-Reply-To: <CAJZ5v0g58LMVwRWdJaTWVOx09gt6KRGTa974k3cvHYQyxk0EYg@mail.gmail.com>
References: <20210325193633.19592-1-daniel.lezcano@linaro.org>
         <CAJZ5v0g58LMVwRWdJaTWVOx09gt6KRGTa974k3cvHYQyxk0EYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 2021-03-26 at 17:37 +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 25, 2021 at 8:38 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > The slope of the temperature increase or decrease can be high and
> > when
> > the temperature crosses the trip point, there could be a
> > significant
> > difference between the trip temperature and the measured
> > temperatures.
> > 
> > That forces the userspace to read the temperature back right after
> > receiving a trip violation notification.
> > 
> > In order to be efficient, give the temperature which resulted in
> > the
> > trip violation.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Srinivas, what do you think?

- IMO netlink message should also be treated as we treat other ABIs. So
add only when this is a must. Although here GENL version is incremented
, users are not that careful. At least on x86, we know users created
their own applications.


- Here the concern is temperature is changing so fast then netlink +
user space processing latency is enough to change further to read
temperature again. Atleast we assume that and read temperature again.
So not sure that this is the right approach to add another field for
the temperature.


Thanks,
Srinivas



> 
> > ---
> >  drivers/thermal/thermal_core.c    |  6 ++++--
> >  drivers/thermal/thermal_netlink.c | 11 ++++++-----
> >  drivers/thermal/thermal_netlink.h |  8 ++++----
> >  include/uapi/linux/thermal.h      |  2 +-
> >  4 files changed, 15 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c
> > index 996c038f83a4..948020ef51b1 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -430,10 +430,12 @@ static void handle_thermal_trip(struct
> > thermal_zone_device *tz, int trip)
> >         if (tz->last_temperature != THERMAL_TEMP_INVALID) {
> >                 if (tz->last_temperature < trip_temp &&
> >                     tz->temperature >= trip_temp)
> > -                       thermal_notify_tz_trip_up(tz->id, trip);
> > +                       thermal_notify_tz_trip_up(tz->id, trip,
> > +                                                 tz->temperature);
> >                 if (tz->last_temperature >= trip_temp &&
> >                     tz->temperature < (trip_temp - hyst))
> > -                       thermal_notify_tz_trip_down(tz->id, trip);
> > +                       thermal_notify_tz_trip_down(tz->id, trip,
> > +                                                   tz-
> > >temperature);
> >         }
> > 
> >         if (type == THERMAL_TRIP_CRITICAL || type ==
> > THERMAL_TRIP_HOT)
> > diff --git a/drivers/thermal/thermal_netlink.c
> > b/drivers/thermal/thermal_netlink.c
> > index 1234dbe95895..a16dd4d5d710 100644
> > --- a/drivers/thermal/thermal_netlink.c
> > +++ b/drivers/thermal/thermal_netlink.c
> > @@ -121,7 +121,8 @@ static int thermal_genl_event_tz(struct param
> > *p)
> >  static int thermal_genl_event_tz_trip_up(struct param *p)
> >  {
> >         if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id)
> > ||
> > -           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p-
> > >trip_id))
> > +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p-
> > >trip_id) ||
> > +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p-
> > >temp))
> >                 return -EMSGSIZE;
> > 
> >         return 0;
> > @@ -285,16 +286,16 @@ int thermal_notify_tz_disable(int tz_id)
> >         return
> > thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
> >  }
> > 
> > -int thermal_notify_tz_trip_down(int tz_id, int trip_id)
> > +int thermal_notify_tz_trip_down(int tz_id, int trip_id, int temp)
> >  {
> > -       struct param p = { .tz_id = tz_id, .trip_id = trip_id };
> > +       struct param p = { .tz_id = tz_id, .trip_id = trip_id,
> > .temp = temp };
> > 
> >         return
> > thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DOWN, &p);
> >  }
> > 
> > -int thermal_notify_tz_trip_up(int tz_id, int trip_id)
> > +int thermal_notify_tz_trip_up(int tz_id, int trip_id, int temp)
> >  {
> > -       struct param p = { .tz_id = tz_id, .trip_id = trip_id };
> > +       struct param p = { .tz_id = tz_id, .trip_id = trip_id,
> > .temp = temp };
> > 
> >         return
> > thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
> >  }
> > diff --git a/drivers/thermal/thermal_netlink.h
> > b/drivers/thermal/thermal_netlink.h
> > index 828d1dddfa98..e554f76291f4 100644
> > --- a/drivers/thermal/thermal_netlink.h
> > +++ b/drivers/thermal/thermal_netlink.h
> > @@ -11,8 +11,8 @@ int thermal_notify_tz_create(int tz_id, const
> > char *name);
> >  int thermal_notify_tz_delete(int tz_id);
> >  int thermal_notify_tz_enable(int tz_id);
> >  int thermal_notify_tz_disable(int tz_id);
> > -int thermal_notify_tz_trip_down(int tz_id, int id);
> > -int thermal_notify_tz_trip_up(int tz_id, int id);
> > +int thermal_notify_tz_trip_down(int tz_id, int id, int temp);
> > +int thermal_notify_tz_trip_up(int tz_id, int id, int temp);
> >  int thermal_notify_tz_trip_delete(int tz_id, int id);
> >  int thermal_notify_tz_trip_add(int tz_id, int id, int type,
> >                                int temp, int hyst);
> > @@ -49,12 +49,12 @@ static inline int thermal_notify_tz_disable(int
> > tz_id)
> >         return 0;
> >  }
> > 
> > -static inline int thermal_notify_tz_trip_down(int tz_id, int id)
> > +static inline int thermal_notify_tz_trip_down(int tz_id, int id,
> > int temp)
> >  {
> >         return 0;
> >  }
> > 
> > -static inline int thermal_notify_tz_trip_up(int tz_id, int id)
> > +static inline int thermal_notify_tz_trip_up(int tz_id, int id, int
> > temp)
> >  {
> >         return 0;
> >  }
> > diff --git a/include/uapi/linux/thermal.h
> > b/include/uapi/linux/thermal.h
> > index c105054cbb57..bf5d9c8ef16f 100644
> > --- a/include/uapi/linux/thermal.h
> > +++ b/include/uapi/linux/thermal.h
> > @@ -18,7 +18,7 @@ enum thermal_trip_type {
> > 
> >  /* Adding event notification support elements */
> >  #define THERMAL_GENL_FAMILY_NAME               "thermal"
> > -#define THERMAL_GENL_VERSION                   0x01
> > +#define THERMAL_GENL_VERSION                   0x02
> >  #define THERMAL_GENL_SAMPLING_GROUP_NAME       "sampling"
> >  #define THERMAL_GENL_EVENT_GROUP_NAME          "event"
> > 
> > --
> > 2.17.1
> > 

