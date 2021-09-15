Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2822340CBDB
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhIORpJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Wed, 15 Sep 2021 13:45:09 -0400
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:34128 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIORpI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 13:45:08 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Sep 2021 13:45:08 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 17F8A160152;
        Wed, 15 Sep 2021 10:34:20 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id I3w-vMnz_MK5; Wed, 15 Sep 2021 10:34:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id D9196160153;
        Wed, 15 Sep 2021 10:34:18 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NItS-eVDZCFe; Wed, 15 Sep 2021 10:34:18 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 34E4D160152;
        Wed, 15 Sep 2021 10:34:18 -0700 (PDT)
To:     Peter Zijlstra <peterz@infradead.org>, andrealmeid@collabora.com,
        tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     dave@stgolabs.net, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        mtk.manpages@gmail.com, kernel@collabora.com, krisman@collabora.com
References: <20210915140710.596174479@infradead.org>
 <20210915141525.621568509@infradead.org>
 <YUITUXbnzAK98DEl@hirez.programming.kicks-ass.net>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: [PATCH 16/20] futex: Implement sys_futex_waitv()
Message-ID: <bdeb5453-e019-7c5b-1bf0-7a225401d358@cs.ucla.edu>
Date:   Wed, 15 Sep 2021 10:34:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUITUXbnzAK98DEl@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/15/21 8:37 AM, Peter Zijlstra wrote:
> I utterly detest timespec.. it makes no sense what so ever.
> 
> Can't we just, for new syscalls, simply use a s64 nsec argument and call
> it a day?

This would stop working in the year 2262. Not a good idea.

Any improvements on struct timespec should be a strict superset, not a 
subset. For example, you could advocate a signed 128-bit argument 
counting in units of attoseconds (10⁻¹⁸ s), the highest power-of-1000 
resolution that does not lose info when converting from struct timespec. 
This could use __int128 on platforms that have it, a two-integer struct 
otherwise.

I'm not sure this is a hill I'd want to die on. That being said, it 
would be cool to keep up with the people in the building near mine who 
are researching attosecond imaging (tricky because the uncertainty 
principle means attosecond laser pulses must have very broad spectra). 
And extending struct timespec on the low end is clearly the way to go, 
since its high end already goes back well before the Big Bang.

I hope you don't mind my going off the deep end a bit here. Still, the 
point is that if we're going to improve on struct timespec then it 
really should be an improvement.
