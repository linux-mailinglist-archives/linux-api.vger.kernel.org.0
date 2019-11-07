Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75858F3468
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 17:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfKGQLF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 11:11:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56736 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387470AbfKGQLE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 11:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573143063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9Yv2ADBEuYgu7K06bm3FCwi5kL7EfkBgwC6m+V6GpE=;
        b=I8cI6crmJeLCq45Dl5hz6nwLbJqIcyP0VSCot9JVZ0SbJfp9STJQeyxVZhdKCrWRNUS2Bu
        0zInqv0ED/4D+qyVZKUhGQ++gucI76ztUULbhurkv+oCGr3unKtM4tPiLLPL5WMLk73Fnm
        seT8LIIdx+jVMnSSeY5yCSUPhZNMLvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-7T61eBXcOASiyFVjHgEPgA-1; Thu, 07 Nov 2019 11:11:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21EB41800D6B;
        Thu,  7 Nov 2019 16:11:00 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-117-20.ams2.redhat.com [10.36.117.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22B5B5D9E5;
        Thu,  7 Nov 2019 16:10:52 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: For review: documentation of clone3() system call
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
        <20191107151941.dw4gtul5lrtax4se@wittgenstein>
Date:   Thu, 07 Nov 2019 17:10:51 +0100
In-Reply-To: <20191107151941.dw4gtul5lrtax4se@wittgenstein> (Christian
        Brauner's message of "Thu, 7 Nov 2019 16:19:43 +0100")
Message-ID: <87y2wrbras.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7T61eBXcOASiyFVjHgEPgA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Christian Brauner:

> I've always been confused by the "..." for the glibc wrapper. The glibc
> prototype in bits/sched.h also looks like this:
>
> extern int clone (int (*__fn) (void *__arg), void *__child_stack, int __f=
lags, void *__arg, ...) __THROW;
>
> The additionl args parent_tid, tls, and child_tid are present in _all_
> clone version in the same order. In fact the glibc wrapper here give the
> illusion that it's parent_tid, tls, child_tid. The underlying syscall
> has a different order parent_tidptr, child_tidptr, tls.
>
> Florian, can you advise what prototype we should mention for the glibc
> clone() wrapper here. I'd like it to be as simple as possible and get
> rid of the ...
> Architectural differences are explained in detail below anyway.

Our header has:

/* Clone current process.  */
extern int clone (int (*__fn) (void *__arg), void *__child_stack,
                  int __flags, void *__arg, ...) __THROW;

I have not checked all assembler implementations.  In theory there could
be one that relies on the different calling convention for variadic
functions (e.g., the existence of a parameter save area on POWER).  Or
that swaps arguments in some architecure-specific way. 8-(

I don't have much guidance on this matter, sorry.  I expect that for
clone3, we'll provide a same-stack variant as well (for fork/vfork-like
usage), which will be much closer to the kernel interface.  clone/clone2
doesn't seem very fixable to me at this point.

Thanks,
Florian

