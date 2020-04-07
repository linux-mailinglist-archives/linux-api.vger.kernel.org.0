Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4AF1A0538
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 05:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDGDXZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 23:23:25 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:32989 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgDGDXZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 23:23:25 -0400
Received: by mail-pl1-f171.google.com with SMTP id ay1so719746plb.0;
        Mon, 06 Apr 2020 20:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W7125HS8Id/3oQMqySFzZfNl7860dmUpNDHGZUrZd8E=;
        b=ZLrLmWOolQ4v2jsFDi511mfo7jtzwuArxj3LFtcxoZsfJC0ppypz8Udu4pBguFvd/R
         6Y8zYdtmeT4jNVd+6NdCrwZZ2OjND9+f2cQHmq6pPd6KMkvchSHUhl9GbfIrjMIGsbSi
         A52Ow3R4opR8fVN9M4xaTOwC0hCOy4iOD6txSsYcV0PwdhTMstPMXKr2Tlk0yPzyB1+r
         QqLV4XU/Bzi1gY+DfgB6ej7t79t/05R9kOvNHw8Ft24wWgaqQFPpW8od61EaBNYPvOJP
         tmpa4bXJvXUAJtUBFzjtY+yznFuvjzuCE5mebsP841dN1k5phJ5cGDKK0OtDsW0FVmL8
         IFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W7125HS8Id/3oQMqySFzZfNl7860dmUpNDHGZUrZd8E=;
        b=OzL7NLfGe5z7VCVa+sBJlaFklU38XU/va3TLJcFXT0m3YQ9tUzjUWDBFiztUHt8R2f
         PmjtDjh/deCPqEdWPmASwEUDvKieFdf0uhG+jbXWzIY4el4fpbtPiLHDRoyTvSgiDW1A
         27p6zLfgMbSbYc2CA2RDHDAyQrjZeTAaikULPwzzhE0czjSlnsFmInMKBIRepAGfFz3s
         YPs2jFDyomIRuHyXDbYps42CPqAexIGphovmZh88u5H1H+J7zOsu17xR3kwagKz35y2Q
         IH5DOolbIQY3QSojL1e3+9R1qPy3pv3sMDRbydEsha5nC39JGvSE1kWb6R3rNdaJm/kL
         WxcQ==
X-Gm-Message-State: AGi0PuZO9m+A1ef6AogsvpRgKUnKt3JDFz1V2D6x5qMHaGtsU3YcfV22
        Hb8CDbU09rHk166bVEtsVuA=
X-Google-Smtp-Source: APiQypI8C/2qgTt/umSrw/tHBivbozx0fL4YiImQ/Ho7/ufHrAhZsVtQoC3bYuGjKF1rM+Zxq4W7Gg==
X-Received: by 2002:a17:90a:378b:: with SMTP id v11mr205147pjb.46.1586229804007;
        Mon, 06 Apr 2020 20:23:24 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id u41sm12297721pgn.8.2020.04.06.20.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 20:23:23 -0700 (PDT)
Date:   Mon, 6 Apr 2020 20:23:18 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        linux-man <linux-man@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>
Subject: Re: RFC: time_namespaces(7) manual page
Message-ID: <20200407032318.GA494464@gmail.com>
References: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Michael,

The man page looks good to me. A few comments are inline.

On Sat, Apr 04, 2020 at 01:08:50PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Dmitry, Andrei, et al.
> 
> I have written a manual page to document time namespaces.
> Could you please take a look and let me know of any
> corrections, improvements, etc.
> 
> The rendered page is shown below. Th epage source is at the foot of
> this mail.
> 
> Thanks,
> 
> Michael
> 
> 
> NAME
>        time_namespaces - overview of Linux time namespaces
> 
> DESCRIPTION
>        Time namespaces virtualize the values of two system clocks:
> 
>        · CLOCK_MONOTONIC   (and   likewise   CLOCK_MONOTONIC_COARSE   and
>          CLOCK_MONOTONIC_RAW), a nonsettable clock that represents  mono‐
>          tonic  time   since—as  described   by  POSIX—"some  unspecified
>          point in the past".
> 
>        · CLOCK_BOOTTIME (and likewise CLOCK_BOOTTIME_ALARM), a clock that
>          is  identical  to  CLOCK_MONOTONIC, except that it also includes
>          any time that the system is suspended.
> 
>        Thus, the processes in a time namespace share per-namespace values
>        for  these clocks.  This affects various APIs that measure against
>        these   clocks,   including:   clock_nanosleep(2),   nanosleep(2),
>        clock_gettime(2), and /proc/uptime.

timer_settime, timerfd_settime

> 
>        Currently,  the  only way to create a time namespace is by calling
>        unshare(2) with the CLONE_NEWTIME flag.  This call creates  a  new
>        time  namespace  but does not place the calling process in the new
>        namespace.  Instead, the calling  process's  subsequently  created
>        children  are placed in the new namespace.  This allows clock off‐
>        sets (see below) for the new namespace to be set before the  first
>        process      is      placed     in     the     namespace.      The
>        /proc/[pid]/ns/time_for_children  symbolic  link  shows  the  time
>        namespace in which the children of a process will be created.

We can mention that the current process can enter the namespace if it
call setns on /proc/self/ns/time_for_children.

> 
>    /proc/PID/timens_offsets
>        Associated  with  each  time namespace are offsets, expressed with
>        respect to the initial time namespace, that define the  values  of
>        the  monotonic  and  boot clocks in that namespace.  These offsets
>        are exposed via the file  /proc/PID/timens_offsets.   Within  this
>        file,  the  offsets  are  expressed  as  lines consisting of three
>        space-delimited fields:
> 
>            <clock-id> <offset-secs> <offset-nanosecs>
> 
>        The clock-id identifies the clock whose offsets are  being  shown.
>        This field is either 1, for CLOCK_MONOTONIC, or 7, for CLOCK_BOOT‐
>        TIME.  The remaining  fields  express  the  offset  (seconds  plus
>        nanoseconds)  for the clock in this time namespace.  These offsets
>        are expressed relative to the clock values  in  the  initial  time
>        namespace.   In  the  initial time namespace, the contents of this
>        file are as follows:

I think we can mention that offset-secs can be negative, but
offset-nanosleep has to be 0 or positive.

Thanks,
Andrei
