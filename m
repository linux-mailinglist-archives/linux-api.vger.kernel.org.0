Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF1234BE8E
	for <lists+linux-api@lfdr.de>; Sun, 28 Mar 2021 21:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhC1TcI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 28 Mar 2021 15:32:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:29442 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhC1Tbd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 28 Mar 2021 15:31:33 -0400
IronPort-SDR: Gp8qwKk6M3yS3oJwO7StUql3wDp1fxyyCKPABTLYKrtCRURy3/p+yr9kCYapz0Hot5d4gkFsKz
 siDsjaEKQMnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="211617194"
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="211617194"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 12:31:32 -0700
IronPort-SDR: DkmjaJX3am0EYO4W9vzxXMBijiggxVlIHej7xjVvNql2vm6+r8bUtPkLv5nnXyIZ6qefiVQDb0
 T+aBWpuYAhpA==
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="376185671"
Received: from bseshadr-mobl2.amr.corp.intel.com ([10.251.23.39])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 12:31:31 -0700
Message-ID: <a2665d9f450b5e6dc0cc5017e2b83a5c49840d3f.camel@linux.intel.com>
Subject: Re: [PATCH] thermal/drivers/netlink: Add the temperature when
 crossing a trip point
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rkumbako@quicinc.com, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>
Date:   Sun, 28 Mar 2021 12:31:31 -0700
In-Reply-To: <ae16d810-e5ec-ad63-7b29-fd1ddab68907@linaro.org>
References: <20210325193633.19592-1-daniel.lezcano@linaro.org>
         <CAJZ5v0g58LMVwRWdJaTWVOx09gt6KRGTa974k3cvHYQyxk0EYg@mail.gmail.com>
         <444a7fc72e6525575b929760fcad186630577afc.camel@linux.intel.com>
         <ae16d810-e5ec-ad63-7b29-fd1ddab68907@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Daniel,

On Sat, 2021-03-27 at 21:25 +0100, Daniel Lezcano wrote:
> Hi Srinivas,
> 
> On 27/03/2021 18:46, Srinivas Pandruvada wrote:
> > On Fri, 2021-03-26 at 17:37 +0100, Rafael J. Wysocki wrote:
> > > On Thu, Mar 25, 2021 at 8:38 PM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > > > The slope of the temperature increase or decrease can be high
> > > > and
> > > > when
> > > > the temperature crosses the trip point, there could be a
> > > > significant
> > > > difference between the trip temperature and the measured
> > > > temperatures.
> > > > 
> > > > That forces the userspace to read the temperature back right
> > > > after
> > > > receiving a trip violation notification.
> > > > 
> > > > In order to be efficient, give the temperature which resulted
> > > > in
> > > > the
> > > > trip violation.
> > > > 
> > > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > 
> > > Srinivas, what do you think?
> > 
> > - IMO netlink message should also be treated as we treat other
> > ABIs. So
> > add only when this is a must. Although here GENL version is
> > incremented
> > , users are not that careful. At least on x86, we know users
> > created
> > their own applications.
> 
> I don't see where is the problem. The protocol is still compatible
> with
> the previous version, so that does not break the existing AFAICT.
> That
> is done on purpose.

The size of netlink message is changed. This is not a good argument to
just adding members at the end. The point I am trying that netlink now
is an ABI, which should go through same process as we are
adding/changing a sysfs attributes.
 

> 
> There is a new attribute added, the application using the previous
> version will just not be aware of its presence and parse the message
> without getting the temperature.
> 
> > - Here the concern is temperature is changing so fast then netlink
> > +
> > user space processing latency is enough to change further to read
> > temperature again. Atleast we assume that and read temperature
> > again.
> > So not sure that this is the right approach to add another field
> > for
> > the temperature.
> 
> I'm not sure to understand your comment. Whatever the mechanism
> (interrupt based or polling), the temperature is read in any case by
> the
> call to thermal_zone_device_update() which in turns calls
> handle_trip_point and then send the message. So, why not add the
> temperature as the userspace is interested on getting the temperature
> anyway.
> For instance, in polling mode, (usually set to 1000ms), the trip
> point
> crossing is detected with a long delay and during this time the
> temperature could be far beyond the trip temperature.
> cosnumer
> It is not about netlink latency but about avoiding a back and forth
> when
> the trip point is crossed and the temperature wavering around.

That is the reasoning given to add this change in the description that
slope of change is high so user is forced to read temperature again as
the trip temp +- current temp is significant. If slope is very high
then, when the temperature passed in the messages is already stale in
few ms, so the user space will still end up in re-reading again.

The reason you want to add temperature is that you sampled the latest
temperature during thermal_zone_device_update(), which may be different
than the trip temperature. So provide temperature also to user space
consumer, so it can decide whether to use as is or re-read sample. This
change will save one additional read from user space in some cases and
also allow disable notifications of trip if the temperature is hovering
around trip.
This is not to say that user can space totally can avoid another read.
Then fine with me.


Thanks,
Srinivas

> 
> 
> > > > ---
> > > >  drivers/thermal/thermal_core.c    |  6 ++++--
> > > >  drivers/thermal/thermal_netlink.c | 11 ++++++-----
> > > >  drivers/thermal/thermal_netlink.h |  8 ++++----
> > > >  include/uapi/linux/thermal.h      |  2 +-
> > > >  4 files changed, 15 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/thermal/thermal_core.c
> > > > b/drivers/thermal/thermal_core.c
> > > > index 996c038f83a4..948020ef51b1 100644
> > > > --- a/drivers/thermal/thermal_core.c
> > > > +++ b/drivers/thermal/thermal_core.c
> > > > @@ -430,10 +430,12 @@ static void handle_thermal_trip(struct
> > > > thermal_zone_device *tz, int trip)
> > > >         if (tz->last_temperature != THERMAL_TEMP_INVALID) {
> > > >                 if (tz->last_temperature < trip_temp &&
> > > >                     tz->temperature >= trip_temp)
> > > > -                       thermal_notify_tz_trip_up(tz->id,
> > > > trip);
> > > > +                       thermal_notify_tz_trip_up(tz->id, trip,
> > > > +                                                 tz-
> > > > >temperature);
> > > >                 if (tz->last_temperature >= trip_temp &&
> > > >                     tz->temperature < (trip_temp - hyst))
> > > > -                       thermal_notify_tz_trip_down(tz->id,
> > > > trip);
> > > > +                       thermal_notify_tz_trip_down(tz->id,
> > > > trip,
> > > > +                                                   tz-
> > > > > temperature);
> > > >         }
> > > > 
> > > >         if (type == THERMAL_TRIP_CRITICAL || type ==
> > > > THERMAL_TRIP_HOT)
> > > > diff --git a/drivers/thermal/thermal_netlink.c
> > > > b/drivers/thermal/thermal_netlink.c
> > > > index 1234dbe95895..a16dd4d5d710 100644
> > > > --- a/drivers/thermal/thermal_netlink.c
> > > > +++ b/drivers/thermal/thermal_netlink.c
> > > > @@ -121,7 +121,8 @@ static int thermal_genl_event_tz(struct
> > > > param
> > > > *p)
> > > >  static int thermal_genl_event_tz_trip_up(struct param *p)
> > > >  {
> > > >         if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p-
> > > > >tz_id)
> > > > -           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID,
> > > > p-
> > > > > trip_id))
> > > > +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID,
> > > > p-
> > > > > trip_id) ||
> > > > +           nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p-
> > > > > temp))
> > > >                 return -EMSGSIZE;
> > > > 
> > > >         return 0;
> > > > @@ -285,16 +286,16 @@ int thermal_notify_tz_disable(int tz_id)
> > > >         return
> > > > thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
> > > >  }
> > > > 
> > > > -int thermal_notify_tz_trip_down(int tz_id, int trip_id)
> > > > +int thermal_notify_tz_trip_down(int tz_id, int trip_id, int
> > > > temp)
> > > >  {
> > > > -       struct param p = { .tz_id = tz_id, .trip_id = trip_id
> > > > };
> > > > +       struct param p = { .tz_id = tz_id, .trip_id = trip_id,
> > > > .temp = temp };
> > > > 
> > > >         return
> > > > thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DOWN, &p);
> > > >  }
> > > > 
> > > > -int thermal_notify_tz_trip_up(int tz_id, int trip_id)
> > > > +int thermal_notify_tz_trip_up(int tz_id, int trip_id, int
> > > > temp)
> > > >  {
> > > > -       struct param p = { .tz_id = tz_id, .trip_id = trip_id
> > > > };
> > > > +       struct param p = { .tz_id = tz_id, .trip_id = trip_id,
> > > > .temp = temp };
> > > > 
> > > >         return
> > > > thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
> > > >  }
> > > > diff --git a/drivers/thermal/thermal_netlink.h
> > > > b/drivers/thermal/thermal_netlink.h
> > > > index 828d1dddfa98..e554f76291f4 100644
> > > > --- a/drivers/thermal/thermal_netlink.h
> > > > +++ b/drivers/thermal/thermal_netlink.h
> > > > @@ -11,8 +11,8 @@ int thermal_notify_tz_create(int tz_id, const
> > > > char *name);
> > > >  int thermal_notify_tz_delete(int tz_id);
> > > >  int thermal_notify_tz_enable(int tz_id);
> > > >  int thermal_notify_tz_disable(int tz_id);
> > > > -int thermal_notify_tz_trip_down(int tz_id, int id);
> > > > -int thermal_notify_tz_trip_up(int tz_id, int id);
> > > > +int thermal_notify_tz_trip_down(int tz_id, int id, int temp);
> > > > +int thermal_notify_tz_trip_up(int tz_id, int id, int temp);
> > > >  int thermal_notify_tz_trip_delete(int tz_id, int id);
> > > >  int thermal_notify_tz_trip_add(int tz_id, int id, int type,
> > > >                                int temp, int hyst);
> > > > @@ -49,12 +49,12 @@ static inline int
> > > > thermal_notify_tz_disable(int
> > > > tz_id)
> > > >         return 0;
> > > >  }
> > > > 
> > > > -static inline int thermal_notify_tz_trip_down(int tz_id, int
> > > > id)
> > > > +static inline int thermal_notify_tz_trip_down(int tz_id, int
> > > > id,
> > > > int temp)
> > > >  {
> > > >         return 0;
> > > >  }
> > > > 
> > > > -static inline int thermal_notify_tz_trip_up(int tz_id, int id)
> > > > +static inline int thermal_notify_tz_trip_up(int tz_id, int id,
> > > > int
> > > > temp)
> > > >  {
> > > >         return 0;
> > > >  }
> > > > diff --git a/include/uapi/linux/thermal.h
> > > > b/include/uapi/linux/thermal.h
> > > > index c105054cbb57..bf5d9c8ef16f 100644
> > > > --- a/include/uapi/linux/thermal.h
> > > > +++ b/include/uapi/linux/thermal.h
> > > > @@ -18,7 +18,7 @@ enum thermal_trip_type {
> > > > 
> > > >  /* Adding event notification support elements */
> > > >  #define THERMAL_GENL_FAMILY_NAME               "thermal"
> > > > -#define THERMAL_GENL_VERSION                   0x01
> > > > +#define THERMAL_GENL_VERSION                   0x02
> > > >  #define THERMAL_GENL_SAMPLING_GROUP_NAME       "sampling"
> > > >  #define THERMAL_GENL_EVENT_GROUP_NAME          "event"
> > > > 
> > > > --
> > > > 2.17.1
> > > > 
> 
> 

