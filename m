Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32FABE2A43
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2019 08:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408465AbfJXGNR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Oct 2019 02:13:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46371 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404173AbfJXGNR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Oct 2019 02:13:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id b25so392263pfi.13;
        Wed, 23 Oct 2019 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EofdUoQrs85PBjjnb/AuG4A4pyzR0R8swOkdIz7JRmY=;
        b=UEEnD9zdltpC7dsv2JkW5q8VBHt24sRtjYqKvhaflNkSIpR3vyG+Jt4ojL1XuDIk84
         JmgdLm91dTbhdSB4MEpXanEX3vO80e3f3rJ/C4xnffB3CGqKMww/Z2zf2VfsfafLxXgw
         b8MsBrU4VeBbu8tdICNuqanVniFkScDJBHm47RToFCuYqK/Kl/AX/44iMl4nPof9pqC6
         h5+MsrYkbmh/Joxh4YOzqOzU4YYwG5GXEyVepYbj/Bd4LMT/hLA8atET5D/yMy1w7x8x
         oRAkAsnx+EXwXyHbasGNpLaFnM+yqdWBtYzfezmbDh4C5oU8WT/im3fFR46pg2pSnvpJ
         Aiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EofdUoQrs85PBjjnb/AuG4A4pyzR0R8swOkdIz7JRmY=;
        b=XYu8TEgt921m/8x3vfy+W6YP6NO0lDRmqyOlYVzik6GY8ZXdu/kYYQr+iowuFF9fRp
         FWhi/TIiEa+bIUVKIWZfDA8zZslfotf7NiaGEyUKiEOSfQtANLpqGKIE/18M19jlFqpF
         KgdByaKPTwS8LaZ1+Uo3nymyNt9v+ZT0VyClYian765mqvX9GsPzbanuLPYklSLqtTsT
         8aFs7ePNsoz0je2GlyzQ3We74n7VPkaEUXheGCZzml9Pd91u0wkYzKZY7qQrEsu+Rwb0
         3iQyGhPaf7IIur855zdMUlJGxtMfwcaeyhT2VLnGe5qEI3B4h0BuweutFMuB0aBFEvIR
         RRlA==
X-Gm-Message-State: APjAAAUBSl+agRUEjtlzumKUDM5frg8TLIYq/e2pO2Lk9tZha//+EvWx
        p5nqoEYysEuhOUKnCN2FXE4=
X-Google-Smtp-Source: APXvYqzUiw+VJdNr6xBvgwrgYwjzfVGVSd4+DNEu1IcRixOkVetVtm5HgL9fQ3UgrnhqDPlrTcgX5A==
X-Received: by 2002:a62:5284:: with SMTP id g126mr15380962pfb.95.1571897595495;
        Wed, 23 Oct 2019 23:13:15 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id e4sm24802948pff.22.2019.10.23.23.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 23:13:14 -0700 (PDT)
Date:   Wed, 23 Oct 2019 23:13:11 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv7 18/33] lib/vdso: Add unlikely() hint into
 vdso_read_begin()
Message-ID: <20191024061311.GA4541@gmail.com>
References: <20191011012341.846266-1-dima@arista.com>
 <20191011012341.846266-19-dima@arista.com>
 <100f6921-9081-7eb0-7acc-f10cfb647c21@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <100f6921-9081-7eb0-7acc-f10cfb647c21@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On Wed, Oct 16, 2019 at 12:24:14PM +0100, Vincenzo Frascino wrote:
> On 10/11/19 2:23 AM, Dmitry Safonov wrote:
> > From: Andrei Vagin <avagin@gmail.com>
> > 
> > Place the branch with no concurrent write before contended case.
> > 
> > Performance numbers for Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
> > (more clock_gettime() cycles - the better):
> >         | before    | after
> > -----------------------------------
> >         | 150252214 | 153242367
> >         | 150301112 | 153324800
> >         | 150392773 | 153125401
> >         | 150373957 | 153399355
> >         | 150303157 | 153489417
> >         | 150365237 | 153494270
> > -----------------------------------
> > avg     | 150331408 | 153345935
> > diff %  | 2	    | 0
> > -----------------------------------
> > stdev % | 0.3	    | 0.1
> > 
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > Co-developed-by: Dmitry Safonov <dima@arista.com>
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Hello Vincenzo,

Could you test the attached patch on aarch64? On x86, it gives about 9%
performance improvement for CLOCK_MONOTONIC and CLOCK_BOOTTIME.

Here is my test:
https://github.com/avagin/vdso-perf

It is calling clock_gettime() in a loop for three seconds and then
reports a number of iterations.

Thanks,
Andrei

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=koi8-r
Content-Disposition: attachment;
	filename="0001-lib-vdso-make-do_hres-and-do_coarse-as-__always_inli.patch"

From 5252093fec4c74802e5ef501b9f1db3369430c80 Mon Sep 17 00:00:00 2001
From: Andrei Vagin <avagin@gmail.com>
Date: Tue, 22 Oct 2019 18:23:17 -0700
Subject: [PATCH] lib/vdso: make do_hres and do_coarse as __always_inline

Performance numbers for Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
(more clock_gettime() cycles - the better):

clock            | before     | after      | diff
----------------------------------------------------------
monotonic        |  153222105 |  166775025 | 8.8%
monotonic-coarse |  671557054 |  691513017 | 3.0%
monotonic-raw    |  147116067 |  161057395 | 9.5%
boottime         |  153446224 |  166962668 | 9.1%

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 lib/vdso/gettimeofday.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index e630e7ff57f1..b4f7f0f246af 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -38,7 +38,7 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 }
 #endif
 
-static int do_hres(const struct vdso_data *vd, clockid_t clk,
+static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 		   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
@@ -68,7 +68,7 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 	return 0;
 }
 
-static void do_coarse(const struct vdso_data *vd, clockid_t clk,
+static __always_inline void do_coarse(const struct vdso_data *vd, clockid_t clk,
 		      struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
@@ -97,12 +97,16 @@ __cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
 	 */
 	msk = 1U << clock;
 	if (likely(msk & VDSO_HRES)) {
-		return do_hres(&vd[CS_HRES_COARSE], clock, ts);
+		vd = &vd[CS_HRES_COARSE];
+out_hres:
+		return do_hres(vd, clock, ts);
 	} else if (msk & VDSO_COARSE) {
 		do_coarse(&vd[CS_HRES_COARSE], clock, ts);
 		return 0;
 	} else if (msk & VDSO_RAW) {
-		return do_hres(&vd[CS_RAW], clock, ts);
+		vd = &vd[CS_RAW];
+		/* goto allows to avoid extra inlining of do_hres. */
+		goto out_hres;
 	}
 	return -1;
 }
-- 
2.21.0


--xHFwDpU9dbj6ez1V--
