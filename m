Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D4FF778B
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfKKPUw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 10:20:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59061 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726845AbfKKPUw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 10:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573485651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1zGHKvwpfTIUGcapQ+PDyzQUKdMx+4TB/qV51A6KfM=;
        b=ZYzyx+8k88KApyTDKgLQLPjMrXkY7WyCLfrmL/wRjCWkjU8JvFLNWHAJkTZD/zHZiIl7Iw
        +XxcFy7n0nk+RxKe7hwqCJgp34FqP8OF+at4RI2KxovGN5f0oLakv4emNRoZasZiS9p+0f
        FSe0q/hoN0YdnxkwXqv3eAtuQ8c5cyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-vBGvGzzCMIG6kes1J63o-g-1; Mon, 11 Nov 2019 10:20:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F7F5911AD;
        Mon, 11 Nov 2019 15:20:46 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E6F060852;
        Mon, 11 Nov 2019 15:20:38 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: For review: documentation of clone3() system call
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
        <87tv7awj4g.fsf@oldenburg2.str.redhat.com>
        <CAG48ez3zpBwU6vHSuY6VoP+Uw_Jz6uxYN1Teg2wSpwZrPmAn-g@mail.gmail.com>
Date:   Mon, 11 Nov 2019 16:20:36 +0100
In-Reply-To: <CAG48ez3zpBwU6vHSuY6VoP+Uw_Jz6uxYN1Teg2wSpwZrPmAn-g@mail.gmail.com>
        (Jann Horn's message of "Mon, 11 Nov 2019 16:15:58 +0100")
Message-ID: <875zjqwibf.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vBGvGzzCMIG6kes1J63o-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Jann Horn:

> On Mon, Nov 11, 2019 at 4:03 PM Florian Weimer <fweimer@redhat.com> wrote=
:
>>
>> * Michael Kerrisk:
>>
>> >        Another  difference  for  the  raw clone() system call is that =
the
>> >        stack argument may be NULL, in which case the child uses a  dup=
li=E2=80=90
>> >        cate  of the parent's stack.  (Copy-on-write semantics ensure t=
hat
>> >        the child gets separate copies of stack pages when either  proc=
ess
>> >        modifies  the  stack.)   In  this case, for correct operation, =
the
>> >        CLONE_VM option should not be specified.  (If the child shares =
the
>> >        parent's  memory  because of the use of the CLONE_VM flag, then=
 no
>> >        copy-on-write duplication occurs and chaos is likely to result.=
)
>>
>> I think sharing the stack also works with CLONE_VFORK with CLONE_VM, as
>> long as measures are taken to preserve the return address in a register.
>
> That basically just requires that the userspace function declaration
> for clone3 includes __attribute__((returns_twice)), right?

The clone3 implementation itself would have to store the return address
in a register because at the time of the second return, a return address
on the stack may have been corrupted by the subprocess because what used
to be the stack frame of the clone function has since been reused for
something else.

__attribute__ ((returns_twice)) is likely needed as well, but that
benefits the caller.  It's also not clear that it is sufficient for this
to work in all cases.  (But the mandatory-to-implement vfork function
faces the same problems.)

Thanks,
Florian

