Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F4BDFFE8
	for <lists+linux-api@lfdr.de>; Tue, 22 Oct 2019 10:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388650AbfJVIp2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Oct 2019 04:45:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39684 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388490AbfJVIp2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Oct 2019 04:45:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so10211006pff.6;
        Tue, 22 Oct 2019 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gbVCuO1WQVx+qJcG6Sg/Opdkgu7URi3xiu037hazHk4=;
        b=TWDMknpFoCT949orSWtnAoCgM5tn9MwYr5BqaG5sz0b8Pp8RF1XKdZ8OpbAFefH31p
         Ix+rM6Lj4xO8zOxphrKRhE48ZA5k5mpdKjqqh9k1DLZaFJ3wdcJufdEavsVF4gWtMrGj
         epHromsW1B/v2SXqRVRl9U9Y8+V55NALadNSh8dCp79PYWg63p03pEC/7NQLw8mjcP3z
         noYiIetKYDZPslISEFvGFJxAeMmGMhsOcUwh93hllqGlrrdWKcT/B0rvoJJOT+EnmCFc
         +WZh3JE+WiZihLWhOhvsp3uP9bInUQS/J0JC6PyEjNzTwJNeWz8AbsmjOgy5iVJC2nqi
         kstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gbVCuO1WQVx+qJcG6Sg/Opdkgu7URi3xiu037hazHk4=;
        b=MxKt1gMuHFKGTd+rsPscpV3zI7OyIYu4K4xLRNPnZL2vYMI0q4Mm6FH3GYmR2EwMCz
         9QGKq5u/eMoPPKN5DmCPjXHhVc5zjbH3hNB7Z9WlfJDPYpb/3qhcgSwKRaJ6gVe1w1tq
         TN1Q8vD5aOzuE7hJWkyvhk7tmrUNOa1YoEuAedrMkpLgSFXFVJbAYvFp3Eufn7bqEYE3
         ctqA1nmBvrWN78V2rW6HaXXhYyUaDVh1+czQl3DLTl6BImAmSbN31r1c59RKZcEztAJS
         qphuTAi97VA5z7IxZkPmGyw3pczc29lNyOxTtRcbGvolNqVsdfgX1dV5LEWEbd191vi0
         LACw==
X-Gm-Message-State: APjAAAUSfwBkBMD7or4xcUvFL1XXMUmQA+BuTNoKGF2RKlFhNdeah4NE
        d/05u4udhd3A/XRyCR6AWGo=
X-Google-Smtp-Source: APXvYqxbVAQyYFXA5Zv6OaHM3Z958GlGOpJyuXawUyhwooBk3J7N3O7dbRKponelNhid1zCiajG1vg==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr2536282pgi.221.1571733926664;
        Tue, 22 Oct 2019 01:45:26 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id o9sm22716329pfp.67.2019.10.22.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:45:25 -0700 (PDT)
Date:   Tue, 22 Oct 2019 01:45:23 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
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
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv7 00/33] kernel: Introduce Time Namespace
Message-ID: <20191022084523.GA2923@gmail.com>
References: <20191011012341.846266-1-dima@arista.com>
 <alpine.DEB.2.21.1910171122030.1824@nanos.tec.linutronix.de>
 <20191017234748.GA26011@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20191017234748.GA26011@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 17, 2019 at 04:47:48PM -0700, Andrei Vagin wrote:
> 
> In my table, the "before" column is actually for the upstream kernel
> with the 18-th patch. Here is the table with the real "before" column:
> 
>         | before    | with 18/33 | CONFIG_TIME_NS=n | host      | inside timens
> ------------------------------------------------------------------------------
> avg     | 150331408 | 153345935  | 153588088        | 150816637 | 139192114
> ------------------------------------------------------------------------------
> diff %  |       98  |      100   | 100.1            | 98.3      | 90.7
> ------------------------------------------------------------------------------
> stdev % |       0.3 |     0.09   | 0.15             | 0.25      | 0.13
> 
> If we compare numbers in "before", "host" and "inside timens" columns, we
> see the same results that you had. clock_gettime() works with the
> same performance in the host namespace and 7% slower in a time
> namespace.
> 

I played with this a bit more and I've found that we can speed up
clock_gettime on 5% more if we mark do_hres and do_coarse as
__always_inline.

With the unlikely hint in vdso_read_begin and noinline for
do_hres_timens and do_coarse_timens:
1..8
ok 1 host:      clock:  monotonic       cycles:  155278332
ok 2 host:      clock: monotonic-coarse cycles:  662067077
ok 3 host:      clock: monotonic-raw    cycles:  151218057
ok 4 host:      clock:   boottime       cycles:  154907635
ok 5 ns:        clock:  monotonic       cycles:  133100433
ok 6 host:      clock: monotonic-coarse cycles:  444170219
ok 7 host:      clock: monotonic-raw    cycles:  129550178
ok 8 ns:        clock:   boottime       cycles:  130167136


With __always_inline for do_hres and do_coarse:
1..8
ok 1 host:      clock:  monotonic       cycles:  163691015
ok 2 host:      clock: monotonic-coarse cycles:  641443397
ok 3 host:      clock: monotonic-raw    cycles:  163649270
ok 4 host:      clock:   boottime       cycles:  163682242
ok 5 ns:        clock:  monotonic       cycles:  138759212
ok 6 host:      clock: monotonic-coarse cycles:  486149502
ok 7 host:      clock: monotonic-raw    cycles:  134801053
ok 8 ns:        clock:   boottime       cycles:  138675460
# Pass 8 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

With __always_inline for do_hres, do_coarse, do_hres_timens,
do_coarse_timens:
1..8
ok 1 host:	clock:  monotonic	cycles:	 158984538
ok 2 host:	clock: monotonic-coarse	cycles:	 594932695
ok 3 host:	clock: monotonic-raw	cycles:	 157834511
ok 4 host:	clock:   boottime	cycles:	 158297691
ok 5 ns:	clock:  monotonic	cycles:	 148559612
ok 6 host:	clock: monotonic-coarse	cycles:	 468505657
ok 7 host:	clock: monotonic-raw	cycles:	 146366575
ok 8 ns:	clock:   boottime	cycles:	 148573015
# Pass 8 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

Thanks,
Andrei
