Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02C3B1D2A
	for <lists+linux-api@lfdr.de>; Wed, 23 Jun 2021 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFWPJr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Jun 2021 11:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWPJr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Jun 2021 11:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624460849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHCiJj43tDNkuVMQugA1B24KSUzuIyfm9V4T1jsq3/Y=;
        b=WBluvY2XAa/eBvaWwvtgJWahnLAxirfiiMHipLY9q8fMFoHKxT6wHyTXLAJznrTRHkcXVx
        fE3FKshmOebkwT3XrJw8rcO+xvXdMefrIJnfs4KS1AZjYhc+uuJrMVcwLLNzZ4JglwOWFK
        BznEG9nOfcrTKmlookYQ3/bpXb3ewKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-bLa3K0S1MjK3aW0KWqe4Wg-1; Wed, 23 Jun 2021 11:07:27 -0400
X-MC-Unique: bLa3K0S1MjK3aW0KWqe4Wg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66E0BBD42A;
        Wed, 23 Jun 2021 15:06:43 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-211.ams2.redhat.com [10.36.112.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEB785C1A1;
        Wed, 23 Jun 2021 15:06:38 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Len Brown <lenb@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
References: <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
        <YIMmwhEr46VPAZa4@zn.tnic>
        <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
        <874kf11yoz.ffs@nanos.tec.linutronix.de>
        <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
        <87k0ntazyn.ffs@nanos.tec.linutronix.de>
        <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
        <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
        <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
        <87pmxk87th.fsf@oldenburg.str.redhat.com>
        <YKfIct+DhpEBbaCQ@hirez.programming.kicks-ass.net>
Date:   Wed, 23 Jun 2021 17:06:35 +0200
In-Reply-To: <YKfIct+DhpEBbaCQ@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 21 May 2021 16:49:22 +0200")
Message-ID: <87wnqkzklg.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Peter Zijlstra:

> On Fri, May 21, 2021 at 04:44:58PM +0200, Florian Weimer wrote:
>
>> And we added an interface for querying x86 CPU features to glibc 2.33
>> which is completely incompatible with this because it assumes that CPU
>> features do not change during the lifetime of a process. 8-(
>
> How many x86 kernel maintainers signed off on that patch?

I've started a new thread:

  x86 CPU features detection for applications (and AMX)
  <https://lore.kernel.org/linux-api/87tulo39ms.fsf@oldenburg.str.redhat.com/>

Thanks,
Florian

