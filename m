Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262701B0719
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2020 13:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgDTLOP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Apr 2020 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726083AbgDTLOO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Apr 2020 07:14:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593A8C061A0C;
        Mon, 20 Apr 2020 04:14:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b11so11608675wrs.6;
        Mon, 20 Apr 2020 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KEgoMrPYxOWJ3qrq0DBSK7YNiWwfwR8bYU8oJ34Cf0k=;
        b=Z/lwwhOnGlXuY+FG0zqYQmWw/z9vSVeCJvnaKWSJuI6A8V3Rc4k5mNNCplwHT/cGir
         wX7j3LY0pBk8V8HT85W5iqUAwdCKcDyFG24l5Wejbo86yV/rpXyhHI8g3gr7zo1KUTUZ
         rQ5dWhCyYBFI9oyIgbbj9RzGA34sStBxZu1rCH8ibEZnbJv71UpHHint8RhjemqogEQE
         y7VMW5YKniDG0W+inrVMqvTneTvzYowAYfzIdig/GFtv0JEsTmN/F09TDUgSxHocKHKN
         sGalgz7OiTLmGeG4UvjMR2UphWL7nuLCafiYdzEWNIXPacITuSy+fdWKbPuNdQ6eDA6C
         vSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KEgoMrPYxOWJ3qrq0DBSK7YNiWwfwR8bYU8oJ34Cf0k=;
        b=m05YslUfaUaQtQDZePLqhczZsAppnkV6ja69tWjbe9wJhXB0DANQBSFZHuu+Es/3xE
         ji9THG/1LZ5UtfHr1fjfKzqELeazz5l9zckUPfu8JRg/9A+HjpGzh/S1hw0hmpXkH89d
         MqGaWgDoX5AYyahRJ9+DILDedClw+b/05EDqO8Q7TEG0ULd1vjCWhfOTxvXfBeP2RCaO
         MObV1hPBQtGiAHefoTe5u6WTQk1O0tfT1qlXLM+3CRWumj0XF+11Y8gy4SbLy2GWcdxW
         5+5vKQ1J24PTRlNACCkNe9Foqzx6mbfwxKGllourQlqdlxNG8miG5Cfj0E4GXG5UgI/N
         CJ2Q==
X-Gm-Message-State: AGi0PuYOuRA+AhJg57j6LQSm5ipApcmkYDhpZ65v2p41thPHincZUaAd
        Xay8+2B87kWmGQb5dg9QFTZsPcHi
X-Google-Smtp-Source: APiQypIRhXIC6GIcfhXn1iSH1AHq+HeHsCTXbNfsIyB+8CdoW/bcYZ34UD4+UPYsl8/RGMlwG78YgQ==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr18068831wrq.368.1587381251836;
        Mon, 20 Apr 2020 04:14:11 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id i13sm761291wro.50.2020.04.20.04.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 04:14:09 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages 2/2] adjtimex.2: document clock_adjtime
To:     Richard Cochran <richardcochran@gmail.com>
References: <20171219165811.6ahuquuf5hq74zg3@localhost>
 <88e5c54201bcfc335e484e83ab66f31f48e9f504.1514787752.git.richardcochran@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <307cff16-1e9b-c1cd-fb21-d2f07f5648ce@gmail.com>
Date:   Mon, 20 Apr 2020 13:14:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <88e5c54201bcfc335e484e83ab66f31f48e9f504.1514787752.git.richardcochran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Richard, Arnd,

On 1/1/18 7:28 AM, Richard Cochran wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> I was experimenting with some possible changes to adjtimex(2) and
> clock_adjtime(2) and tried to look up the man page to see what the
> documented behavior is when I noticed that clock_adjtime() appears
> to be the only system call that is currently undocumented.
> 
> Before I do any changes to it, this tries to document what I
> understand it currently does.
> 
> [ RC: Add better explanations of the usage and error codes
>   and correct some typographical mistakes. ]

And this patch too is now applied.

Thank you!

Cheers,

Michael

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
> ---
>  man2/adjtimex.2      | 63 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  man2/clock_adjtime.2 |  1 +
>  2 files changed, 61 insertions(+), 3 deletions(-)
>  create mode 100644 man2/clock_adjtime.2
> 
> diff --git a/man2/adjtimex.2 b/man2/adjtimex.2
> index fc6892d7e..71b5c4a5a 100644
> --- a/man2/adjtimex.2
> +++ b/man2/adjtimex.2
> @@ -35,6 +35,8 @@ adjtimex, ntp_adjtime \- tune kernel clock
>  .PP
>  .BI "int adjtimex(struct timex *" "buf" );
>  .PP
> +.BI "int clock_adjtime(clockid_t " clk_id, " struct timex *" "buf" );
> +.PP
>  .BI "int ntp_adjtime(struct timex *" buf );
>  .fi
>  .SH DESCRIPTION
> @@ -158,8 +160,26 @@ includes the
>  .B ADJ_NANO
>  flag, then
>  .I buf.time.tv_usec
> -is interpreted as a nanosecond value;
> +is interpreted as a nanosecond value,
>  otherwise it is interpreted as microseconds.
> +.IP
> +The value of
> +.I buf.time
> +is the sum of its two fields, but the
> +field
> +.I buf.time.tv_usec
> +must always be non-negative.  The following example shows how to
> +normalize a timeval with nanosecond resolution.
> +.PP
> +.in +12n
> +.EX
> +while (buf.time.tv_usec < 0) {
> +    buf.time.tv_sec  -= 1;
> +    buf.time.tv_usec += 1000000000;
> +}
> +.EE
> +.in
> +.PP
>  .TP
>  .BR ADJ_MICRO " (since Linux 2.6.26)"
>  .\" commit eea83d896e318bda54be2d2770d2c5d6668d11db
> @@ -344,6 +364,12 @@ Attempts to set read-only
>  .I status
>  bits are silently ignored.
>  .\"
> +.SS clock_adjtime ()
> +The
> +.BR clock_adjtime ()
> +system call (added in Linux 2.6.39) behaves like adjtimex() but takes an additional
> +.IR clk_id
> +argument to specify the particular clock on which to act.
>  .SS ntp_adjtime ()
>  The
>  .BR ntp_adjtime ()
> @@ -472,6 +498,19 @@ An attempt was made to set
>  to a value other than those listed above.
>  .TP
>  .B EINVAL
> +The
> +.I clk_id
> +given to
> +.BR clock_adjtime ()
> +is invalid for one of two reasons.  Either the SYS-V style hard coded
> +positive value is out of range, or the dynamic
> +.I clk_id
> +does not refer to a valid instance of a clock object.
> +See
> +.BR clock_gettime (2)
> +for a discussion of dynamic clocks.
> +.TP
> +.B EINVAL
>  An attempt was made to set
>  .I buf.tick
>  to a value outside the range
> @@ -482,6 +521,20 @@ where
>  .B HZ
>  is the system timer interrupt frequency.
>  .TP
> +.B ENODEV
> +The hot-plugable device (like USB for example) represented by a
> +dynamic
> +.I clk_id
> +has disappeared after its character device was opened.
> +See
> +.BR clock_gettime (2)
> +for a discussion of dynamic clocks.
> +.TP
> +.B EOPNOTSUPP
> +The given
> +.I clk_id
> +does not support adjustment.
> +.TP
>  .B EPERM
>  .I buf.modes
>  is neither 0 nor
> @@ -503,10 +556,12 @@ T{
>  T}	Thread safety	MT-Safe
>  .TE
>  .SH CONFORMING TO
> -Neither of these interfaces is described in POSIX.1
> +None of these interfaces is described in POSIX.1
>  .PP
>  .BR adjtimex ()
> -is Linux-specific and should not be used in programs
> +and
> +.BR clock_adjtime ()
> +are Linux-specific and should not be used in programs
>  intended to be portable.
>  .PP
>  The preferred API for the NTP daemon is
> @@ -533,6 +588,8 @@ is done by the kernel in timer context
>  Thus, it will take one tick into the second
>  for the leap second to be inserted or deleted.
>  .SH SEE ALSO
> +.BR clock_gettime (2)
> +.BR clock_settime (2)
>  .BR settimeofday (2),
>  .BR adjtime (3),
>  .BR ntp_gettime (3),
> diff --git a/man2/clock_adjtime.2 b/man2/clock_adjtime.2
> new file mode 100644
> index 000000000..b08b9c801
> --- /dev/null
> +++ b/man2/clock_adjtime.2
> @@ -0,0 +1 @@
> +.so man2/adjtimex.2
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
