Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F1C38D422
	for <lists+linux-api@lfdr.de>; Sat, 22 May 2021 09:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhEVHSW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 May 2021 03:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229935AbhEVHSV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 22 May 2021 03:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621667816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iE5kXnU1bSfbyfhUY7SBg1/m6Gfmn7ASSYypDQN8NXc=;
        b=C2ZrUT5EjjezSgmXsufb+g7D4QFFSdVNfLYGg1LQS9K8IU0kNxoSA/GvVMSlDsm9iz5YV5
        AQt/KwQI8Bkk+ukod9Eo5cye6gQNVqq+D3hxOJjU/OYx5+171ZYs/XKWLgchcF6OetfB0/
        SzIeLj/oTvxUZHppYhFXN2JzMon5qVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-rDC1RYf7NDmYYJ7YCWCSsQ-1; Sat, 22 May 2021 03:16:52 -0400
X-MC-Unique: rDC1RYf7NDmYYJ7YCWCSsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F6F21007476;
        Sat, 22 May 2021 07:16:50 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-113-228.ams2.redhat.com [10.36.113.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C750B46;
        Sat, 22 May 2021 07:16:46 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Len Brown <lenb@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
References: <20210415044258.GA6318@zn.tnic> <20210419191539.GH9093@zn.tnic>
        <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
        <20210419215809.GJ9093@zn.tnic>
        <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
        <YIMmwhEr46VPAZa4@zn.tnic>
        <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
        <874kf11yoz.ffs@nanos.tec.linutronix.de>
        <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
        <87k0ntazyn.ffs@nanos.tec.linutronix.de>
        <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
        <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
        <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
        <87pmxk87th.fsf@oldenburg.str.redhat.com>
        <939ec057-3851-d8fb-7b45-993fa07c4cb5@intel.com>
        <87r1i06ow2.fsf@oldenburg.str.redhat.com>
        <263a58a9-26d5-4e55-b3e1-3718baf1b81d@www.fastmail.com>
        <87k0nraonu.ffs@nanos.tec.linutronix.de>
        <CAJvTdK=A64DQXjYkZgPebWb-V_p_HAM+jTZRLTyi1qrP9kucMg@mail.gmail.com>
        <878s47aeni.ffs@nanos.tec.linutronix.de>
        <CAJvTdK=Ws1QvBvdx50OSmAi0vBX49KZZHUoiMFbhUUEPmjGmBw@mail.gmail.com>
Date:   Sat, 22 May 2021 09:16:44 +0200
In-Reply-To: <CAJvTdK=Ws1QvBvdx50OSmAi0vBX49KZZHUoiMFbhUUEPmjGmBw@mail.gmail.com>
        (Len Brown's message of "Fri, 21 May 2021 19:31:36 -0400")
Message-ID: <877djr5jc3.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Len Brown:

> A. per-task.  If we do it this way, then we will likely wind up
> mandating a GET at the start of every routine in every library that
> touches AMX, and potentially also a PUT.  This is because the library
> has no idea what thread called it.  The plus is that this will address
> the "used once and sits on a buffer for the rest of the process
> lifetime' scenario.  The minus is that high performance users will be
> executing thousands of unnecessary system calls that have zero value.

We could revive the KTLS proposal (userspace donates memory for use by
the kernel & vDSO), and the thread could reserve (on-stack) buffer space
for kernel use for the duration of the AMX computation.  There would be
a pointer to that space in the KTLS area, set upon entry of the AMX
region, and cleared upon exit.  It's not extremely cheap (unbounded
alloca has a stack probing loop nowadays).  But no system call is
required.

Thanks,
Florian

