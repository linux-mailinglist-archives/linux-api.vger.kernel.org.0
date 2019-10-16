Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EB6D93FA
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2019 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392435AbfJPOfS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Oct 2019 10:35:18 -0400
Received: from foss.arm.com ([217.140.110.172]:41566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731987AbfJPOfR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 Oct 2019 10:35:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C70D142F;
        Wed, 16 Oct 2019 07:35:16 -0700 (PDT)
Received: from [10.37.9.204] (unknown [10.37.9.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 042A73F68E;
        Wed, 16 Oct 2019 07:35:10 -0700 (PDT)
Subject: Re: [PATCHv7 19/33] lib/vdso: Prepare for time namespace support
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
References: <20191011012341.846266-1-dima@arista.com>
 <20191011012341.846266-20-dima@arista.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a726e64f-bf73-4eca-6acf-75926898d88a@arm.com>
Date:   Wed, 16 Oct 2019 15:37:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011012341.846266-20-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Dmitry,

On 10/11/19 2:23 AM, Dmitry Safonov wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To support time namespaces in the vdso with a minimal impact on regular non
> time namespace affected tasks, the namespace handling needs to be hidden in
> a slow path.
> 
> The most obvious place is vdso_seq_begin(). If a task belongs to a time
> namespace then the VVAR page which contains the system wide vdso data is
> replaced with a namespace specific page which has the same layout as the
> VVAR page. That page has vdso_data->seq set to 1 to enforce the slow path
> and vdso_data->clock_mode set to VCLOCK_TIMENS to enforce the time
> namespace handling path.
> 
> The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> update of the vdso data is in progress, is not really affecting regular
> tasks which are not part of a time namespace as the task is spin waiting
> for the update to finish and vdso_data->seq to become even again.
> 
> If a time namespace task hits that code path, it invokes the corresponding
> time getter function which retrieves the real VVAR page, reads host time
> and then adds the offset for the requested clock which is stored in the
> special VVAR page.
> 
> If VDSO time namespace support is disabled the whole magic is compiled out.
> 
> Initial testing shows that the disabled case is almost identical to the
> host case which does not take the slow timens path. With the special timens
> page installed the performance hit is constant time and in the range of
> 5-7%.
> 
> For the vdso functions which are not using the sequence count an
> unconditional check for vdso_data->clock_mode is added which switches to
> the real vdso when the clock_mode is VCLOCK_TIMENS.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/linux/time.h    |   6 ++
>  include/vdso/datapage.h |  19 +++++-
>  lib/vdso/Kconfig        |   6 ++
>  lib/vdso/gettimeofday.c | 128 +++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 155 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/time.h b/include/linux/time.h
> index 27d83fd2ae61..b1a592638d7d 100644
> --- a/include/linux/time.h
> +++ b/include/linux/time.h
> @@ -96,4 +96,10 @@ static inline bool itimerspec64_valid(const struct itimerspec64 *its)
>   */
>  #define time_after32(a, b)	((s32)((u32)(b) - (u32)(a)) < 0)
>  #define time_before32(b, a)	time_after32(a, b)
> +
> +struct timens_offset {
> +	s64	sec;
> +	u64	nsec;
> +};
> +
>  #endif
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index 2e302c0f41f7..65a38acce27e 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -21,6 +21,8 @@
>  #define CS_RAW		1
>  #define CS_BASES	(CS_RAW + 1)
>  
> +#define VCLOCK_TIMENS	UINT_MAX
> +
>  /**
>   * struct vdso_timestamp - basetime per clock_id
>   * @sec:	seconds
> @@ -48,6 +50,7 @@ struct vdso_timestamp {
>   * @mult:		clocksource multiplier
>   * @shift:		clocksource shift
>   * @basetime[clock_id]:	basetime per clock_id
> + * @offset[clock_id]:	time namespace offset per clock_id
>   * @tz_minuteswest:	minutes west of Greenwich
>   * @tz_dsttime:		type of DST correction
>   * @hrtimer_res:	hrtimer resolution
> @@ -55,6 +58,17 @@ struct vdso_timestamp {
>   *
>   * vdso_data will be accessed by 64 bit and compat code at the same time
>   * so we should be careful before modifying this structure.
> + *
> + * @basetime is used to store the base time for the system wide time getter
> + * VVAR page.
> + *
> + * @offset is used by the special time namespace VVAR pages which are
> + * installed instead of the real VVAR page. These namespace pages must set
> + * @seq to 1 and @clock_mode to VLOCK_TIMENS to force the code into the
> + * time namespace slow path. The namespace aware functions retrieve the
> + * real system wide VVAR page, read host time and add the per clock offset.
> + * For clocks which are not affected by time namespace adjustement the
> + * offset must be zero.
>   */
>  struct vdso_data {
>  	u32			seq;
> @@ -65,7 +79,10 @@ struct vdso_data {
>  	u32			mult;
>  	u32			shift;
>  
> -	struct vdso_timestamp	basetime[VDSO_BASES];
> +	union {
> +		struct vdso_timestamp	basetime[VDSO_BASES];
> +		struct timens_offset	offset[VDSO_BASES];
> +	};
>  
>  	s32			tz_minuteswest;
>  	s32			tz_dsttime;
> diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
> index 9fe698ff62ec..85276de70dba 100644
> --- a/lib/vdso/Kconfig
> +++ b/lib/vdso/Kconfig
> @@ -24,4 +24,10 @@ config GENERIC_COMPAT_VDSO
>  	help
>  	  This config option enables the compat VDSO layer.
>  
> +config VDSO_TIMENS

To uniform the naming with the rest of the file and with CONFIG_TIME_NS, can we
please change the name of this config option in GENERIC_VDSO_TIME_NS? And then
follow the logic explained by Thomas in patch 1 of this series.

Thanks,
Vincenzo

> +	bool
> +	help
> +	  Selected by architectures which support time namespaces in the
> +	  VDSO
> +
>  endif
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index e630e7ff57f1..25244b677823 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -38,6 +38,51 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
>  }
>  #endif
>  
> +#ifndef CONFIG_VDSO_TIMENS
> +static __always_inline
> +const struct vdso_data *__arch_get_timens_vdso_data(void)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
> +		      struct __kernel_timespec *ts)
> +{
> +	const struct vdso_data *vd = __arch_get_timens_vdso_data();
> +	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
> +	const struct timens_offset *offs = &vdns->offset[clk];
> +	u64 cycles, last, ns;
> +	s64 sec;
> +	u32 seq;
> +
> +	do {
> +		seq = vdso_read_begin(vd);
> +		cycles = __arch_get_hw_counter(vd->clock_mode);
> +		ns = vdso_ts->nsec;
> +		last = vd->cycle_last;
> +		if (unlikely((s64)cycles < 0))
> +			return -1;
> +
> +		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
> +		ns >>= vd->shift;
> +		sec = vdso_ts->sec;
> +	} while (unlikely(vdso_read_retry(vd, seq)));
> +
> +	/* Add the namespace offset */
> +	sec += offs->sec;
> +	ns += offs->nsec;
> +
> +	/*
> +	 * Do this outside the loop: a race inside the loop could result
> +	 * in __iter_div_u64_rem() being extremely slow.
> +	 */
> +	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
> +	ts->tv_nsec = ns;
> +
> +	return 0;
> +}
> +
>  static int do_hres(const struct vdso_data *vd, clockid_t clk,
>  		   struct __kernel_timespec *ts)
>  {
> @@ -46,7 +91,28 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
>  	u32 seq;
>  
>  	do {
> -		seq = vdso_read_begin(vd);
> +		/*
> +		 * Open coded to handle VCLOCK_TIMENS. Time namespace
> +		 * enabled tasks have a special VVAR page installed which
> +		 * has vd->seq set to 1 and vd->clock_mode set to
> +		 * VCLOCK_TIMENS. For non time namespace affected tasks
> +		 * this does not affect performance because if vd->seq is
> +		 * odd, i.e. a concurrent update is in progress the extra
> +		 * check for vd->clock_mode is just a few extra
> +		 * instructions while spin waiting for vd->seq to become
> +		 * even again.
> +		 */
> +		while (1) {
> +			seq = READ_ONCE(vd->seq);
> +			if (likely(!(seq & 1)))
> +				break;
> +			if (IS_ENABLED(CONFIG_VDSO_TIMENS) &&
> +			    vd->clock_mode == VCLOCK_TIMENS)
> +				return do_hres_timens(vd, clk, ts);
> +			cpu_relax();
> +		}
> +		smp_rmb();
> +
>  		cycles = __arch_get_hw_counter(vd->clock_mode);
>  		ns = vdso_ts->nsec;
>  		last = vd->cycle_last;
> @@ -68,6 +134,34 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
>  	return 0;
>  }
>  
> +static void do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
> +			 struct __kernel_timespec *ts)
> +{
> +	const struct vdso_data *vd = __arch_get_timens_vdso_data();
> +	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
> +	const struct timens_offset *offs = &vdns->offset[clk];
> +	u64 nsec;
> +	s64 sec;
> +	s32 seq;
> +
> +	do {
> +		seq = vdso_read_begin(vd);
> +		sec = vdso_ts->sec;
> +		nsec = vdso_ts->nsec;
> +	} while (unlikely(vdso_read_retry(vd, seq)));
> +
> +	/* Add the namespace offset */
> +	sec += offs->sec;
> +	nsec += offs->nsec;
> +
> +	/*
> +	 * Do this outside the loop: a race inside the loop could result
> +	 * in __iter_div_u64_rem() being extremely slow.
> +	 */
> +	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
> +	ts->tv_nsec = nsec;
> +}
> +
>  static void do_coarse(const struct vdso_data *vd, clockid_t clk,
>  		      struct __kernel_timespec *ts)
>  {
> @@ -75,7 +169,23 @@ static void do_coarse(const struct vdso_data *vd, clockid_t clk,
>  	u32 seq;
>  
>  	do {
> -		seq = vdso_read_begin(vd);
> +		/*
> +		 * Open coded to handle VCLOCK_TIMENS. See comment in
> +		 * do_hres().
> +		 */
> +		while (1) {
> +			seq = READ_ONCE(vd->seq);
> +			if (likely(!(seq & 1)))
> +				break;
> +			if (IS_ENABLED(CONFIG_VDSO_TIMENS) &&
> +			    vd->clock_mode == VCLOCK_TIMENS) {
> +				do_coarse_timens(vd, clk, ts);
> +				return;
> +			}
> +			cpu_relax();
> +		}
> +		smp_rmb();
> +
>  		ts->tv_sec = vdso_ts->sec;
>  		ts->tv_nsec = vdso_ts->nsec;
>  	} while (unlikely(vdso_read_retry(vd, seq)));
> @@ -156,6 +266,10 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
>  	}
>  
>  	if (unlikely(tz != NULL)) {
> +		if (IS_ENABLED(CONFIG_VDSO_TIMENS) &&
> +		    vd->clock_mode == VCLOCK_TIMENS)
> +			vd = __arch_get_timens_vdso_data();
> +
>  		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
>  		tz->tz_dsttime = vd[CS_HRES_COARSE].tz_dsttime;
>  	}
> @@ -167,7 +281,12 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
>  static __maybe_unused time_t __cvdso_time(time_t *time)
>  {
>  	const struct vdso_data *vd = __arch_get_vdso_data();
> -	time_t t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
> +	time_t t;
> +
> +	if (IS_ENABLED(CONFIG_VDSO_TIMENS) && vd->clock_mode == VCLOCK_TIMENS)
> +		vd = __arch_get_timens_vdso_data();
> +
> +	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
>  
>  	if (time)
>  		*time = t;
> @@ -189,6 +308,9 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
>  	if (unlikely((u32) clock >= MAX_CLOCKS))
>  		return -1;
>  
> +	if (IS_ENABLED(CONFIG_VDSO_TIMENS) && vd->clock_mode == VCLOCK_TIMENS)
> +		vd = __arch_get_timens_vdso_data();
> +
>  	hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
>  	/*
>  	 * Convert the clockid to a bitmask and use it to check which
> 

-- 
Regards,
Vincenzo
