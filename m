Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71D1B0717
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2020 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDTLOE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Apr 2020 07:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTLOD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Apr 2020 07:14:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9096EC061A0C;
        Mon, 20 Apr 2020 04:14:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so10548639wmc.0;
        Mon, 20 Apr 2020 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PB/co54T82CMjoSU4EBAp6E7fpGni+Es+h0ETNge2LI=;
        b=uE/lF2ETs5kE3wdZTl5EdzzMaCs4bV2Ok2nYeqKuQrExv6teL+Kq7azLH3sQOwekai
         oZTERyoFD78pYIKRBLILPVtnFkHo++iHLF5t486ddpSWuf5bIGGIY2svjhRBjNwP3fCV
         siYE+fXGat1W1l8+lvhq/p8HarS3VGoFjsl6ROByHeQxkXNIPikPl3UlcZRWpd31rSoA
         YiTUGVikEo5guEhQiiP3j7HnSpTRXyzeF9lxNBJE/leo0QQvb+HM7OyL7VU/h0SDm1I/
         bkcRfO+YijJ10SG+RX1upIMmsOdTERG7Ncc2joqR/jDJY2hsIMu1jHvZLpMI2/90rdSb
         eE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PB/co54T82CMjoSU4EBAp6E7fpGni+Es+h0ETNge2LI=;
        b=LjwNIcxnIc1WjxkQRohyUp0YPpz3pNR/LHCbA4sXYj5LvxQ0pY0hy1A1M0INjrcGQh
         8oEAhwMDEAokOTQqO2/qmeL+LpqclQmUsxLnLS+l7fFjJHSXDHIbYMdSUqos2AeeSN8e
         cT8oM7of/U+UigaZfnHCFZ8BU1o/CbMJ9jGTUt191ODcK6GWMFrcRXkRn2b9NGmIzmsA
         nAoT0T3XKoO5CWsdz3nUEy/odIVHZIUnqP6IEa9f2z0IQSK9ik3t8I2PloRhz7UlbiUT
         LOjOaQEnmCZ0ABwG5vIQ8FNLTGa2ijErqdik3bN9RlRubMK2WAVkmYWqGPiCXUotzP53
         70MA==
X-Gm-Message-State: AGi0PuZsogZM1ZsWMRlrtb7ju32NYcwvvQB/dHHd0CN4h85MdmmwEveN
        OToYOIKjGpcjUNu+Q8pm2N+qN89c
X-Google-Smtp-Source: APiQypKVPI2C4FcuVfYFuB4RX4KjW5LAbgCI20nEFJcNlwpFzLDRSGhuUqANj/CBYYu/VnDSqlWOFw==
X-Received: by 2002:a1c:b38b:: with SMTP id c133mr16783612wmf.24.1587381242134;
        Mon, 20 Apr 2020 04:14:02 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id q143sm963751wme.31.2020.04.20.04.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 04:13:59 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages 1/2] clock_getres.2: Explain dynamic clocks.
To:     Richard Cochran <richardcochran@gmail.com>
References: <20171219165811.6ahuquuf5hq74zg3@localhost>
 <f85030cb44354de97f3b7822b23ec34fd21d1f28.1514787752.git.richardcochran@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <aba829df-3da2-dd9e-dd19-808a46e09035@gmail.com>
Date:   Mon, 20 Apr 2020 13:13:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f85030cb44354de97f3b7822b23ec34fd21d1f28.1514787752.git.richardcochran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Richard,

On 1/1/18 7:28 AM, Richard Cochran wrote:
> Linux has allowed passing open file descriptors to clock_gettime() and
> friends since v2.6.39.  This patch documents these "dynamic" clocks
> and adds a brief example of how to use them.

This fell on the floor, I'm sorry. It's applied now.

Thanks you!

Michael

> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
> ---
>  man2/clock_getres.2 | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/clock_getres.2 b/man2/clock_getres.2
> index 0812d159a..30cbfe46a 100644
> --- a/man2/clock_getres.2
> +++ b/man2/clock_getres.2
> @@ -183,6 +183,35 @@ Per-process CPU-time clock
>  .TP
>  .BR CLOCK_THREAD_CPUTIME_ID " (since Linux 2.6.12)"
>  Thread-specific CPU-time clock.
> +.PP
> +Linux also implements dynamic clock instances as described below.
> +.SH DYNAMIC CLOCKS " (since Linux 2.6.39)"
> +In addition to hard coded SYS-V style clock ids, Linux also supports
> +POSIX clock operations on certain character devices.  Such devices are
> +called "dynamic" clocks.  Using the appropriate macros, open file
> +descriptors may be converted into clock ids and passed to
> +.BR clock_gettime (),
> +.BR clock_settime (),
> +and
> +.BR clock_adj (2).
> +The follow example shows how to convert a file descriptor into a
> +dynamic clock id.
> +.PP
> +.in +4n
> +.EX
> +#define CLOCKFD 3
> +#define FD_TO_CLOCKID(fd)       ((~(clockid_t) (fd) << 3) | CLOCKFD)
> +#define CLOCKID_TO_FD(clk)      ((unsigned int) ~((clk) >> 3))
> +
> +struct timeval tv;
> +clockid_t clkid;
> +int fd;
> +
> +fd = open("/dev/ptp0", O_RDWR);
> +clkid = FD_TO_CLOCKID(fd);
> +clock_gettime(clkid, &tv);
> +.EE
> +.in
>  .SH RETURN VALUE
>  .BR clock_gettime (),
>  .BR clock_settime (),
> @@ -200,11 +229,19 @@ points outside the accessible address space.
>  .B EINVAL
>  The
>  .I clk_id
> -specified is not supported on this system.
> +specified is invalid for one of two reasons.  Either the SYS-V style
> +hard coded positive value is out of range, or the dynamic clock id
> +does not refer to a valid instance of a clock object.
>  .\" Linux also gives this error on attempts to set CLOCK_PROCESS_CPUTIME_ID
>  .\" and CLOCK_THREAD_CPUTIME_ID, when probably the proper error should be
>  .\" EPERM.
>  .TP
> +.B ENODEV
> +The hot-plugable device (like USB for example) represented by a
> +dynamic
> +.I clk_id
> +has disappeared after its character device was opened.
> +.TP
>  .B EPERM
>  .BR clock_settime ()
>  does not have permission to set the clock indicated.
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
