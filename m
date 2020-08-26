Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0561B253571
	for <lists+linux-api@lfdr.de>; Wed, 26 Aug 2020 18:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHZQwN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Aug 2020 12:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbgHZQwK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 26 Aug 2020 12:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598460728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fseon1CUZlvG+qAn5/Dq00exA8K9BCSeKO7lSLO6dwU=;
        b=cKrBw6Ry33n5HUUHGYLdL/m7KR0eeDfXoFgbDzQmt3dqsywlTm2U1B1tQAaGnbeCxTIm1Z
        VGtt4g24X73ATH+L/7ou5oAUw4EODtUOxfcHg4RV8wFLS9k7CMF+QUjXLonFLqyKFsgQvK
        hpYUDxTG/8yyhtJPqBNTfLu2v7cm2UA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-CGPhPkXwNDaMQykNbqtiGg-1; Wed, 26 Aug 2020 12:52:06 -0400
X-MC-Unique: CGPhPkXwNDaMQykNbqtiGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADF7D80BCA0;
        Wed, 26 Aug 2020 16:52:02 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-37.ams2.redhat.com [10.36.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D3D619C78;
        Wed, 26 Aug 2020 16:51:50 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "Yu\, Yu-cheng" <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for shadow stack
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
        <20200825002540.3351-26-yu-cheng.yu@intel.com>
        <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
        <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com>
        <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
        <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com>
        <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
        <ef7f9e24-f952-d78c-373e-85435f742688@intel.com>
        <20200826164604.GW6642@arm.com>
Date:   Wed, 26 Aug 2020 18:51:48 +0200
In-Reply-To: <20200826164604.GW6642@arm.com> (Dave Martin's message of "Wed,
        26 Aug 2020 17:46:05 +0100")
Message-ID: <87ft892vvf.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Dave Martin:

> On Tue, Aug 25, 2020 at 04:34:27PM -0700, Yu, Yu-cheng wrote:
>> On 8/25/2020 4:20 PM, Dave Hansen wrote:
>> >On 8/25/20 2:04 PM, Yu, Yu-cheng wrote:
>> >>>>I think this is more arch-specific.=C2=A0 Even if it becomes a new s=
yscall,
>> >>>>we still need to pass the same parameters.
>> >>>
>> >>>Right, but without the copying in and out of memory.
>> >>>
>> >>Linux-api is already on the Cc list.=C2=A0 Do we need to add more peop=
le to
>> >>get some agreements for the syscall?
>> >What kind of agreement are you looking for?  I'd suggest just coding it
>> >up and posting the patches.  Adding syscalls really is really pretty
>> >straightforward and isn't much code at all.
>> >
>>=20
>> Sure, I will do that.
>
> Alternatively, would a regular prctl() work here?

Is this something appliation code has to call, or just the dynamic
loader?

prctl in glibc is a variadic function, so if there's a mismatch between
the kernel/userspace syscall convention and the userspace calling
convention (for variadic functions) for specific types, it can't be made
to work in a generic way.

The loader can use inline assembly for system calls and does not have
this issue, but applications would be implcated by it.

Thanks,
Florian

