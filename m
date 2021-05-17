Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF91B382905
	for <lists+linux-api@lfdr.de>; Mon, 17 May 2021 11:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhEQJ6a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 May 2021 05:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236374AbhEQJ6E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 May 2021 05:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621245407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C+hYtbQeVxoHt/6+9B9mxwjiL2Lj7LwbtAeSgLEv7zA=;
        b=HPzZH9GBOKg427dR3pme72oPFIAt1F6jpy2zgNd6Pvd8iE9MMCnlJjjtRFc5hdkJcASk2m
        kdHPbth4NcrIeUmVyQtAP9VVM39ogw4WehC0xEAK3Ak7vkjtcshbi/l3Rj6yW2JX93XdrF
        91BcYEk4JMw4NuyfP6ACznA4r2718Ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-D9EuS6n9N9KmTukwNhIbLw-1; Mon, 17 May 2021 05:56:44 -0400
X-MC-Unique: D9EuS6n9N9KmTukwNhIbLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70AAB1B18BFA;
        Mon, 17 May 2021 09:56:33 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-137.ams2.redhat.com [10.36.112.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 543E56E70E;
        Mon, 17 May 2021 09:56:29 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
        <20210415054713.GB6318@zn.tnic>
        <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
        <20210419141454.GE9093@zn.tnic>
        <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
        <20210419191539.GH9093@zn.tnic>
        <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
        <20210419215809.GJ9093@zn.tnic>
        <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
        <YIMmwhEr46VPAZa4@zn.tnic>
        <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
        <874kf11yoz.ffs@nanos.tec.linutronix.de>
Date:   Mon, 17 May 2021 11:56:27 +0200
In-Reply-To: <874kf11yoz.ffs@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Mon, 17 May 2021 11:45:00 +0200")
Message-ID: <87pmxpk7jo.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Thomas Gleixner:

> Having a proper interface (syscall, prctl) which user space can use to
> ask for permission and allocation of the necessary buffer(s) is clearly
> avoiding the downsides and provides the necessary mechanisms for proper
> control and failure handling.
>
> It's not the end of the world if something which wants to utilize this
> has do issue a syscall during detection. It does not matter whether
> that's a library or just the application code itself.
>
> That's a one off operation and every involved entity can cache the
> result in TLS.

I'm not sure if it's a good idea to have each AMX consumer to set up its
own TLS cache.  How expensive is checking XCR0 via XGETBV instead on the
AMX path?  Then AMX can be enabled on the thread via a system call.  It
also allows disabling of AMX.

It would also need an AT_HWCAP2 feature flag telling user space that AMX
support is available after that system call (switching on AMX to check
whether AMX paths should enabled later seems potentially wasteful if the
AMX paths are never taken after all).

Thanks,
Florian

