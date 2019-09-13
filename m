Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216D3B23B7
	for <lists+linux-api@lfdr.de>; Fri, 13 Sep 2019 17:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbfIMP6L (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Sep 2019 11:58:11 -0400
Received: from mail.efficios.com ([167.114.142.138]:35202 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387621AbfIMP6L (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Sep 2019 11:58:11 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 749962B50FE;
        Fri, 13 Sep 2019 11:58:09 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Nui7TqnjKyAc; Fri, 13 Sep 2019 11:58:09 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 016E92B50F9;
        Fri, 13 Sep 2019 11:58:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 016E92B50F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568390289;
        bh=t2rOmkzot+SvxnuW5zmOlNOGh9D8GTyBdB/sgjpjO6w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GaotWm2jgQWH/tVnzh9WUMYiS5GWgqQfyVHe2CiLiaxBnk4oLGGXi9F/lkvafAOHz
         LeppsoiiP3DC53gFhkscZWzz2FkxTwsYSVR0c3LtFPS6Y9/4z5PvbyON8iIws/wKrW
         IiUElIo5mxGUmPA94cNPMsUncrJVbW0UVWLloGWLEs8UUnWBj9x4LimLAKh2oPMh2M
         8rJ8dnKLo6JKuc5Fw2It0JpnxxYfDTK4Kcv/3VGty2wyDigxjmoEzTHUMF8+JrW7hh
         qKWqQvLB+n078lWy3YNXa/yILCMAsKYNmXaKzgp6NM5j0AJY4FK3YfE/IH/OWDgnTC
         YBqmZONtE6NRg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id VNHIZqALTk6E; Fri, 13 Sep 2019 11:58:08 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id DA5102B50E7;
        Fri, 13 Sep 2019 11:58:08 -0400 (EDT)
Date:   Fri, 13 Sep 2019 11:58:08 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     carlos <carlos@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1137395748.2754.1568390288746.JavaMail.zimbra@efficios.com>
In-Reply-To: <7db64714-3dc5-b322-1edc-736b08ee7d63@redhat.com>
References: <20190807142726.2579-1-mathieu.desnoyers@efficios.com> <20190807142726.2579-2-mathieu.desnoyers@efficios.com> <8736h2sn8y.fsf@oldenburg2.str.redhat.com> <7db64714-3dc5-b322-1edc-736b08ee7d63@redhat.com>
Subject: Re: [PATCH glibc 2.31 1/5] glibc: Perform rseq(2) registration at C
 startup and thread creation (v12)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3847)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v12)
Thread-Index: CV9YTfISAeF89N8YT671OJtvipHjFw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Sep 11, 2019, at 3:00 PM, carlos carlos@redhat.com wrote:

> On 9/11/19 2:26 PM, Florian Weimer wrote:
>> * Mathieu Desnoyers:
>> 
>>> +#ifdef SHARED
>>> +  if (rtld_active ())
>>> +    {
>>> +      /* Register rseq ABI to the kernel.   */
>>> +      (void) rseq_register_current_thread ();
>>> +    }
>>> +#else
>> 
>> I think this will need *another* check for the inner libc in an audit
>> module.  See what we do in malloc.  __libc_multiple_libcs is supposed to
>> cover that, but it's unfortunately not reliable.
>> 
>> I believe without that additional check, the first audit module we load
>> will claim rseq, and the main program will not have control over the
>> rseq area.  Reversed roles would be desirable here.
>> 
>> In October, I hope to fix __libc_multiple_libcs, and then you can use
>> just that.  (We have a Fedora patch that is supposed to fix it, I need
>> to documen the mechanism and upstream it.)
> 
> This is a technical issue we can resolve.

I'm unsure whether there are changes I need to do in my rseq patchset, or
if this is a separate issue that will be fixed separately before glibc 2.31
is out, which would then update the rseq bits accordingly ?

> 
>>> +/* Advertise Restartable Sequences registration ownership across
>>> +   application and shared libraries.
>>> +
>>> +   Libraries and applications must check whether this variable is zero or
>>> +   non-zero if they wish to perform rseq registration on their own. If it
>>> +   is zero, it means restartable sequence registration is not handled, and
>>> +   the library or application is free to perform rseq registration. In
>>> +   that case, the library or application is taking ownership of rseq
>>> +   registration, and may set __rseq_handled to 1. It may then set it back
>>> +   to 0 after it completes unregistering rseq.
>>> +
>>> +   If __rseq_handled is found to be non-zero, it means that another
>>> +   library (or the application) is currently handling rseq registration.
>>> +
>>> +   Typical use of __rseq_handled is within library constructors and
>>> +   destructors, or at program startup.  */
>>> +
>>> +int __rseq_handled;
>> 
>> Are there any programs that use __rseq_handled *today*?

No, because I told all open source project developers asking whether they
can use rseq to wait until we agree on _this_ precise user-level ABI
(__rseq_abi and __rseq_handled). Until we agree on this, there _can_
be no users, unless they are willing to suffer conflicts when their
application/program is linked against an updated glibc.

>> 
>> I'm less convinced that we actually need this.  I don't think we have
>> ever done anything like that before, and I don't think it's necessary.
>> Any secondary rseq library just needs to note if it could perform
>> registration, and if it failed to do so, do not perform unregistration
>> in a pthread destructor callback.

If that secondary rseq library happens to try to perform registration within
its library constructor (before glibc has performed the __rseq_abi TLS
registration), we end up in a situation where the secondary library takes
ownership of rseq, even though libc would require ownership. This is a
scenario we want to avoid.

Making sure libc reserves ownership through __rseq_handled (which is
a non-TLS variable that can be accessed early in the program lifetime)
protects against this.

>> 
>> Sure, there's the matter of pthread destructor ordering, but that
>> problem is not different from any other singleton (thread-local or not),
>> and the fix for the last time this has come up (TLS destructors vs
>> dlclose) was to upgrade glibc.
> 
> This is a braoder issue.
> 
> Mathieu,
> 
> It would be easier to merge the patch set if it were just an unconditional
> registration like we do for set_robust_list().
> 
> What's your thought there?

I don't expect set_robust_list was really useful without glibc support.
In the current case, rseq can be used by applications and libraries even
with older glibc. My goal is to enable such use and not wait for years
before end-users upgrade their glibc before rseq can be used.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
