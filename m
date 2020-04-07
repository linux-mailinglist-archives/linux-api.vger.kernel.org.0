Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 983A01A0BF3
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 12:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgDGKa5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 7 Apr 2020 06:30:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46992 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgDGKa4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Apr 2020 06:30:56 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jLlVG-0004Aj-Kw; Tue, 07 Apr 2020 12:30:46 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 31A28101303; Tue,  7 Apr 2020 12:30:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrei Vagin <avagin@gmail.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
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
        Adrian Reber <adrian@lisas.de>
Subject: Re: RFC: time_namespaces(7) manual page
In-Reply-To: <20200407032318.GA494464@gmail.com>
References: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com> <20200407032318.GA494464@gmail.com>
Date:   Tue, 07 Apr 2020 12:30:46 +0200
Message-ID: <87r1wzk2p5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andrei Vagin <avagin@gmail.com> writes:
> On Sat, Apr 04, 2020 at 01:08:50PM +0200, Michael Kerrisk (man-pages) wrote:
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

I assume you meant offset-nanosecs :)

That aside, there are also limitations in place.

  1) Negative offsets which would offset time into negative space are
     rejected, i.e. its enforced that

          now(CLOCK) + offset[CLOCK] >= 0

     This is necessary as the kernel expects and also enforces that time
     cannot be negative.

  2) Positive offsets which would offset time above KTTIME_SEC_MAX / 2 are
     rejected, i.e. it's enforced that

          now(CLOCK) + offset[CLOCK] <= KTIME_SEC_MAX / 2

     That is done to prevent that clocks wrap around if the offset would
     bring it close enough to the wrap around point.

     The cutoff value is a pretty arbitrary choice (~146 years). So to
     hit this you'd need a system which has an uptime of > 146 years,
     which is pretty much unrealistic.

Thanks,

        tglx

     
          
