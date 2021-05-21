Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23BA38C96B
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 16:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhEUOqm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 10:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236903AbhEUOqe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 10:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621608310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UzfrhhjYSYiIuzBU0H2YNGGzT9stjrQrZgCfIc9Eyrw=;
        b=X7SjMra7JnYv8MCotiw/eICiF+y7diEz2xPmap63D6tKly6x5+6ysO8E7iLOSkkPpov6a2
        pmIQGzausFHK3nBpK/MB+vk2NXvR9dZlZ7s/Ynr4dpAlzg6HsnQVkaN20bGTE1Ql+zpQ+p
        xbHEMRlBJeLf8ANLMELErMxelwfHkHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-vKGhCmr3Nfek4CE7RcWfvA-1; Fri, 21 May 2021 10:45:07 -0400
X-MC-Unique: vKGhCmr3Nfek4CE7RcWfvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43C78107ACC7;
        Fri, 21 May 2021 14:45:05 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-113-228.ams2.redhat.com [10.36.113.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B410260D4B;
        Fri, 21 May 2021 14:45:00 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Len Brown <lenb@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
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
        <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
        <87k0ntazyn.ffs@nanos.tec.linutronix.de>
        <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
        <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
        <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
Date:   Fri, 21 May 2021 16:44:58 +0200
Message-ID: <87pmxk87th.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Dave Hansen via Libc-alpha:

> Our system calls are *REALLY* fast.  We can even do a vsyscall for this
> if we want to get the overhead down near zero.  Userspace can also cache
> the "I did the prctl()" state in thread-local storage if it wants to
> avoid the syscall.

Why can't userspace look at XCR0 to make the decision?

And we added an interface for querying x86 CPU features to glibc 2.33
which is completely incompatible with this because it assumes that CPU
features do not change during the lifetime of a process. 8-(

Thanks,
Florian

