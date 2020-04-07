Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9FC51A09D6
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 11:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDGJPr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Apr 2020 05:15:47 -0400
Received: from foss.arm.com ([217.140.110.172]:53870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgDGJPq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 Apr 2020 05:15:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20BE830E;
        Tue,  7 Apr 2020 02:15:46 -0700 (PDT)
Received: from [10.37.12.138] (unknown [10.37.12.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10B563F73D;
        Tue,  7 Apr 2020 02:15:42 -0700 (PDT)
Subject: Re: [PATCH] kernel/time: Add max_time_namespaces ucount
To:     mtk.manpages@gmail.com, Andrei Vagin <avagin@gmail.com>
Cc:     Dmitry Safonov via Containers 
        <containers@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrey Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Linux API <linux-api@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, stable@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>
References: <20200406171342.128733-1-dima@arista.com>
 <20200407033148.GB494464@gmail.com>
 <CAKgNAkgTdND5m60Adb2O+SnogcUcho15F9cF5sZt_yrDF0REYg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e6718888-3a18-45da-e091-577c3822d6ac@arm.com>
Date:   Tue, 7 Apr 2020 10:16:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKgNAkgTdND5m60Adb2O+SnogcUcho15F9cF5sZt_yrDF0REYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/7/20 9:22 AM, Michael Kerrisk (man-pages) wrote:
> On Tue, 7 Apr 2020 at 05:31, Andrei Vagin <avagin@gmail.com> wrote:
>>
>> On Mon, Apr 06, 2020 at 06:13:42PM +0100, Dmitry Safonov via Containers wrote:
>>> Introduce missing time namespaces limit per-userns.
>>> Michael noticed that userns limit for number of time namespaces is
>>> missing.
>>>
>>> Furthermore, time namespace introduced UCOUNT_TIME_NAMESPACES, but
>>> didn't introduce an array member in user_table[]. It would make array's
>>> initialisation OOB write, but by luck the user_table array has
>>> an excessive empty member (all accesses to the array are limited with
>>> UCOUNT_COUNTS - so it silently reuses the last free member.
>>>
>>> Fixes user-visible regression: max_inotify_instances by reason of the
>>> missing UCOUNT_ENTRY() has limited max number of namespaces instead of
>>> the number of inotify instances.
>>>
>>> Fixes: 769071ac9f20 ("ns: Introduce Time Namespace")
>>> Cc: Adrian Reber <adrian@lisas.de>
>>> Cc: Andrey Vagin <avagin@openvz.org>
>>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>> Cc: Containers <containers@lists.linux-foundation.org>
>>> Cc: Linux API <linux-api@vger.kernel.org>
>>> Cc: stable@kernel.org # v5.6+
>>> Reported-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
>>
>> Acked-by: Andrei Vagin <avagin@gmail.com>
> 
> Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>
> 
> 
> 

Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

-- 
Regards,
Vincenzo
