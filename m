Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D22838CAD9
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 18:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhEUQUp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 12:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231234AbhEUQUp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 12:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621613961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fFS4V+laUEHsiKbste7xkg0EuH4cmkgb3wAVYYo6X24=;
        b=BBwI4GBLuCks0zB80XTryi7U7WmQmy543VsKKwJMjTS3FJbtK2pPcqCjZKlRjRBoKbsS+R
        9olHBUnOQpp9yePob67raTPAhLtu0tKFMIRlkUHKyoX3gz1iaJiESzUpyQWcXmavvNchgu
        y1mZol4pt59RXzX0CcNBz4vf+T8XKCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-qYSbj5MvMNux4HU5wvqCEg-1; Fri, 21 May 2021 12:19:17 -0400
X-MC-Unique: qYSbj5MvMNux4HU5wvqCEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B8546D4E0;
        Fri, 21 May 2021 16:19:15 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-113-228.ams2.redhat.com [10.36.113.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9302D5D6DC;
        Fri, 21 May 2021 16:19:11 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Len Brown <lenb@kernel.org>, Rich Felker <dalias@libc.org>,
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
        <87pmxk87th.fsf@oldenburg.str.redhat.com>
        <939ec057-3851-d8fb-7b45-993fa07c4cb5@intel.com>
Date:   Fri, 21 May 2021 18:19:09 +0200
In-Reply-To: <939ec057-3851-d8fb-7b45-993fa07c4cb5@intel.com> (Dave Hansen's
        message of "Fri, 21 May 2021 09:14:12 -0700")
Message-ID: <87r1i06ow2.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Dave Hansen:

> On 5/21/21 7:44 AM, Florian Weimer wrote:
>> * Dave Hansen via Libc-alpha:
>>> Our system calls are *REALLY* fast.  We can even do a vsyscall for this
>>> if we want to get the overhead down near zero.  Userspace can also cache
>>> the "I did the prctl()" state in thread-local storage if it wants to
>>> avoid the syscall.
>> Why can't userspace look at XCR0 to make the decision?
>
> The thing we're trying to avoid is a #NM exception from XFD (the new
> first-use detection feature) that occurs on the first use of AMX.
> XCR0 will have XCR0[AMX]=1, even if XFD is "armed" and ready to
> generate the #NM.

I see.  So essentially the hardware wants to offer transparent
initialize-on-use, but Linux does not seem to want to implement it this
way.

Is there still a chance to bring the hardware and Linux into alignment?

Thanks,
Florian

