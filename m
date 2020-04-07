Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8811A0DF9
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 14:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgDGMxg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Apr 2020 08:53:36 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55861 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgDGMxg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Apr 2020 08:53:36 -0400
Received: by mail-wm1-f46.google.com with SMTP id e26so1609216wmk.5;
        Tue, 07 Apr 2020 05:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Djsn5L3wuOf5V4MbgSkLprg1uFPVvVgq4aej/IVjACs=;
        b=YlVIPEym+l/GSODXyh2JshtfWewO6UBzo8au9gbCuGPRbW1eU+207czLwDBBthjf9b
         HYdKmFs6mzTlJjxtYAKC4CcPhUg4oGSCg3xP4KI9y5he6d96iG78MY1qMO0wdwUPEgHf
         8DmsFT0WFWCJ0l6qCKawzZXAwrEVh4Jokirhe9Mk3IHyrWRqKzFO8faKNQZ30kGfdVbA
         PzmdhAcqZAR1HPTLk9UUzfWZMdKX5+3sO1GsRAYv+/WRe1SqcfISGcWBqykUiZIzmZDA
         AdxgUPMhiB6xUbNzPROQnE0CQhBmRk+RJkF2F2tEKB1Wy3PecqOdzR1+oe/IuH0cXCgO
         WVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Djsn5L3wuOf5V4MbgSkLprg1uFPVvVgq4aej/IVjACs=;
        b=tHCMmxIWcj+yzcUtKl7UhJWS58EmayciB/bWdLW/fnCHZ7gHaG0wD5kKHFgPrMyBhQ
         RRymK3IwvI7MTzGOlJWlUUtwGvISCJRBlLpHE8itUEFank0wTQvZkcHWmhRcujGQePjQ
         96dUlMhhElXE5yhZVUo5I06WJspBT+A+33Bs+RU86kGxOis0qiXmtdIl6G7M8Js95Dfz
         vnFDdlleM6JuAKnDM/L2VoVjwKMkOGb6RhGyBiVs7PySfIl35UBUENJRbMGi90fXP1gM
         GZ0eo0wNE1ePH+O9n+s2qO450RIcQSaUrbqZ5sXEJvIBuN0ANEg5uHY5dldi1cWIPwxH
         cN2A==
X-Gm-Message-State: AGi0PubKrAHaotSam3XHrhpJDI5vvB0KnJDJnW03T5jQq6Oyc5LRjfvy
        AemDktByeV6qPH7JxC1W6ls=
X-Google-Smtp-Source: APiQypKaai1PvkdI/Zo4DdPi9KJtrWTsxxIJn0+prZO9/dVAAR4O5h6NxatJXm4Mjr7NOzAsKTY5Bg==
X-Received: by 2002:a1c:7f8e:: with SMTP id a136mr2345170wmd.33.1586264012962;
        Tue, 07 Apr 2020 05:53:32 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id y7sm2375wmb.43.2020.04.07.05.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 05:53:32 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
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
To:     Andrei Vagin <avagin@gmail.com>
References: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
 <20200407032318.GA494464@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <5a5d01d5-5930-7825-38b4-e9d6e67afd3c@gmail.com>
Date:   Tue, 7 Apr 2020 14:53:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407032318.GA494464@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Andrei,

On 4/7/20 5:23 AM, Andrei Vagin wrote:
> Hi Michael,
> 
> The man page looks good to me. A few comments are inline.

Thanks for looking the page over!

> On Sat, Apr 04, 2020 at 01:08:50PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hello Dmitry, Andrei, et al.
>>
>> I have written a manual page to document time namespaces.
>> Could you please take a look and let me know of any
>> corrections, improvements, etc.
>>
>> The rendered page is shown below. Th epage source is at the foot of
>> this mail.
>>
>> Thanks,
>>
>> Michael
>>
>>
>> NAME
>>        time_namespaces - overview of Linux time namespaces
>>
>> DESCRIPTION
>>        Time namespaces virtualize the values of two system clocks:
>>
>>        · CLOCK_MONOTONIC   (and   likewise   CLOCK_MONOTONIC_COARSE   and
>>          CLOCK_MONOTONIC_RAW), a nonsettable clock that represents  mono‐
>>          tonic  time   since—as  described   by  POSIX—"some  unspecified
>>          point in the past".
>>
>>        · CLOCK_BOOTTIME (and likewise CLOCK_BOOTTIME_ALARM), a clock that
>>          is  identical  to  CLOCK_MONOTONIC, except that it also includes
>>          any time that the system is suspended.
>>
>>        Thus, the processes in a time namespace share per-namespace values
>>        for  these clocks.  This affects various APIs that measure against
>>        these   clocks,   including:   clock_nanosleep(2),   nanosleep(2),
>>        clock_gettime(2), and /proc/uptime.
> 
> timer_settime, timerfd_settime

Added.

>>        Currently,  the  only way to create a time namespace is by calling
>>        unshare(2) with the CLONE_NEWTIME flag.  This call creates  a  new
>>        time  namespace  but does not place the calling process in the new
>>        namespace.  Instead, the calling  process's  subsequently  created
>>        children  are placed in the new namespace.  This allows clock off‐
>>        sets (see below) for the new namespace to be set before the  first
>>        process      is      placed     in     the     namespace.      The
>>        /proc/[pid]/ns/time_for_children  symbolic  link  shows  the  time
>>        namespace in which the children of a process will be created.
> 
> We can mention that the current process can enter the namespace if it
> call setns on /proc/self/ns/time_for_children.

Yes, thanks. I overlooked that, and I was puzzled about how setns() could
be useful before the first process was created in a time NS.

I added:

    (A process can use a file descriptor opened on this symbolic
    link in a call to setns(2) in order to move into the namespace.)

>>    /proc/PID/timens_offsets
>>        Associated  with  each  time namespace are offsets, expressed with
>>        respect to the initial time namespace, that define the  values  of
>>        the  monotonic  and  boot clocks in that namespace.  These offsets
>>        are exposed via the file  /proc/PID/timens_offsets.   Within  this
>>        file,  the  offsets  are  expressed  as  lines consisting of three
>>        space-delimited fields:
>>
>>            <clock-id> <offset-secs> <offset-nanosecs>
>>
>>        The clock-id identifies the clock whose offsets are  being  shown.
>>        This field is either 1, for CLOCK_MONOTONIC, or 7, for CLOCK_BOOT‐
>>        TIME.  The remaining  fields  express  the  offset  (seconds  plus
>>        nanoseconds)  for the clock in this time namespace.  These offsets
>>        are expressed relative to the clock values  in  the  initial  time
>>        namespace.   In  the  initial time namespace, the contents of this
>>        file are as follows:
> 
> I think we can mention that offset-secs can be negative, but
> offset-nanosleep has to be 0 or positive.

Thanks. See my upcoming reply to Thomas.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
