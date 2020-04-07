Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E891A0E21
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 15:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgDGNGu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Apr 2020 09:06:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42243 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGNGu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Apr 2020 09:06:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so3799113wrx.9;
        Tue, 07 Apr 2020 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MEPzDZ9IoJw38i90BPa2OSkfDts3fp3hKXaAGFVJfro=;
        b=cPnSJSxI7zI4EO3aV5JFMn1psYxiLNRznt6FHBeZ1UKtOC2xbgFvNINQ1s+SsJmBMB
         zM6EWFT9OSJ7gxiGR23KiupyZWcAkf5Shocu9a/Scdy71nyKNn09u/ZU3fWko6nJg1LG
         BeP7P7XOXLhPIplobwGYWV0ibiQK6RjHZZtQuAnIRtiTkrkJ01YKg2YvGLDbpT0tz0tt
         70xP2vRTM1J1imqtRRO9F5tx2OrAmLgiyXNb1knPom8stFJQqZM8SMWbUlYeEREh61I4
         ViUvk7y+te39vdt2mab5UfaUn0amb30wrF8bp28pG9kaevifJ4yIkxZGq6OYtkrI4W1v
         ol/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MEPzDZ9IoJw38i90BPa2OSkfDts3fp3hKXaAGFVJfro=;
        b=iUg9cZts5NByevSgnEF3DFM97uKnHOXoBf2D/wYXPlevBv1IGS/LgqfioA2CUgLHtk
         ADFJ8XOUJlgIX66QbxFNnaNfB9LU8sSuCT6+/vtoa+lX4BgUCA7iOrKnyDqWaDv6mZQ6
         RudKaMdolcDOflbhcypmVDgUfuiiSZNjUgBA9Kep+YjWn831NEEjxJ+M36/iZ+oEXWHC
         i4xbVc4WhGslD77JvD8h6XyMgBYXWPb11YnQ3bXVsp39EhScol5UPb9xvbF7js2sMkCA
         /seW8JjEjUiv/hrPMA69MkJx2Yox4OHfJZUTmJ0OnAyHtEnFMu/7cXCg3uE/BKwCFEe3
         8CBg==
X-Gm-Message-State: AGi0PubLAP2/jn1ji8ksl3VeeLKwlfs0Fx38Wz8vBdb/aAOvNafeMAzx
        sLq+vyFxRcTd0lbLW/YlpzE=
X-Google-Smtp-Source: APiQypIpLpen9Ih/0EUrIyaSgyYIpFcBC5grCTVFUnEFuFwlfbgMfAThgUn3kNphffj0AXvbovr2eg==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr2354116wrw.310.1586264807537;
        Tue, 07 Apr 2020 06:06:47 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id y16sm31440038wrp.78.2020.04.07.06.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 06:06:46 -0700 (PDT)
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
        Adrian Reber <adrian@lisas.de>
Subject: Re: RFC: time_namespaces(7) manual page
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>
References: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
 <20200407032318.GA494464@gmail.com> <87r1wzk2p5.fsf@nanos.tec.linutronix.de>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <fe940759-9159-5d89-1f5b-f92fa247177f@gmail.com>
Date:   Tue, 7 Apr 2020 15:06:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87r1wzk2p5.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/7/20 12:30 PM, Thomas Gleixner wrote:
> Andrei Vagin <avagin@gmail.com> writes:
>> On Sat, Apr 04, 2020 at 01:08:50PM +0200, Michael Kerrisk (man-pages) wrote:
>>>    /proc/PID/timens_offsets
>>>        Associated  with  each  time namespace are offsets, expressed with
>>>        respect to the initial time namespace, that define the  values  of
>>>        the  monotonic  and  boot clocks in that namespace.  These offsets
>>>        are exposed via the file  /proc/PID/timens_offsets.   Within  this
>>>        file,  the  offsets  are  expressed  as  lines consisting of three
>>>        space-delimited fields:
>>>
>>>            <clock-id> <offset-secs> <offset-nanosecs>
>>>
>>>        The clock-id identifies the clock whose offsets are  being  shown.
>>>        This field is either 1, for CLOCK_MONOTONIC, or 7, for CLOCK_BOOT‐
>>>        TIME.  The remaining  fields  express  the  offset  (seconds  plus
>>>        nanoseconds)  for the clock in this time namespace.  These offsets
>>>        are expressed relative to the clock values  in  the  initial  time
>>>        namespace.   In  the  initial time namespace, the contents of this
>>>        file are as follows:
>>
>> I think we can mention that offset-secs can be negative, but
>> offset-nanosleep has to be 0 or positive.
> 
> I assume you meant offset-nanosecs :)
> 
> That aside, there are also limitations in place.
> 
>   1) Negative offsets which would offset time into negative space are
>      rejected, i.e. its enforced that
> 
>           now(CLOCK) + offset[CLOCK] >= 0
> 
>      This is necessary as the kernel expects and also enforces that time
>      cannot be negative.
> 
>   2) Positive offsets which would offset time above KTTIME_SEC_MAX / 2 are
>      rejected, i.e. it's enforced that
> 
>           now(CLOCK) + offset[CLOCK] <= KTIME_SEC_MAX / 2
> 
>      That is done to prevent that clocks wrap around if the offset would
>      bring it close enough to the wrap around point.
> 
>      The cutoff value is a pretty arbitrary choice (~146 years). So to
>      hit this you'd need a system which has an uptime of > 146 years,
>      which is pretty much unrealistic.

Thanks Thomas!

I've tried to capture this info, as well some other relevant errors
in the following text. Does it look okay?

       Writes  to  the  timens_offsets  file  can fail with the following
       errors:

       EINVAL An offset-nanosecs value is greater than 999,999,999.

       EINVAL A clock-id value is not valid.

       EPERM  The caller does not have the the CAP_SYS_TIME capability.

       ERANGE An offset-secs value is out of range.  In particular;

              · offset-secs can't be set to a value which would make  the
                current time on the corresponding clock inside the names‐
                pace a negative value; and

              · offset-secs can't be set to a value such that the time on
                the corresponding clock inside the namespace would exceed
                half of the value of the  kernel  constant  KTIME_SEC_MAX
                (this  limits  the  clock  value to a maximum of approxi‐
                mately 146 years).

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
