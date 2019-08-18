Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75189917C3
	for <lists+linux-api@lfdr.de>; Sun, 18 Aug 2019 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfHRQWT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 18 Aug 2019 12:22:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44743 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRQWR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 18 Aug 2019 12:22:17 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzNw8-00089r-GO; Sun, 18 Aug 2019 18:21:44 +0200
Date:   Sun, 18 Aug 2019 18:21:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv6 23/36] x86/vdso: Allocate timens vdso
In-Reply-To: <483678c7-7687-5445-f09e-e45e9460d559@gmail.com>
Message-ID: <alpine.DEB.2.21.1908171709360.1923@nanos.tec.linutronix.de>
References: <20190815163836.2927-1-dima@arista.com> <20190815163836.2927-24-dima@arista.com> <b719199a-ed91-610b-38bc-015a0749f600@kernel.org> <alpine.DEB.2.21.1908162208190.1923@nanos.tec.linutronix.de> <483678c7-7687-5445-f09e-e45e9460d559@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dmitry,

On Fri, 16 Aug 2019, Dmitry Safonov wrote:
> On 8/16/19 9:10 PM, Thomas Gleixner wrote:
> > On Fri, 16 Aug 2019, Andy Lutomirski wrote:
> [..]
> >> I'm unconvinced that any of this magic is wise.  I think you should make a
> >> special timens vvar page that causes the normal fastpath to fail (using a
> >> special vclock mode, a special seq value, or a special "last" value) and then
> >> make the failure path detect that timens is in use and use the timens path.
> 
> I see. That's so clever, it haven't come on my mind.
> Hmm, is that better because of the price of 5-byte NOP?
> I'm a bit afraid to complicate that seq/vclock logic more..

See below.

> > My initial suggestion still stands. Do that at compile time. It really does
> > not matter whether we have another 2 or 3 variants of vdso binaries.
> > 
> > Use it and be done with it. No special magic, just straight forward
> > decisions to use a timens capable VDSO or not.
> 
> I believe that was something we did in version 1 of the patches set.
> It doesn't sound like a rocket science to do, but it resulted in a
> couple of ugly patches.
> 
> The post-attempt notes about downsides of doing it compile-time are:
> 
> 1. There is additional .so for each vdso: 64-bit, ia32, x32. The same
> for every architecture to-be supported. It adds rules in Makefiles. [2]
> 2. If we still intend to keep setns() working without exec(), function
> entries on both host/namespace vdso should be aligned to each other [3].
> That results in a patch to vdso2c to generate offsets [4, 5] and in
> linker magic to align another vdso [6].
> 3. As unexpected consequence, we also need to align local functions on
> vdso [7].
> 
> So, it might be all related to my lack of skills, but it seems to bring
> some big amount of complexity into build process. And in my point of
> view, major issue is that it would not scale easily when the day will
> come and there will be a need to introduce another vdso.so. As I didn't
> want to be the guy that happens to be remembered as "he wrote this
> unmaintainable pile of garbage", I've taken dynamic patching approach
> that is done once a boot time.

Fair enough. Did not think about that part.
 
> Regardless, we both with Andrei want to improve the patches set and make
> it acceptable and easy to maintain in future. I hope, that our effort to
> do that is visible through evolution of patches. And we're very glad
> that we've constructive critics and such patient maintainers.

I'm happy to review well written stuff which makes progress and takes
review comments into account or the submitter discusses them for
resolution.

> So, if I'm mistaken in those points about compile-time vdso(s), or you
> have in mind a plan how-to avoid those, I'd appreciate and rework it to
> that direction.

Coming back to Andy's idea. Create your time namespace page as an exact
copy of the vdso data page. When the page is created do:

     	 memset(p->vdso_data, 0, sizeof(p->vdso_data));
     	 p->vdso_data[0].clock_mode = CLOCK_TIMENS;
	 p->vdso_data[0].seq = 1;
 
	 /* Store the namespace offsets in basetime */
	 p->vdso_data[0].basetime[CLOCK_MONOTONIC].sec = myns->mono_sec;
	 p->vdso_data[0].basetime[CLOCK_MONOTONIC].nsec = myns->mono_nsec;
	 p->vdso_data[0].basetime[CLOCK_BOOTTIME].sec = myns->boot_sec;
	 p->vdso_data[0].basetime[CLOCK_BOOTTIME].nsec = myns->boot_nsec;

     	 p->vdso_data[1].clock_mode = CLOCK_TIMENS;
	 p->vdso_data[1].seq = 1;

For a normal task the VVAR pages are installed in the normal ordering:

       VVAR
       PVCLOCK
       HVCLOCK
       TIMENS	<- Not really required

Now for a timens task you install the pages in the following order

       TIMENS
       PVCLOCK
       HVCLOCK
       VVAR

The check for vdso_data->clock_mode is in the unlikely path of the now open
coded seq begin magic. So for the non-timens case most of the time 'seq' is
even, so the branch is not taken.

If 'seq' is odd, i.e. a concurrent update is in progress, the extra check
for vdso_data->clock_mode is a non-issue. The task is spin waiting for the
update to finish and for 'seq' to become even anyway.

Patch below. I tested this with the normal order and by installing a
'timens' page unconditionally for all processes. I'll reply with the timens
testing hacks so you can see what I did.

The test results are pretty good.

    	 	 Base (upstream)  + VDSO patch	+ timens page

MONO		 30ns 		    30ns 	  32ns
REAL		 30ns		    30ns	  32ns
BOOT		 30ns		    30ns	  32ns
MONOCOARSE	  7ns		     8ns	  10ns
REALCOARSE	  7ns		     8ns	  10ns
TAI		 30ns		    30ns	  32ns
MONORAW		 30ns		    30ns	  32ns

So except for the coarse clocks there is no change when the timens page is
not used, i.e. the regular VVAR page is at the proper place. But that's on
one machine, a different one showed an effect in the noise range. I'm not
worried about that as the VDSO behaviour varies depending on micro
architecture anyway.

With timens enabled the performance hit (cache hot microbenchmark) is
somewhere in the range of 5-7% when looking at the perf counters
numbers. The hit for the coarse accessors is larger obviously because the
overhead is constant time.

I did a quick comparison of the array vs. switch case (what you used for
your clk_to_ns() helper). The switch case is slower.

So I rather go for the array based approach. It's simpler code and the
I-cache footprint is smaller and no conditional branches involved.

That means your timens_to_host() and host_to_timens() conversion functions
should just use that special VDSO page and do the same array based
unconditional add/sub of the clock specific offset.

Thanks,

	tglx

8<-----------------
Subject: lib/vdso: Prepare for time namespace support
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 18 Aug 2019 16:53:06 +0200

To support time namespaces in the vdso with a minimal impact on regular non
time namespace affected tasks, the namespace handling needs to be hidden in
a slow path.

The most obvious place is vdso_seq_begin(). If a task belongs to a time
namespace then the VVAR page which contains the system wide vdso data is
replaced with a namespace specific page which has the same layout as the
VVAR page. That page has vdso_data->seq set to 1 to enforce the slow path
and vdso_data->clock_mode set to VCLOCK_TIMENS to enforce the time
namespace handling path.

The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
update of the vdso data is in progress, is not really affecting regular
tasks which are not part of a time namespace as the task is spin waiting
for the update to finish and vdso_data->seq to become even again.

If a time namespace task hits that code path, it invokes the corresponding
time getter function which retrieves the real VVAR page, reads host time
and then adds the offset for the requested clock which is stored in the
special VVAR page.

If VDSO time namespace support is disabled the whole magic is compiled out.

Initial testing shows that the disabled case is almost identical to the
host case which does not take the slow timens path. With the special timens
page installed the performance hit is constant time and in the range of
5-7%.

For the vdso functions which are not using the sequence count an
unconditional check for vdso_data->clock_mode is added which switches to
the real vdso when the clock_mode is VCLOCK_TIMENS.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/time.h    |    6 ++
 include/vdso/datapage.h |   19 ++++++-
 lib/vdso/Kconfig        |    6 ++
 lib/vdso/gettimeofday.c |  128 ++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 155 insertions(+), 4 deletions(-)

--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -96,4 +96,10 @@ static inline bool itimerspec64_valid(co
  */
 #define time_after32(a, b)	((s32)((u32)(b) - (u32)(a)) < 0)
 #define time_before32(b, a)	time_after32(a, b)
+
+struct timens_offset {
+	s64	sec;
+	u64	nsec;
+};
+
 #endif
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -21,6 +21,8 @@
 #define CS_RAW		1
 #define CS_BASES	(CS_RAW + 1)
 
+#define VCLOCK_TIMENS	UINT_MAX
+
 /**
  * struct vdso_timestamp - basetime per clock_id
  * @sec:	seconds
@@ -48,6 +50,7 @@ struct vdso_timestamp {
  * @mult:		clocksource multiplier
  * @shift:		clocksource shift
  * @basetime[clock_id]:	basetime per clock_id
+ * @offset[clock_id]:	time namespace offset per clock_id
  * @tz_minuteswest:	minutes west of Greenwich
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
@@ -55,6 +58,17 @@ struct vdso_timestamp {
  *
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
+ *
+ * @basetime is used to store the base time for the system wide time getter
+ * VVAR page.
+ *
+ * @offset is used by the special time namespace VVAR pages which are
+ * installed instead of the real VVAR page. These namespace pages must set
+ * @seq to 1 and @clock_mode to VLOCK_TIMENS to force the code into the
+ * time namespace slow path. The namespace aware functions retrieve the
+ * real system wide VVAR page, read host time and add the per clock offset.
+ * For clocks which are not affected by time namespace adjustement the
+ * offset must be zero.
  */
 struct vdso_data {
 	u32			seq;
@@ -65,7 +79,10 @@ struct vdso_data {
 	u32			mult;
 	u32			shift;
 
-	struct vdso_timestamp	basetime[VDSO_BASES];
+	union {
+		struct vdso_timestamp	basetime[VDSO_BASES];
+		struct timens_offset	offset[VDSO_BASES];
+	};
 
 	s32			tz_minuteswest;
 	s32			tz_dsttime;
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -33,4 +33,10 @@ config CROSS_COMPILE_COMPAT_VDSO
 	  If a 64 bit compiler (i.e. x86_64) can compile the VDSO for
 	  32 bit, it does not need to define this parameter.
 
+config VDSO_TIMENS
+	bool
+	help
+	  Selected by architectures which support time namespaces in the
+	  VDSO
+
 endif
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -38,6 +38,51 @@ u64 vdso_calc_delta(u64 cycles, u64 last
 }
 #endif
 
+#ifndef CONFIG_VDSO_TIMENS
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
+{
+	return NULL;
+}
+#endif
+
+static int do_hres_ns(const struct vdso_data *vdns, clockid_t clk,
+		      struct __kernel_timespec *ts)
+{
+	const struct vdso_data *vd = __arch_get_timens_vdso_data(vdns);
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	const struct timens_offset *offs = &vdns->offset[clk];
+	u64 cycles, last, ns;
+	s64 sec;
+	u32 seq;
+
+	do {
+		seq = vdso_read_begin(vd);
+		cycles = __arch_get_hw_counter(vd->clock_mode);
+		ns = vdso_ts->nsec;
+		last = vd->cycle_last;
+		if (unlikely((s64)cycles < 0))
+			return -1;
+
+		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
+		ns >>= vd->shift;
+		sec = vdso_ts->sec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	/* Add the namespace offset */
+	sec += offs->sec;
+	ns += offs->nsec;
+
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+
 static int do_hres(const struct vdso_data *vd, clockid_t clk,
 		   struct __kernel_timespec *ts)
 {
@@ -46,7 +91,28 @@ static int do_hres(const struct vdso_dat
 	u32 seq;
 
 	do {
-		seq = vdso_read_begin(vd);
+		/*
+		 * Open coded to handle VCLOCK_TIMENS. Time namespace
+		 * enabled tasks have a special VVAR page installed which
+		 * has vd->seq set to 1 and vd->clock_mode set to
+		 * VCLOCK_TIMENS. For non time namespace affected tasks
+		 * this does not affect performance because if vd->seq is
+		 * odd, i.e. a concurrent update is in progress the extra
+		 * check for vd->clock_mode is just a few extra
+		 * instructions while spin waiting for vd->seq to become
+		 * even again.
+		 */
+		while (1) {
+			seq = READ_ONCE(vd->seq);
+			if (likely(!(seq & 1)))
+				break;
+			if (IS_ENABLED(CONFIG_VDSO_TIMENS) &&
+			    vd->clock_mode == VCLOCK_TIMENS)
+				return do_hres_ns(vd, clk, ts);
+			cpu_relax();
+		}
+		smp_rmb();
+
 		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
@@ -68,6 +134,34 @@ static int do_hres(const struct vdso_dat
 	return 0;
 }
 
+static void do_coarse_ns(const struct vdso_data *vdns, clockid_t clk,
+			 struct __kernel_timespec *ts)
+{
+	const struct vdso_data *vd = __arch_get_timens_vdso_data(vdns);
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	const struct timens_offset *offs = &vdns->offset[clk];
+	u64 nsec;
+	s64 sec;
+	s32 seq;
+
+	do {
+		seq = vdso_read_begin(vd);
+		sec = vdso_ts->sec;
+		nsec = vdso_ts->nsec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	/* Add the namespace offset */
+	sec += offs->sec;
+	nsec += offs->nsec;
+
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
+}
+
 static void do_coarse(const struct vdso_data *vd, clockid_t clk,
 		      struct __kernel_timespec *ts)
 {
@@ -75,7 +169,23 @@ static void do_coarse(const struct vdso_
 	u32 seq;
 
 	do {
-		seq = vdso_read_begin(vd);
+		/*
+		 * Open coded to handle VCLOCK_TIMENS. See comment in
+		 * do_hres().
+		 */
+		while (1) {
+			seq = READ_ONCE(vd->seq);
+			if (likely(!(seq & 1)))
+				break;
+			if (IS_ENABLED(CONFIG_VDSO_TIMENS) &&
+			    vd->clock_mode == VCLOCK_TIMENS) {
+				do_coarse_ns(vd, clk, ts);
+				return;
+			}
+			cpu_relax();
+		}
+		smp_rmb();
+
 		ts->tv_sec = vdso_ts->sec;
 		ts->tv_nsec = vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
@@ -156,6 +266,10 @@ static __maybe_unused int
 	}
 
 	if (unlikely(tz != NULL)) {
+		if (IS_ENABLED(CONFIG_VDSO_TIMENS) &&
+		    vd->clock_mode == VCLOCK_TIMENS)
+			vd = __arch_get_timens_vdso_data(vd);
+
 		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
 		tz->tz_dsttime = vd[CS_HRES_COARSE].tz_dsttime;
 	}
@@ -167,7 +281,12 @@ static __maybe_unused int
 static __maybe_unused time_t __cvdso_time(time_t *time)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
-	time_t t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+	time_t t;
+
+	if (IS_ENABLED(CONFIG_VDSO_TIMENS) && vd->clock_mode == VCLOCK_TIMENS)
+		vd = __arch_get_timens_vdso_data(vd);
+
+	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
 
 	if (time)
 		*time = t;
@@ -189,6 +308,9 @@ int __cvdso_clock_getres_common(clockid_
 	if (unlikely((u32) clock >= MAX_CLOCKS))
 		return -1;
 
+	if (IS_ENABLED(CONFIG_VDSO_TIMENS) && vd->clock_mode == VCLOCK_TIMENS)
+		vd = __arch_get_timens_vdso_data(vd);
+
 	hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
